#ifndef MOD_SPIRIT_REGEN_H
#define MOD_SPIRIT_REGEN_H

#include "Define.h"

class Player;

namespace SpiritRegen
{
struct Settings
{
    bool Enabled = false;
    bool PreserveVanillaOutOfCast = true;
    bool StrictMode = true;
    bool AuditUnknownFlatRegen = true;
    bool Debug = false;
    uint32 UpdateIntervalMs = 500;
    float CombatMp5PerSpirit = 0.5f;
    float PaladinMultiplier = 1.0f;
    float HunterMultiplier = 1.0f;
    float PriestMultiplier = 1.0f;
    float ShamanMultiplier = 1.0f;
    float MageMultiplier = 1.0f;
    float WarlockMultiplier = 1.0f;
    float DruidMultiplier = 1.0f;
};

struct Snapshot
{
    float Spirit = 0.0f;
    float Intellect = 0.0f;
    float FlatManaPerSecond = 0.0f;
    float AllowedActiveManaPerSecond = 0.0f;
    float BlockedPassiveManaPerSecond = 0.0f;
    float VanillaSpiritPerSecond = 0.0f;
    float NormalizedSpiritPerSecond = 0.0f;
    float SpiritRegenMultiplier = 1.0f;
    float CastingSpiritMultiplier = 1.0f;
    float NormalRegenPerSecond = 0.0f;
    float InterruptedRegenPerSecond = 0.0f;
    uint32 BlockedAuraCount = 0;
};

Settings const& GetSettings();
void LoadConfig();
bool SupportsPlayer(Player const* player);
Snapshot CalculateAndApply(Player* player, bool apply);
}

#endif
