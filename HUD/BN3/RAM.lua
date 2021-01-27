-- RAM Addresses & Functions for MMBN 3 Scripting by Tterraj42, enjoy.

local max_RNG_index = 60 * 60 * 60; -- 10 minutes of frames

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

local ram = {};

ram.rng = require("BN3/RNG");
ram.chips = require("BN3/Chips");
ram.enemyNames = require("BN3/Enemies");

-- Addresses

local     area = 0x02001884; -- 1 byte
local sub_area = 0x02001885; -- 1 byte
local progress = 0x02001886; -- 1 byte
--local        = 0x02001887; -- 1 byte TBD
--local        = 0x02001888; -- 1 byte TBD
local paused   = 0x02001889; -- 1 byte, paused or custom menu in battle
local zenny    = 0x020018F4; -- 4 bytes
local frags    = 0x020018F8; -- 4 bytes
local version  = 0x080000AA; -- 1 byte, blue or white

local mega_x = 0x02008F54; -- 2 bytes
local mega_y = 0x02008F56; -- 2 bytes
local steps  = 0x02001DDC; -- 2 bytes
local check  = 0x02001DE0; -- 2 bytes, steps at the last encounter check
local sneak  = 0x02001DEC; -- 2 bytes, starts at 6000

local game_state = 0x020097F8; -- 1 byte
local game_state_names = {};
game_state_names[0x00] = "title";
game_state_names[0x04] = "world";
game_state_names[0x08] = "battle";
game_state_names[0x0C] = "player_change"; -- jack-in/out
game_state_names[0x14] = "splash";
game_state_names[0x18] = "menu";

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
    return memory.read_u8(gameState);
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

-- Functions -> Location

-- https://forums.therockmanexezone.com/list-of-mmbn3-areas-and-subareas-t5354.html

function ram.get_area()
    return memory.read_u8(area);
end

function ram.get_sub_area()
    return memory.read_u8(subArea);
end

function ram.is_mega()
    if ram.get_area() >= 0x80 then
        return true;
    end
    return false;
end

function ram.get_x()
    return memory.read_s16_le(mega_x);
end

function ram.get_y()
    return memory.read_s16_le(mega_y);
end

function ram.get_steps()
    return memory.read_u32_le(steps);
end

function ram.set_steps(new_steps)
    memory.write_u32_le(steps, new_steps);
end

function ram.get_check()
    return memory.read_u32_le(check);
end

function ram.set_check(new_check)
    memory.write_u32_le(check, new_check);
end

-- Functions -> Inventory

function ram.get_zenny()
	return memory.read_u32_le(zenny);
end

function ram.set_zenny(new_zenny)
	return memory.write_u32_le(zenny, new_zenny);
end

function ram.add_zenny(some_zenny)
	return memory.write_u32_le(zenny, ram.get_zenny() + some_zenny);
end

function ram.get_frags()
	return memory.read_u32_le(frags);
end

function ram.set_frags(new_frags)
	return memory.write_u32_le(frags, new_frags);
end

function ram.add_frags(some_frags)
	return memory.write_u32_le(frags, ram.get_frags() + some_frags);
end

-- Encounter Tracking and Avoidance

function ram.encounter_check(skip_encounters)
    if skip_encounters then
        if ram.get_steps() > 64 then
            ram.set_steps(ram.get_steps() % 64);
            ram.set_check(ram.get_check() % 64);
        end
    end
end

-- Controls

function ram.initialize()
    ram.rng.initialize(max_RNG_index);
end

function ram.update_pre()
    ram.rng.update_pre();
end

function ram.update_post()
    ram.rng.update_post();
end

return ram;

