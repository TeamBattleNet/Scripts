-- RAM addresses for MMBN 2 scripting, enjoy.

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

addresses.flags               = 0x02000000; -- N bytes, to 5F at most
addresses.star_byte_yellow    = 0x02000000; -- Somewhere in the first row
addresses.star_byte_green     = 0x02000000; -- Somewhere in the second row
addresses.library             = 0x02000060; -- ? bytes, bit flags, ends on 80?

-- 91-9F PAs in here somewhere...

-- A0+ don't write to these bytes!
-- 100-10F don't write to these bytes!
-- 10A Pause state?
-- 10B Don't write to this byte...

addresses.folder_1_ID         = 0x02000AB0; -- every other 2 bytes, chip  IDs  of folder 1, ends at B24
addresses.folder_1_code       = 0x02000AB2; -- every other 2 bytes, chip codes of folder 1, ends at B26

-- DC0 start of important things?

addresses.game_state_also     = 0x02000DC0; -- 1 byte?
addresses.main_area           = 0x02000DC4; -- 1 byte
addresses.sub_area            = 0x02000DC5; -- 1 byte
addresses.battle_paused       = 0x02000DC9; -- 1 byte, flag 0x01
addresses.progress            = 0x02000DCA; -- 1 byte
addresses.music_progress      = 0x02000DCB; -- 1 byte
addresses.is_talking          = 0x02000DDA; -- 1 byte, with NPC/MD, flag 0x01
addresses.is_interacting      = 0x02000DDA; -- 1 byte, toggle check, flag 0x01

addresses.zenny               = 0x02000E34; -- 4 bytes, 999999 "max"

-- E3B end of important things?

addresses.style_active        = 0x02000000; -- 1 byte
addresses.style_stored_1      = 0x02000000; -- 1 byte
addresses.style_stored_2      = 0x02000000; -- 1 byte

addresses.element_next        = 0x0200112B; -- 1 byte, element of next style?
addresses.steps               = 0x02001150; -- 4 bytes
addresses.steps_total         = 0x0200113C; -- 4 bytes? steps since new game?
addresses.play_time_frames    = 0x02001144; -- 4 bytes, check for skipped frames
addresses.check               = 0x02001154; -- 4 bytes, steps at the last encounter check
addresses.sneak               = 0x02001178; -- 4? bytes, starts at 6000

addresses.custom_gauge_battle = 0x02004F0C; -- 2 bytes, counts up to 0x4000

addresses.points_guts         = 0x02003A5D; -- 2 bytes
addresses.points_cust         = 0x02003A62; -- 2 bytes
addresses.points_team         = 0x02003A64; -- 2 bytes
addresses.points_shld         = 0x02003A66; -- 2 bytes
-- ties go in order of: shield, custom, team, guts? (according to faq)
addresses.battles_guts        = 0x02003A68; -- 4 bytes
addresses.battles_cust        = 0x02003A6C; -- 4 bytes
addresses.battles_team        = 0x02003A70; -- 4 bytes
addresses.battles_shld        = 0x02003A74; -- 4 bytes

addresses.enemy_ID            = 0x02004F3C; -- 1 byte
addresses.enemy_ID_2          = 0x02004F3D; -- 1 byte
addresses.enemy_ID_3          = 0x02004F3F; -- 1 byte

addresses.battle_draw_slots   = 0x02005EC0; -- 1 byte each, in battle chip draws, ends at 492D

addresses.chip_cooldown       = 0x0200626B; -- 1 byte ???

addresses.your_X              = 0x02006374; -- 2 bytes
addresses.your_Y              = 0x02006376; -- 2 bytes
addresses.your_X2             = 0x02000000; -- 2 bytes
addresses.your_Y2             = 0x02000000; -- 2 bytes

--addresses.                  = 0x0200EEF0; -- 1 byte, battle data
--addresses.                  = 0x0200EEF0; -- 1 byte, battle data
--addresses.                  = 0x0200EEF1; -- 1 byte, custom menu state: 0x04 chip select 0x0C OK 0x10 ADD
--addresses.                  = 0x0200EEF4; -- 1 byte, battle data
addresses.custom_hover_slot   = 0x0200EEF5; -- 1 byte
addresses.custom_hover_slot   = 0x0200EF38; -- 1 byte each, select visual state: 0x00 normal 0x01 selected 0x02 black out
addresses.custom_folder_slot  = 0x0200EF42; -- 1 byte each, the selected folder slots (in order)
addresses.custom_select_slot  = 0x0200EF47; -- 1 byte each, the selected  chip  slots (in order)
addresses.custom_select_code  = 0x0200EF51; -- 1 byte each, the selected  chip  codes (in order)
addresses.custom_gauge_fill   = 0x0200EF91; -- 1 byte, counts up to 0x80
addresses.custom_gauge_visual = 0x0200EF91; -- 1 byte, loops
addresses.battle_visual_state = 0x0200EFA5; -- 1 byte, normal, BATTLE START!, PAUSE
addresses.battle_timer        = 0x0200EFBA; -- 2 bytes, frame counter for current battle (doesn't pause?)

addresses.enemy_HP_text       = 0x0200EFD2; -- 2 bytes, which_enemy * 0x08, for counting down HP over time
addresses.enemy_HP_text_2     = 0x0200EFDA; -- 2 bytes, which_enemy * 0x08, for counting down HP over time
addresses.enemy_HP_text_3     = 0x0200EFE2; -- 2 bytes, which_enemy * 0x08, for counting down HP over time

addresses.menu_state          = 0x02007EA1; -- 1 byte
addresses.cursor_ID           = 0x02007EA8; -- 1 byte, chip  ID  of cursor
addresses.cursor_code         = 0x02007EAA; -- 1 byte, chip code of cursor
addresses.folder_count        = 0x02007EA5; -- 1 byte, number of chips in folder
addresses.cursor_pack         = 0x02007EBC; -- 2 bytes, cursor value in the pack
addresses.cursor_pack_copy    = 0x02007EBE; -- 2 bytes
addresses.offset_pack         = 0x02007EC0; -- 2 bytes, offset value in the pack
addresses.offset_pack_copy    = 0x02007EC2; -- 2 bytes
addresses.offset_selected_pack   = 0x02007EF0; -- 2 bytes, offset value of selected chip
addresses.cursor_selected_pack   = 0x02007EF2; -- 2 bytes, cursor value of selected chip
addresses.offset_selected_folder = 0x02007EE8; -- 2 bytes, offset value of selected chip
addresses.cursor_selected_folder = 0x02007EEA; -- 2 bytes, cursor value of selected chip

addresses.cursor_folder       = 0x02007EB2; -- 2 bytes, cursor value in the folder
addresses.cursor_folder_copy  = 0x02007EB4; -- 2 bytes
addresses.offset_folder       = 0x02007EB6; -- 2 bytes, offset value in the folder
addresses.offset_folder_copy  = 0x02007EB8; -- 2 bytes
addresses.cursor_sort         = 0x0200EC06; -- 2 bytes, sort menu cursor position (both folder and pack)
addresses.cursor_sort_copy    = 0x0200EC08; -- 2 bytes

addresses.steps_menu          = 0x02008828; -- 4 bytes? steps since last menu?
addresses.power_on_frames     = 0x02008880; -- 2 bytes, session counter

addresses.enemy_HP            = 0x02008B54; -- 2 bytes, which_enemy * 0xC0
addresses.enemy_HP_max        = 0x02008B56; -- 2 bytes, for healing

addresses.enemy_HP_2          = 0x02008C14; -- 2 bytes, which_enemy * 0xC0
addresses.enemy_HP_max_2      = 0x02008C16; -- 2 bytes, for healing

addresses.enemy_HP_3          = 0x02008CD4; -- 2 bytes, which_enemy * 0xC0
addresses.enemy_HP_max_3      = 0x02008CD6; -- 2 bytes, for healing

--addresses.                  = 0x02009070; -- 4 bytes, state transition related?
addresses.game_state          = 0x02009078; -- 1 byte
addresses.RNG                 = 0x02009080; -- 4 bytes, restarts on the title screen

-- Each pack slot covers 32 bytes or 0x20 addresses
addresses.pack_ID             = 0x0201901C; -- 2 bytes each, 0x20 offset
addresses.pack_code           = 0x0201900A; -- 1 byte each, 0x20 offset
addresses.pack_quantity       = 0x02019016; -- 1 byte each, number of copies
-- Ends at 23FFF? 291FF? Many of these values appear to be duplicates, possibly to help with sorting

-- TODO: V

addresses.BMD                 = 0x02000000; -- bit flags
addresses.bug_frags           = 0x02000000; -- 1 byte, caps at 32?
addresses.GMD_reward          = 0x02000000; -- 2 bytes, how to decode?
addresses.button_flags        = 0x02000000; -- many bytes, many flags

addresses.HPMemory            = 0x02000000; -- 1 byte, collected
addresses.PowerUP             = 0x02000000; -- 1 byte, available
addresses.buster_attack       = 0x02000000; -- 1 byte, 0 indexed, can't change mid-battle
addresses.buster_rapid        = 0x02000000; -- 1 byte, 0 indexed, can't change mid-battle
addresses.buster_charge       = 0x02000000; -- 1 byte, 0 indexed, can't change mid-battle

addresses.battle_pointer      = 0x02000000; -- 2 bytes? ROM offset?
addresses.battle_state        = 0x02000000; -- 1 byte

-- 0x0203FFFF end of WRAM?
-- 0x02047FFF end of WRAM?

---------------------------------------- ROM  08000000-09FFFFFF ----------------------------------------

addresses.version_byte        = 0x080000AF;

---------------------------------------- Verion Dependent ----------------------------------------

local version_byte = memory.read_u8(addresses.version_byte);

if     version_byte == 0x45 then -- E
    addresses.version_name    = "English";
    addresses.encounter_odds  = 0x08000000;
    addresses.encounter_curve = 0x08000000;
elseif version_byte == 0x4A then -- J
    addresses.version_name    = "Japanese";
    addresses.encounter_odds  = 0x08000000;
    addresses.encounter_curve = 0x08000000;
elseif version_byte == 0x50 then -- P
    addresses.version_name    = "PAL";
    addresses.encounter_odds  = 0x08000000;
    addresses.encounter_curve = 0x08000000;
else
    addresses.version_name    = "Unknown";
    addresses.encounter_odds  = 0x08000000;
    addresses.encounter_curve = 0x08000000;
    print("\nRAM: Warning! Unrecognized game version! Unable to set certain addresses!");
end

return addresses;

