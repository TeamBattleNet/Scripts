-- RAM addresses for MMBN 4 scripting, enjoy.

local addresses = require("All/Addresses");

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

---------------------------------------- WRAM 02000000-0203FFFF ----------------------------------------

-- 001100 - 0011FF

addresses.lazy_RNG            = 0x020015D4; -- 4 bytes, resets and pauses on the title screen

-- 001300 - 0013FF

addresses.main_RNG            = 0x02001790; -- 4 bytes, resets and pauses on the title screen

-- 001B00 - 001BFF

addresses.game_state          = 0x0200A7E0; -- 1 byte
addresses.main_area           = 0x02002134; -- 1 byte
addresses.sub_area            = 0x02002135; -- 1 byte
addresses.progress            = 0x02002136; -- 1 byte

-- 001C00 - 001CFF

addresses.steps               = 0x020021DA; -- 4 bytes
addresses.check               = 0x020021DC; -- 4 bytes, steps at the last encounter check

-- 004700 - 0047FF

addresses.reg_slot			  = 0x0200214C; -- 1 byte, Reg Chip. 255 if no reg

-- 008400 - 0084FF

addresses.cursor_code         = 0x0200845C; -- 1 byte, chip code of cursor
addresses.cursor_ID           = 0x0200845E; -- 1 byte, chip  ID  of cursor

-- 009A00 - 009AFF

addresses.offset_folder       = 0x02009A54; -- 2 bytes, offset value in the folder
addresses.offset_pack         = 0x02009A5E; -- 2 bytes, offset value in the pack

-- 00AC00 - 00ACFF

addresses.your_X              = 0x0200A384; -- 2 bytes
addresses.your_Y              = 0x0200A386; -- 2 bytes

---------------------------------------- ROM  08000000-09FFFFFF ----------------------------------------

-- 000000 - 0000FF

addresses.version_byte        = 0x080000AC

-- 020C00 - 020CFF
addresses.encounter_odds  	  = 0x08018960;
addresses.encounter_curve 	  = 0x080189E8;

---------------------------------------- Verion Dependent ----------------------------------------

local version_byte = memory.read_u32_le(addresses.version_byte);

if version_byte == 0x45423442 then
    addresses.version_name    = "Blue Moon US";
elseif version_byte == 0x4A423442 then
    addresses.version_name    = "Blue Moon JP";
elseif version_byte == 0x45573442 then
        addresses.version_name    = "Red Sun US";
elseif version_byte == 0x4A573442 then
    addresses.version_name    = "Red Sun JP";
else
    addresses.version_name    = "Unknown";
    print("RAM: Warning! Unrecognized game version! Unable to set certain addresses!");
end


return addresses;

