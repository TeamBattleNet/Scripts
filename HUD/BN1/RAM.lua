-- RAM Addresses & Functions for MMBN 1 Scripting, enjoy.

local ram = {};

ram.rng = require("BN1/RNG");
ram.areas = require("BN1/Areas");
ram.chips = require("BN1/Chips");
ram.enemies = require("BN1/Enemies");

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

local magic_flag         = 0x0200001D; -- 0x00010000 (progress must be == 0x54)

local fires_flags_1      = 0x02000070; -- fire flags
local fires_flags_2      = 0x02000071; -- fire flags
local fires_flags_3      = 0x02000072; -- fire flags
local fires_flags_4      = 0x02000073; -- fire flags
local fires_flags_4      = 0x02000073; -- fire flags

local folder_ID          = 0x020001C0; -- 1 byte, chip  ID  of folder slot 1, ends at TBD
local folder_code        = 0x020001C1; -- 1 byte, chip Code of folder slot 1, ends at TBD

local area               = 0x02000214; -- 1 byte
local sub_area           = 0x02000215; -- 1 byte
local progress           = 0x02000216; -- 1 byte
local zenny              = 0x02000284; -- 4 bytes, 999999 "max"
local IceBlock_count     = 0x020002D1; -- 1 byte, for both Oven and WWW 1

local powerups_available = 0x02000311; -- 1 byte
local steps              = 0x020003F4; -- 4 bytes
local check              = 0x020003F8; -- 4 bytes, steps at the last encounter check
local battle_pointer     = 0x02003784; -- 4 bytes, pointer to current battle

local battle_draw_slots  = 0x02004910; -- 1 byte each, in battle chip draws, ends at TBD
local your_X             = 0x02004954; -- 2 bytes ???
local your_Y             = 0x02004956; -- 2 bytes ???

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

-- Unverified

--local mega_level         = 0x02000000; -- 1 byte ???
--local world_HP_max       = 0x02000000; -- 2 bytes ???
--local title_star_flag    = 0x02000000; -- 1 bit for 1 star :)
--local battle_enemy_ID    = 0x02000000; -- 1 byte, per enemy up to 3

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

function ram.get_progress()
    return memory.read_u8(progress);
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
    if bit.band(ram.get_magic_byte(), 0x10) == 0x10 then
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

function ram.get_enemy_ID(enemy_number) -- convert from 1 to 0 index
    return -1;
    --return memory.read_u8(battle_enemy_ID + enemy_number - 1);
end

function ram.get_enemy_name(enemy_number)
    return ram.enemies.names[ram.get_enemy_ID(enemy_number)];
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

