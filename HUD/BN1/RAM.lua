-- RAM Addresses for MMBN 1 scripting, enjoy.

local ram  = {};

ram.rng = require("BN1/RNG");

--[[
General Internal Memory
    00000000-00003FFF   BIOS - System ROM         (16 KBytes)
    00004000-01FFFFFF   Not used
    02000000-0203FFFF   WRAM - On-board Work RAM  (256 KBytes) 2 Wait
    02040000-02FFFFFF   Not used
    03000000-03007FFF   WRAM - On-chip Work RAM   (32 KBytes)
    03008000-03FFFFFF   Not used
    04000000-040003FE   I/O Registers
    04000400-04FFFFFF   Not used
Internal Display Memory
    05000000-050003FF   BG/OBJ Palette RAM        (1 Kbyte)
    05000400-05FFFFFF   Not used
    06000000-06017FFF   VRAM - Video RAM          (96 KBytes)
    06018000-06FFFFFF   Not used
    07000000-070003FF   OAM - OBJ Attributes      (1 Kbyte)
    07000400-07FFFFFF   Not used
External Memory (Game Pak)
    08000000-09FFFFFF   Game Pak ROM/FlashROM (max 32MB) - Wait State 0
    0A000000-0BFFFFFF   Game Pak ROM/FlashROM (max 32MB) - Wait State 1
    0C000000-0DFFFFFF   Game Pak ROM/FlashROM (max 32MB) - Wait State 2
    0E000000-0E00FFFF   Game Pak SRAM    (max 64 KBytes) - 8bit Bus width
    0E010000-0FFFFFFF   Not used
Unused Memory Area
    10000000-FFFFFFFF   Not used (upper 4bits of address bus unused)
https://problemkaputt.de/gbatek.htm#gbamemorymap
--]]

------------------------------ WRAM 02000000-0203FFFF ------------------------------

ram.addr = {};

ram.addr.title_star_byte     = 0x02000000; -- 0x04 1 bit for 1 star :)

-- 000-00F ??? WWW Pin Doors

ram.addr.metro_ticket        = 0x02000005; -- TBD

ram.addr.fire_flags_oven     = 0x02000014; -- 30 bit flags, shared use
ram.addr.fire_flags_www      = 0x0200001B; -- 23 bit flags, shared use
ram.addr.elevator_flag       = 0x0200001C; -- 1-------b
ram.addr.magic_byte          = 0x0200001D; -- ---10---b (progress must be == 0x54)

ram.addr.library             = 0x02000020; -- bit flags (with gaps) ends at 0x38
ram.addr.library_bass        = 0x02000038; -- 00000001b

--  39-3F  Reserved for library (included in count)

ram.addr.emails_gave_flags   = 0x02000040; -- maybe? ends at 47
ram.addr.emails_read_flags   = 0x02000048; -- maybe? ends at 4F

ram.addr.BMD_flags           = 0x02000050; -- ends at 6F? 0x80 is shelf PET

ram.addr.fire_flags          = 0x02000070; -- 4 bytes, 32 fire bit flags

--  70-8B  ??? flags

--  8C-8F  ??? all 1's

-- 110-120 ??? all 1's

-- 120-170 ??? no idea

-- 170-1BF ??? all 1's

ram.addr.folder_ID           = 0x020001C0; -- every other byte, chip  ID  of folder slot 1, ends at 0x020001FA
ram.addr.folder_code         = 0x020001C1; -- every other byte, chip code of folder slot 1, ends at 0x020001FB

-- 1FC-203 ??? 1FF changes a lot

-- 204-213 ??? mostly 1's

ram.addr.main_area           = 0x02000214; -- 1 byte
ram.addr.sub_area            = 0x02000215; -- 1 byte
ram.addr.progress            = 0x02000216; -- 1 byte
ram.addr.music_progress      = 0x02000217; -- 1 byte
--ram.addr.                  = 0x02000218; -- ? byte
--ram.addr.                  = 0x02000219; -- ? byte
--ram.addr.                  = 0x0200021A; -- ? byte
--ram.addr.                  = 0x0200021B; -- ? byte
--ram.addr.                  = 0x0200021C; -- ? byte
--ram.addr.                  = 0x0200021D; -- ? byte
--ram.addr.                  = 0x0200021E; -- ? byte
--ram.addr.                  = 0x0200021F; -- ? byte
--ram.addr.                  = 0x02000220; -- ? byte
--ram.addr.                  = 0x02000221; -- ? byte
--ram.addr.                  = 0x02000222; -- ? byte
--ram.addr.                  = 0x02000223; -- ? byte
ram.addr.buster_attack       = 0x02000224; -- 1 byte, max is 0x04, can't change mid-battle
ram.addr.buster_rapid        = 0x02000225; -- 1 byte, max is 0x04, can't change mid-battle
ram.addr.buster_charge       = 0x02000226; -- 1 byte, max is 0x04, can't change mid-battle
ram.addr.armor_equipped      = 0x02000227; -- 1 byte, max is 0x04
--ram.addr.                  = 0x02000228; -- ? byte
--ram.addr.                  = 0x02000229; -- ? byte
--ram.addr.                  = 0x0200022A; -- ? byte
--ram.addr.                  = 0x0200022B; -- ? byte
ram.addr.HP_max_1            = 0x0200022C; -- 2 bytes, max is 0x03E8
ram.addr.HP_max_2            = 0x0200022E; -- 2 bytes, max is 0x03E8
--ram.addr.                  = 0x02000230; -- ? byte

-- 230+ more flags?

--ram.addr.                  = 0x02000234; -- ? byte HP & Internet links

-- 21D ???

ram.addr.zenny               = 0x02000284; -- 4 bytes, 999999 "max"

-- 2AC-2CF

-- Key Items are 1 byte each, some are counters
ram.addr.key_PET             = 0x020002D0; -- 1 byte
ram.addr.key_IceBlock_count  = 0x020002D1; -- 1 byte, for both Oven and WWW 1
ram.addr.key_WaterGun        = 0x020002D2; -- 1 byte value of 0x05?
ram.addr.key_SchoolID        = 0x020002D3; -- 1 byte
ram.addr.key_SciLabID        = 0x020002D4; -- 1 byte, snip snip
ram.addr.key_Handle          = 0x020002D5; -- 1 byte
ram.addr.key_Message         = 0x020002D6; -- 1 byte, from 5th grade Froid
ram.addr.key_Response        = 0x020002D7; -- 1 byte, to Mayl's email
ram.addr.key_WWW_PIN         = 0x020002D8; -- 1 byte
ram.addr.key_BatteryA        = 0x020002D9; -- 1 byte
ram.addr.key_BatteryB        = 0x020002DA; -- 1 byte
ram.addr.key_BatteryC        = 0x020002DB; -- 1 byte
ram.addr.key_BatteryD        = 0x020002DC; -- 1 byte
ram.addr.key_BatteryE        = 0x020002DD; -- 1 byte
ram.addr.key_Charger         = 0x020002DE; -- 1 byte
ram.addr.key_WWW_Pass        = 0x020002DF; -- 1 byte, expired
--ram.addr.key_invalid       = 0x020002E0; -- 1 byte
ram.addr.key_Dentures        = 0x020002E1; -- 1 byte TBD
--ram.addr.key_invalid       = 0x020002E2 to 0x020002EF
--ram.addr.key_invalid       = 0x020002F0; -- 1 byte
ram.addr.key_at_Mayl         = 0x020002F1; -- 1 byte
ram.addr.key_at_Yai          = 0x020002F2; -- 1 byte
ram.addr.key_at_Dex          = 0x020002F3; -- 1 byte
--ram.addr.key_invalid       = 0x020002F4; -- 1 byte
ram.addr.key_at_Dad          = 0x020002F5; -- 1 byte
ram.addr.key_at_Sal          = 0x020002F6; -- 1 byte TBD
--ram.addr.key_invalid       = 0x020002F7; -- 1 byte
ram.addr.key_at_Miyu         = 0x020002F8; -- 1 byte TBD
--ram.addr.key_invalid       = 0x020002F9; -- 1 byte
--ram.addr.key_invalid       = 0x020002FA; -- 1 byte
ram.addr.key_at_Masa         = 0x020002FB; -- 1 byte
--ram.addr.key_invalid       = 0x020002FC; -- 1 byte
ram.addr.key_at_WWW          = 0x020002FD; -- 1 byte
--ram.addr.key_invalid       = 0x020002FE; -- 1 byte
--ram.addr.key_invalid       = 0x020002FF; -- 1 byte
ram.addr.key_slash_Dex       = 0x02000300; -- 1 byte, 0x21 and 0x02000010 -> 0x00200000
ram.addr.key_slash_Sal       = 0x02000301; -- 1 byte
ram.addr.key_slash_Miyu      = 0x02000302; -- 1 byte
--ram.addr.key_invalid       = 0x02000303; -- 1 byte
ram.addr.key_Hig_Memo        = 0x02000304; -- 1 byte
ram.addr.key_Lab_Memo        = 0x02000305; -- 1 byte
ram.addr.key_Pa_Memo         = 0x02000306; -- 1 byte
ram.addr.key_Yuri_Memo       = 0x02000307; -- 1 byte
--ram.addr.key_invalid       = 0x02000308; -- 1 byte
--ram.addr.key_invalid       = 0x02000309; -- 1 byte
--ram.addr.key_invalid       = 0x0200030A; -- 1 byte
--ram.addr.key_invalid       = 0x0200030B; -- 1 byte
ram.addr.key_ACDCPass        = 0x0200030C; -- 1 byte
ram.addr.key_GovtPass        = 0x0200030D; -- 1 byte
ram.addr.key_TownPass        = 0x0200030E; -- 1 byte
--ram.addr.key_invalid       = 0x0200030F; -- 1 byte

ram.addr.HPMemory            = 0x02000310; -- 1 byte, collected
ram.addr.PowerUP             = 0x02000311; -- 1 byte, unused
--ram.addr.                  = 0x02000312; -- 1 byte
--ram.addr.                  = 0x02000313; -- 1 byte
ram.addr.armor_heat          = 0x02000314; -- 1 byte
ram.addr.armor_aqua          = 0x02000315; -- 1 byte
ram.addr.armor_wood          = 0x02000316; -- 1 byte
--ram.addr.                  = 0x02000317; -- 1 byte

-- 370-3CF divider

ram.addr.steps_also          = 0x020003E0; -- 3 bytes ???
ram.addr.play_time_frames    = 0x020003E8; -- 4 bytes, check for skipped frames
ram.addr.steps               = 0x020003F4; -- 4 bytes
ram.addr.check               = 0x020003F8; -- 4 bytes, steps at the last encounter check

-- 448-49F big divider

-- 5AA broken divider?

-- 13A0 first usable?

ram.addr.battle_state        = 0x02003712; -- 2 byte?
ram.addr.battle_turns        = 0x0200371C; -- 1 byte, number of custom gauge opens + 1
ram.addr.chip_window_count   = 0x02003720; -- 1 byte, number of chips in the custom menu
ram.addr.battle_timer        = 0x02003730; -- 2 bytes, frame counter for current battle
ram.addr.battle_pointer      = 0x02003784; -- 2 bytes? ROM offset?
ram.addr.battle_custom_gauge = 0x0200374E; -- 2 bytes, counts up to 0x4000

ram.addr.battle_draw_slots   = 0x02004910; -- 1 byte each, in battle chip draws, ends at 492D
ram.addr.your_X              = 0x02004954; -- 2 bytes ???
ram.addr.your_Y              = 0x02004956; -- 2 bytes ???

ram.addr.cursor_ID           = 0x020062E4; -- 1 byte, chip  ID  of cursor
ram.addr.cursor_code         = 0x020062E5; -- 1 byte, chip code of cursor
ram.addr.in_folder_count     = 0x020062F0; -- 1 byte, number of chips in folder
ram.addr.GMD_reward          = 0x02006380; -- 2 bytes, how to decode?
ram.addr.game_state          = 0x02006CB8; -- 1 byte
ram.addr.RNG                 = 0x02006CC0; -- 4 bytes, resets and pauses on the title screen

ram.addr.folder_cursor       = 0x020062F4; -- 2 bytes?, cursor value in the folder
ram.addr.folder_offset       = 0x020062F6; -- 2 bytes?, offset value in the folder
ram.addr.pack_cursor         = 0x020062FE; -- 2 bytes?, cursor value in the pack
ram.addr.pack_offset         = 0x02006300; -- 2 bytes?, offset value in the pack
ram.addr.selected_offset     = 0x02006308; -- 2 bytes?, offset value of selected chip
ram.addr.selected_cursor     = 0x0200630A; -- 2 bytes?, cursor value of selected chip

ram.addr.button_flags        = 0x020065F0; -- many bytes, many flags

ram.addr.chip_cooldown       = 0x02006719; -- 1 byte, BstrBomb HYPE

ram.addr.number_door_code    = 0x02009A90; -- 1 byte?

ram.addr.pack_ID             = 0x02019018; -- 1 byte, chip  ID  of pack slot 1
ram.addr.pack_code           = 0x0201900A; -- 1 byte, chip code of pack slot 1

-- 0x0203FFFF end of WRAM?
-- 0x02047FFF end of WRAM?

------------------------------ ROM  08000000-09FFFFFF ------------------------------

ram.addr.battle_data         = 0x080852B0; -- plus offset from TBD?

------------------------------ Getters & Setters ------------------------------

ram.get = {};
ram.set = {};

ram.get.bytes_1 = function(addr) return memory.read_u8 (addr       )    ; end;
ram.set.bytes_1 = function(addr, value) memory.write_u8(addr, value)    ; end;
ram.get.bytes_2 = function(addr) return memory.read_u16_le (addr       ); end;
ram.set.bytes_2 = function(addr, value) memory.write_u16_le(addr, value); end;
ram.get.bytes_4 = function(addr) return memory.read_u32_le (addr       ); end;
ram.set.bytes_4 = function(addr, value) memory.write_u32_le(addr, value); end;

ram.get.main_area = function() return memory.read_u8(ram.addr.main_area); end;
ram.set.main_area = function(main_area) memory.write_u8(ram.addr.main_area, main_area); end;
ram.get.sub_area = function() return memory.read_u8(ram.addr.sub_area); end;
ram.set.sub_area = function(sub_area) memory.write_u8(ram.addr.sub_area, sub_area); end;

ram.get.armor_heat = function() return memory.read_u8(ram.addr.armor_heat); end;
ram.set.armor_heat = function(armor_heat) memory.write_u8(ram.addr.armor_heat, armor_heat); end;
ram.get.armor_aqua = function() return memory.read_u8(ram.addr.armor_aqua); end;
ram.set.armor_aqua = function(armor_aqua) memory.write_u8(ram.addr.armor_aqua, armor_aqua); end;
ram.get.armor_wood = function() return memory.read_u8(ram.addr.armor_wood); end;
ram.set.armor_wood = function(armor_wood) memory.write_u8(ram.addr.armor_wood, armor_wood); end;

ram.get.battle_pointer = function() return memory.read_u16_le(ram.addr.battle_pointer); end;
ram.set.battle_pointer = function(battle_pointer) memory.write_u16_le(ram.addr.battle_pointer, battle_pointer); end;

ram.get.buster_attack = function() return memory.read_u8(ram.addr.buster_attack); end;
ram.set.buster_attack = function(buster_attack) memory.write_u8(ram.addr.buster_attack, buster_attack); end;
ram.get.buster_rapid = function() return memory.read_u8(ram.addr.buster_rapid); end;
ram.set.buster_rapid = function(buster_rapid) memory.write_u8(ram.addr.buster_rapid, buster_rapid); end;
ram.get.buster_charge = function() return memory.read_u8(ram.addr.buster_charge); end;
ram.set.buster_charge = function(buster_charge) memory.write_u8(ram.addr.buster_charge, buster_charge); end;

ram.get.chip_cooldown = function() return memory.read_u8(ram.addr.chip_cooldown); end;
ram.set.chip_cooldown = function(chip_cooldown) memory.write_u8(ram.addr.chip_cooldown, chip_cooldown); end;

ram.get.chip_window_count = function() return memory.read_u8(ram.addr.chip_window_count); end;
ram.set.chip_window_count = function(chip_window_count) memory.write_u8(ram.addr.chip_window_count, chip_window_count); end;

ram.get.check = function() return memory.read_u16_le(ram.addr.check); end;
ram.set.check = function(check) memory.write_u16_le(ram.addr.check, check); end;

ram.get.custom_gauge = function() return memory.read_u16_le(ram.addr.battle_custom_gauge); end;
ram.set.custom_gauge = function(battle_custom_gauge) memory.write_u16_le(ram.addr.battle_custom_gauge, battle_custom_gauge); end;

ram.get.door_code = function() return memory.read_u8(ram.addr.number_door_code); end;
ram.set.door_code = function(number_door_code) memory.write_u8(ram.addr.number_door_code, number_door_code); end;

ram.get.delete_timer = function() return memory.read_u16_le(ram.addr.battle_timer); end;
ram.set.delete_timer = function(battle_timer) memory.write_u16_le(ram.addr.battle_timer, battle_timer); end;

ram.get.folder_ID = function(which_slot) return memory.read_u8(ram.addr.folder_ID+(2*which_slot)); end;
ram.set.folder_ID = function(which_slot, chip_ID) memory.write_u8(ram.addr.folder_ID+(2*which_slot), chip_ID); end;

ram.get.folder_code = function(which_slot) return memory.read_u8(ram.addr.folder_code+(2*which_slot)); end;
ram.set.folder_code = function(which_slot, chip_code) memory.write_u8(ram.addr.folder_code+(2*which_slot), chip_code); end;

ram.get.draw_slot = function(which_slot) return memory.read_u8(ram.addr.battle_draw_slots+which_slot); end;
ram.set.draw_slot = function(which_slot, battle_draw_slot) memory.write_u8(ram.addr.battle_draw_slots+which_slot, battle_draw_slot); end;

ram.get.fire_flags = function() return memory.read_u32_le(ram.addr.fire_flags); end;
ram.set.fire_flags = function(fire_flags) memory.write_u32_le(ram.addr.fire_flags, fire_flags); end;
ram.get.fire_flags_oven = function() return memory.read_u32_le(ram.addr.fire_flags_oven); end;
ram.set.fire_flags_oven = function(fire_flags_oven) memory.write_u32_le(ram.addr.fire_flags_oven, fire_flags_oven); end;
ram.get.fire_flags_www = function() return memory.read_u32_le(ram.addr.fire_flags_www); end;
ram.set.fire_flags_www = function(fire_flags_www) memory.write_u32_le(ram.addr.fire_flags_www, fire_flags_www); end;

ram.get.game_state = function() return memory.read_u8(ram.addr.game_state); end;
ram.set.game_state = function(game_state) memory.write_u8(ram.addr.game_state, game_state); end;

ram.get.HPMemory = function() return memory.read_u8(ram.addr.HPMemory); end;
ram.set.HPMemory = function(HPMemory) memory.write_u8(ram.addr.HPMemory, HPMemory); end;

ram.get.IceBlock = function() return memory.read_u8(ram.addr.key_IceBlock_count); end;
ram.set.IceBlock = function(key_IceBlock_count) memory.write_u8(ram.addr.key_IceBlock_count, key_IceBlock_count); end;

ram.get.library = function(offset) return memory.read_u8(ram.addr.library+offset); end;
ram.set.library = function(offset, bit_flags) memory.write_u8(ram.addr.library+offset, bit_flags); end;

ram.get.magic_byte = function() return memory.read_u8(ram.addr.magic_byte); end;
ram.set.magic_byte = function(magic_byte) memory.write_u8(ram.addr.magic_byte, magic_byte); end;

ram.get.play_time = function() return memory.read_u32_le(ram.addr.play_time_frames); end;
ram.set.play_time = function(play_time_frames) memory.write_u32_le(ram.addr.play_time_frames, play_time_frames); end;

ram.get.PowerUP = function() return memory.read_u8(ram.addr.PowerUP); end;
ram.set.PowerUP = function(PowerUP) memory.write_u8(ram.addr.PowerUP, PowerUP); end;

ram.get.progress = function() return memory.read_u8(ram.addr.progress); end;
ram.set.progress = function(progress) memory.write_u8(ram.addr.progress, progress); end;

ram.get.steps = function() return memory.read_u16_le(ram.addr.steps); end;
ram.set.steps = function(steps) memory.write_u16_le(ram.addr.steps, steps); end;

ram.get.title_star_byte = function() return memory.read_u8(ram.addr.title_star_byte); end;
ram.set.title_star_byte = function(title_star_byte) memory.write_u8(ram.addr.title_star_byte, title_star_byte); end;

ram.get.your_X = function() return memory.read_s16_le(ram.addr.your_X); end;
ram.set.your_X = function(your_X) memory.write_s16_le(ram.addr.your_X, your_X); end;
ram.get.your_Y = function() return memory.read_s16_le(ram.addr.your_Y); end;
ram.set.your_Y = function(your_Y) memory.write_s16_le(ram.addr.your_Y, your_Y); end;

ram.get.zenny = function() return memory.read_u32_le(ram.addr.zenny); end;
ram.set.zenny = function(zenny) memory.write_u32_le(ram.addr.zenny, zenny); end;

ram.get.name = function() return memory.read_u8(ram.addr.name); end;
ram.set.name = function(name) memory.write_u8(ram.addr.name, name); end;
ram.get.name = function() return memory.read_u16_le(ram.addr.name); end;
ram.set.name = function(name) memory.write_u16_le(ram.addr.name, name); end;
ram.get.name = function() return memory.read_u32_le(ram.addr.name); end;
ram.set.name = function(name) memory.write_u32_le(ram.addr.name, name); end;

------------------------------ Address Groupings ------------------------------

ram.addr.enemy         =         {};
ram.addr.enemy[1]      =         {};
ram.addr.enemy[1].ID   = 0x02003774; -- 1 byte
ram.addr.enemy[1].HP   = 0x02006790; -- 2 bytes
ram.addr.enemy[1].text = 0x02004D30; -- 2 bytes, for counting down HP over time
ram.addr.enemy[2]      =         {};
ram.addr.enemy[2].ID   = 0x02003775; -- 1 byte
ram.addr.enemy[2].HP   = 0x02006850; -- 2 bytes
ram.addr.enemy[2].text = 0x020050A0; -- 2 bytes, for counting down HP over time
ram.addr.enemy[3]      =         {};
ram.addr.enemy[3].ID   = 0x02003776; -- 1 byte
ram.addr.enemy[3].HP   = 0x02006910; -- 2 bytes
ram.addr.enemy[3].text = 0x02005200; -- 2 bytes, for counting down HP over time

ram.get.enemy       = {};
ram.get.enemy[1]    = {};
ram.get.enemy[1].ID = function() return memory.read_u8    (ram.addr.enemy[1].ID); end;
ram.get.enemy[1].HP = function() return memory.read_u16_le(ram.addr.enemy[1].HP); end;
ram.get.enemy[2]    = {};
ram.get.enemy[2].ID = function() return memory.read_u8    (ram.addr.enemy[2].ID); end;
ram.get.enemy[2].HP = function() return memory.read_u16_le(ram.addr.enemy[2].HP); end;
ram.get.enemy[3]    = {};
ram.get.enemy[3].ID = function() return memory.read_u8    (ram.addr.enemy[3].ID); end;
ram.get.enemy[3].HP = function() return memory.read_u16_le(ram.addr.enemy[3].HP); end;

ram.set.enemy       = {};
ram.set.enemy[1]    = {};
ram.set.enemy[1].ID = function(enemy_ID) memory.write_u8    (ram.addr.enemy[1].ID, enemy_ID); end;
ram.set.enemy[1].HP = function(enemy_HP) memory.write_u16_le(ram.addr.enemy[1].HP, enemy_HP); end;
ram.set.enemy[2]    = {};
ram.set.enemy[2].ID = function(enemy_ID) memory.write_u8    (ram.addr.enemy[2].ID, enemy_ID); end;
ram.set.enemy[2].HP = function(enemy_HP) memory.write_u16_le(ram.addr.enemy[2].HP, enemy_HP); end;
ram.set.enemy[3]    = {};
ram.set.enemy[3].ID = function(enemy_ID) memory.write_u8    (ram.addr.enemy[3].ID, enemy_ID); end;
ram.set.enemy[3].HP = function(enemy_HP) memory.write_u16_le(ram.addr.enemy[3].HP, enemy_HP); end;

------------------------------ Verion Dependent ------------------------------

local ID_US   = 0x45;
local ID_JP   = 0x4A;
local ID_PAL  = 0x50;

ram.version_byte = memory.read_u8(0x080000AF);

if     ram.version_byte == ID_US  then
    ram.version_name         = "English";
    ram.addr.encounter_odds  = 0x08009934;
    ram.addr.encounter_curve = 0x080099BC;
elseif ram.version_byte == ID_JP  then
    ram.version_name         = "Japanese";
    ram.addr.encounter_odds  = 0x08009900;
    ram.addr.encounter_curve = 0x08009988;
elseif ram.version_byte == ID_PAL then
    ram.version_name         = "PAL";
    ram.addr.encounter_odds  = 0x08009940;
    ram.addr.encounter_curve = 0x080099C8;
else
    ram.version_name = "Unknown";
    ram.addr.encounter_odds = nil;
    ram.addr.encounter_curve = nil;
    print("RAM: Unrecognized game version. Unable to set certain values!");
end

---------------------------------------- RNG Wrapper ----------------------------------------

function ram.get_RNG_value()
    return ram.rng.get_RNG_value();
end

function ram.set_RNG_value(new_rng)
    ram.rng.set_RNG_value(new_rng);
end

function ram.get_RNG_index()
    return ram.rng.get_RNG_index();
end

function ram.set_RNG_index(new_index)
    ram.rng.set_RNG_index(new_index)
end

function ram.get_RNG_delta()
    return ram.rng.get_RNG_delta();
end

function ram.adjust_RNG(steps)
    ram.rng.adjust_RNG(steps);
end

---------------------------------------- Module Controls ----------------------------------------

function ram.initialize(options)
    options.RNG_address = ram.addr.RNG;
    ram.rng.initialize(options);
end

function ram.update_pre(options)
    if options.no_chip_cooldown then
        ram.set.chip_cooldown(0);
    end
    ram.rng.update_pre(options);
end

function ram.update_post(options)
    ram.rng.update_post(options);
end

return ram;

