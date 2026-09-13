/* JestokyCraft Hardcore memorials. GPL-2.0-or-later. */
#include "HardcoreMemorialHooks.h"
#include "AllMapScript.h"
#include "Chat.h"
#include "DatabaseEnv.h"
#include "DBCStores.h"
#include "GameObject.h"
#include "GameObjectScript.h"
#include "Guild.h"
#include "GuildMgr.h"
#include "Log.h"
#include "Map.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "WorldPacket.h"
#include "WorldScript.h"
#include "WorldSession.h"
#include <cmath>
#include <map>
#include <mutex>
#include <sstream>
#include <stdexcept>
#include <vector>

namespace
{
constexpr uint32 MemorialEntry = 900150;
struct Memorial
{
    uint32 guid, map, instance, phase, diedAt;
    float x,y,z,o;
    std::string payload;
};
struct MapMemorials { uint32 elapsed=2000; std::map<uint32,ObjectGuid> spawned; };
std::mutex memorialMutex;
std::map<uint32,Memorial> memorials;
std::map<Map*,MapMemorials> mapMemorials;

std::string Clean(std::string text)
{
    for (char& c : text) if (c=='\t' || c=='\n' || c=='\r' || c=='|') c=' ';
    return text.empty() ? "—" : text;
}
Memorial Read(Field* f)
{
    return {f[0].Get<uint32>(),f[1].Get<uint32>(),f[2].Get<uint32>(),f[3].Get<uint32>(),f[4].Get<uint32>(),
        f[5].Get<float>(),f[6].Get<float>(),f[7].Get<float>(),f[8].Get<float>(),f[9].Get<std::string>()};
}
char const* SelectConfirmed = "SELECT m.guid,m.map_id,m.instance_id,m.phase_mask,m.died_at,m.x,m.y,m.z,m.orientation,m.payload "
    "FROM character_hardcore_memorial m INNER JOIN character_hardcore_attempt a ON a.guid=m.guid "
    "WHERE a.state IN (2,3) AND a.ended_at=m.died_at";
std::string Hex(std::string_view text)
{
    char const* digits="0123456789abcdef";std::string out;out.reserve(text.size()*2);
    for (unsigned char c:text) { out+=digits[c>>4];out+=digits[c&15]; }
    return out;
}
void Send(Player* player,std::string const& message)
{
    WorldPacket packet;
    // Addon transport must not switch to SMSG_GM_MESSAGECHAT for privileged readers.
    ChatHandler::BuildChatPacket(packet,CHAT_MSG_WHISPER,LANG_ADDON,
        player->GetGUID(),player->GetGUID(),"JCHCMEM\t"+message,0,
        player->GetName(),player->GetName(),0,false);
    player->SendDirectMessage(&packet);
}
void SendMemorial(Player* player,Memorial const& record)
{
    std::string id=std::to_string(record.guid);
    size_t chunks=(record.payload.size()+63)/64;
    Send(player,id+":B:"+std::to_string(chunks));
    for(size_t i=0;i<chunks;++i)
        Send(player,id+":D:"+std::to_string(i+1)+":"+Hex(std::string_view(record.payload).substr(i*64,64)));
    Send(player,id+":E");
}

class HardcoreMemorialWorld : public WorldScript
{
public:
    HardcoreMemorialWorld():WorldScript("HardcoreMemorialWorld",{WORLDHOOK_ON_STARTUP}){}
    void OnStartup() override
    {
        Player::InitializeHardcoreJournal();
        if (!CharacterDatabase.Query("SELECT COUNT(*) FROM character_hardcore_memorial") || !sObjectMgr->GetGameObjectTemplate(MemorialEntry))
            throw std::runtime_error("Hardcore memorial migration/template is missing");
        std::lock_guard<std::mutex> lock(memorialMutex);
        memorials.clear();
        if(QueryResult result=CharacterDatabase.Query(SelectConfirmed))
            do { auto record=Read(result->Fetch());memorials[record.guid]=std::move(record); } while(result->NextRow());
        LOG_INFO("server.loading","Hardcore memorials: loaded {} durable records",memorials.size());
    }
};
class HardcoreMemorialMaps : public AllMapScript
{
public:
    HardcoreMemorialMaps():AllMapScript("HardcoreMemorialMaps",{ALLMAPHOOK_ON_MAP_UPDATE,ALLMAPHOOK_ON_DESTROY_MAP}){}
    void OnDestroyMap(Map* map) override
    { std::lock_guard<std::mutex> lock(memorialMutex);mapMemorials.erase(map); }
    void OnMapUpdate(Map* map,uint32 diff) override
    {
        std::lock_guard<std::mutex> lock(memorialMutex);
        auto& state=mapMemorials[map];state.elapsed+=diff;
        if(state.elapsed<2000)return;state.elapsed=0;
        for(auto const& [id,r]:memorials)
        {
            if(r.map!=map->GetId() || r.instance!=map->GetInstanceId() || !map->IsGridLoaded(r.x,r.y))continue;
            auto existing=state.spawned.find(id);
            if(existing!=state.spawned.end() && map->GetGameObject(existing->second))continue;
            bool playerNearby=false;
            for(auto const& ref:map->GetPlayers())
                if(Player* p=ref.GetSource())
                    if(!p->GetSession()->IsBot() && (p->GetPhaseMask()&r.phase) && p->IsWithinDist3d(r.x,r.y,r.z,120.0f)) {playerNearby=true;break;}
            if(!playerNearby)continue;
            if(!std::isfinite(r.x)||!std::isfinite(r.y)||!std::isfinite(r.z)||r.z < -1500 || r.z > 20000)continue;
            auto* go=new GameObject();
            if(!go->Create(map->GenerateLowGuid<HighGuid::GameObject>(),MemorialEntry,map,r.phase,r.x,r.y,r.z,r.o,
                G3D::Quat(0,0,std::sin(r.o/2),std::cos(r.o/2)),0,GO_STATE_ACTIVE)) {delete go;continue;}
            go->SetRespawnTime(0);go->SetSpawnedByDefault(true);
            if(!map->AddToMap(go)) {delete go;continue;}
            // Active state is sent to the client; the memorial is clickable but never a barrier.
            go->EnableCollision(false);
            state.spawned[id]=go->GetGUID();
        }
    }
};
class HardcoreMemorialStone : public GameObjectScript
{
public:
    HardcoreMemorialStone():GameObjectScript("go_hardcore_memorial"){}
    bool OnGossipHello(Player* player,GameObject* go) override
    {
        if(!player || !go || !player->IsInMap(go) || !player->IsWithinDistInMap(go,7.0f) || !(player->GetPhaseMask()&go->GetPhaseMask()))return true;
        std::lock_guard<std::mutex> lock(memorialMutex);
        auto state=mapMemorials.find(go->GetMap());if(state==mapMemorials.end())return true;
        for(auto const& [id,guid]:state->second.spawned)
            if(guid==go->GetGUID())
            {
                auto found=memorials.find(id);if(found!=memorials.end())SendMemorial(player,found->second);
                break;
            }
        return true; // Suppress native gossip: the client owns the memorial presentation.
    }
};
}

void HardcoreMemorialCapture(Player* player,Unit* killer,uint32 spell,uint8 environment,uint32 diedAt)
{
    if(player->GetHardcoreState()!=1 || player->GetSession()->IsBot())return;
    uint32 id=player->GetGUID().GetCounter();
    std::string cause="Причина не установлена",killerName="—",spellName="—";
    if(environment!=255)
    {
        char const* causes[]={"Истощение","Утопление","Падение","Лава","Огонь","Ядовитая среда","Падение в бездну"};
        if(environment<7)cause=causes[environment];else cause="Окружающая среда";
    }
    else if(killer && killer!=player) {cause="Смертельный удар";killerName=killer->GetNameForLocaleIdx(LOCALE_ruRU);}
    else if(killer==player)cause="Урон самому себе";
    if(SpellInfo const* info=sSpellMgr->GetSpellInfo(spell))spellName=info->SpellName[LOCALE_ruRU][0]?info->SpellName[LOCALE_ruRU]:info->SpellName[0];
    std::string zone="Неизвестная местность",mapName="Неизвестная карта";
    if(auto const* area=sAreaTableStore.LookupEntry(player->GetZoneId()))zone=area->area_name[LOCALE_ruRU][0]?area->area_name[LOCALE_ruRU]:area->area_name[0];
    if(auto const* map=sMapStore.LookupEntry(player->GetMapId()))mapName=map->name[LOCALE_ruRU][0]?map->name[LOCALE_ruRU]:map->name[0];
    std::string guildName;
    if (Guild* guild = sGuildMgr->GetGuildById(player->GetGuildId()))
        guildName = guild->GetName();
    std::ostringstream payload;
    payload<<id<<'\t'<<Clean(player->GetName())<<'\t'<<uint32(player->getRace())<<'\t'<<uint32(player->getClass())<<'\t'<<uint32(player->getGender())
        <<'\t'<<uint32(player->GetLevel())<<'\t'<<diedAt<<'\t'<<player->GetTotalPlayedTime()<<'\t'<<Clean(killerName)<<'\t'<<Clean(spellName)
        <<'\t'<<player->GetHardcorePacts()<<'\t'<<(player->IsSolitary()?1:0)<<'\t'<<Clean(guildName)<<'\t'<<Clean(zone)
        <<'\t'<<Clean(mapName)<<'\t'<<Clean(cause)<<'\t'<<spell<<'\t'<<player->GetZoneId()<<'\t'<<(killer?killer->GetLevel():0);
    std::string escaped=payload.str();CharacterDatabase.EscapeString(escaped);
    CharacterDatabase.DirectExecute("INSERT INTO character_hardcore_memorial (guid,map_id,instance_id,phase_mask,died_at,x,y,z,orientation,payload) "
        "SELECT {},{},{},{},{},{},{},{},{},'{}' FROM character_hardcore_attempt WHERE guid={} AND state=1 "
        "ON DUPLICATE KEY UPDATE map_id=VALUES(map_id),instance_id=VALUES(instance_id),phase_mask=VALUES(phase_mask),died_at=VALUES(died_at),"
        "x=VALUES(x),y=VALUES(y),z=VALUES(z),orientation=VALUES(orientation),payload=VALUES(payload)",id,player->GetMapId(),player->GetInstanceId(),player->GetPhaseMask(),diedAt,
        player->GetPositionX(),player->GetPositionY(),player->GetPositionZ(),player->GetOrientation(),escaped,id);
    QueryResult check=CharacterDatabase.Query("SELECT payload,died_at FROM character_hardcore_memorial WHERE guid={}",id);
    if(!check || check->Fetch()[0].Get<std::string>()!=payload.str() || check->Fetch()[1].Get<uint32>()!=diedAt)
        throw std::runtime_error("Hardcore memorial snapshot not confirmed before death journal");
}
void HardcoreMemorialPublish(Player* player)
{
    QueryResult result=CharacterDatabase.Query("{} AND m.guid={}",SelectConfirmed,player->GetGUID().GetCounter());
    if(!result)throw std::runtime_error("Hardcore memorial publication requires confirmed death");
    auto record=Read(result->Fetch());std::lock_guard<std::mutex> lock(memorialMutex);memorials[record.guid]=std::move(record);
}
void AddHardcoreMemorialScripts()
{ new HardcoreMemorialWorld();new HardcoreMemorialMaps();new HardcoreMemorialStone(); }
