-- RAM Addresses & Functions for MMBN 3 Scripting, enjoy.

local ram = {};

ram.rng = require("BN3/RNG");
ram.chips = require("BN3/Chips");
ram.enemies = require("BN3/Enemies");

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

-- Addresses -- 02000000-0203FFFF - On-board Work RAM (WRAM) (256 KBytes)

local folder_state      = 0x02000040; -- 1 byte
local HP_memory_value   = 0x02000150; -- 1 byte ???

local library_flags     = 0x02000330; -- 1 bit per chip, runs for ~44 bytes

local battles_guts      = 0x02000E60; -- 1 byte
local battles_cust      = 0x02000E61; -- 1 byte
local battles_team      = 0x02000E62; -- 1 byte
local battles_shld      = 0x02000E63; -- 1 byte
local battles_grnd      = 0x02000E64; -- 1 byte
local battles_shdw      = 0x02000E65; -- 1 byte
local battles_bug       = 0x02000E66; -- 1 byte
--local                 = 0x02000E67; -- 1 byte TBD
local GMD_RNG           = 0x02000E68; -- 4 bytes, drop table index

local folder_1_ID       = 0x02001410; -- 2 bytes, chip  ID  of folder 1 slot 1, ends 0x2001484
local folder_1_code     = 0x02001412; -- 2 bytes, chip Code of folder 1 slot 1, ends 0x02001486
local folder_2_ID       = 0x02001500; -- 2 bytes, chip  ID  of folder 1 slot 1, ends 0x02001574
local folder_2_code     = 0x02001502; -- 2 bytes, chip Code of folder 1 slot 1, ends 0x02001576
local folder_3_ID       = 0x02001488; -- 2 bytes, chip  ID  of folder 1 slot 1, ends 0x020014FC
local folder_3_code     = 0x0200148A; -- 2 bytes, chip Code of folder 1 slot 1, ends 0x020014FE

local control_flags     = 0x02001880; -- 1 byte ???
local style_active      = 0x02001881; -- 1 byte
--local                 = 0x02001882; -- 1 byte TBD
--local                 = 0x02001883; -- 1 byte TBD
local     area          = 0x02001884; -- 1 byte
local sub_area          = 0x02001885; -- 1 byte
local progress          = 0x02001886; -- 1 byte
--local                 = 0x02001887; -- 1 byte TBD music???
--local                 = 0x02001888; -- 1 byte TBD
local battle_paused     = 0x02001889; -- 1 byte, paused or custom menu in battle
local style_stored      = 0x02001894; -- 1 byte
local world_HP_current  = 0x020018A0; -- 2 bytes
local world_HP_max      = 0x020018A2; -- 2 bytes
local zenny             = 0x020018F4; -- 4 bytes, 999999 "max"
local frags             = 0x020018F8; -- 4 bytes,   9999 "max"

local next_element      = 0x02001DBB; -- 1 byte, next element
local battle_count      = 0x02001DCA; -- 1 byte, number of battles since last style change
local steps             = 0x02001DDC; -- 4 bytes
local check             = 0x02001DE0; -- 4 bytes, steps at the last encounter check
local sneak             = 0x02001DEC; -- 4 bytes, starts at 6000

local battle_escape_lvl = 0x02001A20; -- 1 byte ???

local pack_chip_counts  = 0x02001f60; -- 18*312 bytes, first 6 of every 18 bytes are used, ends 0x02003550?

local credits_cutscene  = 0x020050A8; -- 1 byte ???

local buster1           = 0x02005778; -- 1 byte ???
local buster2           = 0x02005779; -- 1 byte ???
local buster3           = 0x0200577A; -- 1 byte ???
local max_HP_over_five  = 0x0200579C; -- 1 byte, Maximum HP Check for HP Memory (Max HP/5)

local battle_enemy_ID   = 0x02006D00; -- 1 byte, per enemy up to 3

local cursor_ID         = 0x02007D14; -- 2 bytes? chip ID of cursor
local cursor_code       = 0x02007D18; -- 2 bytes? chip Code of cursor
local folder_or_pack    = 0x02007DD3; -- 1 byte, 26 == folder, 8 == pack

local your_x1           = 0x02008F54; -- 2 bytes graphical position?
local your_y1           = 0x02008F56; -- 2 bytes graphical position?
local your_x2           = 0x02008F58; -- 2 bytes actual position?
local your_y2           = 0x02008F5A; -- 2 bytes actual position?

local folder_cursor     = 0x020093E2; -- 2 bytes?, cursor value in the folder
local folder_offset     = 0x020093E6; -- 2 bytes?, offset value in the folder
local pack_cursor       = 0x020093EC; -- 2 bytes?, cursor value in the pack
local pack_offset       = 0x020093F0; -- 2 bytes?, offset value in the pack
local folder_count      = 0x020093DA; -- 1 byte, number of chips in folder being edited

local selected_offset_folder = 0x02009420; -- 2 bytes?, offset value of selected chip in folder
local selected_cursor_folder = 0x02009422; -- 2 bytes?, cursor value of selected chip in folder
local selected_offset_pack   = 0x02009428; -- 2 bytes?, offset value of selected chip in pack
local selected_cursor_pack   = 0x0200942A; -- 2 bytes?, cursor value of selected chip in pack

local is_interacting    = 0x02009480; -- 1 byte ???
local interact_with     = 0x02009481; -- 1 byte ???
local interact_offset   = 0x020094AC; -- 4 bytes ???
local GMD_value         = 0x020094B8; -- 2 bytes, how to decode?
local number_trader     = 0x020094B8; -- 1 byte per 8 digits
local  sub_RNG          = 0x02009730; -- controls encounter ID and chip draws
local bbs_jobs_new      = 0x020097A5; -- 1 byte ???
local bbs_jobs_total    = 0x020097BA; -- 1 byte ???
local game_state        = 0x020097F8; -- 1 byte
local main_RNG          = 0x02009800; -- controls everything else
local gamble_win        = 0x02009DB2; -- 1 byte, winning value
local gamble_pick       = 0x02009DB1; -- 1 byte, current value

local title_star_flags  = 0x0200A30A; -- 1 bit per star 0xFE

--local battle_         = 0x0200F332; -- 2 bytes, something battle related
local battle_reward     = 0x0200F332; -- 2 bytes, how to decode? (mask 0x40 means zenny)
--local battle_         = 0x0200F334; -- 2 bytes, stats? S+?
local battle_field      = 0x0200F47E; -- 8*3 bytes, current battlefield

local pack_ID           = 0x0201881C; -- 2 bytes, chip ID of pack
local pack_code         = 0x0201880A; -- 2 bytes, chip code of pack

local draw_index        = 0x02034040; -- 1 byte each, battle chip draws, ends at 0x0203405D
local battle_HP_current = 0x02037294; -- 1 byte
local battle_HP_max     = 0x02037296; -- 1 byte

local version          = 0x080000AA; -- 1 byte, blue 0x42 or white 0x57

local style_names = {"Elec", "Heat", "Aqua", "Wood"}; -- FWEG but Elec is first, 1 indexed

local game_state_names = {};
game_state_names[0x00] = "title";
game_state_names[0x04] = "world";
game_state_names[0x08] = "battle";
game_state_names[0x0C] = "player_change"; -- jack-in/out
game_state_names[0x14] = "splash";
game_state_names[0x18] = "menu";

-- Flags to find: Key Items, MDs, Jobs, Trades, Vines, Fires

------------------------------------------------------------------------------------------------------------------------

-- Functions -> Game State

function ram.get_version()
    if memory.read_u8(version) == 0x42 then
        return "Blue";
    elseif memory.read_u8(version) == 0x57 then
        return "White";
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
    return ram.get_game_state() == 0x14;
end

function ram.in_menu()
    return ram.get_game_state() == 0x18;
end

-- Functions -> Location https://forums.therockmanexezone.com/list-of-mmbn3-areas-and-subareas-t5354.html

function ram.get_area()
    return memory.read_u8(area);
end

function ram.get_sub_area()
    return memory.read_u8(subArea);
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
    return memory.read_s16_le(your_x2);
end

function ram.set_x()
    return memory.write_s16_le(your_x2); -- untested
end

function ram.get_y()
    return memory.read_s16_le(your_y2);
end

function ram.set_y()
    return memory.write_s16_le(your_y2); -- untested
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

function ram.get_gamble_win()
    return memory.read_u8(gamble_win);
end

function ram.get_gamble_win()
    return memory.read_u8(gamble_pick);
end

function ram.is_gambling()
    if ram.get_area() == 0x8C then -- Sub Comps
        if ram.get_sub_area() == 0x02 or ram.get_sub_area() == 0x08 or ram.get_sub_area() == 0x0C then
            return true; -- Vending Comp (SciLab) or TV Board Comp or Vending Comp (Hospital)
        end
    end
    
    return false;
end

function ram.in_Secret_3()
    if ram.get_area() == 0x95 and ram.get_sub_area() == 0x02 then
        return true; -- Bug Frag Trader
    end
    
    return false;
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
    return memory.write_u32_le(zenny, ram.get_zenny() + some_zenny);
end

function ram.get_frags()
    return memory.read_u32_le(frags);
end

function ram.set_frags(new_frags)
    if new_frags < 0 then
        new_frags = 0;
    elseif new_frags > 9999 then
        new_frags = 9999;
    end
    return memory.write_u32_le(frags, new_frags);
end

function ram.add_frags(some_frags)
    return memory.write_u32_le(frags, ram.get_frags() + some_frags);
end

-- Functions -> Battlechips

function ram.get_chip_name(ID)
    return ram.chips.names[ID];
end

function ram.get_chip_code(code)
    return ram.chips.codes[code];
end

-- Functions -> Mega Man

function ram.get_next_element()
    return memory.read_u8(next_element);
end

function ram.get_next_element_name()
    return style_names[ram.get_next_element()]; -- shouldn't be nil...
end

function ram.set_next_element(new_next_element)
    return memory.write_u8(next_element, bit.band(new_next_element, 0x07));
end

function ram.get_battle_count()
    return memory.read_u8(battle_count);
end

function ram.set_battle_count(new_battle_count)
    return memory.write_u8(battleCount, new_battle_count);
end

function ram.add_battle_count(some_battles)
    return ram.set_battle_count(ram.get_battle_count() + some_battles);
end

-- Functions -> Battle Information

function ram.get_enemy_ID(enemy_number) -- convert from 1 to 0 index
    return memory.read_u8(battle_enemy_ID + enemy_number - 1);
end

function ram.get_enemy_name(enemy_number)
    return ram.enemies[ram.get_enemy_ID(enemy_number)];
end

function ram.get_draw_slot(which_slot) -- convert from 1 to 0 index
    return memory.read_u8(draw_index + which_slot - 1) + 1;
end

function ram.get_draw_slots()
    slots = {};
    for i=1,30 do -- check off by 1
        slots[i] = ram.get_draw_slot(i);
    end
    return slots;
end

-- Functions -> Misc.

function ram.get_GMD_RNG()
    return memory.read_u32_le(GMD_RNG);
end

function ram.set_GMD_RNG(new_GMD_RNG)
    return memory.write_u32_le(GMD_RNG, new_GMD_RNG);
end

function ram.randomize_GMD_RNG()
    return ram.set_GMD_RNG(rng.get_main_RNG_value());
end

function ram.get_GMD_value()
    return memory.read_u32_le(GMD_value);
end

------------------------------------------------------------------------------------------------------------------------

-- Encounter Tracking and Avoidance

local last_encounter_check = 0; -- the previous value of check

function ram.get_encounter_checks()
    return math.floor(last_encounter_check / 64); -- approximate
end

ram.skip_encounters = false;

local function encounter_check()
    if ram.in_world() then
        if ram.get_check() < last_encounter_check then
            last_encounter_check = 0; -- area reloaded or state loaded
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

