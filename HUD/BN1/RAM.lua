-- RAM Addresses & Functions for MMBN 1 Scripting, enjoy.

local ram = {};

ram.rng = require("BN1/RNG");
ram.areas = require("BN1/Areas");
ram.chips = require("BN1/Chips");
ram.enemies = require("BN1/Enemies");
ram.progress_names = require("BN1/Progress");

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

-- Addresses -> 02000000-0203FFFF - On-board Work RAM (WRAM) (256 KBytes)

local metro_ticket       = 0x02000005; -- TBD

local magic_flag         = 0x0200001D; -- 0x---10--- (progress must be == 0x54)

local library_start      = 0x02000020; -- starts at 2nd bit  flag
local library_end        = 0x02000034; -- or later?

-- 42, higsby email?

local emails_read_1      = 0x02000048; -- ends at 4F?

local BMD_flags_start    = 0x02000050; -- or earlier?
--local GMD_flags          = 0x02000051; -- -53?
local BMD_flags_end      = 0x0200006B; -- or later?

-- 6C-8B temp flags?

local fire_flags         = 0x02000070; -- 4 bytes, 32 fire bit flags

-- 83 dex hp link?

-- 110-120 divider

-- 120-170 ???

local folder_ID          = 0x020001C0; -- 1 byte, chip  ID  of folder slot 1, ends at 0x020001FB
local folder_code        = 0x020001C1; -- 1 byte, chip Code of folder slot 1, ends at TBD

local WHAT_IS_THIS       = 0x020001FF; -- 1 byte?

--local                  = 0x02000200; -- 1 byte flags?
--local                  = 0x02000210; -- 1 byte TBD fight GutsMan
local area               = 0x02000214; -- 1 byte
local sub_area           = 0x02000215; -- 1 byte
local progress           = 0x02000216; -- 1 byte
local music_progress     = 0x02000217; -- 1 byte
--local                  = 0x02000218; -- 1 byte TBD
--local                  = 0x02000219; -- 1 byte TBD
--230-233 block of 1's
--local link_flags       = 0x02000234; -- 1 byte TBD hp & internet
--21D ???
local zenny              = 0x02000284; -- 4 bytes, 999999 "max"
-- 2AC-2CF
local key_PET            = 0x020002D0; -- 1 byte
local IceBlock_count     = 0x020002D1; -- 1 byte, for both Oven and WWW 1
local key_WaterGun       = 0x020002D2; -- 1 byte value of 0x05?
local key_SchoolID       = 0x020002D3; -- 1 byte
local key_SciLabID       = 0x020002D4; -- 1 byte, snip snip
local key_Handle         = 0x020002D5; -- 1 byte
local key_Message        = 0x020002D6; -- 1 byte, 5th grade Froid
local key_Response       = 0x020002D7; -- 1 byte, to Mayl's email
local key_WWW_PIN        = 0x020002D8; -- 1 byte
local key_BatteryA       = 0x020002D9; -- 1 byte
local key_BatteryB       = 0x020002DA; -- 1 byte
local key_BatteryC       = 0x020002DB; -- 1 byte
local key_BatteryD       = 0x020002DC; -- 1 byte
local key_BatteryE       = 0x020002DD; -- 1 byte
local key_Charger        = 0x020002DE; -- 1 byte
local key_WWW_Pass       = 0x020002DF; -- 1 byte, expired
--local key_invalid      = 0x020002E0; -- 1 byte
local key_Dentures       = 0x020002E1; -- 1 byte TBD
-- 0x020002E2 to 0x020002EF invalid
--local key_invalid      = 0x020002F0; -- 1 byte
local key_at_Mayl        = 0x020002F1; -- 1 byte
local key_at_Yai         = 0x020002F2; -- 1 byte
local key_at_Dex         = 0x020002F3; -- 1 byte
--local key_invalid      = 0x020002F4; -- 1 byte
local key_at_Dad         = 0x020002F5; -- 1 byte
local key_at_Sal         = 0x020002F6; -- 1 byte TBD
--local key_invalid      = 0x020002F7; -- 1 byte
local key_at_Miyu        = 0x020002F8; -- 1 byte TBD
--local key_invalid      = 0x020002F9; -- 1 byte
--local key_invalid      = 0x020002FA; -- 1 byte
local key_at_Masa        = 0x020002FB; -- 1 byte
--local key_invalid      = 0x020002FC; -- 1 byte
local key_at_WWW         = 0x020002FD; -- 1 byte
--local key_invalid      = 0x020002FE; -- 1 byte
--local key_invalid      = 0x020002FF; -- 1 byte
local key_slash_Dex      = 0x02000300; -- 1 byte, 0x21 and 0x02000010 -> 0x00200000
local key_slash_Sal      = 0x02000301; -- 1 byte
local key_slash_Miyu     = 0x02000302; -- 1 byte
--local key_invalid      = 0x02000303; -- 1 byte
local key_Hig_Memo       = 0x02000304; -- 1 byte
local key_Lab_Memo       = 0x02000305; -- 1 byte
local key_Pa_Memo        = 0x02000306; -- 1 byte
local key_Yuri_Memo      = 0x02000307; -- 1 byte
--local key_invalid      = 0x02000308; -- 1 byte
--local key_invalid      = 0x02000309; -- 1 byte
--local key_invalid      = 0x0200030A; -- 1 byte
--local key_invalid      = 0x0200030B; -- 1 byte
local key_ACDCPass       = 0x0200030C; -- 1 byte
local key_GovtPass       = 0x0200030D; -- 1 byte
local key_TownPass       = 0x0200030E; -- 1 byte
--local key_invalid      = 0x0200030F; -- 1 byte

local HPMemory           = 0x02000310; -- 1 byte TBD
local powerups_available = 0x02000311; -- 1 byte
--local                  = 0x02000312; -- 1 byte
--local                  = 0x02000313; -- 1 byte
local armor_heat         = 0x02000314; -- 1 byte
--local armor_           = 0x02000315; -- 1 byte
local armor_wood         = 0x02000316; -- 1 byte

-- 370-3CF divider

local steps_also         = 0x020003E0; -- 3 bytes ???
local time_in_frames     = 0x020003E8; -- 4 bytes, check for skipped frames
local steps              = 0x020003F4; -- 4 bytes
local check              = 0x020003F8; -- 4 bytes, steps at the last encounter check

-- 448-49F big divider

-- 5AA broken divider?

-- 13A0 first usable?

local battle_pointer     = 0x02003784; -- 4 bytes, pointer to current battle

local battle_draw_slots  = 0x02004910; -- 1 byte each, in battle chip draws, ends at TBD
local your_X             = 0x02004954; -- 2 bytes ???
local your_Y             = 0x02004956; -- 2 bytes ???

local enemy = {};
enemy[1]      =         {}; -- TBD
enemy[1].ID   = 0x02000000; -- TBD
enemy[1].HP   = 0x02006790; -- 2 bytes
enemy[1].text = 0x02004D30; -- 2 bytes, for counting down over time
enemy[2]      =         {}; -- TBD
enemy[2].ID   = 0x02000000; -- TBD
enemy[2].HP   = 0x02006850; -- 2 bytes
enemy[2].text = 0x020050A0; -- 2 bytes, for counting down over time
enemy[3]      =         {}; -- TBD
enemy[3].ID   = 0x02000000; -- TBD
enemy[3].HP   = 0x02006910; -- 2 bytes
enemy[3].text = 0x02005200; -- 2 bytes, for counting down over time

local cursor_ID          = 0x020062E4; -- 1 byte, chip  ID  of cursor
local cursor_code        = 0x020062E5; -- 1 byte, chip Code of cursor
local in_folder_count    = 0x020062F0; -- 1 byte, number of chips in folder
local GMD_reward         = 0x02006380; -- 2 bytes, how to decode?
local game_state         = 0x02006CB8; -- 1 byte
local RNG_address        = 0x02006CC0; -- 4 bytes, resets and pauses on the title screen

local folder_cursor      = 0x020062F4; -- 2 bytes?, cursor value in the folder
local folder_offset      = 0x020062F6; -- 2 bytes?, offset value in the folder
local pack_cursor        = 0x020062FE; -- 2 bytes?, cursor value in the pack
local pack_offset        = 0x02006300; -- 2 bytes?, offset value in the pack
local selected_offset    = 0x02006308; -- 2 bytes?, offset value of selected chip
local selected_cursor    = 0x0200630A; -- 2 bytes?, cursor value of selected chip

local number_door_code   = 0x02009A90; -- 1 byte?

local pack_ID            = 0x02019018; -- 1 byte, chip  ID  of pack slot 1
local pack_code          = 0x0201900A; -- 1 byte, chip code of pack slot 1

-- 0x02047FFF end of WRAM

-- Unverified

--local mega_level         = 0x02000000; -- 1 byte ???
--local world_HP_max       = 0x02000000; -- 2 bytes ???
--local title_star_flag    = 0x02000000; -- 1 bit for 1 star :)

-- Addresses -> 08000000-09FFFFFF - Game Pak ROM/FlashROM (max 32MB)

local version            = 0x080000AF; -- 1 byte

local encounter_odds = {};
encounter_odds[0x45] = 0x08009934; -- US
encounter_odds[0x4A] = 0x08009900; -- JP
encounter_odds[0x50] = 0x08009940; -- PAL

local encounter_curve = {};
encounter_curve[0x45] = 0x080099BC; -- US
encounter_curve[0x4A] = 0x08009988; -- JP
encounter_curve[0x50] = 0x080099C8; -- PAL

------------------------------------------------------------------------------------------------------------------------

local game_state_names = {};
game_state_names[0x00] = "title";
game_state_names[0x04] = "world";
game_state_names[0x08] = "battle";
game_state_names[0x0C] = "player_change"; -- jack-in/out
game_state_names[0x10] = "demo_end"; -- ???
game_state_names[0x14] = "capcom_logo";
game_state_names[0x18] = "menu";
game_state_names[0x1C] = "shop";
game_state_names[0x20] = "game_over";
game_state_names[0x24] = "trader";
game_state_names[0x28] = "credits";
game_state_names[0x2C] = "ubisoft_logo";

-- Functions -> Game State

function ram.get_version_byte()
    return memory.read_u8(version);
end

function ram.get_version()
    if ram.get_version_byte() == 0x45 then
        return "English";
    elseif ram.get_version_byte() == 0x4A then
        return "Japanese";
    elseif ram.get_version_byte() == 0x50 then
        return "Pal";
    end
    return "???";
end

function ram.get_game_state()
    return memory.read_u8(game_state);
end

function ram.get_game_state_name()
    return game_state_names[ram.get_game_state()] or "unknown";
end

function ram.in_title()
    return ram.get_game_state() == 0x00;
end

function ram.in_world()
    return ram.get_game_state() == 0x04;
end

function ram.in_battle()
    return ram.get_game_state() == 0x08;
end

function ram.in_transition()
    return ram.get_game_state() == 0x0C;
end

function ram.in_splash()
    return (ram.get_game_state() == 0x14 or ram.get_game_state() == 0x2C);
end

function ram.in_menu()
    return ram.get_game_state() == 0x18;
end

function ram.in_shop()
    return ram.get_game_state() == 0x1C;
end

function ram.in_game_over()
  return ram.get_game_state() == 0x20;
end

function ram.in_chip_trader()
  return ram.get_game_state() == 0x24;
end

function ram.in_credits()
    return ram.get_game_state() == 0x28;
end

function ram.get_magic_byte()
    return memory.read_u8(magic_flag);
end

function ram.is_magic_bit_set()
    if bit.band(ram.get_magic_byte(), 0x18) == 0x10 then
        return true;
    end
    return false;
end

function ram.is_go_mode()
    if ram.is_magic_bit_set() then
        return "Yes!";
    end
    return "Nope";
end

function ram.get_progress()
    return memory.read_u8(progress);
end

function ram.get_progress_name()
    return ram.progress_names[ram.get_progress()];
end

function ram.set_progress(new_progress)
    if new_progress < 0x00 then
        new_progress = 0x00;
    elseif new_progress > 0x5F then
        new_progress = 0x5F;
    end
    return memory.write_u8(progress, new_progress);
end

function ram.add_progress(some_progress)
    return ram.set_progress(ram.get_progress() + some_progress);
end

-- Functions -> Position 

function ram.get_area()
    return memory.read_u8(area);
end

function ram.set_area(new_area)
    return memory.write_u8(area, new_area);
end

function ram.get_sub_area()
    return memory.read_u8(sub_area);
end

function ram.set_sub_area(new_sub_area)
    return memory.write_u8(sub_area, new_sub_area);
end

function ram.get_area_name()
    if ram.areas.names[ram.get_area()] then
        if ram.areas.names[ram.get_area()][ram.get_sub_area()] then
            return ram.areas.names[ram.get_area()][ram.get_sub_area()];
        end
        return "Unknown Sub Area";
    end
    return "Unknown Area";
end

function ram.does_area_exist(main_area, sub_area)
    return ram.areas.names[main_area] and ram.areas.names[main_area][sub_area];
end

function ram.in_real_world()
    if ram.get_area() < 0x80 then
        return true;
    end
    return false;
end

function ram.in_digital_world()
    return not ram.in_real_world();
end

function ram.get_x()
    return memory.read_s16_le(your_X);
end

function ram.get_y()
    return memory.read_s16_le(your_Y);
end

function ram.get_steps()
    return memory.read_u32_le(steps);
end

function ram.set_steps(new_steps)
    if new_steps < 0 then
        new_steps = 0
    end
    memory.write_u32_le(steps, new_steps);
end

function ram.add_steps(some_steps)
    ram.set_steps(ram.get_steps() + some_steps);
end

function ram.get_check()
    return memory.read_u32_le(check);
end

function ram.set_check(new_check)
    if new_check < 0 then
        new_check = 0
    end
    memory.write_u32_le(check, new_check);
end

function ram.add_check(some_check)
    ram.set_check(ram.get_check() + some_check);
end

-- Functions -> Inventory

function ram.get_zenny()
    return memory.read_u32_le(zenny);
end

function ram.set_zenny(new_zenny)
    if new_zenny < 0 then
        new_zenny = 0;
    elseif new_zenny > 999999 then
        new_zenny = 999999;
    end
    return memory.write_u32_le(zenny, new_zenny);
end

function ram.add_zenny(some_zenny)
    return ram.set_zenny(ram.get_zenny() + some_zenny)
end

-- Functions -> Battlechips

function ram.get_chip_name(ID)
    return ram.chips.names[ID];
end

function ram.get_chip_code(code)
    return ram.chips.codes[code];
end

-- Functions -> Mega Man

function ram.get_max_HP()
    --return memory.read_u16_le(world_HP_max);
end

function ram.get_mega_level()
    -- TODO: Calculate and return Mega Man's level
end

function ram.get_IceBlock_available()
    return memory.read_u8(IceBlock_count);
end

function ram.set_IceBlock_available(new_IceBlock_available)
    if new_IceBlock_available < 0 then
        new_IceBlock_available = 0;
    elseif new_IceBlock_available > 53 then
        new_IceBlock_available = 53;
    end
    return memory.write_u8(IceBlock_count, new_IceBlock_available);
end

function ram.add_IceBlock_available(some_IceBlock)
    ram.set_IceBlock_available(ram.get_IceBlock_available() + some_IceBlock);
end

function ram.get_powerups_available()
    return memory.read_u8(powerups_available);
end

function ram.set_powerups_available(new_powerups_available)
    if new_powerups_available < 0 then
        new_powerups_available = 0;
    elseif new_powerups_available > 20 then
        new_powerups_available = 20;
    end
    return memory.write_u8(powerups_available, new_powerups_available);
end

function ram.add_powerups_available(some_powerups)
    ram.set_powerups_available(ram.get_powerups_available() + some_powerups);
end

-- Functions -> Battle Information

function ram.get_enemy_ID(which_enemy)
    return memory.read_u8(enemy[which_enemy].ID);
end

function ram.get_enemy_name(which_enemy)
    return ram.enemies.names[ram.get_enemy_ID(which_enemy)];
end

function ram.get_enemy_HP(which_enemy)
    return memory.read_u16_le(enemy[which_enemy].HP);
end

function ram.set_enemy_HP(which_enemy, new_HP)
    memory.write_u16_le(enemy[which_enemy].HP, new_HP);
end

function ram.kill_enemy(which_enemy)
    if which_enemy == 0 then
        ram.set_enemy_HP(1, 0);
        ram.set_enemy_HP(2, 0);
        ram.set_enemy_HP(3, 0);
    else
        ram.set_enemy_HP(which_enemy, 0);
    end
end

function ram.get_draw_slot(which_slot) -- convert from 1 to 0 index, then back
    if 1 <= which_slot and which_slot <= 30 then
        return memory.read_u8(battle_draw_slots + which_slot - 1) + 1;
    end
    return -1;
end

function ram.get_draw_slots()
    slots = {};
    for i=1,30 do
        slots[i] = ram.get_draw_slot(i);
    end
    return slots;
end

-- Functions -> Misc.

function ram.get_door_code()
    return memory.read_u16_le(number_door_code);
end

function ram.set_door_code(new_door_code)
    return memory.write_u16_le(number_door_code, new_door_code);
end

function ram.near_number_doors() -- School Comps or WWW Comp 2
    return ram.get_area() == 0x80 or (ram.get_area() == 0x85 and ram.get_sub_area() == 0x01);
end

function ram.get_fire_flags()
    return memory.read_u32_le(fires_flags);
end

function ram.ignite_oven_fires()
    --memory.write_u32_le(fires_flags, 0x00000000);
end

function ram.extinguish_oven_fires()
    --memory.write_u32_le(fires_flags, 0xFFFFFFFF);
end

function ram.ignite_WWW_fires()
    --memory.write_u32_le(fires_flags, 0x00000000);
end

function ram.extinguish_WWW_fires()
    --memory.write_u32_le(fires_flags, 0xFFFFFFFF);
end

------------------------------------------------------------------------------------------------------------------------

-- Encounter Tracking and Avoidance

local last_encounter_check = 0; -- the previous value of check

function ram.get_encounter_checks()
    return math.floor(last_encounter_check / 64); -- approximate
end

function ram.get_encounter_threshold()
    local curve_addr = encounter_curve[ram.get_version_byte()];
    curve = memory.read_u8(curve_addr + (ram.get_area() - 0x80) * 0x10 + ram.get_sub_area());
    local odds_addr = encounter_odds[ram.get_version_byte()];
    local test_level = math.min(math.floor(ram.get_steps() / 64) + 1, 16);
    return memory.read_u8(odds_addr + test_level * 8 + ram.get_curve());
end

function ram.get_encounter_chance()
    local threshold = ram.get_encounter_threshold();
    return (threshold / 32) * 100;
end

function ram.would_get_encounter() -- Encounter if rand(0x20) >= rate
    return ram.rng.get_rng_value() % 0x20 > ram.get_encounter_chance();
end

ram.skip_encounters = false;

local function encounter_check()
    if ram.in_world() then
        if ram.get_check() < last_encounter_check then
            last_encounter_check = 0; -- dodged encounter or area (re)load or state load
        elseif ram.get_check() > last_encounter_check then
            last_encounter_check = ram.get_check();
        end
        
        if ram.skip_encounters then
            if ram.get_steps() > 64 then
                ram.set_steps(ram.get_steps() % 64);
                ram.set_check(ram.get_check() % 64);
            end
        end
    end
end

-- Controls

function ram.initialize(options)
    ram.rng.initialize(options.max_RNG_index);
end

function ram.update_pre()
    encounter_check();
    ram.rng.update_pre();
end

function ram.update_post()
    ram.rng.update_post();
end

return ram;

