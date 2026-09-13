#ifndef WORLD_QUEST_OBJECTIVE_DATA_H
#define WORLD_QUEST_OBJECTIVE_DATA_H

#include "DataMap.h"
#include "Define.h"

#include <unordered_map>
#include <unordered_set>

struct WorldQuestObjectiveData : DataMap::Base
{
    std::unordered_set<uint32> GameObjects;
    std::unordered_map<uint32, uint32> Items;
};

#endif
