#include "Bag.h"
#include "CollectionPreviewCreatures.h"
#include <chrono>
#include <map>
#include "Chat.h"
#include "CharacterDatabase.h"
#include "Item.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "PlayerScript.h"
#include "ScriptMgr.h"
#include "SharedDefines.h"
#include "StringFormat.h"
#include "WorldPacket.h"
#include "WorldSession.h"

#include <algorithm>
#include <array>
#include <charconv>
#include <optional>
#include <string>
#include <string_view>
#include <unordered_map>
#include <unordered_set>
#include <vector>

namespace
{
constexpr std::string_view AddonPrefix = "WCollections\t";
constexpr std::size_t MaxPayloadSize = 220;

struct CatalogEntry
{
    uint32 ItemId = 0;
    uint32 DisplayId = 0;
    ItemTemplate const* Template = nullptr;
    std::string Packed;
};

using AppearanceSet = std::unordered_set<uint32>;

std::unordered_map<std::string, std::vector<CatalogEntry>> Catalog;
std::unordered_map<uint32, AppearanceSet> AccountAppearances;
std::unordered_set<uint32> LoadedAccounts;
std::unordered_map<uint32, uint32> ItemTransmogs;
std::unordered_set<uint32> LoadedCharacters;

constexpr uint32 HiddenVisualItem = 15;

void SendAddon(Player* player, std::string_view payload);

std::string GetCatalogSlot(ItemTemplate const* itemTemplate)
{
    switch (itemTemplate->InventoryType)
    {
        case INVTYPE_HEAD: return "HEAD";
        case INVTYPE_SHOULDERS: return "SHOULDER";
        case INVTYPE_BODY: return "SHIRT";
        case INVTYPE_CHEST:
        case INVTYPE_ROBE: return "CHEST";
        case INVTYPE_WAIST: return "WAIST";
        case INVTYPE_LEGS: return "LEGS";
        case INVTYPE_FEET: return "FEET";
        case INVTYPE_WRISTS: return "WRIST";
        case INVTYPE_HANDS: return "HANDS";
        case INVTYPE_CLOAK: return "BACK";
        case INVTYPE_TABARD: return "TABARD";
        case INVTYPE_SHIELD: return "SHIELD";
        case INVTYPE_HOLDABLE: return "HOLDABLE";
        default: break;
    }

    if (itemTemplate->Class != ITEM_CLASS_WEAPON)
        return {};

    switch (itemTemplate->SubClass)
    {
        case ITEM_SUBCLASS_WEAPON_AXE: return "1H_AXE";
        case ITEM_SUBCLASS_WEAPON_AXE2: return "2H_AXE";
        case ITEM_SUBCLASS_WEAPON_BOW: return "BOW";
        case ITEM_SUBCLASS_WEAPON_GUN: return "GUN";
        case ITEM_SUBCLASS_WEAPON_MACE: return "1H_MACE";
        case ITEM_SUBCLASS_WEAPON_MACE2: return "2H_MACE";
        case ITEM_SUBCLASS_WEAPON_POLEARM: return "POLEARM";
        case ITEM_SUBCLASS_WEAPON_SWORD: return "1H_SWORD";
        case ITEM_SUBCLASS_WEAPON_SWORD2: return "2H_SWORD";
        case ITEM_SUBCLASS_WEAPON_STAFF: return "STAFF";
        case ITEM_SUBCLASS_WEAPON_FIST: return "FIST";
        case ITEM_SUBCLASS_WEAPON_MISC: return "MISC";
        case ITEM_SUBCLASS_WEAPON_DAGGER: return "DAGGER";
        case ITEM_SUBCLASS_WEAPON_THROWN: return "THROWN";
        case ITEM_SUBCLASS_WEAPON_CROSSBOW: return "CROSSBOW";
        case ITEM_SUBCLASS_WEAPON_WAND: return "WAND";
        case ITEM_SUBCLASS_WEAPON_FISHING_POLE: return "FISHING_POLE";
        default: return {};
    }
}

uint32 GetPrimaryArmorSubclass(Player const* player)
{
    switch (player->getClass())
    {
        case CLASS_PRIEST:
        case CLASS_MAGE:
        case CLASS_WARLOCK: return ITEM_SUBCLASS_ARMOR_CLOTH;
        case CLASS_ROGUE:
        case CLASS_DRUID: return ITEM_SUBCLASS_ARMOR_LEATHER;
        case CLASS_HUNTER:
        case CLASS_SHAMAN: return ITEM_SUBCLASS_ARMOR_MAIL;
        case CLASS_WARRIOR:
        case CLASS_PALADIN:
        case CLASS_DEATH_KNIGHT: return ITEM_SUBCLASS_ARMOR_PLATE;
        default: return ITEM_SUBCLASS_ARMOR_MISC;
    }
}

bool IsEligibleTemplate(Player const* player, ItemTemplate const* itemTemplate)
{
    if (!itemTemplate || itemTemplate->DisplayInfoID == 0 || GetCatalogSlot(itemTemplate).empty())
        return false;

    if (itemTemplate->Quality < ITEM_QUALITY_UNCOMMON)
        return false;

    uint32 classMask = 1u << (player->getClass() - 1);
    uint32 raceMask = 1u << (player->getRace() - 1);
    if (itemTemplate->AllowableClass && !(itemTemplate->AllowableClass & classMask))
        return false;
    if (itemTemplate->AllowableRace && !(itemTemplate->AllowableRace & raceMask))
        return false;

    if (itemTemplate->Class == ITEM_CLASS_ARMOR &&
        itemTemplate->SubClass >= ITEM_SUBCLASS_ARMOR_CLOTH &&
        itemTemplate->SubClass <= ITEM_SUBCLASS_ARMOR_PLATE &&
        itemTemplate->SubClass != GetPrimaryArmorSubclass(player))
        return false;

    return true;
}

void BuildCatalog()
{
    if (!Catalog.empty())
        return;

    for (auto const& [itemId, itemTemplate] : *sObjectMgr->GetItemTemplateStore())
    {
        std::string slot = GetCatalogSlot(&itemTemplate);
        if (slot.empty() || itemTemplate.DisplayInfoID == 0 || itemTemplate.Quality < ITEM_QUALITY_UNCOMMON)
            continue;

        std::string packed = Acore::StringFormat("{}I{}", itemId, itemTemplate.InventoryType - 1);
        if (itemTemplate.Class == ITEM_CLASS_WEAPON)
            packed += "E";
        else if (itemTemplate.Class == ITEM_CLASS_ARMOR)
            packed += Acore::StringFormat("A{}", itemTemplate.SubClass);

        Catalog[slot].push_back({ itemId, itemTemplate.DisplayInfoID, &itemTemplate, std::move(packed) });
    }

    for (auto& [slot, entries] : Catalog)
        std::sort(entries.begin(), entries.end(), [](CatalogEntry const& left, CatalogEntry const& right) { return left.ItemId < right.ItemId; });
}

AppearanceSet& GetAppearances(uint32 accountId)
{
    AppearanceSet& appearances = AccountAppearances[accountId];
    if (LoadedAccounts.insert(accountId).second)
    {
        QueryResult result = CharacterDatabase.Query(Acore::StringFormat(
            "SELECT `appearance_id` FROM `account_transmog_appearance` WHERE `account_id` = {}", accountId));
        if (result)
        {
            do
            {
                appearances.insert(result->Fetch()[0].Get<uint32>());
            } while (result->NextRow());
        }
    }
    return appearances;
}

std::optional<int32> ParseInt(std::string_view value)
{
    int32 result = 0;
    auto [end, error] = std::from_chars(value.data(), value.data() + value.size(), result);
    if (error != std::errc() || end != value.data() + value.size())
        return std::nullopt;
    return result;
}

std::vector<std::string_view> Split(std::string_view value, char delimiter)
{
    std::vector<std::string_view> result;
    while (true)
    {
        std::size_t position = value.find(delimiter);
        result.push_back(value.substr(0, position));
        if (position == std::string_view::npos)
            return result;
        value.remove_prefix(position + 1);
    }
}

void LoadTransmogs(Player* player)
{
    uint32 ownerGuid = player->GetGUID().GetCounter();
    if (!LoadedCharacters.insert(ownerGuid).second)
        return;

    QueryResult result = CharacterDatabase.Query(Acore::StringFormat(
        "SELECT `item_guid`, `fake_entry` FROM `item_instance_transmog` WHERE `owner_guid` = {}", ownerGuid));
    if (!result)
        return;

    do
    {
        Field* fields = result->Fetch();
        ItemTransmogs[fields[0].Get<uint32>()] = fields[1].Get<uint32>();
    } while (result->NextRow());
}

uint32 GetFakeEntry(Item const* item)
{
    if (!item)
        return 0;
    auto itr = ItemTransmogs.find(item->GetGUID().GetCounter());
    return itr == ItemTransmogs.end() ? 0 : itr->second;
}

bool IsCollected(Player* player, ItemTemplate const* sourceTemplate)
{
    if (!sourceTemplate || sourceTemplate->DisplayInfoID == 0)
        return false;
    AppearanceSet const& appearances = GetAppearances(player->GetSession()->GetAccountId());
    return appearances.contains(sourceTemplate->DisplayInfoID);
}

bool IsCompatible(ItemTemplate const* target, ItemTemplate const* source)
{
    if (!target || !source || target->Class != source->Class)
        return false;

    if (target->Class == ITEM_CLASS_WEAPON)
        return target->SubClass == source->SubClass;

    if (target->Class != ITEM_CLASS_ARMOR || target->SubClass != source->SubClass)
        return false;

    bool targetChest = target->InventoryType == INVTYPE_CHEST || target->InventoryType == INVTYPE_ROBE;
    bool sourceChest = source->InventoryType == INVTYPE_CHEST || source->InventoryType == INVTYPE_ROBE;
    return target->InventoryType == source->InventoryType || (targetChest && sourceChest);
}

bool CanHideSlot(uint8 slot)
{
    switch (slot)
    {
        case EQUIPMENT_SLOT_HEAD:
        case EQUIPMENT_SLOT_SHOULDERS:
        case EQUIPMENT_SLOT_BODY:
        case EQUIPMENT_SLOT_CHEST:
        case EQUIPMENT_SLOT_WAIST:
        case EQUIPMENT_SLOT_LEGS:
        case EQUIPMENT_SLOT_FEET:
        case EQUIPMENT_SLOT_WRISTS:
        case EQUIPMENT_SLOT_HANDS:
        case EQUIPMENT_SLOT_BACK:
        case EQUIPMENT_SLOT_TABARD:
            return true;
        default:
            return false;
    }
}

void SetFakeEntry(Player* player, Item* item, uint32 fakeEntry)
{
    uint32 itemGuid = item->GetGUID().GetCounter();
    if (fakeEntry == 0)
    {
        ItemTransmogs.erase(itemGuid);
        CharacterDatabase.Execute(Acore::StringFormat(
            "DELETE FROM `item_instance_transmog` WHERE `item_guid` = {}", itemGuid));
    }
    else
    {
        ItemTransmogs[itemGuid] = fakeEntry;
        CharacterDatabase.Execute(Acore::StringFormat(
            "INSERT INTO `item_instance_transmog` (`item_guid`, `owner_guid`, `fake_entry`) VALUES ({}, {}, {}) "
            "ON DUPLICATE KEY UPDATE `owner_guid` = VALUES(`owner_guid`), `fake_entry` = VALUES(`fake_entry`)",
            itemGuid, player->GetGUID().GetCounter(), fakeEntry));
    }

    player->SetUInt32Value(PLAYER_VISIBLE_ITEM_1_ENTRYID + (item->GetSlot() * 2),
        fakeEntry == HiddenVisualItem ? 0 : (fakeEntry ? fakeEntry : item->GetEntry()));
}

std::string PackItemTransmog(uint32 slot, Item const* item)
{
    if (!item)
        return {};
    return Acore::StringFormat("{}={},{},,0,:", slot, item->GetEntry(), GetFakeEntry(item));
}

void SendAllTransmogs(Player* player)
{
    std::string payload = "GETTRANSMOG:ALL:";
    for (uint8 slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; ++slot)
    {
        std::string packed = PackItemTransmog(slot, player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot));
        if (payload.size() + packed.size() + 3 > MaxPayloadSize)
        {
            SendAddon(player, payload);
            payload = "GETTRANSMOG:ALL:";
        }
        payload += packed;
    }
    payload += "END";
    SendAddon(player, payload);
}

struct PendingChange
{
    uint8 Slot = 0;
    Item* Target = nullptr;
    uint32 FakeEntry = 0;
};

bool ValidateChanges(Player* player, std::string_view key, std::vector<PendingChange>& changes,
    std::string& entryFailures, std::string& enchantFailures)
{
    std::vector<std::string_view> records = Split(key, ':');
    for (std::size_t index = 1; index < records.size(); ++index)
    {
        if (records[index].empty())
            continue;
        std::size_t equals = records[index].find('=');
        if (equals == std::string_view::npos)
            return false;

        auto clientSlot = ParseInt(records[index].substr(0, equals));
        std::vector<std::string_view> values = Split(records[index].substr(equals + 1), ',');
        if (!clientSlot || *clientSlot < 1 || *clientSlot > EQUIPMENT_SLOT_END || values.size() != 6)
            return false;

        uint8 slot = uint8(*clientSlot - 1);
        Item* target = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot);
        auto baseEntry = ParseInt(values[0]);
        auto pendingEntry = ParseInt(values[4]);
        auto pendingEnchant = ParseInt(values[5]);
        if (!target || !baseEntry || uint32(*baseEntry) != target->GetEntry() || !pendingEntry || !pendingEnchant)
            return false;

        if (*pendingEnchant != 0)
        {
            if (!enchantFailures.empty())
                enchantFailures += ',';
            enchantFailures += Acore::StringFormat("{}=ILLUSIONS_NOT_SUPPORTED", *clientSlot);
        }

        if (*pendingEntry == 0)
            continue;

        uint32 fakeEntry = *pendingEntry == -1 ? 0 : uint32(*pendingEntry);
        bool valid = false;
        if (fakeEntry == HiddenVisualItem)
            valid = CanHideSlot(slot);
        else if (ItemTemplate const* source = sObjectMgr->GetItemTemplate(fakeEntry))
            valid = IsCollected(player, source) && IsEligibleTemplate(player, source) &&
                IsCompatible(target->GetTemplate(), source);

        if (!valid)
        {
            if (!entryFailures.empty())
                entryFailures += ',';
            entryFailures += Acore::StringFormat("{}=APPEARANCE_NOT_COLLECTED_OR_INCOMPATIBLE", *clientSlot);
            continue;
        }
        changes.push_back({ slot, target, fakeEntry });
    }
    return true;
}

void HandleTransmogrify(Player* player, std::string_view operation, std::string_view key)
{
    std::vector<PendingChange> changes;
    std::string entryFailures;
    std::string enchantFailures;
    if (!ValidateChanges(player, key, changes, entryFailures, enchantFailures))
    {
        SendAddon(player, Acore::StringFormat("TRANSMOGRIFY:{}:FAIL:INVALID_REQUEST", operation));
        return;
    }

    if (!entryFailures.empty() || !enchantFailures.empty())
    {
        SendAddon(player, Acore::StringFormat("TRANSMOGRIFY:{}:FAIL:{}:{}:{}", operation,
            entryFailures, enchantFailures, key));
        return;
    }

    if (operation == "APPLY")
        for (PendingChange const& change : changes)
            SetFakeEntry(player, change.Target, change.FakeEntry);

    SendAddon(player, Acore::StringFormat("TRANSMOGRIFY:{}:OK:0:0:{}", operation, key));
}

void SendAddon(Player* player, std::string_view payload)
{
    std::string message(AddonPrefix);
    message.append(payload);
    WorldPacket packet;
    ChatHandler::BuildChatPacket(packet, CHAT_MSG_WHISPER, LANG_ADDON, ObjectGuid::Empty, player->GetGUID(), message,
        CHAT_TAG_NONE, "", player->GetName());
    player->GetSession()->SendPacket(&packet);
}

void SendCatalog(Player* player, std::string const& slot)
{
    BuildCatalog();
    std::string prefix = "LIST:ALL:" + slot + ":";
    std::string payload = prefix;
    auto itr = Catalog.find(slot);
    if (itr != Catalog.end())
    {
        for (CatalogEntry const& entry : itr->second)
        {
            if (!IsEligibleTemplate(player, entry.Template))
                continue;

            std::string token = entry.Packed + ":";
            if (payload.size() + token.size() + 3 > MaxPayloadSize)
            {
                SendAddon(player, payload);
                payload = prefix;
            }
            payload += token;
        }
    }
    payload += "END";
    SendAddon(player, payload);
}

void SendCollected(Player* player)
{
    BuildCatalog();
    AppearanceSet const& appearances = GetAppearances(player->GetSession()->GetAccountId());
    std::string prefix = "LIST:SKIN:";
    std::string payload = prefix;
    for (auto const& [slot, entries] : Catalog)
    {
        for (CatalogEntry const& entry : entries)
        {
            if (!appearances.contains(entry.DisplayId) || !IsEligibleTemplate(player, entry.Template))
                continue;

            std::string token = Acore::StringFormat("{}:", entry.ItemId);
            if (payload.size() + token.size() + 3 > MaxPayloadSize)
            {
                SendAddon(player, payload);
                payload = prefix;
            }
            payload += token;
        }
    }
    payload += "END";
    SendAddon(player, payload);
}

// Creature entries are server template IDs, not CreatureDisplayInfo IDs.
// Reuse the core serializer so locale, model variants and packet layout stay native.
std::map<ObjectGuid, std::chrono::steady_clock::time_point> PreviewRequests;

void SendCollectionPreview(Player* player, std::string_view request)
{
    auto entry = ParseInt(request);
    if (!entry || *entry <= 0 || !std::binary_search(CollectionPreviewCreatures.begin(),
        CollectionPreviewCreatures.end(), uint32(*entry)))
        return;

    auto now = std::chrono::steady_clock::now();
    auto& last = PreviewRequests[player->GetGUID()];
    if (now - last < std::chrono::milliseconds(200))
        return;
    last = now;

    if (!sObjectMgr->GetCreatureTemplate(uint32(*entry)))
    {
        SendAddon(player, Acore::StringFormat("PREVIEWCACHE:{}:MISSING", *entry));
        return;
    }

    WorldPacket query(CMSG_CREATURE_QUERY, sizeof(uint32) + sizeof(uint64));
    query << uint32(*entry) << ObjectGuid::Empty;
    player->GetSession()->HandleCreatureQueryOpcode(query);
    SendAddon(player, Acore::StringFormat("PREVIEWCACHE:{}:OK", *entry));
}

void SendItemCacheBatch(Player* player, uint32 offset)
{
    BuildCatalog();
    std::vector<uint32> itemIds;
    for (auto const& [slot, entries] : Catalog)
        for (CatalogEntry const& entry : entries)
            if (IsEligibleTemplate(player, entry.Template))
                itemIds.push_back(entry.ItemId);

    std::sort(itemIds.begin(), itemIds.end());
    itemIds.erase(std::unique(itemIds.begin(), itemIds.end()), itemIds.end());

    constexpr uint32 BatchSize = 50;
    uint32 total = uint32(itemIds.size());
    uint32 end = std::min(offset + BatchSize, total);
    for (uint32 index = std::min(offset, total); index < end; ++index)
    {
        WorldPacket query(CMSG_ITEM_QUERY_SINGLE, sizeof(uint32));
        query << itemIds[index];
        player->GetSession()->HandleItemQuerySingleOpcode(query);
    }

    SendAddon(player, Acore::StringFormat("PRELOADCACHE:ITEMS:{}:{}", end, total));
}

void SendSearchResults(Player* player, std::string_view request)
{
    std::vector<std::string_view> fields = Split(request, ':');
    if (fields.size() < 3)
        return;

    auto searchType = ParseInt(fields[0]);
    auto token = ParseInt(fields[1]);
    if (!searchType || !token || *searchType < 1 || *token < 0)
        return;

    std::string responsePrefix = Acore::StringFormat("TRANSMOGRIFY:SEARCH:{}:{}:", *searchType, *token);

    // WCollections uses search types 2 and 3 for outfit sets.  This module
    // deliberately exposes item appearances from the model collection only.
    if (*searchType != 1)
    {
        SendAddon(player, responsePrefix + "OK:0");
        return;
    }

    BuildCatalog();
    std::vector<uint32> results;
    auto catalog = Catalog.find(std::string(fields[2]));
    if (catalog != Catalog.end())
    {
        ItemTemplate const* targetTemplate = nullptr;
        if (fields.size() >= 5)
        {
            std::vector<std::string_view> equipped = Split(fields[4], ',');
            if (equipped.size() >= 2)
                if (auto targetItemId = ParseInt(equipped[1]); targetItemId && *targetItemId > 0)
                    targetTemplate = sObjectMgr->GetItemTemplate(uint32(*targetItemId));
        }

        for (CatalogEntry const& entry : catalog->second)
        {
            if (!IsEligibleTemplate(player, entry.Template))
                continue;
            if (targetTemplate && !IsCompatible(targetTemplate, entry.Template))
                continue;
            results.push_back(entry.ItemId);
        }
    }

    SendAddon(player, responsePrefix + Acore::StringFormat("OK:{}", results.size()));
    if (results.empty())
        return;

    std::string resultsPrefix = responsePrefix + "RESULTS:";
    std::string payload = resultsPrefix;
    for (uint32 itemId : results)
    {
        std::string value = Acore::StringFormat("{}:", itemId);
        if (payload.size() + value.size() + 3 > MaxPayloadSize)
        {
            SendAddon(player, payload);
            payload = resultsPrefix;
        }
        payload += value;
    }
    payload += "END";
    SendAddon(player, payload);
}

void LearnAppearance(Player* player, Item* item)
{
    if (!player || !item || !item->IsSoulBound() || item->IsBOPTradable() || !IsEligibleTemplate(player, item->GetTemplate()))
        return;

    uint32 accountId = player->GetSession()->GetAccountId();
    uint32 displayId = item->GetTemplate()->DisplayInfoID;
    AppearanceSet& appearances = GetAppearances(accountId);
    if (!appearances.insert(displayId).second)
        return;

    CharacterDatabase.Execute(Acore::StringFormat(
        "INSERT IGNORE INTO `account_transmog_appearance` "
        "(`account_id`, `appearance_id`, `source_item_id`, `learned_by_guid`) VALUES ({}, {}, {}, {})",
        accountId, displayId, item->GetEntry(), player->GetGUID().GetCounter()));

    BuildCatalog();
    for (auto const& [slot, entries] : Catalog)
        for (CatalogEntry const& entry : entries)
            if (entry.DisplayId == displayId && IsEligibleTemplate(player, entry.Template))
                SendAddon(player, Acore::StringFormat("ADD:SKIN:{}", entry.ItemId));
}

void ScanInventory(Player* player)
{
    for (uint8 slot = EQUIPMENT_SLOT_START; slot < INVENTORY_SLOT_ITEM_END; ++slot)
        LearnAppearance(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot));

    for (uint8 bagSlot = INVENTORY_SLOT_BAG_START; bagSlot < INVENTORY_SLOT_BAG_END; ++bagSlot)
        if (Bag* bag = player->GetBagByPos(bagSlot))
            for (uint32 slot = 0; slot < bag->GetBagSize(); ++slot)
                LearnAppearance(player, bag->GetItemByPos(slot));
}

bool HandleAddonMessage(Player* player, uint32 type, uint32 language, std::string const& message)
{
    if (type != CHAT_MSG_WHISPER || language != LANG_ADDON || !message.starts_with(AddonPrefix))
        return true;

    std::string_view command(message.data() + AddonPrefix.size(), message.size() - AddonPrefix.size());
    if (command.starts_with("VERSION:"))
        SendAddon(player, "SERVERVERSION:1.2.0:OK");
    else if (command == "GETTRANSMOG:ALL")
    {
        SendAllTransmogs(player);
        SendAddon(player, "COLLECTIONS:SKIN:END");
        SendAddon(player, "CACHEVERSION:1");
    }
    else if (command.starts_with("GETTRANSMOG:"))
    {
        std::string_view request = command.substr(12);
        if (auto slot = ParseInt(request); slot && *slot >= EQUIPMENT_SLOT_START && *slot < EQUIPMENT_SLOT_END)
        {
            Item* item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, uint8(*slot));
            SendAddon(player, "GETTRANSMOG:" + PackItemTransmog(uint32(*slot), item) + "END");
        }
        else
            SendAddon(player, "GETTRANSMOG:END");
    }
    else if (command.starts_with("TRANSMOGRIFY:COST:"))
        HandleTransmogrify(player, "COST", command.substr(18));
    else if (command.starts_with("TRANSMOGRIFY:APPLY:"))
        HandleTransmogrify(player, "APPLY", command.substr(19));
    else if (command.starts_with("TRANSMOGRIFY:SEARCH:"))
        SendSearchResults(player, command.substr(20));
    else if (command.starts_with("PREVIEWCACHE:"))
        SendCollectionPreview(player, command.substr(13));
    else if (command.starts_with("PRELOADCACHE:ITEMS:"))
    {
        auto offset = ParseInt(command.substr(19));
        if (offset && *offset >= 0)
            SendItemCacheBatch(player, uint32(*offset));
        else
            SendAddon(player, "PRELOADCACHE:ITEMS:INVALID_OFFSET");
    }
    else if (command == "LIST:SKIN")
        SendCollected(player);
    else if (command.starts_with("LIST:ALL:"))
        SendCatalog(player, std::string(command.substr(9)));
    else if (command.starts_with("LIST:DATA:"))
        SendAddon(player, std::string(command) + ":END");

    return false;
}

class AccountAppearancePlayerScript : public PlayerScript
{
public:
    AccountAppearancePlayerScript() : PlayerScript("AccountAppearancePlayerScript") { }

    void OnPlayerLogin(Player* player) override
    {
        GetAppearances(player->GetSession()->GetAccountId());
        LoadTransmogs(player);
        ScanInventory(player);
        for (uint8 slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; ++slot)
            if (Item* item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot))
                if (uint32 fakeEntry = GetFakeEntry(item))
                    player->SetUInt32Value(PLAYER_VISIBLE_ITEM_1_ENTRYID + (slot * 2),
                        fakeEntry == HiddenVisualItem ? 0 : fakeEntry);
    }

    void OnPlayerLogout(Player* player) override
    {
        PreviewRequests.erase(player->GetGUID());
        LoadedCharacters.erase(player->GetGUID().GetCounter());
    }

    void OnPlayerDelete(ObjectGuid guid, uint32 /*accountId*/) override
    {
        CharacterDatabase.Execute(Acore::StringFormat(
            "DELETE FROM `item_instance_transmog` WHERE `owner_guid` = {}", guid.GetCounter()));
        LoadedCharacters.erase(guid.GetCounter());
    }

    void OnPlayerStoreNewItem(Player* player, Item* item, uint32 /*count*/) override { LearnAppearance(player, item); }
    void OnPlayerCreateItem(Player* player, Item* item, uint32 /*count*/) override { LearnAppearance(player, item); }
    void OnPlayerQuestRewardItem(Player* player, Item* item, uint32 /*count*/) override { LearnAppearance(player, item); }
    void OnPlayerEquip(Player* player, Item* item, uint8 /*bag*/, uint8 /*slot*/, bool /*update*/) override { LearnAppearance(player, item); }

    void OnPlayerAfterSetVisibleItemSlot(Player* player, uint8 slot, Item* item) override
    {
        if (!item)
            return;
        if (uint32 fakeEntry = GetFakeEntry(item))
            player->SetUInt32Value(PLAYER_VISIBLE_ITEM_1_ENTRYID + (slot * 2),
                fakeEntry == HiddenVisualItem ? 0 : fakeEntry);
    }

    bool OnPlayerCanUseChat(Player* player, uint32 type, uint32 language, std::string& message, Player* /*receiver*/) override
    {
        return HandleAddonMessage(player, type, language, message);
    }
};
}

void AddAccountAppearanceScripts()
{
    new AccountAppearancePlayerScript();
}
