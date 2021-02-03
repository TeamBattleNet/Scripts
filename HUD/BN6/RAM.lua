-- RAM Addresses & Functions for MMBN 6 Scripting, enjoy.

local ram = {};

ram.rng = require("BN6/RNG");
ram.areas = require("BN6/Areas");
ram.chips = require("BN6/Chips");
ram.enemies = require("BN6/Enemies");

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

-- GMD_value and number_code use the same address
-- Pressing LButton during CopyMan skip could be an exploit
-- Flags to find: Beta Navis, Key Items, MDs, Jobs, Trades, Vines, Fires, Animals, Jack-Out Lock Out

-- Addresses -> 02000000-0203FFFF - On-board Work RAM (WRAM) (256 KBytes)

local folder_state      = 0; -- 1 byte
local HP_memory_value   = 0; -- 1 byte ???

local library_flags     = 0; -- 1 bit per chip, runs for ~44 bytes

--local                 = 0x02000E67; -- 1 byte TBD

local folder_1_ID       = 0; -- 2 bytes, chip  ID  of folder 1 slot 1, ends 0x02001484
local folder_1_code     = 0; -- 2 bytes, chip Code of folder 1 slot 1, ends 0x02001486
local folder_2_ID       = 0; -- 2 bytes, chip  ID  of folder 1 slot 1, ends 0x02001574
local folder_2_code     = 0; -- 2 bytes, chip Code of folder 1 slot 1, ends 0x02001576
local folder_3_ID       = 0; -- 2 bytes, chip  ID  of folder 1 slot 1, ends 0x020014FC
local folder_3_code     = 0; -- 2 bytes, chip Code of folder 1 slot 1, ends 0x020014FE

local control_flags     = 0; -- 1 byte ???
local style_active      = 0; -- 1 byte
--local                 = 0x02001882; -- 1 byte TBD
--local                 = 0x02001883; -- 1 byte TBD
local     area          = 0x02001B84; -- 1 byte
local sub_area          = 0x02001B85; -- 1 byte
local progress          = 0x02001B86; -- 1 byte
--local                 = 0x02001887; -- 1 byte TBD music???
--local                 = 0x02001888; -- 1 byte TBD
local battle_paused     = 0; -- 1 byte, paused or custom menu in battle
local style_stored      = 0; -- 1 byte
local world_HP_current  = 0; -- 2 bytes
local world_HP_max      = 0; -- 2 bytes
local zenny             = 0x02001DBC; -- 4 bytes, 999999 "max"
local bug_frags         = 0x02001BE0; -- 4 bytes,   9999 "max"

local next_element      = 0; -- 1 byte, next element
local battle_count      = 0; -- 1 byte, number of battles since last style change
local steps             = 0x02001C16; -- 2 bytes
local check             = 0x02001C18; -- 2 bytes, steps at the last encounter check
local sneak             = 0x02001C28; -- 4 bytes, starts at 6000

local battle_escape_lvl = 0; -- 1 byte ???

local pack_chip_counts  = 0; -- 18*312 bytes, first 6 of every 18 bytes are used, ends 0x02003550?

local credits_cutscene  = 0; -- 1 byte ???

local buster1           = 0; -- 1 byte ???
local buster2           = 0; -- 1 byte ???
local buster3           = 0; -- 1 byte ???
local max_HP_over_five  = 0; -- 1 byte, Maximum HP Check for HP Memory (Max HP/5)

local battle_enemy_ID   = 0x02000000; -- 2 bytes, per enemy up to 3 (changed to something less jittery)

local cursor_ID         = 0x0200845E; -- 2 bytes? chip ID of cursor
local cursor_code       = 0x0200845C; -- 2 bytes? chip Code of cursor
local folder_or_pack    = 0x02019A67; -- 1 byte, 26 == folder, 8 == pack

local your_X            = 0x0200AC50; -- 2 bytes freezing doesn't prevent movement???
local your_Y            = 0x0200AC52; -- 2 bytes freezing doesn't prevent movement???
local map_offset_x      = 0; -- 2 bytes % 256 to scroll screen
local map_offset_y      = 0; -- 2 bytes % 256 to scroll screen

local folder_cursor     = 0; -- 2 bytes?, cursor value in the folder
local folder_offset     = 0x02009A54; -- 2 bytes?, offset value in the folder
local pack_cursor       = 0; -- 2 bytes?, cursor value in the pack
local pack_offset       = 0x02009A5E; -- 2 bytes?, offset value in the pack
local folder_count      = 0; -- 1 byte, number of chips in folder being edited
local reg				= 0x020047FA; -- 1 byte, Reg Chip. 255 if no reg

local selected_offset_folder = 0; -- 2 bytes?, offset value of selected chip in folder
local selected_cursor_folder = 0; -- 2 bytes?, cursor value of selected chip in folder
local selected_offset_pack   = 0; -- 2 bytes?, offset value of selected chip in pack
local selected_cursor_pack   = 0; -- 2 bytes?, cursor value of selected chip in pack

local is_interacting    = 0; -- 1 byte ???
local interact_with     = 0; -- 1 byte ???
local interact_offset   = 0; -- 4 bytes ???
local GMD_value         = 0; -- 2 bytes, how to decode?
local number_code       = 0; -- 1 byte per 8 digits
local lazy_RNG          = 0x02001120; -- 4 bytes, controls encounter ID and chip draws
local bbs_jobs_new      = 0; -- 1 byte ???
local bbs_jobs_total    = 0; -- 1 byte ???
local game_state        = 0x02001B80; -- 1 byte
local main_RNG          = 0x020013F0; -- 4 bytes, controls everything else

local title_star_flags  = 0; -- 1 bit per star 0xFE

--local battle_         = 0; -- 2 bytes, something battle related
local battle_reward     = 0; -- 2 bytes, how to decode? (mask 0x40 means zenny)
--local battle_         = 0; -- 2 bytes, stats? S+?
local battle_field      = 0; -- 8*3 bytes, current battlefield

local pack_ID           = 0; -- 2 bytes, chip ID of pack
local pack_code         = 0; -- 2 bytes, chip code of pack

local battle_draw_slots = 0; -- 1 byte each, in battle chip draws, ends at 0x0203405D
local battle_HP_current = 0; -- 1 byte
local battle_HP_max     = 0; -- 1 byte

-- Addresses -> 08000000-09FFFFFF - Game Pak ROM/FlashROM (max 32MB)

local version           = 0; -- 1 byte

-- unverified
-- 020047D5 0x0032 50MB Reg Memory
-- 0200480A 0x03E8 1000 Max HP
-- 020348BC current battle offset

------------------------------------------------------------------------------------------------------------------------

local style_elements = {}; -- FWEG but Elec is first, 1 indexed
style_elements[0x00] = "None";
style_elements[0x01] = "Elec";
style_elements[0x02] = "Heat";
style_elements[0x03] = "Aqua";
style_elements[0x04] = "Wood";

local style_names = {};
style_names[0x00] = "Norm";
style_names[0x01] = "Guts";
style_names[0x02] = "Cust";
style_names[0x03] = "Team";
style_names[0x04] = "Shld";
style_names[0x05] = "Grnd";
style_names[0x06] = "Shdw";
style_names[0x07] = "Bug";

local game_state_names = {};
game_state_names[0x00] = "ow_init";
game_state_names[0x04] = "ow";
game_state_names[0x08] = "battle_init";
game_state_names[0x0C] = "battle";
game_state_names[0x10] = "map_change";
game_state_names[0x14] = "player_change";
game_state_names[0x18] = "menu";
game_state_names[0x1C] = "bbs";
game_state_names[0x20] = "shop";
game_state_names[0x24] = "chip_trader";
game_state_names[0x30] = "request_bbs";
game_state_names[0x34] = "mailbox";
game_state_names[0x38] = "chargeman_minigame";

-- Chip Draw Simulation
local drawIndex = {};

-- Functions -> Game State

--[[
Gregar BR5E US
Falzar BR6E US
Gregar BR5P EU
Falzar BR6P EU
Gregar BR5J JP
Falzar BR6J JP
--]]

function ram.get_version()
    if     memory.read_u8(version) == 0x00 then
        return "Gregar";
    elseif memory.read_u8(version) == 0x00 then
        return "Falzar";
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
    return ram.get_game_state() == 0x0C;
end

function ram.in_transition()
    return ram.get_game_state() == 0x10;
end

function ram.in_splash()
    return ram.get_game_state() == 0x14;
end

function ram.in_menu()
    return ram.get_game_state() == 0x18;
end

function ram.in_credits()
    return ram.get_game_state() == 0x30;
end

function ram.get_stars()
    return memory.read_u8(title_star_flags);
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
    return memory.read_u16_le(steps);
end

function ram.set_steps(new_steps)
    if new_steps < 0 then
        new_steps = 0
    end
    memory.write_u16_le(steps, new_steps);
end

function ram.add_steps(some_steps)
    ram.set_steps(ram.get_steps() + some_steps);
end

function ram.get_check()
    return memory.read_u16_le(check);
end

function ram.set_check(new_check)
    if new_check < 0 then
        new_check = 0
    end
    memory.write_u16_le(check, new_check);
end

function ram.add_check(some_check)
    ram.set_check(ram.get_check() + some_check);
end

function ram.get_sneak()
    return memory.read_u32_le(sneak);
end

function ram.reset_sneak(new_sneak)
    memory.write_u32_le(sneak, 6000);
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

function ram.get_bug_frags()
    return memory.read_u32_le(bug_frags);
end

function ram.set_bug_frags(new_bug_frags)
    if new_bug_frags < 0 then
        new_bug_frags = 0;
    elseif new_bug_frags > 9999 then
        new_bug_frags = 9999;
    end
    return memory.write_u32_le(bug_frags, new_bug_frags);
end

function ram.add_bug_frags(some_bug_frags)
    return ram.set_bug_frags(ram.get_bug_frags() + some_bug_frags);
end

function ram.get_reg_slot()
	return memory.readbyte(reg);
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
    return memory.read_u16_le(world_HP_max);
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
    return memory.read_u16_le(battle_enemy_ID + enemy_number - 1);
end

function ram.get_enemy_name(enemy_number)
    return ram.enemies.names[ram.get_enemy_ID(enemy_number)] or "Unknown ID";
end

function ram.get_draw_slot(which_slot) -- convert from 1 to 0 index, then back
    if 1 <= which_slot and which_slot <= 30 then
        return drawIndex[which_slot - 1] + 1;
    end
    return -1;
end

function ram.to_int(seed)
	return bit.band(seed, 0x7FFFFFFF)
end

function ram.get_draw_slots()
	return drawIndex;
end

function ram.simulate_draw()
	-- Need to simulate draw after BN3
    for i=0,29 do
		drawIndex[i] = i;
	end
	
	drawSeed = ram.rng.get_lazy_RNG_value();
	
	for i=0,135 do
		drawSeed = ram.rng.simulate_RNG(drawSeed);
	end
	
	regSlot = ram.get_reg_slot();
	
	if regSlot == 255 then
		for i=1,30 do
			drawSeed = ram.rng.simulate_RNG(drawSeed);
			slot1 = ram.to_int(drawSeed) % 30;
			drawSeed = ram.rng.simulate_RNG(drawSeed);
			slot2 = ram.to_int(drawSeed) % 30;

			drawIndex[slot1], drawIndex[slot2] = drawIndex[slot2], drawIndex[slot1];
		end
	else
		for i=1,29 do
			drawSeed = ram.rng.simulate_RNG(drawSeed);
			slot1 = ram.to_int(drawSeed) % 29;
			if slot1 >= regSlot then
				slot1 = slot1 + 1
			end
			
			drawSeed = ram.rng.simulate_RNG(drawSeed);
			slot2 = ram.to_int(drawSeed) % 29;
			if slot2 >= regSlot then
				slot2 = slot2 + 1
			end

			drawIndex[slot1], drawIndex[slot2] = drawIndex[slot2], drawIndex[slot1];
		end
		
		-- In BN6, place reg chip at top and move other chips down.
		-- In other games, swap the reg slot with the top chip.
		for i=regSlot,0,-1 do
			drawIndex[i] = drawIndex[i - 1];
		end
		
		drawIndex[0] = regSlot;
	end
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

