-- RAM addresses for MMBN 4 scripting, enjoy.

local addresses = {};

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

-- Potential addresses to look for

addresses.title_star_byte     = 0; -- 0x04 1 bit for 1 star :)
addresses.flags_0000          = 0; -- 00000 star 00
addresses.flags_0001          = 0; -- 000 try_access_internet_2 0000 | internet_2_access?
addresses.flags_0002          = 0; -- 00000000
addresses.flags_0003          = 0; -- 00000000
addresses.flags_0004          = 0; -- 00000000
addresses.library             = 0; -- bit flags (with gaps) ends at 0x38
addresses.emails_gave_flags   = 0; -- maybe? ends at 47
addresses.emails_read_flags   = 0; -- maybe? ends at 4F
addresses.BMD_flags           = 0; -- ends at 6F? 0x80 is shelf PET
addresses.folder_ID           = 0; -- every other byte, chip  ID  of folder slot 1, ends at 0x020001FA
addresses.folder_code         = 0; -- every other byte, chip code of folder slot 1, ends at 0x020001FB
addresses.music_progress      = 0; -- 1 byte
addresses.battle_paused       = 0; -- 1 byte, flag 0x01
addresses.buster_attack       = 0; -- 1 byte, 0 indexed, can't change mid-battle
addresses.buster_rapid        = 0; -- 1 byte, 0 indexed, can't change mid-battle
addresses.buster_charge       = 0; -- 1 byte, 0 indexed, can't change mid-battle
addresses.HP_max_1            = 0; -- 2 bytes, max is 0x03E8
addresses.HP_max_2            = 0; -- 2 bytes, max is 0x03E8
addresses.HPMemory            = 0; -- 1 byte, collected
addresses.steps_total         = 0; -- 3 bytes, since new game
addresses.play_time_frames    = 0; -- 4 bytes, check for skipped frames
addresses.battle_timer_total  = 0; -- 4 bytes, from load in to load out
addresses.battle_turns        = 0; -- 1 byte, number of custom gauge opens + 1
addresses.chip_window_count   = 0; -- 1 byte, number of chips in the custom menu
addresses.battle_paused_also  = 0; -- 1 byte, flag 0x08 (no effect on write)
addresses.battle_timer        = 0; -- 2 bytes, frame counter for current battle
addresses.battle_pointer      = 0; -- 2 bytes? ROM offset?
addresses.battle_custom_gauge = 0; -- 2 bytes, counts up to 0x4000
addresses.folder_to_pack      = 0; -- 1 byte, menu transition and tracker
addresses.folder_to_pack_copy = 0; -- 1 byte, copy
addresses.cursor_animation    = 0; -- 1 byte
addresses.folder_count        = 0; -- 1 byte, number of chips in folder
addresses.chip_selected       = 0; -- 1 byte, flag: 0x01 folder 0x02 pack
addresses.cursor_folder       = 0; -- 2 bytes, cursor value in the folder
addresses.cursor_folder_copy  = 0; -- 2 bytes, copy
addresses.offset_folder_copy  = 0; -- 2 bytes, copy
addresses.folder_bottom_index = 0; -- 2 bytes, to limit cursor
addresses.cursor_pack         = 0; -- 2 bytes, cursor value in the pack
addresses.cursor_pack_copy    = 0; -- 2 bytes, copy
addresses.offset_pack_copy    = 0; -- 2 bytes, copy
addresses.pack_bottom_index   = 0; -- 2 bytes, to limit cursor
addresses.chip_selected_flag  = 0; -- 1 byte, flag: 0x12 folder 0x1C pack
addresses.offset_selected     = 0; -- 2 bytes, offset value of selected chip
addresses.cursor_selected     = 0; -- 2 bytes, cursor value of selected chip
addresses.GMD_reward          = 0; -- 2 bytes, how to decode?
addresses.power_on_frames     = 0; -- 2 bytes, session counter
addresses.button_flags        = 0; -- many bytes, many flags
addresses.chip_cooldown       = 0; -- 1 byte, BstrBomb HYPE
addresses.pack_ID             = 0; -- 1 byte, chip  ID  of pack slot 1
addresses.pack_code           = 0; -- 1 byte, chip code of pack slot 1
addresses.version_byte        = 0; -- 1 byte

-- 001100 - 0011FF

addresses.lazy_RNG            = 0x020015D4; -- 4 bytes, resets and pauses on the title screen

-- 001300 - 0013FF

addresses.main_RNG            = 0x02001790; -- 4 bytes, resets and pauses on the title screen

-- 001B00 - 001BFF

addresses.game_state          = 0x0200A7E0; -- 1 byte
addresses.main_area           = 0x02002134; -- 1 byte
addresses.sub_area            = 0x02002135; -- 1 byte
addresses.progress            = 0x02002136; -- 1 byte

addresses.zenny               = 0; -- 4 bytes, 999999 "max"
addresses.bugfrags			  = 0; -- 4 bytes, 9999 "max"
addresses.bugfrags_copy_1	  = 0; -- 4 bytes, copy 1?
addresses.bugfrags_copy_2	  = 0; -- 4 bytes, copy 2?

-- 001C00 - 001CFF

addresses.steps               = 0x020021DA; -- 4 bytes
addresses.check               = 0x020021DC; -- 4 bytes, steps at the last encounter check
addresses.sneak               = 0; -- 4 bytes, starts at 6000

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

-- 019A00 - 019AFF

addresses.folder_menu_state   = 0; -- 1 byte, 0x04 normal 0x14 sorting 0x10 go right 0x0C go left 0x08 left

-- 034800 - 0348FF

addresses.enemy_ID            = 0; -- 2 bytes
addresses.enemy_ID_2          = 0; -- 2 bytes
addresses.enemy_ID_3          = 0; -- 2 bytes

-- 03CA00 - 03CAFF

addresses.battle_state        = 0;

-- 03AA00 - 03AAFF

addresses.enemy_HP            = 0; -- 2 bytes, which_enemy * 0xC0

-- 03AB00 - 03ABFF

addresses.enemy_HP_2          = 0; -- 2 bytes, which_enemy * 0xC0

-- 03AC00 - 03ACFF

addresses.enemy_HP_3          = 0; -- 2 bytes, which_enemy * 0xC0

---------------------------------------- ROM  08000000-09FFFFFF ----------------------------------------

-- 020C00 - 020CFF
addresses.encounter_odds  	  = 0;
addresses.encounter_curve 	  = 0;

---------------------------------------- Verion Dependent ----------------------------------------

local version_byte = memory.read_u8(addresses.version_byte);

if     version_byte == 0x45 then
    addresses.version_name    = "English";
    --addresses.encounter_odds  = 0x08009934;
    --addresses.encounter_curve = 0x080099BC;
elseif version_byte == 0x4A then
    addresses.version_name    = "Japanese";
	--addresses.encounter_odds  = 0x08009900;
    --addresses.encounter_curve = 0x08009988;
elseif version_byte == 0x50 then
    addresses.version_name    = "PAL";
    --addresses.encounter_odds  = 0x08009940;
    --addresses.encounter_curve = 0x080099C8;
else
    addresses.version_name    = "Unknown";
    --addresses.encounter_odds  = 0x08000000;
    --addresses.encounter_curve = 0x08000000;
    print("RAM: Warning! Unrecognized game version! Unable to set certain addresses!");
end


return addresses;

