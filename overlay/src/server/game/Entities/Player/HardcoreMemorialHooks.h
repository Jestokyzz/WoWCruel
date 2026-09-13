#ifndef JESTOKY_HARDCORE_MEMORIAL_HOOKS_H
#define JESTOKY_HARDCORE_MEMORIAL_HOOKS_H
#include <cstdint>
class Player;
class Unit;
class SpellInfo;
void HardcoreRecordDeathWithSource(Player* player, Unit* killer, SpellInfo const* spell);
void HardcoreMemorialCapture(Player* player, Unit* killer, std::uint32_t spell, std::uint8_t environment, std::uint32_t diedAt);
void HardcoreMemorialPublish(Player* player);
struct HardcoreEnvironmentScope
{
    HardcoreEnvironmentScope(Player* player, std::uint8_t type);
    ~HardcoreEnvironmentScope();
    Player* previousPlayer;
    std::uint8_t previousType;
};
#endif
