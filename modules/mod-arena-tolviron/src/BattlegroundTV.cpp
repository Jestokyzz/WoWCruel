/*
 * Copyright (C) 2011-2020 Project SkyFire <http://www.projectskyfire.org/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Arena.h"
#include "Battleground.h"
#include "GameObject.h"
#include "ObjectMgr.h"
#include "Transport.h"
#include "ScriptedCreature.h"
#include "GameGraveyard.h"

#include "BattlegroundMgr.h"
#include "Player.h"
#include "WorldPacket.h"
#include "Language.h"
#include <unordered_map>

#include "ScriptMgr.h"
#include "Config.h"

enum BattlegroundTVObjectTypes
{
    BG_TV_OBJECT_DOOR_1         = 0,
    BG_TV_OBJECT_DOOR_2         = 1,
    BG_TV_OBJECT_BUFF_1         = 2,
    BG_TV_OBJECT_BUFF_2         = 3,
    BG_TV_OBJECT_MAX            = 4
};

enum BattlegroundTVObjects
{
    BG_TV_OBJECT_TYPE_DOOR_1    = 213196,
    BG_TV_OBJECT_TYPE_DOOR_2    = 213197,
    BG_TV_OBJECT_TYPE_BUFF_1    = 184663,
    BG_TV_OBJECT_TYPE_BUFF_2    = 184664
};

class AC_GAME_API BattlegroundTV : public Arena
{
    public:
        BattlegroundTV();
        ~BattlegroundTV();

        /* inherited from BattlegroundClass */
        // void AddPlayer(Player* player);
        void StartingEventCloseDoors() override;
        void StartingEventOpenDoors() override;

        // void RemovePlayer(Player* player);
        void HandleAreaTrigger(Player* player, uint32 trigger) override;
        bool SetupBattleground() override;
        void FillInitialWorldStates(WorldPackets::WorldState::InitWorldStates& packet) override;
        // void HandleKillPlayer(Player* player, Player* killer);

        // /* Scorekeeping */
        // bool UpdatePlayerScore(Player* Source, uint32 type, uint32 value, bool doAddHonor = true) override;
};



// adding Battleground to the core battlegrounds list
BattlegroundTypeId BATTLEGROUND_TV = BattlegroundTypeId(102); // internal uint8 ID; .pvpport alias is 870
BattlegroundQueueTypeId BATTLEGROUND_QUEUE_TV = BattlegroundQueueTypeId(0);
constexpr uint32 ARENA_SHADOW_SIGHT_RESPAWN = 90;


BattlegroundTV::BattlegroundTV()
{
    BgObjects.resize(BG_TV_OBJECT_MAX);
}

BattlegroundTV::~BattlegroundTV() { }

void BattlegroundTV::StartingEventCloseDoors()
{
	for (uint32 i = BG_TV_OBJECT_DOOR_1; i <= BG_TV_OBJECT_DOOR_2; ++i)
        SpawnBGObject(i, RESPAWN_IMMEDIATELY);

    for (uint32 i = BG_TV_OBJECT_BUFF_1; i <= BG_TV_OBJECT_BUFF_2; ++i)
        SpawnBGObject(i, RESPAWN_ONE_DAY);
}

void BattlegroundTV::StartingEventOpenDoors()
{
    for (uint32 i = BG_TV_OBJECT_DOOR_1; i <= BG_TV_OBJECT_DOOR_2; ++i)
        DoorOpen(i);

    for (uint32 i = BG_TV_OBJECT_BUFF_1; i <= BG_TV_OBJECT_BUFF_2; ++i)
        SpawnBGObject(i, ARENA_SHADOW_SIGHT_RESPAWN);
}

// void BattlegroundTV::AddPlayer(Player* player)
// {
//     Battleground::AddPlayer(player);
//     PlayerScores[player->GetGUID()] = new BattlegroundScore(player);
//     Battleground::UpdateArenaWorldState();
// }

// void BattlegroundTV::RemovePlayer(Player* /*player*/)
// {
//     if (GetStatus() == STATUS_WAIT_LEAVE)
//         return;

//     Battleground::UpdateArenaWorldState();
//     CheckArenaWinConditions();
// }

// void BattlegroundTV::HandleKillPlayer(Player* player, Player* killer)
// {
//     if (GetStatus() != STATUS_IN_PROGRESS)
//         return;

//     if (!killer)
//     {
//         sLog->outError("BattlegroundTV: Killer player not found");
//         return;
//     }

//     Battleground::HandleKillPlayer(player, killer);

//     Battleground::UpdateArenaWorldState();
//     CheckArenaWinConditions();
// }

void BattlegroundTV::HandleAreaTrigger(Player* /* player */, uint32 trigger)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    switch (trigger)
    {
        case 4536:
        case 4537:
            break;
        default:
            break;
    }
}

void BattlegroundTV::FillInitialWorldStates(WorldPackets::WorldState::InitWorldStates& packet)
{
    packet.Worldstates.emplace_back(0xE1A, 1);
    Arena::FillInitialWorldStates(packet);
}

bool BattlegroundTV::SetupBattleground()
{
    // gates
    if (!AddObject(BG_TV_OBJECT_DOOR_1, BG_TV_OBJECT_TYPE_DOOR_1, -10774.6f, 430.992f, 24.41076f, 0.0156f, 0.0f, 0.0f, 0.00779992f, 0.99996958f, RESPAWN_IMMEDIATELY)
        || !AddObject(BG_TV_OBJECT_DOOR_2, BG_TV_OBJECT_TYPE_DOOR_2, -10655.0f, 428.117f, 24.416f, 3.148f, 0.0f, 0.0f, 0.99999487f, -0.00320367f, RESPAWN_IMMEDIATELY)
        // buffs
        || !AddObject(BG_TV_OBJECT_BUFF_1, BG_TV_OBJECT_TYPE_BUFF_1, -10717.63f, 383.8223f, 24.412825f, 1.555f, 0.0f, 0.0f, 0.70149994f, 0.71266951f, ARENA_SHADOW_SIGHT_RESPAWN)
        || !AddObject(BG_TV_OBJECT_BUFF_2, BG_TV_OBJECT_TYPE_BUFF_2, -10716.6f, 475.364f, 24.4131f, 0.0f, 0.0f, 0.0f, 1.0f, ARENA_SHADOW_SIGHT_RESPAWN))
    {
        LOG_ERROR("sql.sql", "BattlegroundTV: Failed to spawn some object!");
        return false;
    }

    return true;
}

// void BattlegroundTV::UpdatePlayerScore(Player* Source, uint32 type, uint32 value, bool doAddHonor)
// {
//     BattlegroundScoreMap::iterator itr = PlayerScores.find(Source->GetGUID());
//     if (itr == PlayerScores.end())                         // player not found...
//         return;

//     //there is nothing special in this score
//     Battleground::UpdatePlayerScore(Source, type, value, doAddHonor);
// }

class TolVironWorld : public WorldScript
{
	public:
    	TolVironWorld() : WorldScript("TolVironWorld") { }
};

void AddTolVironScripts() {
	new TolVironWorld();

	// Add Tol Viron to battleground list
	BattlegroundMgr::bgToQueue[BATTLEGROUND_TV] = BATTLEGROUND_QUEUE_TV;
	BattlegroundMgr::bgtypeToBattleground[BATTLEGROUND_TV] = new BattlegroundTV;

	BattlegroundMgr::bgTypeToTemplate[BATTLEGROUND_TV] = [](Battleground *bg_t) -> Battleground * { return new BattlegroundTV(*(BattlegroundTV *)bg_t); };

	Player::bgZoneIdToFillWorldStates[6296] = [](Battleground* bg, WorldPackets::WorldState::InitWorldStates& packet) {
    if (bg && bg->GetBgTypeID(true) == BATTLEGROUND_TV) {
      bg->FillInitialWorldStates(packet);
    }
    else
    {
        packet.Worldstates.emplace_back(0xa0f, 0);      // 7
        packet.Worldstates.emplace_back(0xa10, 0);      // 8
        packet.Worldstates.emplace_back(0xa11, 0);      // 9 show
    }
	};
}
