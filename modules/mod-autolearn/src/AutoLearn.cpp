#include "Chat.h"
#include "Config.h"
#include "DisableMgr.h"
#include "Formulas.h"
#include "Item.h"
#include "ItemScript.h"
#include "LFGMgr.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "PlayerScript.h"
#include "QuestDef.h"
#include "ScriptMgr.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "Trainer.h"
#include "WorldScript.h"
#include "WorldSession.h"
#include "World.h"

#include <array>

namespace
{
struct AutoLearnConfig
{
    bool Enabled = true;
    bool TrainerSpells = true;
    bool QuestSpells = true;
    bool LoginCatchUp = true;
    bool RequiredItems = true;
    bool Announce = true;
    bool IncludeBots = false;
};

AutoLearnConfig Config;

struct RequiredClassItem
{
    uint32 ItemId;
    uint8 RequiredLevel;
};

constexpr std::array<RequiredClassItem, 4> ShamanTotems = {{
    { 5175, 4 },  // Earth Totem
    { 5176, 10 }, // Fire Totem
    { 5177, 20 }, // Water Totem
    { 5178, 30 }  // Air Totem
}};

bool ShouldProcess(Player const* player)
{
    if (!Config.Enabled || !player || !player->GetSession())
        return false;

    return Config.IncludeBots || !player->GetSession()->IsBot();
}

uint32 LearnTrainerSpells(Player* player)
{
    uint32 learned = 0;
    bool hadNewSpells;

    do
    {
        hadNewSpells = false;
        for (Trainer::Trainer const* trainer : sObjectMgr->GetClassTrainers(player->getClass()))
        {
            if (!trainer->IsTrainerValidForPlayer(player))
                continue;

            for (Trainer::Spell const& trainerSpell : trainer->GetSpells())
            {
                if (!trainer->CanTeachSpell(player, &trainerSpell))
                    continue;

                if (trainerSpell.IsCastable())
                    player->CastSpell(player, trainerSpell.SpellId, true);
                else
                    player->learnSpell(trainerSpell.SpellId, false);

                ++learned;
                hadNewSpells = true;
            }
        }
    } while (hadNewSpells);

    return learned;
}

bool HasPendingQuestRewardSpell(Player const* player, Quest const* quest)
{
    int32 rewardSpellId = quest->GetRewSpellCast();
    if (rewardSpellId <= 0)
        return false;

    SpellInfo const* rewardSpell = sSpellMgr->GetSpellInfo(rewardSpellId);
    if (!rewardSpell)
        return false;

    for (SpellEffectInfo const& effect : rewardSpell->GetEffects())
    {
        if (!effect.IsEffect(SPELL_EFFECT_LEARN_SPELL) || !effect.TriggerSpell || player->HasSpell(effect.TriggerSpell))
            continue;

        SpellInfo const* learnedSpell = sSpellMgr->GetSpellInfo(effect.TriggerSpell);
        if (learnedSpell && learnedSpell->GetEffect(EFFECT_0).IsEffect(SPELL_EFFECT_TRADE_SKILL))
            continue;

        return true;
    }

    return false;
}

uint32 LearnQuestSpells(Player* player)
{
    uint32 learned = 0;

    for (auto const& [questId, quest] : sObjectMgr->GetQuestTemplates())
    {
        if (!quest->GetRequiredClasses() || !HasPendingQuestRewardSpell(player, quest))
            continue;

        if (sDisableMgr->IsDisabledFor(DISABLE_TYPE_QUEST, questId, player))
            continue;

        if (!player->SatisfyQuestClass(quest, false) || !player->SatisfyQuestRace(quest, false) ||
            !player->SatisfyQuestLevel(quest, false) || !player->SatisfyQuestSkill(quest, false))
            continue;

        player->learnQuestRewardedSpells(quest);
        if (!HasPendingQuestRewardSpell(player, quest))
            ++learned;
    }

    return learned;
}

uint32 GiveRequiredItems(Player* player)
{
    if (!player->IsClass(CLASS_SHAMAN, CLASS_CONTEXT_SKILL))
        return 0;

    uint32 given = 0;
    for (RequiredClassItem const& item : ShamanTotems)
    {
        if (player->GetLevel() < item.RequiredLevel || player->HasItemCount(item.ItemId, 1, true))
            continue;

        if (player->AddItem(item.ItemId, 1))
            ++given;
        else if (Config.Announce)
            ChatHandler(player->GetSession()).PSendSysMessage(
                "Автоизучение: освободите место в сумках для обязательного классового предмета {}.", item.ItemId);
    }

    return given;
}

void ProcessAutoLearn(Player* player)
{
    if (!ShouldProcess(player))
        return;

    uint32 learned = 0;
    uint32 items = 0;

    if (Config.TrainerSpells)
        learned += LearnTrainerSpells(player);

    if (Config.QuestSpells)
        learned += LearnQuestSpells(player);

    if (Config.RequiredItems)
        items = GiveRequiredItems(player);

    if (Config.Announce && (learned || items))
        ChatHandler(player->GetSession()).PSendSysMessage(
            "Автоизучение: изучено способностей: {}, получено обязательных предметов: {}.", learned, items);
}
}

class AutoLearnWorldScript : public WorldScript
{
public:
    AutoLearnWorldScript() : WorldScript("AutoLearnWorldScript", { WORLDHOOK_ON_AFTER_CONFIG_LOAD }) { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        Config.Enabled = sConfigMgr->GetOption<bool>("AutoLearn.Enable", true);
        Config.TrainerSpells = sConfigMgr->GetOption<bool>("AutoLearn.TrainerSpells", true);
        Config.QuestSpells = sConfigMgr->GetOption<bool>("AutoLearn.QuestSpells", true);
        Config.LoginCatchUp = sConfigMgr->GetOption<bool>("AutoLearn.LoginCatchUp", true);
        Config.RequiredItems = sConfigMgr->GetOption<bool>("AutoLearn.RequiredItems", true);
        Config.Announce = sConfigMgr->GetOption<bool>("AutoLearn.Announce", true);
        Config.IncludeBots = sConfigMgr->GetOption<bool>("AutoLearn.IncludeBots", false);

        LOG_INFO("module.autolearn", "AutoLearn is {} (trainer: {}, quest: {}, login catch-up: {}, required items: {}, bots: {})",
            Config.Enabled ? "enabled" : "disabled", Config.TrainerSpells, Config.QuestSpells, Config.LoginCatchUp,
            Config.RequiredItems, Config.IncludeBots);
    }
};

class AutoLearnPlayerScript : public PlayerScript
{
public:
    AutoLearnPlayerScript() : PlayerScript("AutoLearnPlayerScript", {
        PLAYERHOOK_ON_LEVEL_CHANGED,
        PLAYERHOOK_ON_LOGIN,
        PLAYERHOOK_ON_VICTIM_REWARD_AFTER
    }) { }

    void OnPlayerLevelChanged(Player* player, uint8 /*oldLevel*/) override
    {
        ProcessAutoLearn(player);
    }

    void OnPlayerLogin(Player* player) override
    {
        if (Config.LoginCatchUp)
            ProcessAutoLearn(player);
    }

    void OnPlayerVictimRewardAfter(Player* player, Player* /*victim*/, uint32& /*killerTitle*/,
        int32& /*victimRank*/, float& /*honor*/) override
    {
        if (!player || player->InArena() || player->GetLevel() >= sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
            return;

        // A Warsong Gulch flag capture rewards bonus honor equivalent to two
        // honorable kills. Award one tenth of the XP produced by that activity,
        // independently of the battleground/map where this honorable kill occurs.
        float flagHonor = Acore::Honor::hk_honor_at_level(player->GetLevel(), 2.0f) * sWorld->getRate(RATE_HONOR);
        uint32 flagXP = static_cast<uint32>(flagHonor * (3.0f + player->GetLevel() * 0.30f) *
            sWorld->getRate(RATE_XP_BATTLEGROUND_BONUS));
        uint32 killXP = std::max<uint32>(1, flagXP / 10);

        sScriptMgr->OnPlayerGiveXP(player, killXP, nullptr, PlayerXPSource::XPSOURCE_BATTLEGROUND);
        player->GiveXP(killXP, nullptr);
    }
};

class item_jestoky_deserter_cleanser : public ItemScript
{
public:
    item_jestoky_deserter_cleanser() : ItemScript("item_jestoky_deserter_cleanser") { }

    bool OnUse(Player* player, Item* item, SpellCastTargets const& /*targets*/) override
    {
        constexpr uint32 BattlegroundDeserter = 26013;

        player->RemoveAurasDueToSpell(BattlegroundDeserter);
        player->RemoveAurasDueToSpell(lfg::LFG_SPELL_DUNGEON_DESERTER);
        player->RemoveAurasDueToSpell(lfg::LFG_SPELL_DUNGEON_COOLDOWN);
        if (player->GetSession())
            ChatHandler(player->GetSession()).SendSysMessage(
                "Штрафы за выход с поля боя и из подземелья сняты.");

        // Let the harmless instant item spell complete normally. This sends
        // the client its cast completion and consumes one charged use, which
        // prevents the item from remaining grey and the player from appearing
        // to cast forever.
        return false;
    }
};

void AddAutoLearnScripts()
{
    new AutoLearnWorldScript();
    new AutoLearnPlayerScript();
    new item_jestoky_deserter_cleanser();
}
