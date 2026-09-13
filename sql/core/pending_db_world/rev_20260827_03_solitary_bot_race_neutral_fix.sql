-- Generated race-neutral Solitary gear upgrade; do not edit manually.
-- Every row is guarded by its previous item entry and is safe to re-run.
START TRANSACTION;
-- pve-toc-dk-blood-tank slot 11: Signet of the Traitor King -> Clutch of Fortification
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47731 WHERE `template_id` = 204002 AND `equipment_slot` = 11 AND `item_entry` = 47157;
-- pvp-a5-dk-unholy slot 17: Deadly Gladiator's Sigil of Strife -> Sigil of Awareness
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 40207 WHERE `template_id` = 101004 AND `equipment_slot` = 17 AND `item_entry` = 42620;
-- pvp-a6-dk-unholy slot 10: Furious Gladiator's Band of Triumph -> Seal of the Betrayed King
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45534 WHERE `template_id` = 102004 AND `equipment_slot` = 10 AND `item_entry` = 42117;
-- pvp-a6-dk-unholy slot 11: Furious Gladiator's Band of Dominance -> Furious Gladiator's Band of Triumph
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42117 WHERE `template_id` = 102004 AND `equipment_slot` = 11 AND `item_entry` = 42116;
-- pvp-a6-dk-unholy slot 13: Medallion of the Alliance -> Mjolnir Runestone
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45931 WHERE `template_id` = 102004 AND `equipment_slot` = 13 AND `item_entry` = 42124;
-- pvp-a7-dk-unholy slot 10: Relentless Gladiator's Band of Victory -> Band of the Violent Temperment
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 46966 WHERE `template_id` = 103004 AND `equipment_slot` = 10 AND `item_entry` = 42119;
-- pvp-a7-dk-unholy slot 11: Relentless Gladiator's Band of Ascendancy -> Relentless Gladiator's Band of Victory
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42119 WHERE `template_id` = 103004 AND `equipment_slot` = 11 AND `item_entry` = 42118;
-- pvp-a8-dk-unholy slot 5: Wrathful Gladiator's Girdle of Triumph -> Coldwraith Links
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50620 WHERE `template_id` = 104004 AND `equipment_slot` = 5 AND `item_entry` = 51362;
-- pvp-a8-dk-unholy slot 8: Wrathful Gladiator's Bracers of Triumph -> Bracers of the Heir
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 54559 WHERE `template_id` = 104004 AND `equipment_slot` = 8 AND `item_entry` = 51364;
-- pvp-a8-dk-unholy slot 10: Wrathful Gladiator's Band of Triumph -> Ashen Band of Endless Might
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 52572 WHERE `template_id` = 104004 AND `equipment_slot` = 10 AND `item_entry` = 51358;
-- pvp-a8-dk-unholy slot 11: Wrathful Gladiator's Band of Dominance -> Wrathful Gladiator's Band of Triumph
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51358 WHERE `template_id` = 104004 AND `equipment_slot` = 11 AND `item_entry` = 51336;
-- pvp-a8-dk-unholy slot 13: Medallion of the Alliance -> Death's Choice
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47464 WHERE `template_id` = 104004 AND `equipment_slot` = 13 AND `item_entry` = 51377;
-- pvp-a8-dk-unholy slot 14: Wrathful Gladiator's Cloak of Victory -> Vereesa's Dexterity
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47545 WHERE `template_id` = 104004 AND `equipment_slot` = 14 AND `item_entry` = 51356;
-- pvp-a5-druid-balance slot 12: Medallion of the Horde -> Flow of Knowledge
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 44912 WHERE `template_id` = 101005 AND `equipment_slot` = 12 AND `item_entry` = 42122;
-- pvp-a5-druid-balance slot 13: Medallion of the Alliance -> Bitter Balebrew Charm
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 49116 WHERE `template_id` = 101005 AND `equipment_slot` = 13 AND `item_entry` = 42123;
-- pvp-a6-druid-balance slot 12: Medallion of the Alliance -> Pandora's Plea
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45490 WHERE `template_id` = 102005 AND `equipment_slot` = 12 AND `item_entry` = 42124;
-- pvp-a6-druid-balance slot 13: Medallion of the Horde -> Flow of Knowledge
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 44912 WHERE `template_id` = 102005 AND `equipment_slot` = 13 AND `item_entry` = 42126;
-- pvp-a7-druid-balance slot 10: Relentless Gladiator's Band of Ascendancy -> Ashen Band of Destruction
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50377 WHERE `template_id` = 103005 AND `equipment_slot` = 10 AND `item_entry` = 42118;
-- pvp-a7-druid-balance slot 11: Relentless Gladiator's Band of Victory -> Relentless Gladiator's Band of Ascendancy
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42118 WHERE `template_id` = 103005 AND `equipment_slot` = 11 AND `item_entry` = 42119;
-- pvp-a7-druid-balance slot 13: Medallion of the Alliance -> Pandora's Plea
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45490 WHERE `template_id` = 103005 AND `equipment_slot` = 13 AND `item_entry` = 42124;
-- pvp-a8-druid-balance slot 10: Wrathful Gladiator's Band of Dominance -> Ashen Band of Endless Destruction
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50398 WHERE `template_id` = 104005 AND `equipment_slot` = 10 AND `item_entry` = 51336;
-- pvp-a8-druid-balance slot 11: Wrathful Gladiator's Band of Triumph -> Wrathful Gladiator's Band of Dominance
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51336 WHERE `template_id` = 104005 AND `equipment_slot` = 11 AND `item_entry` = 51358;
-- pvp-a8-druid-balance slot 13: Medallion of the Alliance -> Talisman of Volatile Power
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47946 WHERE `template_id` = 104005 AND `equipment_slot` = 13 AND `item_entry` = 51377;
-- pvp-a5-druid-feral-dps slot 12: Medallion of the Horde -> Banner of Victory
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47214 WHERE `template_id` = 101006 AND `equipment_slot` = 12 AND `item_entry` = 42122;
-- pvp-a5-druid-feral-dps slot 13: Medallion of the Alliance -> Bitter Balebrew Charm
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 49116 WHERE `template_id` = 101006 AND `equipment_slot` = 13 AND `item_entry` = 42123;
-- pvp-a6-druid-feral-dps slot 13: Medallion of the Alliance -> Banner of Victory
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47214 WHERE `template_id` = 102006 AND `equipment_slot` = 13 AND `item_entry` = 42124;
-- pvp-a7-druid-feral-dps slot 11: Relentless Gladiator's Band of Ascendancy -> Ring of Callous Aggression
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47070 WHERE `template_id` = 103006 AND `equipment_slot` = 11 AND `item_entry` = 42118;
-- pvp-a7-druid-feral-dps slot 13: Medallion of the Alliance -> Banner of Victory
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47214 WHERE `template_id` = 103006 AND `equipment_slot` = 13 AND `item_entry` = 42124;
-- pvp-a8-druid-feral-dps slot 7: Wrathful Gladiator's Boots of Triumph -> Frostbitten Fur Boots
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50607 WHERE `template_id` = 104006 AND `equipment_slot` = 7 AND `item_entry` = 51369;
-- pvp-a8-druid-feral-dps slot 8: Wrathful Gladiator's Armwraps of Triumph -> Toskk's Maximized Wristguards
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50670 WHERE `template_id` = 104006 AND `equipment_slot` = 8 AND `item_entry` = 51370;
-- pvp-a8-druid-feral-dps slot 10: Wrathful Gladiator's Band of Triumph -> Frostbrood Sapphire Ring
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50618 WHERE `template_id` = 104006 AND `equipment_slot` = 10 AND `item_entry` = 51358;
-- pvp-a8-druid-feral-dps slot 11: Wrathful Gladiator's Band of Dominance -> Ashen Band of Endless Vengeance
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50402 WHERE `template_id` = 104006 AND `equipment_slot` = 11 AND `item_entry` = 51336;
-- pvp-a8-druid-feral-dps slot 13: Medallion of the Alliance -> Needle-Encrusted Scorpion
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50198 WHERE `template_id` = 104006 AND `equipment_slot` = 13 AND `item_entry` = 51377;
-- pve-toc-druid-feral-tank slot 10: Signet of the Traitor King -> Clutch of Fortification
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47731 WHERE `template_id` = 204007 AND `equipment_slot` = 10 AND `item_entry` = 47157;
-- pve-toc-druid-feral-tank slot 11: Clutch of Fortification -> Loop of the Twin Val'kyr
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47955 WHERE `template_id` = 204007 AND `equipment_slot` = 11 AND `item_entry` = 47731;
-- pvp-a5-druid-restoration slot 12: Medallion of the Horde -> Flow of Knowledge
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 44912 WHERE `template_id` = 101008 AND `equipment_slot` = 12 AND `item_entry` = 42122;
-- pvp-a5-druid-restoration slot 13: Medallion of the Alliance -> Bitter Balebrew Charm
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 49116 WHERE `template_id` = 101008 AND `equipment_slot` = 13 AND `item_entry` = 42123;
-- pvp-a6-druid-restoration slot 13: Medallion of the Alliance -> Meteorite Crystal
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 46051 WHERE `template_id` = 102008 AND `equipment_slot` = 13 AND `item_entry` = 42124;
-- pvp-a7-druid-restoration slot 11: Relentless Gladiator's Band of Victory -> Heartmender Circle
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47733 WHERE `template_id` = 103008 AND `equipment_slot` = 11 AND `item_entry` = 42119;
-- pvp-a8-druid-restoration slot 10: Wrathful Gladiator's Band of Dominance -> Ashen Band of Unmatched Wisdom
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50399 WHERE `template_id` = 104008 AND `equipment_slot` = 10 AND `item_entry` = 51336;
-- pvp-a8-druid-restoration slot 11: Wrathful Gladiator's Band of Triumph -> Wrathful Gladiator's Band of Dominance
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51336 WHERE `template_id` = 104008 AND `equipment_slot` = 11 AND `item_entry` = 51358;
-- pve-toc-druid-restoration slot 11: Ring of the Darkmender -> Band of the Invoker
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47732 WHERE `template_id` = 204008 AND `equipment_slot` = 11 AND `item_entry` = 47224;
-- pvp-a5-hunter-marksmanship slot 13: Medallion of the Alliance -> Darkmoon Card: Greatness
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 44253 WHERE `template_id` = 101010 AND `equipment_slot` = 13 AND `item_entry` = 42123;
-- pvp-a6-hunter-marksmanship slot 10: Furious Gladiator's Band of Triumph -> Brann's Signet Ring
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45608 WHERE `template_id` = 102010 AND `equipment_slot` = 10 AND `item_entry` = 42117;
-- pvp-a6-hunter-marksmanship slot 11: Furious Gladiator's Band of Dominance -> Furious Gladiator's Band of Triumph
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42117 WHERE `template_id` = 102010 AND `equipment_slot` = 11 AND `item_entry` = 42116;
-- pvp-a6-hunter-marksmanship slot 12: Medallion of the Alliance -> Mjolnir Runestone
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45931 WHERE `template_id` = 102010 AND `equipment_slot` = 12 AND `item_entry` = 42124;
-- pvp-a6-hunter-marksmanship slot 13: Medallion of the Horde -> Grim Toll
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 40256 WHERE `template_id` = 102010 AND `equipment_slot` = 13 AND `item_entry` = 42126;
-- pvp-a7-hunter-marksmanship slot 10: Relentless Gladiator's Band of Victory -> Ring of Callous Aggression
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47075 WHERE `template_id` = 103010 AND `equipment_slot` = 10 AND `item_entry` = 42119;
-- pvp-a7-hunter-marksmanship slot 11: Relentless Gladiator's Band of Ascendancy -> Relentless Gladiator's Band of Victory
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42119 WHERE `template_id` = 103010 AND `equipment_slot` = 11 AND `item_entry` = 42118;
-- pvp-a7-hunter-marksmanship slot 13: Medallion of the Alliance -> Mjolnir Runestone
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45931 WHERE `template_id` = 103010 AND `equipment_slot` = 13 AND `item_entry` = 42124;
-- pvp-a8-hunter-marksmanship slot 1: Wrathful Gladiator's Pendant of Victory -> Sindragosa's Cruel Claw
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50633 WHERE `template_id` = 104010 AND `equipment_slot` = 1 AND `item_entry` = 51357;
-- pvp-a8-hunter-marksmanship slot 5: Wrathful Gladiator's Waistguard of Triumph -> Nerub'ar Stalker's Cord
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50688 WHERE `template_id` = 104010 AND `equipment_slot` = 5 AND `item_entry` = 51350;
-- pvp-a8-hunter-marksmanship slot 8: Wrathful Gladiator's Wristguards of Triumph -> Scourge Hunter's Vambraces
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50655 WHERE `template_id` = 104010 AND `equipment_slot` = 8 AND `item_entry` = 51352;
-- pvp-a8-hunter-marksmanship slot 13: Medallion of the Alliance -> Death's Verdict
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47131 WHERE `template_id` = 104010 AND `equipment_slot` = 13 AND `item_entry` = 51377;
-- pvp-a8-hunter-marksmanship slot 14: Wrathful Gladiator's Cloak of Victory -> Vereesa's Dexterity
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47545 WHERE `template_id` = 104010 AND `equipment_slot` = 14 AND `item_entry` = 51356;
-- pvp-a5-hunter-survival slot 12: Medallion of the Alliance -> Darkmoon Card: Greatness
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 44253 WHERE `template_id` = 101011 AND `equipment_slot` = 12 AND `item_entry` = 42123;
-- pvp-a5-hunter-survival slot 13: Medallion of the Horde -> Mirror of Truth
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 40684 WHERE `template_id` = 101011 AND `equipment_slot` = 13 AND `item_entry` = 42122;
-- pvp-a6-hunter-survival slot 10: Furious Gladiator's Band of Triumph -> Brann's Signet Ring
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45608 WHERE `template_id` = 102011 AND `equipment_slot` = 10 AND `item_entry` = 42117;
-- pvp-a6-hunter-survival slot 11: Furious Gladiator's Band of Dominance -> Furious Gladiator's Band of Triumph
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42117 WHERE `template_id` = 102011 AND `equipment_slot` = 11 AND `item_entry` = 42116;
-- pvp-a6-hunter-survival slot 12: Medallion of the Alliance -> Darkmoon Card: Greatness
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 44253 WHERE `template_id` = 102011 AND `equipment_slot` = 12 AND `item_entry` = 42124;
-- pvp-a6-hunter-survival slot 13: Medallion of the Horde -> Mirror of Truth
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 40684 WHERE `template_id` = 102011 AND `equipment_slot` = 13 AND `item_entry` = 42126;
-- pvp-a7-hunter-survival slot 10: Relentless Gladiator's Band of Victory -> Ring of Callous Aggression
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47075 WHERE `template_id` = 103011 AND `equipment_slot` = 10 AND `item_entry` = 42119;
-- pvp-a7-hunter-survival slot 11: Relentless Gladiator's Band of Ascendancy -> Relentless Gladiator's Band of Victory
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42119 WHERE `template_id` = 103011 AND `equipment_slot` = 11 AND `item_entry` = 42118;
-- pvp-a7-hunter-survival slot 13: Medallion of the Alliance -> Darkmoon Card: Greatness
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 44253 WHERE `template_id` = 103011 AND `equipment_slot` = 13 AND `item_entry` = 42124;
-- pvp-a8-hunter-survival slot 13: Medallion of the Alliance -> Death's Verdict
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47131 WHERE `template_id` = 104011 AND `equipment_slot` = 13 AND `item_entry` = 51377;
-- pvp-a5-mage-frost slot 5: Deadly Gladiator's Cord of Dominance -> Titan-Forged Cord of Salvation
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 46080 WHERE `template_id` = 101014 AND `equipment_slot` = 5 AND `item_entry` = 41897;
-- pvp-a6-mage-frost slot 1: Furious Gladiator's Pendant of Subjugation -> Pendant of Fiery Havoc
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45133 WHERE `template_id` = 102014 AND `equipment_slot` = 1 AND `item_entry` = 42038;
-- pvp-a6-mage-frost slot 5: Furious Gladiator's Cord of Dominance -> Starwatcher's Binding
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45619 WHERE `template_id` = 102014 AND `equipment_slot` = 5 AND `item_entry` = 41898;
-- pvp-a6-mage-frost slot 7: Furious Gladiator's Slippers of Dominance -> Boots of Fiery Resolution
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45135 WHERE `template_id` = 102014 AND `equipment_slot` = 7 AND `item_entry` = 41903;
-- pvp-a6-mage-frost slot 8: Furious Gladiator's Cuffs of Dominance -> Titan-Forged Cuffs of Salvation
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 48979 WHERE `template_id` = 102014 AND `equipment_slot` = 8 AND `item_entry` = 41909;
-- pvp-a6-mage-frost slot 10: Furious Gladiator's Band of Dominance -> Starshine Circle
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45614 WHERE `template_id` = 102014 AND `equipment_slot` = 10 AND `item_entry` = 42116;
-- pvp-a6-mage-frost slot 11: Furious Gladiator's Band of Triumph -> Conductive Seal
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45495 WHERE `template_id` = 102014 AND `equipment_slot` = 11 AND `item_entry` = 42117;
-- pvp-a6-mage-frost slot 13: Medallion of the Alliance -> Scale of Fates
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45466 WHERE `template_id` = 102014 AND `equipment_slot` = 13 AND `item_entry` = 42124;
-- pvp-a6-mage-frost slot 14: Furious Gladiator's Cloak of Ascendancy -> Drape of Mortal Downfall
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45242 WHERE `template_id` = 102014 AND `equipment_slot` = 14 AND `item_entry` = 42071;
-- pvp-a7-mage-frost slot 1: Relentless Gladiator's Pendant of Subjugation -> Wail of the Val'kyr
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47144 WHERE `template_id` = 103014 AND `equipment_slot` = 1 AND `item_entry` = 42045;
-- pvp-a7-mage-frost slot 5: Relentless Gladiator's Cord of Alacrity -> Cord of the Tenebrous Mist
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 46973 WHERE `template_id` = 103014 AND `equipment_slot` = 5 AND `item_entry` = 49179;
-- pvp-a8-mage-frost slot 1: Wrathful Gladiator's Pendant of Subjugation -> Amulet of the Silent Eulogy
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50658 WHERE `template_id` = 104014 AND `equipment_slot` = 1 AND `item_entry` = 51333;
-- pvp-a8-mage-frost slot 5: Wrathful Gladiator's Cord of Alacrity -> Crushing Coldwraith Belt
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50613 WHERE `template_id` = 104014 AND `equipment_slot` = 5 AND `item_entry` = 51337;
-- pvp-a8-mage-frost slot 6: Wrathful Gladiator's Silk Trousers -> Plaguebringer's Stained Pants
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50694 WHERE `template_id` = 104014 AND `equipment_slot` = 6 AND `item_entry` = 51466;
-- pvp-a8-mage-frost slot 7: Wrathful Gladiator's Treads of Alacrity -> Plague Scientist's Boots
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50699 WHERE `template_id` = 104014 AND `equipment_slot` = 7 AND `item_entry` = 51338;
-- pvp-a8-mage-frost slot 10: Wrathful Gladiator's Band of Dominance -> Ring of Rapid Ascent
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50664 WHERE `template_id` = 104014 AND `equipment_slot` = 10 AND `item_entry` = 51336;
-- pvp-a8-mage-frost slot 11: Wrathful Gladiator's Band of Triumph -> Ashen Band of Endless Destruction
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50398 WHERE `template_id` = 104014 AND `equipment_slot` = 11 AND `item_entry` = 51358;
-- pvp-a8-mage-frost slot 13: Medallion of the Alliance -> Reign of the Unliving
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47188 WHERE `template_id` = 104014 AND `equipment_slot` = 13 AND `item_entry` = 51377;
-- pvp-a8-mage-frost slot 14: Wrathful Gladiator's Cloak of Subjugation -> Jaina's Radiance
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47552 WHERE `template_id` = 104014 AND `equipment_slot` = 14 AND `item_entry` = 51332;
-- pvp-a8-mage-frost slot 17: Wrathful Gladiator's Wand of Alacrity -> Corpse-Impaling Spike
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50684 WHERE `template_id` = 104014 AND `equipment_slot` = 17 AND `item_entry` = 51451;
-- pvp-a5-paladin-holy slot 12: Medallion of the Horde -> Flow of Knowledge
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 44912 WHERE `template_id` = 101015 AND `equipment_slot` = 12 AND `item_entry` = 42122;
-- pvp-a5-paladin-holy slot 13: Medallion of the Alliance -> Bitter Balebrew Charm
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 49116 WHERE `template_id` = 101015 AND `equipment_slot` = 13 AND `item_entry` = 42123;
-- pvp-a6-paladin-holy slot 12: Medallion of the Alliance -> Meteorite Crystal
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 46051 WHERE `template_id` = 102015 AND `equipment_slot` = 12 AND `item_entry` = 42124;
-- pvp-a6-paladin-holy slot 13: Medallion of the Horde -> Flow of Knowledge
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 44912 WHERE `template_id` = 102015 AND `equipment_slot` = 13 AND `item_entry` = 42126;
-- pvp-a8-paladin-holy slot 10: Wrathful Gladiator's Band of Dominance -> Ashen Band of Endless Wisdom
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50400 WHERE `template_id` = 104015 AND `equipment_slot` = 10 AND `item_entry` = 51336;
-- pvp-a8-paladin-holy slot 11: Wrathful Gladiator's Band of Triumph -> Ashen Band of Unmatched Wisdom
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50399 WHERE `template_id` = 104015 AND `equipment_slot` = 11 AND `item_entry` = 51358;
-- pve-toc-paladin-holy slot 10: Ring of the Darkmender -> Conductive Seal
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45495 WHERE `template_id` = 204015 AND `equipment_slot` = 10 AND `item_entry` = 47224;
-- pve-toc-paladin-holy slot 11: Circle of the Darkmender -> Starshine Circle
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45614 WHERE `template_id` = 204015 AND `equipment_slot` = 11 AND `item_entry` = 47439;
-- pve-icc-normal-paladin-holy slot 11: Ring of the Darkmender -> Conductive Seal
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45495 WHERE `template_id` = 205015 AND `equipment_slot` = 11 AND `item_entry` = 47224;
-- pve-toc-paladin-protection slot 11: Signet of the Traitor King -> Clutch of Fortification
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47731 WHERE `template_id` = 204016 AND `equipment_slot` = 11 AND `item_entry` = 47157;
-- pvp-a5-paladin-retribution slot 11: Deadly Gladiator's Band of Ascendancy -> Ruthlessness
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 40075 WHERE `template_id` = 101017 AND `equipment_slot` = 11 AND `item_entry` = 42114;
-- pvp-a6-paladin-retribution slot 1: Furious Gladiator's Pendant of Triumph -> Pendulum of Infinity
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45517 WHERE `template_id` = 102017 AND `equipment_slot` = 1 AND `item_entry` = 42034;
-- pvp-a6-paladin-retribution slot 5: Furious Gladiator's Girdle of Triumph -> Belt of Colossal Rage
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45241 WHERE `template_id` = 102017 AND `equipment_slot` = 5 AND `item_entry` = 40881;
-- pvp-a6-paladin-retribution slot 7: Furious Gladiator's Greaves of Triumph -> Sabatons of Lifeless Night
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45599 WHERE `template_id` = 102017 AND `equipment_slot` = 7 AND `item_entry` = 40882;
-- pvp-a6-paladin-retribution slot 8: Furious Gladiator's Bracers of Triumph -> Armbands of Bedlam
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45663 WHERE `template_id` = 102017 AND `equipment_slot` = 8 AND `item_entry` = 40889;
-- pvp-a6-paladin-retribution slot 10: Furious Gladiator's Band of Triumph -> Seal of the Betrayed King
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45534 WHERE `template_id` = 102017 AND `equipment_slot` = 10 AND `item_entry` = 42117;
-- pvp-a6-paladin-retribution slot 11: Furious Gladiator's Band of Dominance -> Brann's Signet Ring
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45608 WHERE `template_id` = 102017 AND `equipment_slot` = 11 AND `item_entry` = 42116;
-- pvp-a6-paladin-retribution slot 14: Furious Gladiator's Cloak of Triumph -> Drape of Icy Intent
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45461 WHERE `template_id` = 102017 AND `equipment_slot` = 14 AND `item_entry` = 42074;
-- pvp-a7-paladin-retribution slot 1: Relentless Gladiator's Pendant of Triumph -> Charge of the Demon Lord
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47060 WHERE `template_id` = 103017 AND `equipment_slot` = 1 AND `item_entry` = 42041;
-- pvp-a7-paladin-retribution slot 5: Relentless Gladiator's Girdle of Triumph -> Belt of the Merciless Killer
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47112 WHERE `template_id` = 103017 AND `equipment_slot` = 5 AND `item_entry` = 40883;
-- pvp-a7-paladin-retribution slot 7: Relentless Gladiator's Greaves of Triumph -> Greaves of the 7th Legion
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47154 WHERE `template_id` = 103017 AND `equipment_slot` = 7 AND `item_entry` = 40884;
-- pvp-a7-paladin-retribution slot 8: Relentless Gladiator's Bracers of Triumph -> Bracers of Dark Determination
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47155 WHERE `template_id` = 103017 AND `equipment_slot` = 8 AND `item_entry` = 40890;
-- pvp-a7-paladin-retribution slot 10: Relentless Gladiator's Band of Victory -> Ring of Callous Aggression
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47075 WHERE `template_id` = 103017 AND `equipment_slot` = 10 AND `item_entry` = 42119;
-- pvp-a7-paladin-retribution slot 11: Relentless Gladiator's Band of Ascendancy -> Band of Callous Aggression
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47443 WHERE `template_id` = 103017 AND `equipment_slot` = 11 AND `item_entry` = 42118;
-- pvp-a7-paladin-retribution slot 14: Relentless Gladiator's Cloak of Triumph -> Cloak of the Victorious Combatant
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 48674 WHERE `template_id` = 103017 AND `equipment_slot` = 14 AND `item_entry` = 42081;
-- pvp-a8-paladin-retribution slot 14: Wrathful Gladiator's Cloak of Triumph -> Varian's Furor
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47547 WHERE `template_id` = 104017 AND `equipment_slot` = 14 AND `item_entry` = 51354;
-- pvp-a5-priest-discipline slot 5: Deadly Gladiator's Cord of Dominance -> Titan-Forged Cord of Salvation
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 46080 WHERE `template_id` = 101018 AND `equipment_slot` = 5 AND `item_entry` = 41897;
-- pvp-a6-priest-discipline slot 8: Furious Gladiator's Cuffs of Dominance -> Titan-Forged Cuffs of Salvation
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 48979 WHERE `template_id` = 102018 AND `equipment_slot` = 8 AND `item_entry` = 41909;
-- pvp-a6-priest-discipline slot 10: Furious Gladiator's Band of Dominance -> Starshine Circle
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45614 WHERE `template_id` = 102018 AND `equipment_slot` = 10 AND `item_entry` = 42116;
-- pvp-a6-priest-discipline slot 11: Furious Gladiator's Band of Triumph -> Conductive Seal
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45495 WHERE `template_id` = 102018 AND `equipment_slot` = 11 AND `item_entry` = 42117;
-- pvp-a7-priest-discipline slot 5: Relentless Gladiator's Cord of Alacrity -> Cord of Biting Cold
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47084 WHERE `template_id` = 103018 AND `equipment_slot` = 5 AND `item_entry` = 49179;
-- pvp-a7-priest-discipline slot 10: Relentless Gladiator's Band of Ascendancy -> Band of Deplorable Violence
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47237 WHERE `template_id` = 103018 AND `equipment_slot` = 10 AND `item_entry` = 42118;
-- pvp-a7-priest-discipline slot 11: Relentless Gladiator's Band of Victory -> Relentless Gladiator's Band of Ascendancy
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42118 WHERE `template_id` = 103018 AND `equipment_slot` = 11 AND `item_entry` = 42119;
-- pvp-a8-priest-discipline slot 5: Wrathful Gladiator's Cord of Alacrity -> Crushing Coldwraith Belt
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50613 WHERE `template_id` = 104018 AND `equipment_slot` = 5 AND `item_entry` = 51337;
-- pvp-a8-priest-discipline slot 10: Wrathful Gladiator's Band of Dominance -> Ring of Rapid Ascent
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50664 WHERE `template_id` = 104018 AND `equipment_slot` = 10 AND `item_entry` = 51336;
-- pvp-a8-priest-discipline slot 11: Wrathful Gladiator's Band of Triumph -> Marrowgar's Frigid Eye
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50610 WHERE `template_id` = 104018 AND `equipment_slot` = 11 AND `item_entry` = 51358;
-- pvp-a8-priest-discipline slot 13: Medallion of the Alliance -> Solace of the Defeated
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47059 WHERE `template_id` = 104018 AND `equipment_slot` = 13 AND `item_entry` = 51377;
-- pve-toc-priest-discipline slot 10: Ring of the Darkmender -> Band of Deplorable Violence
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47237 WHERE `template_id` = 204018 AND `equipment_slot` = 10 AND `item_entry` = 47224;
-- pve-toc-priest-discipline slot 11: Circle of the Darkmender -> Lurid Manifestation
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47489 WHERE `template_id` = 204018 AND `equipment_slot` = 11 AND `item_entry` = 47439;
-- pve-icc-normal-priest-discipline slot 11: Ring of the Darkmender -> Band of Deplorable Violence
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47237 WHERE `template_id` = 205018 AND `equipment_slot` = 11 AND `item_entry` = 47224;
-- pve-toc-priest-holy slot 11: Ring of the Darkmender -> Band of Deplorable Violence
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47237 WHERE `template_id` = 204019 AND `equipment_slot` = 11 AND `item_entry` = 47224;
-- pvp-a5-priest-shadow slot 12: Medallion of the Alliance -> Flow of Knowledge
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 44912 WHERE `template_id` = 101020 AND `equipment_slot` = 12 AND `item_entry` = 42123;
-- pvp-a5-priest-shadow slot 13: Medallion of the Horde -> Pendulum of Telluric Currents
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 37264 WHERE `template_id` = 101020 AND `equipment_slot` = 13 AND `item_entry` = 42122;
-- pvp-a6-priest-shadow slot 10: Furious Gladiator's Band of Dominance -> Titan-Forged Band of Ascendancy
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 48999 WHERE `template_id` = 102020 AND `equipment_slot` = 10 AND `item_entry` = 42116;
-- pvp-a6-priest-shadow slot 11: Furious Gladiator's Band of Triumph -> Furious Gladiator's Band of Dominance
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42116 WHERE `template_id` = 102020 AND `equipment_slot` = 11 AND `item_entry` = 42117;
-- pvp-a6-priest-shadow slot 13: Medallion of the Alliance -> Flow of Knowledge
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 44912 WHERE `template_id` = 102020 AND `equipment_slot` = 13 AND `item_entry` = 42124;
-- pvp-a8-priest-shadow slot 10: Wrathful Gladiator's Band of Dominance -> Ashen Band of Endless Destruction
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50398 WHERE `template_id` = 104020 AND `equipment_slot` = 10 AND `item_entry` = 51336;
-- pvp-a8-priest-shadow slot 11: Wrathful Gladiator's Band of Triumph -> Wrathful Gladiator's Band of Dominance
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51336 WHERE `template_id` = 104020 AND `equipment_slot` = 11 AND `item_entry` = 51358;
-- pvp-a8-priest-shadow slot 13: Medallion of the Horde -> Reign of the Unliving
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47188 WHERE `template_id` = 104020 AND `equipment_slot` = 13 AND `item_entry` = 51378;
-- pvp-a5-rogue-subtlety slot 13: Medallion of the Alliance -> Anvil of Titans
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 44914 WHERE `template_id` = 101023 AND `equipment_slot` = 13 AND `item_entry` = 42123;
-- pvp-a6-rogue-subtlety slot 10: Furious Gladiator's Band of Triumph -> Brann's Signet Ring
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45608 WHERE `template_id` = 102023 AND `equipment_slot` = 10 AND `item_entry` = 42117;
-- pvp-a6-rogue-subtlety slot 11: Furious Gladiator's Band of Dominance -> Furious Gladiator's Band of Triumph
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42117 WHERE `template_id` = 102023 AND `equipment_slot` = 11 AND `item_entry` = 42116;
-- pvp-a6-rogue-subtlety slot 12: Medallion of the Horde -> Mjolnir Runestone
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45931 WHERE `template_id` = 102023 AND `equipment_slot` = 12 AND `item_entry` = 42126;
-- pvp-a6-rogue-subtlety slot 13: Medallion of the Alliance -> Grim Toll
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 40256 WHERE `template_id` = 102023 AND `equipment_slot` = 13 AND `item_entry` = 42124;
-- pvp-a7-rogue-subtlety slot 6: Relentless Gladiator's Leather Legguards -> Garona's Legplates of Triumph
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 48236 WHERE `template_id` = 103023 AND `equipment_slot` = 6 AND `item_entry` = 41656;
-- pvp-a7-rogue-subtlety slot 7: Relentless Gladiator's Boots of Triumph -> Icewalker Treads
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47445 WHERE `template_id` = 103023 AND `equipment_slot` = 7 AND `item_entry` = 41837;
-- pvp-a7-rogue-subtlety slot 10: Relentless Gladiator's Band of Victory -> Band of Callous Aggression
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47443 WHERE `template_id` = 103023 AND `equipment_slot` = 10 AND `item_entry` = 42119;
-- pvp-a7-rogue-subtlety slot 11: Relentless Gladiator's Band of Ascendancy -> Relentless Gladiator's Band of Victory
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42119 WHERE `template_id` = 103023 AND `equipment_slot` = 11 AND `item_entry` = 42118;
-- pvp-a7-rogue-subtlety slot 13: Medallion of the Horde -> Mjolnir Runestone
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45931 WHERE `template_id` = 103023 AND `equipment_slot` = 13 AND `item_entry` = 42126;
-- pvp-a8-rogue-subtlety slot 1: Wrathful Gladiator's Pendant of Triumph -> Sindragosa's Cruel Claw
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50633 WHERE `template_id` = 104023 AND `equipment_slot` = 1 AND `item_entry` = 51355;
-- pvp-a8-rogue-subtlety slot 4: Wrathful Gladiator's Leather Tunic -> Sanctified Shadowblade Breastplate
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51250 WHERE `template_id` = 104023 AND `equipment_slot` = 4 AND `item_entry` = 51492;
-- pvp-a8-rogue-subtlety slot 5: Wrathful Gladiator's Belt of Triumph -> Astrylian's Sutured Cinch
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50707 WHERE `template_id` = 104023 AND `equipment_slot` = 5 AND `item_entry` = 51368;
-- pvp-a8-rogue-subtlety slot 7: Wrathful Gladiator's Boots of Triumph -> Frostbitten Fur Boots
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50607 WHERE `template_id` = 104023 AND `equipment_slot` = 7 AND `item_entry` = 51369;
-- pvp-a8-rogue-subtlety slot 8: Wrathful Gladiator's Armwraps of Triumph -> Toskk's Maximized Wristguards
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50670 WHERE `template_id` = 104023 AND `equipment_slot` = 8 AND `item_entry` = 51370;
-- pvp-a8-rogue-subtlety slot 10: Wrathful Gladiator's Band of Triumph -> Ashen Band of Endless Vengeance
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50402 WHERE `template_id` = 104023 AND `equipment_slot` = 10 AND `item_entry` = 51358;
-- pvp-a8-rogue-subtlety slot 11: Wrathful Gladiator's Band of Dominance -> Wrathful Gladiator's Band of Triumph
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51358 WHERE `template_id` = 104023 AND `equipment_slot` = 11 AND `item_entry` = 51336;
-- pvp-a8-rogue-subtlety slot 13: Medallion of the Horde -> Death's Verdict
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47131 WHERE `template_id` = 104023 AND `equipment_slot` = 13 AND `item_entry` = 51378;
-- pvp-a8-rogue-subtlety slot 14: Wrathful Gladiator's Cloak of Victory -> Vereesa's Dexterity
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47545 WHERE `template_id` = 104023 AND `equipment_slot` = 14 AND `item_entry` = 51356;
-- pvp-a6-shaman-elemental slot 10: Furious Gladiator's Band of Dominance -> Conductive Seal
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45495 WHERE `template_id` = 102024 AND `equipment_slot` = 10 AND `item_entry` = 42116;
-- pvp-a6-shaman-elemental slot 11: Furious Gladiator's Band of Triumph -> Furious Gladiator's Band of Dominance
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42116 WHERE `template_id` = 102024 AND `equipment_slot` = 11 AND `item_entry` = 42117;
-- pvp-a6-shaman-elemental slot 13: Medallion of the Alliance -> Dying Curse
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 40255 WHERE `template_id` = 102024 AND `equipment_slot` = 13 AND `item_entry` = 42124;
-- pvp-a8-shaman-elemental slot 10: Wrathful Gladiator's Band of Dominance -> Ring of Rapid Ascent
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50664 WHERE `template_id` = 104024 AND `equipment_slot` = 10 AND `item_entry` = 51336;
-- pvp-a8-shaman-elemental slot 11: Wrathful Gladiator's Band of Triumph -> Wrathful Gladiator's Band of Dominance
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51336 WHERE `template_id` = 104024 AND `equipment_slot` = 11 AND `item_entry` = 51358;
-- pve-toc-shaman-elemental slot 10: Ring of the Darkmender -> Conductive Seal
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45495 WHERE `template_id` = 204024 AND `equipment_slot` = 10 AND `item_entry` = 47224;
-- pve-toc-shaman-elemental slot 11: Circle of the Darkmender -> Starshine Circle
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45614 WHERE `template_id` = 204024 AND `equipment_slot` = 11 AND `item_entry` = 47439;
-- pvp-a5-shaman-enhancement slot 12: Medallion of the Horde -> Anvil of Titans
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 44914 WHERE `template_id` = 101025 AND `equipment_slot` = 12 AND `item_entry` = 42122;
-- pvp-a5-shaman-enhancement slot 13: Medallion of the Alliance -> Bitter Balebrew Charm
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 49116 WHERE `template_id` = 101025 AND `equipment_slot` = 13 AND `item_entry` = 42123;
-- pvp-a6-shaman-enhancement slot 13: Medallion of the Alliance -> Mjolnir Runestone
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45931 WHERE `template_id` = 102025 AND `equipment_slot` = 13 AND `item_entry` = 42124;
-- pvp-a7-shaman-enhancement slot 11: Relentless Gladiator's Band of Ascendancy -> Dexterous Brightstone Ring
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47730 WHERE `template_id` = 103025 AND `equipment_slot` = 11 AND `item_entry` = 42118;
-- pvp-a7-shaman-enhancement slot 13: Medallion of the Alliance -> Mjolnir Runestone
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45931 WHERE `template_id` = 103025 AND `equipment_slot` = 13 AND `item_entry` = 42124;
-- pvp-a8-shaman-enhancement slot 10: Wrathful Gladiator's Band of Triumph -> Ashen Band of Endless Vengeance
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50402 WHERE `template_id` = 104025 AND `equipment_slot` = 10 AND `item_entry` = 51358;
-- pvp-a8-shaman-enhancement slot 11: Wrathful Gladiator's Band of Dominance -> Wrathful Gladiator's Band of Triumph
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51358 WHERE `template_id` = 104025 AND `equipment_slot` = 11 AND `item_entry` = 51336;
-- pvp-a8-shaman-enhancement slot 12: Medallion of the Horde -> Deathbringer's Will
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50362 WHERE `template_id` = 104025 AND `equipment_slot` = 12 AND `item_entry` = 51378;
-- pvp-a8-shaman-enhancement slot 13: Deathbringer's Will -> Needle-Encrusted Scorpion
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50198 WHERE `template_id` = 104025 AND `equipment_slot` = 13 AND `item_entry` = 50362;
-- pvp-a5-shaman-restoration slot 12: Medallion of the Horde -> Flow of Knowledge
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 44912 WHERE `template_id` = 101026 AND `equipment_slot` = 12 AND `item_entry` = 42122;
-- pvp-a5-shaman-restoration slot 13: Medallion of the Alliance -> Bitter Balebrew Charm
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 49116 WHERE `template_id` = 101026 AND `equipment_slot` = 13 AND `item_entry` = 42123;
-- pvp-a5-shaman-restoration slot 17: Deadly Gladiator's Totem of the Third Wind -> Totem of Misery
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 39728 WHERE `template_id` = 101026 AND `equipment_slot` = 17 AND `item_entry` = 42597;
-- pvp-a6-shaman-restoration slot 12: Medallion of the Alliance -> Meteorite Crystal
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 46051 WHERE `template_id` = 102026 AND `equipment_slot` = 12 AND `item_entry` = 42124;
-- pvp-a6-shaman-restoration slot 13: Medallion of the Horde -> Flow of Knowledge
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 44912 WHERE `template_id` = 102026 AND `equipment_slot` = 13 AND `item_entry` = 42126;
-- pvp-a7-shaman-restoration slot 13: Medallion of the Alliance -> Meteorite Crystal
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 46051 WHERE `template_id` = 103026 AND `equipment_slot` = 13 AND `item_entry` = 42124;
-- pvp-a8-shaman-restoration slot 11: Wrathful Gladiator's Band of Triumph -> Ring of Rapid Ascent
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50008 WHERE `template_id` = 104026 AND `equipment_slot` = 11 AND `item_entry` = 51358;
-- pvp-a8-shaman-restoration slot 13: Medallion of the Alliance -> Bauble of True Blood
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50354 WHERE `template_id` = 104026 AND `equipment_slot` = 13 AND `item_entry` = 51377;
-- pve-toc-shaman-restoration slot 10: Ring of the Darkmender -> Conductive Seal
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45495 WHERE `template_id` = 204026 AND `equipment_slot` = 10 AND `item_entry` = 47224;
-- pve-toc-shaman-restoration slot 11: Circle of the Darkmender -> Starshine Circle
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45614 WHERE `template_id` = 204026 AND `equipment_slot` = 11 AND `item_entry` = 47439;
-- pvp-a6-warlock-affliction slot 10: Furious Gladiator's Band of Dominance -> Conductive Seal
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45495 WHERE `template_id` = 102027 AND `equipment_slot` = 10 AND `item_entry` = 42116;
-- pvp-a6-warlock-affliction slot 11: Furious Gladiator's Band of Triumph -> Furious Gladiator's Band of Dominance
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42116 WHERE `template_id` = 102027 AND `equipment_slot` = 11 AND `item_entry` = 42117;
-- pvp-a6-warlock-affliction slot 13: Medallion of the Alliance -> Pandora's Plea
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45490 WHERE `template_id` = 102027 AND `equipment_slot` = 13 AND `item_entry` = 42124;
-- pvp-a7-warlock-affliction slot 13: Medallion of the Alliance -> Pandora's Plea
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45490 WHERE `template_id` = 103027 AND `equipment_slot` = 13 AND `item_entry` = 42124;
-- pvp-a8-warlock-affliction slot 10: Wrathful Gladiator's Band of Dominance -> Ring of Rapid Ascent
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50664 WHERE `template_id` = 104027 AND `equipment_slot` = 10 AND `item_entry` = 51336;
-- pvp-a8-warlock-affliction slot 11: Wrathful Gladiator's Band of Triumph -> Wrathful Gladiator's Band of Dominance
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51336 WHERE `template_id` = 104027 AND `equipment_slot` = 11 AND `item_entry` = 51358;
-- pvp-a8-warlock-affliction slot 13: Medallion of the Horde -> Nevermelting Ice Crystal
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50259 WHERE `template_id` = 104027 AND `equipment_slot` = 13 AND `item_entry` = 51378;
-- pve-toc-warlock-affliction slot 10: Circle of the Darkmender -> Lurid Manifestation
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47489 WHERE `template_id` = 204027 AND `equipment_slot` = 10 AND `item_entry` = 47439;
-- pve-toc-warlock-affliction slot 11: Ring of the Darkmender -> Band of Deplorable Violence
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47237 WHERE `template_id` = 204027 AND `equipment_slot` = 11 AND `item_entry` = 47224;
-- pve-toc-warlock-demonology slot 11: Circle of the Darkmender -> Lurid Manifestation
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47489 WHERE `template_id` = 204028 AND `equipment_slot` = 11 AND `item_entry` = 47439;
-- pvp-a6-warlock-destruction slot 10: Furious Gladiator's Band of Dominance -> Conductive Seal
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45495 WHERE `template_id` = 102029 AND `equipment_slot` = 10 AND `item_entry` = 42116;
-- pvp-a6-warlock-destruction slot 11: Furious Gladiator's Band of Triumph -> Furious Gladiator's Band of Dominance
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42116 WHERE `template_id` = 102029 AND `equipment_slot` = 11 AND `item_entry` = 42117;
-- pvp-a6-warlock-destruction slot 12: Medallion of the Alliance -> Pandora's Plea
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45490 WHERE `template_id` = 102029 AND `equipment_slot` = 12 AND `item_entry` = 42124;
-- pvp-a6-warlock-destruction slot 13: Medallion of the Horde -> Dying Curse
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 40255 WHERE `template_id` = 102029 AND `equipment_slot` = 13 AND `item_entry` = 42126;
-- pvp-a7-warlock-destruction slot 13: Medallion of the Alliance -> Pandora's Plea
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45490 WHERE `template_id` = 103029 AND `equipment_slot` = 13 AND `item_entry` = 42124;
-- pvp-a8-warlock-destruction slot 10: Wrathful Gladiator's Band of Dominance -> Ring of Rapid Ascent
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50664 WHERE `template_id` = 104029 AND `equipment_slot` = 10 AND `item_entry` = 51336;
-- pvp-a8-warlock-destruction slot 11: Wrathful Gladiator's Band of Triumph -> Wrathful Gladiator's Band of Dominance
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51336 WHERE `template_id` = 104029 AND `equipment_slot` = 11 AND `item_entry` = 51358;
-- pvp-a8-warlock-destruction slot 13: Medallion of the Horde -> Muradin's Spyglass
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50340 WHERE `template_id` = 104029 AND `equipment_slot` = 13 AND `item_entry` = 51378;
-- pve-toc-warlock-destruction slot 10: Circle of the Darkmender -> Lurid Manifestation
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47489 WHERE `template_id` = 204029 AND `equipment_slot` = 10 AND `item_entry` = 47439;
-- pve-toc-warlock-destruction slot 11: Ring of the Darkmender -> Band of Deplorable Violence
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47237 WHERE `template_id` = 204029 AND `equipment_slot` = 11 AND `item_entry` = 47224;
-- pvp-a5-warrior-arms slot 11: Deadly Gladiator's Band of Ascendancy -> Ruthlessness
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 40075 WHERE `template_id` = 101030 AND `equipment_slot` = 11 AND `item_entry` = 42114;
-- pvp-a6-warrior-arms slot 10: Furious Gladiator's Band of Triumph -> Seal of the Betrayed King
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45534 WHERE `template_id` = 102030 AND `equipment_slot` = 10 AND `item_entry` = 42117;
-- pvp-a6-warrior-arms slot 11: Furious Gladiator's Band of Dominance -> Brann's Signet Ring
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45608 WHERE `template_id` = 102030 AND `equipment_slot` = 11 AND `item_entry` = 42116;
-- pvp-a6-warrior-arms slot 12: Medallion of the Alliance -> Mjolnir Runestone
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45931 WHERE `template_id` = 102030 AND `equipment_slot` = 12 AND `item_entry` = 42124;
-- pvp-a6-warrior-arms slot 13: Medallion of the Horde -> Grim Toll
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 40256 WHERE `template_id` = 102030 AND `equipment_slot` = 13 AND `item_entry` = 42126;
-- pvp-a7-warrior-arms slot 10: Relentless Gladiator's Band of Victory -> Band of the Violent Temperment
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 46966 WHERE `template_id` = 103030 AND `equipment_slot` = 10 AND `item_entry` = 42119;
-- pvp-a7-warrior-arms slot 11: Relentless Gladiator's Band of Ascendancy -> Relentless Gladiator's Band of Victory
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42119 WHERE `template_id` = 103030 AND `equipment_slot` = 11 AND `item_entry` = 42118;
-- pvp-a7-warrior-arms slot 13: Medallion of the Alliance -> Mjolnir Runestone
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 45931 WHERE `template_id` = 103030 AND `equipment_slot` = 13 AND `item_entry` = 42124;
-- pvp-a8-warrior-arms slot 7: Wrathful Gladiator's Greaves of Triumph -> Blood-Soaked Saronite Stompers
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50639 WHERE `template_id` = 104030 AND `equipment_slot` = 7 AND `item_entry` = 51363;
-- pvp-a8-warrior-arms slot 8: Wrathful Gladiator's Bracers of Triumph -> Toskk's Maximized Wristguards
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50670 WHERE `template_id` = 104030 AND `equipment_slot` = 8 AND `item_entry` = 51364;
-- pvp-a8-warrior-arms slot 10: Wrathful Gladiator's Band of Triumph -> Frostbrood Sapphire Ring
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50618 WHERE `template_id` = 104030 AND `equipment_slot` = 10 AND `item_entry` = 51358;
-- pvp-a8-warrior-arms slot 11: Wrathful Gladiator's Band of Dominance -> Might of Blight
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50693 WHERE `template_id` = 104030 AND `equipment_slot` = 11 AND `item_entry` = 51336;
-- pvp-a8-warrior-arms slot 13: Medallion of the Alliance -> Death's Verdict
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47131 WHERE `template_id` = 104030 AND `equipment_slot` = 13 AND `item_entry` = 51377;
-- pve-toc-warrior-protection slot 11: Signet of the Traitor King -> Clutch of Fortification
UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47731 WHERE `template_id` = 204032 AND `equipment_slot` = 11 AND `item_entry` = 47157;
UPDATE `solitary_bot_gear_template` SET `template_version` = 3, `verified` = 1 WHERE `template_id` IN (101004,101005,101006,101008,101010,101011,101014,101015,101017,101018,101020,101023,101025,101026,101030,102004,102005,102006,102008,102010,102011,102014,102015,102017,102018,102020,102023,102024,102025,102026,102027,102029,102030,103004,103005,103006,103008,103010,103011,103014,103017,103018,103023,103025,103026,103027,103029,103030,104004,104005,104006,104008,104010,104011,104014,104015,104017,104018,104020,104023,104024,104025,104026,104027,104029,104030,204002,204007,204008,204015,204016,204018,204019,204024,204026,204027,204028,204029,204032,205015,205018);
COMMIT;

-- Postflight: expected race_restricted_bindings=0.
SELECT CONCAT('race_restricted_bindings=', COUNT(*)) FROM `solitary_bot_gear_template_item` b JOIN `item_template` i ON i.`entry` = b.`item_entry` WHERE i.`AllowableRace` <> -1 AND (i.`AllowableRace` & 1791) <> 1791;

-- Rollback (manual, after restoring the pre-change database backup):
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47157 WHERE `template_id` = 204002 AND `equipment_slot` = 11 AND `item_entry` = 47731;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42620 WHERE `template_id` = 101004 AND `equipment_slot` = 17 AND `item_entry` = 40207;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42117 WHERE `template_id` = 102004 AND `equipment_slot` = 10 AND `item_entry` = 45534;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42116 WHERE `template_id` = 102004 AND `equipment_slot` = 11 AND `item_entry` = 42117;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42124 WHERE `template_id` = 102004 AND `equipment_slot` = 13 AND `item_entry` = 45931;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42119 WHERE `template_id` = 103004 AND `equipment_slot` = 10 AND `item_entry` = 46966;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42118 WHERE `template_id` = 103004 AND `equipment_slot` = 11 AND `item_entry` = 42119;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51362 WHERE `template_id` = 104004 AND `equipment_slot` = 5 AND `item_entry` = 50620;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51364 WHERE `template_id` = 104004 AND `equipment_slot` = 8 AND `item_entry` = 54559;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51358 WHERE `template_id` = 104004 AND `equipment_slot` = 10 AND `item_entry` = 52572;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51336 WHERE `template_id` = 104004 AND `equipment_slot` = 11 AND `item_entry` = 51358;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51377 WHERE `template_id` = 104004 AND `equipment_slot` = 13 AND `item_entry` = 47464;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51356 WHERE `template_id` = 104004 AND `equipment_slot` = 14 AND `item_entry` = 47545;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42122 WHERE `template_id` = 101005 AND `equipment_slot` = 12 AND `item_entry` = 44912;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42123 WHERE `template_id` = 101005 AND `equipment_slot` = 13 AND `item_entry` = 49116;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42124 WHERE `template_id` = 102005 AND `equipment_slot` = 12 AND `item_entry` = 45490;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42126 WHERE `template_id` = 102005 AND `equipment_slot` = 13 AND `item_entry` = 44912;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42118 WHERE `template_id` = 103005 AND `equipment_slot` = 10 AND `item_entry` = 50377;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42119 WHERE `template_id` = 103005 AND `equipment_slot` = 11 AND `item_entry` = 42118;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42124 WHERE `template_id` = 103005 AND `equipment_slot` = 13 AND `item_entry` = 45490;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51336 WHERE `template_id` = 104005 AND `equipment_slot` = 10 AND `item_entry` = 50398;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51358 WHERE `template_id` = 104005 AND `equipment_slot` = 11 AND `item_entry` = 51336;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51377 WHERE `template_id` = 104005 AND `equipment_slot` = 13 AND `item_entry` = 47946;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42122 WHERE `template_id` = 101006 AND `equipment_slot` = 12 AND `item_entry` = 47214;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42123 WHERE `template_id` = 101006 AND `equipment_slot` = 13 AND `item_entry` = 49116;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42124 WHERE `template_id` = 102006 AND `equipment_slot` = 13 AND `item_entry` = 47214;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42118 WHERE `template_id` = 103006 AND `equipment_slot` = 11 AND `item_entry` = 47070;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42124 WHERE `template_id` = 103006 AND `equipment_slot` = 13 AND `item_entry` = 47214;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51369 WHERE `template_id` = 104006 AND `equipment_slot` = 7 AND `item_entry` = 50607;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51370 WHERE `template_id` = 104006 AND `equipment_slot` = 8 AND `item_entry` = 50670;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51358 WHERE `template_id` = 104006 AND `equipment_slot` = 10 AND `item_entry` = 50618;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51336 WHERE `template_id` = 104006 AND `equipment_slot` = 11 AND `item_entry` = 50402;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51377 WHERE `template_id` = 104006 AND `equipment_slot` = 13 AND `item_entry` = 50198;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47157 WHERE `template_id` = 204007 AND `equipment_slot` = 10 AND `item_entry` = 47731;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47731 WHERE `template_id` = 204007 AND `equipment_slot` = 11 AND `item_entry` = 47955;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42122 WHERE `template_id` = 101008 AND `equipment_slot` = 12 AND `item_entry` = 44912;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42123 WHERE `template_id` = 101008 AND `equipment_slot` = 13 AND `item_entry` = 49116;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42124 WHERE `template_id` = 102008 AND `equipment_slot` = 13 AND `item_entry` = 46051;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42119 WHERE `template_id` = 103008 AND `equipment_slot` = 11 AND `item_entry` = 47733;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51336 WHERE `template_id` = 104008 AND `equipment_slot` = 10 AND `item_entry` = 50399;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51358 WHERE `template_id` = 104008 AND `equipment_slot` = 11 AND `item_entry` = 51336;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47224 WHERE `template_id` = 204008 AND `equipment_slot` = 11 AND `item_entry` = 47732;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42123 WHERE `template_id` = 101010 AND `equipment_slot` = 13 AND `item_entry` = 44253;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42117 WHERE `template_id` = 102010 AND `equipment_slot` = 10 AND `item_entry` = 45608;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42116 WHERE `template_id` = 102010 AND `equipment_slot` = 11 AND `item_entry` = 42117;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42124 WHERE `template_id` = 102010 AND `equipment_slot` = 12 AND `item_entry` = 45931;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42126 WHERE `template_id` = 102010 AND `equipment_slot` = 13 AND `item_entry` = 40256;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42119 WHERE `template_id` = 103010 AND `equipment_slot` = 10 AND `item_entry` = 47075;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42118 WHERE `template_id` = 103010 AND `equipment_slot` = 11 AND `item_entry` = 42119;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42124 WHERE `template_id` = 103010 AND `equipment_slot` = 13 AND `item_entry` = 45931;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51357 WHERE `template_id` = 104010 AND `equipment_slot` = 1 AND `item_entry` = 50633;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51350 WHERE `template_id` = 104010 AND `equipment_slot` = 5 AND `item_entry` = 50688;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51352 WHERE `template_id` = 104010 AND `equipment_slot` = 8 AND `item_entry` = 50655;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51377 WHERE `template_id` = 104010 AND `equipment_slot` = 13 AND `item_entry` = 47131;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51356 WHERE `template_id` = 104010 AND `equipment_slot` = 14 AND `item_entry` = 47545;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42123 WHERE `template_id` = 101011 AND `equipment_slot` = 12 AND `item_entry` = 44253;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42122 WHERE `template_id` = 101011 AND `equipment_slot` = 13 AND `item_entry` = 40684;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42117 WHERE `template_id` = 102011 AND `equipment_slot` = 10 AND `item_entry` = 45608;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42116 WHERE `template_id` = 102011 AND `equipment_slot` = 11 AND `item_entry` = 42117;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42124 WHERE `template_id` = 102011 AND `equipment_slot` = 12 AND `item_entry` = 44253;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42126 WHERE `template_id` = 102011 AND `equipment_slot` = 13 AND `item_entry` = 40684;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42119 WHERE `template_id` = 103011 AND `equipment_slot` = 10 AND `item_entry` = 47075;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42118 WHERE `template_id` = 103011 AND `equipment_slot` = 11 AND `item_entry` = 42119;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42124 WHERE `template_id` = 103011 AND `equipment_slot` = 13 AND `item_entry` = 44253;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51377 WHERE `template_id` = 104011 AND `equipment_slot` = 13 AND `item_entry` = 47131;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 41897 WHERE `template_id` = 101014 AND `equipment_slot` = 5 AND `item_entry` = 46080;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42038 WHERE `template_id` = 102014 AND `equipment_slot` = 1 AND `item_entry` = 45133;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 41898 WHERE `template_id` = 102014 AND `equipment_slot` = 5 AND `item_entry` = 45619;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 41903 WHERE `template_id` = 102014 AND `equipment_slot` = 7 AND `item_entry` = 45135;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 41909 WHERE `template_id` = 102014 AND `equipment_slot` = 8 AND `item_entry` = 48979;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42116 WHERE `template_id` = 102014 AND `equipment_slot` = 10 AND `item_entry` = 45614;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42117 WHERE `template_id` = 102014 AND `equipment_slot` = 11 AND `item_entry` = 45495;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42124 WHERE `template_id` = 102014 AND `equipment_slot` = 13 AND `item_entry` = 45466;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42071 WHERE `template_id` = 102014 AND `equipment_slot` = 14 AND `item_entry` = 45242;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42045 WHERE `template_id` = 103014 AND `equipment_slot` = 1 AND `item_entry` = 47144;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 49179 WHERE `template_id` = 103014 AND `equipment_slot` = 5 AND `item_entry` = 46973;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51333 WHERE `template_id` = 104014 AND `equipment_slot` = 1 AND `item_entry` = 50658;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51337 WHERE `template_id` = 104014 AND `equipment_slot` = 5 AND `item_entry` = 50613;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51466 WHERE `template_id` = 104014 AND `equipment_slot` = 6 AND `item_entry` = 50694;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51338 WHERE `template_id` = 104014 AND `equipment_slot` = 7 AND `item_entry` = 50699;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51336 WHERE `template_id` = 104014 AND `equipment_slot` = 10 AND `item_entry` = 50664;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51358 WHERE `template_id` = 104014 AND `equipment_slot` = 11 AND `item_entry` = 50398;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51377 WHERE `template_id` = 104014 AND `equipment_slot` = 13 AND `item_entry` = 47188;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51332 WHERE `template_id` = 104014 AND `equipment_slot` = 14 AND `item_entry` = 47552;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51451 WHERE `template_id` = 104014 AND `equipment_slot` = 17 AND `item_entry` = 50684;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42122 WHERE `template_id` = 101015 AND `equipment_slot` = 12 AND `item_entry` = 44912;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42123 WHERE `template_id` = 101015 AND `equipment_slot` = 13 AND `item_entry` = 49116;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42124 WHERE `template_id` = 102015 AND `equipment_slot` = 12 AND `item_entry` = 46051;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42126 WHERE `template_id` = 102015 AND `equipment_slot` = 13 AND `item_entry` = 44912;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51336 WHERE `template_id` = 104015 AND `equipment_slot` = 10 AND `item_entry` = 50400;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51358 WHERE `template_id` = 104015 AND `equipment_slot` = 11 AND `item_entry` = 50399;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47224 WHERE `template_id` = 204015 AND `equipment_slot` = 10 AND `item_entry` = 45495;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47439 WHERE `template_id` = 204015 AND `equipment_slot` = 11 AND `item_entry` = 45614;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47224 WHERE `template_id` = 205015 AND `equipment_slot` = 11 AND `item_entry` = 45495;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47157 WHERE `template_id` = 204016 AND `equipment_slot` = 11 AND `item_entry` = 47731;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42114 WHERE `template_id` = 101017 AND `equipment_slot` = 11 AND `item_entry` = 40075;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42034 WHERE `template_id` = 102017 AND `equipment_slot` = 1 AND `item_entry` = 45517;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 40881 WHERE `template_id` = 102017 AND `equipment_slot` = 5 AND `item_entry` = 45241;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 40882 WHERE `template_id` = 102017 AND `equipment_slot` = 7 AND `item_entry` = 45599;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 40889 WHERE `template_id` = 102017 AND `equipment_slot` = 8 AND `item_entry` = 45663;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42117 WHERE `template_id` = 102017 AND `equipment_slot` = 10 AND `item_entry` = 45534;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42116 WHERE `template_id` = 102017 AND `equipment_slot` = 11 AND `item_entry` = 45608;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42074 WHERE `template_id` = 102017 AND `equipment_slot` = 14 AND `item_entry` = 45461;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42041 WHERE `template_id` = 103017 AND `equipment_slot` = 1 AND `item_entry` = 47060;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 40883 WHERE `template_id` = 103017 AND `equipment_slot` = 5 AND `item_entry` = 47112;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 40884 WHERE `template_id` = 103017 AND `equipment_slot` = 7 AND `item_entry` = 47154;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 40890 WHERE `template_id` = 103017 AND `equipment_slot` = 8 AND `item_entry` = 47155;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42119 WHERE `template_id` = 103017 AND `equipment_slot` = 10 AND `item_entry` = 47075;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42118 WHERE `template_id` = 103017 AND `equipment_slot` = 11 AND `item_entry` = 47443;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42081 WHERE `template_id` = 103017 AND `equipment_slot` = 14 AND `item_entry` = 48674;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51354 WHERE `template_id` = 104017 AND `equipment_slot` = 14 AND `item_entry` = 47547;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 41897 WHERE `template_id` = 101018 AND `equipment_slot` = 5 AND `item_entry` = 46080;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 41909 WHERE `template_id` = 102018 AND `equipment_slot` = 8 AND `item_entry` = 48979;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42116 WHERE `template_id` = 102018 AND `equipment_slot` = 10 AND `item_entry` = 45614;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42117 WHERE `template_id` = 102018 AND `equipment_slot` = 11 AND `item_entry` = 45495;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 49179 WHERE `template_id` = 103018 AND `equipment_slot` = 5 AND `item_entry` = 47084;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42118 WHERE `template_id` = 103018 AND `equipment_slot` = 10 AND `item_entry` = 47237;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42119 WHERE `template_id` = 103018 AND `equipment_slot` = 11 AND `item_entry` = 42118;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51337 WHERE `template_id` = 104018 AND `equipment_slot` = 5 AND `item_entry` = 50613;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51336 WHERE `template_id` = 104018 AND `equipment_slot` = 10 AND `item_entry` = 50664;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51358 WHERE `template_id` = 104018 AND `equipment_slot` = 11 AND `item_entry` = 50610;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51377 WHERE `template_id` = 104018 AND `equipment_slot` = 13 AND `item_entry` = 47059;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47224 WHERE `template_id` = 204018 AND `equipment_slot` = 10 AND `item_entry` = 47237;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47439 WHERE `template_id` = 204018 AND `equipment_slot` = 11 AND `item_entry` = 47489;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47224 WHERE `template_id` = 205018 AND `equipment_slot` = 11 AND `item_entry` = 47237;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47224 WHERE `template_id` = 204019 AND `equipment_slot` = 11 AND `item_entry` = 47237;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42123 WHERE `template_id` = 101020 AND `equipment_slot` = 12 AND `item_entry` = 44912;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42122 WHERE `template_id` = 101020 AND `equipment_slot` = 13 AND `item_entry` = 37264;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42116 WHERE `template_id` = 102020 AND `equipment_slot` = 10 AND `item_entry` = 48999;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42117 WHERE `template_id` = 102020 AND `equipment_slot` = 11 AND `item_entry` = 42116;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42124 WHERE `template_id` = 102020 AND `equipment_slot` = 13 AND `item_entry` = 44912;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51336 WHERE `template_id` = 104020 AND `equipment_slot` = 10 AND `item_entry` = 50398;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51358 WHERE `template_id` = 104020 AND `equipment_slot` = 11 AND `item_entry` = 51336;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51378 WHERE `template_id` = 104020 AND `equipment_slot` = 13 AND `item_entry` = 47188;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42123 WHERE `template_id` = 101023 AND `equipment_slot` = 13 AND `item_entry` = 44914;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42117 WHERE `template_id` = 102023 AND `equipment_slot` = 10 AND `item_entry` = 45608;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42116 WHERE `template_id` = 102023 AND `equipment_slot` = 11 AND `item_entry` = 42117;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42126 WHERE `template_id` = 102023 AND `equipment_slot` = 12 AND `item_entry` = 45931;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42124 WHERE `template_id` = 102023 AND `equipment_slot` = 13 AND `item_entry` = 40256;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 41656 WHERE `template_id` = 103023 AND `equipment_slot` = 6 AND `item_entry` = 48236;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 41837 WHERE `template_id` = 103023 AND `equipment_slot` = 7 AND `item_entry` = 47445;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42119 WHERE `template_id` = 103023 AND `equipment_slot` = 10 AND `item_entry` = 47443;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42118 WHERE `template_id` = 103023 AND `equipment_slot` = 11 AND `item_entry` = 42119;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42126 WHERE `template_id` = 103023 AND `equipment_slot` = 13 AND `item_entry` = 45931;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51355 WHERE `template_id` = 104023 AND `equipment_slot` = 1 AND `item_entry` = 50633;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51492 WHERE `template_id` = 104023 AND `equipment_slot` = 4 AND `item_entry` = 51250;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51368 WHERE `template_id` = 104023 AND `equipment_slot` = 5 AND `item_entry` = 50707;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51369 WHERE `template_id` = 104023 AND `equipment_slot` = 7 AND `item_entry` = 50607;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51370 WHERE `template_id` = 104023 AND `equipment_slot` = 8 AND `item_entry` = 50670;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51358 WHERE `template_id` = 104023 AND `equipment_slot` = 10 AND `item_entry` = 50402;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51336 WHERE `template_id` = 104023 AND `equipment_slot` = 11 AND `item_entry` = 51358;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51378 WHERE `template_id` = 104023 AND `equipment_slot` = 13 AND `item_entry` = 47131;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51356 WHERE `template_id` = 104023 AND `equipment_slot` = 14 AND `item_entry` = 47545;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42116 WHERE `template_id` = 102024 AND `equipment_slot` = 10 AND `item_entry` = 45495;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42117 WHERE `template_id` = 102024 AND `equipment_slot` = 11 AND `item_entry` = 42116;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42124 WHERE `template_id` = 102024 AND `equipment_slot` = 13 AND `item_entry` = 40255;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51336 WHERE `template_id` = 104024 AND `equipment_slot` = 10 AND `item_entry` = 50664;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51358 WHERE `template_id` = 104024 AND `equipment_slot` = 11 AND `item_entry` = 51336;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47224 WHERE `template_id` = 204024 AND `equipment_slot` = 10 AND `item_entry` = 45495;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47439 WHERE `template_id` = 204024 AND `equipment_slot` = 11 AND `item_entry` = 45614;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42122 WHERE `template_id` = 101025 AND `equipment_slot` = 12 AND `item_entry` = 44914;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42123 WHERE `template_id` = 101025 AND `equipment_slot` = 13 AND `item_entry` = 49116;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42124 WHERE `template_id` = 102025 AND `equipment_slot` = 13 AND `item_entry` = 45931;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42118 WHERE `template_id` = 103025 AND `equipment_slot` = 11 AND `item_entry` = 47730;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42124 WHERE `template_id` = 103025 AND `equipment_slot` = 13 AND `item_entry` = 45931;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51358 WHERE `template_id` = 104025 AND `equipment_slot` = 10 AND `item_entry` = 50402;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51336 WHERE `template_id` = 104025 AND `equipment_slot` = 11 AND `item_entry` = 51358;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51378 WHERE `template_id` = 104025 AND `equipment_slot` = 12 AND `item_entry` = 50362;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 50362 WHERE `template_id` = 104025 AND `equipment_slot` = 13 AND `item_entry` = 50198;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42122 WHERE `template_id` = 101026 AND `equipment_slot` = 12 AND `item_entry` = 44912;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42123 WHERE `template_id` = 101026 AND `equipment_slot` = 13 AND `item_entry` = 49116;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42597 WHERE `template_id` = 101026 AND `equipment_slot` = 17 AND `item_entry` = 39728;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42124 WHERE `template_id` = 102026 AND `equipment_slot` = 12 AND `item_entry` = 46051;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42126 WHERE `template_id` = 102026 AND `equipment_slot` = 13 AND `item_entry` = 44912;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42124 WHERE `template_id` = 103026 AND `equipment_slot` = 13 AND `item_entry` = 46051;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51358 WHERE `template_id` = 104026 AND `equipment_slot` = 11 AND `item_entry` = 50008;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51377 WHERE `template_id` = 104026 AND `equipment_slot` = 13 AND `item_entry` = 50354;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47224 WHERE `template_id` = 204026 AND `equipment_slot` = 10 AND `item_entry` = 45495;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47439 WHERE `template_id` = 204026 AND `equipment_slot` = 11 AND `item_entry` = 45614;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42116 WHERE `template_id` = 102027 AND `equipment_slot` = 10 AND `item_entry` = 45495;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42117 WHERE `template_id` = 102027 AND `equipment_slot` = 11 AND `item_entry` = 42116;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42124 WHERE `template_id` = 102027 AND `equipment_slot` = 13 AND `item_entry` = 45490;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42124 WHERE `template_id` = 103027 AND `equipment_slot` = 13 AND `item_entry` = 45490;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51336 WHERE `template_id` = 104027 AND `equipment_slot` = 10 AND `item_entry` = 50664;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51358 WHERE `template_id` = 104027 AND `equipment_slot` = 11 AND `item_entry` = 51336;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51378 WHERE `template_id` = 104027 AND `equipment_slot` = 13 AND `item_entry` = 50259;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47439 WHERE `template_id` = 204027 AND `equipment_slot` = 10 AND `item_entry` = 47489;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47224 WHERE `template_id` = 204027 AND `equipment_slot` = 11 AND `item_entry` = 47237;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47439 WHERE `template_id` = 204028 AND `equipment_slot` = 11 AND `item_entry` = 47489;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42116 WHERE `template_id` = 102029 AND `equipment_slot` = 10 AND `item_entry` = 45495;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42117 WHERE `template_id` = 102029 AND `equipment_slot` = 11 AND `item_entry` = 42116;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42124 WHERE `template_id` = 102029 AND `equipment_slot` = 12 AND `item_entry` = 45490;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42126 WHERE `template_id` = 102029 AND `equipment_slot` = 13 AND `item_entry` = 40255;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42124 WHERE `template_id` = 103029 AND `equipment_slot` = 13 AND `item_entry` = 45490;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51336 WHERE `template_id` = 104029 AND `equipment_slot` = 10 AND `item_entry` = 50664;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51358 WHERE `template_id` = 104029 AND `equipment_slot` = 11 AND `item_entry` = 51336;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51378 WHERE `template_id` = 104029 AND `equipment_slot` = 13 AND `item_entry` = 50340;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47439 WHERE `template_id` = 204029 AND `equipment_slot` = 10 AND `item_entry` = 47489;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47224 WHERE `template_id` = 204029 AND `equipment_slot` = 11 AND `item_entry` = 47237;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42114 WHERE `template_id` = 101030 AND `equipment_slot` = 11 AND `item_entry` = 40075;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42117 WHERE `template_id` = 102030 AND `equipment_slot` = 10 AND `item_entry` = 45534;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42116 WHERE `template_id` = 102030 AND `equipment_slot` = 11 AND `item_entry` = 45608;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42124 WHERE `template_id` = 102030 AND `equipment_slot` = 12 AND `item_entry` = 45931;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42126 WHERE `template_id` = 102030 AND `equipment_slot` = 13 AND `item_entry` = 40256;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42119 WHERE `template_id` = 103030 AND `equipment_slot` = 10 AND `item_entry` = 46966;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42118 WHERE `template_id` = 103030 AND `equipment_slot` = 11 AND `item_entry` = 42119;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 42124 WHERE `template_id` = 103030 AND `equipment_slot` = 13 AND `item_entry` = 45931;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51363 WHERE `template_id` = 104030 AND `equipment_slot` = 7 AND `item_entry` = 50639;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51364 WHERE `template_id` = 104030 AND `equipment_slot` = 8 AND `item_entry` = 50670;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51358 WHERE `template_id` = 104030 AND `equipment_slot` = 10 AND `item_entry` = 50618;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51336 WHERE `template_id` = 104030 AND `equipment_slot` = 11 AND `item_entry` = 50693;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 51377 WHERE `template_id` = 104030 AND `equipment_slot` = 13 AND `item_entry` = 47131;
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = 47157 WHERE `template_id` = 204032 AND `equipment_slot` = 11 AND `item_entry` = 47731;
-- UPDATE `solitary_bot_gear_template` SET `template_version` = 2 WHERE `template_id` IN (101004,101005,101006,101008,101010,101011,101014,101015,101017,101018,101020,101023,101025,101026,101030,102004,102005,102006,102008,102010,102011,102014,102015,102017,102018,102020,102023,102024,102025,102026,102027,102029,102030,103004,103005,103006,103008,103010,103011,103014,103017,103018,103023,103025,103026,103027,103029,103030,104004,104005,104006,104008,104010,104011,104014,104015,104017,104018,104020,104023,104024,104025,104026,104027,104029,104030,204002,204007,204008,204015,204016,204018,204019,204024,204026,204027,204028,204029,204032,205015,205018);
