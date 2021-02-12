-- RAM addresses for MMBN 2 scripting, enjoy.

local addresses = require("All/Addresses");

---------------------------------------- WRAM 02000000-0203FFFF ----------------------------------------

addresses.GMD_reward            = 0x02000000; -- TODO: 2? bytes, how to decode?

addresses.flags                 = 0x02000000; -- N bytes, to 5F at most
addresses.star_byte_yellow      = 0x02000000; -- Somewhere in the first row
addresses.star_byte_green       = 0x02000010; -- Somewhere in the second row
addresses.library               = 0x02000060; -- ? bytes, bit flags, ends on 80?

-- 91-9F PAs in here somewhere...

addresses.MD_flags              = 0x020000A0; -- ? bytes, bit flags

-- 100-10F don't write to these bytes!
-- 10A Pause state?
-- 10B Don't write to this byte...

addresses.folder[1].ID          = 0x02000AB0; -- every other 2 bytes, chip  IDs  of folder 1, ends at B24
addresses.folder[1].code        = 0x02000AB2; -- every other 2 bytes, chip codes of folder 1, ends at B26
addresses.folder[2].ID          = 0x02000B28; -- every other 2 bytes, chip  IDs  of folder 2, ends at B9C
addresses.folder[2].code        = 0x02000B2A; -- every other 2 bytes, chip codes of folder 2, ends at B9E
addresses.folder[3].ID          = 0x02000BA0; -- every other 2 bytes, chip  IDs  of folder 3, ends at C14
addresses.folder[3].code        = 0x02000BA2; -- every other 2 bytes, chip codes of folder 3, ends at C16

-- C1B MDs in current area

-- DC0 start of important things?

addresses.game_mode             = 0x02000DC0; -- 1 byte, maybe?
--addresses.                    = 0x02000DC1; -- 1 byte TBD
--addresses.                    = 0x02000DC2; -- 1 byte TBD
--addresses.                    = 0x02000DC3; -- 1 byte TBD
addresses.main_area             = 0x02000DC4; -- 1 byte
addresses.sub_area              = 0x02000DC5; -- 1 byte
addresses.progress              = 0x02000DC6; -- 1 byte
addresses.music_progress        = 0x02000DC7; -- 1 byte
--addresses.                    = 0x02000DC8; -- 1 byte TBD
addresses.battle_paused         = 0x02000DC9; -- 1 byte, flag 0x01
--addresses.                    = 0x02000DCA; -- 1 byte TBD
--addresses.                    = 0x02000DCB; -- 1 byte TBD
addresses.main_area_previous    = 0x02000DCC; -- 1 byte
addresses.sub_area_previous     = 0x02000DCD; -- 1 byte

addresses.mega_HP_current       = 0x02000DE0; -- 2 bytes
addresses.mega_HP_max           = 0x02000DE2; -- 2 bytes

addresses.is_talking            = 0x02000DDA; -- 1 byte, with NPC/MD, flag 0x01
addresses.is_interacting        = 0x02000DDA; -- 1 byte, toggle check, flag 0x01
addresses.battle_buster_attack  = 0x02000DD4; -- 1 byte, in battle, 0x04 is max
addresses.battle_buster_rapid   = 0x02000DD5; -- 1 byte, in battle, 0x04 is max
addresses.battle_buster_charge  = 0x02000DD6; -- 1 byte, in battle, 0x04 is max

addresses.zenny                 = 0x02000E34; -- 4 bytes, 999999 "max"

-- E3B end of important things?

addresses.bug_frags             = 0x02000EC5; -- 1 byte, 32 "max"
addresses.HPMemory              = 0x02000EE0; -- 1 byte, HPMems collected
addresses.PowerUP               = 0x02000EE1; -- 1 byte, PowerUPs available

-- E80 - F1F

addresses.style_active          = 0x02000000; -- 1 byte
addresses.style_stored_1        = 0x02000000; -- 1 byte
addresses.style_stored_2        = 0x02000000; -- 1 byte

addresses.buster_attack         = 0x02001128; -- 1 byte, 0x04 is max
addresses.buster_rapid          = 0x02001129; -- 1 byte, 0x04 is max
addresses.buster_charge         = 0x0200112A; -- 1 byte, 0x04 is max
addresses.element_next          = 0x0200112B; -- 1 byte, element of next style?
addresses.steps                 = 0x02001150; -- 4 bytes
addresses.steps_total           = 0x0200113C; -- 4 bytes? steps since new game?
addresses.true_HP_current       = 0x02001130; -- 2 bytes
addresses.true_HP_max           = 0x02001132; -- 2 bytes
addresses.play_time_frames      = 0x02001144; -- 4 bytes, check for skipped frames
addresses.check                 = 0x02001154; -- 4 bytes, steps at the last encounter check
addresses.sneak                 = 0x02001178; -- 4? bytes, starts at 6000

-- 24C0 Shop inventories

-- 3080 BMDs? 32XX? 33XX? Animation?

-- 3A50 style point area
addresses.points_guts           = 0x02003A5D; -- 2 bytes
addresses.points_cust           = 0x02003A62; -- 2 bytes
addresses.points_team           = 0x02003A64; -- 2 bytes
addresses.points_shld           = 0x02003A66; -- 2 bytes
-- ties go in order of: shield, custom, team, guts? (according to faq)
addresses.battles_guts          = 0x02003A68; -- 4 bytes
addresses.battles_cust          = 0x02003A6C; -- 4 bytes
addresses.battles_team          = 0x02003A70; -- 4 bytes
addresses.battles_shld          = 0x02003A74; -- 4 bytes

addresses.chip_window_size_next = 0x02004EEE; -- 1 byte, number of chips available in the custom menu on next open

addresses.battle_mode           = 0x02000000; -- TODO
addresses.battle_state          = 0x02000000; -- TODO

addresses.battle_custom_gauge   = 0x02004F0C; -- 2 bytes, counts up to 0x4000

addresses.enemy[1].ID           = 0x02004F3C; -- 1 byte
addresses.enemy[2].ID           = 0x02004F3D; -- 1 byte
addresses.enemy[3].ID           = 0x02004F3F; -- 1 byte

addresses.battle_draw_slots     = 0x02005EC0; -- 1 byte each, in battle chip draws, ends at 492D

addresses.your_X                = 0x02006374; -- 2 bytes
addresses.your_Y                = 0x02006376; -- 2 bytes
addresses.your_X2               = 0x02000000; -- 2 bytes
addresses.your_Y2               = 0x02000000; -- 2 bytes

addresses.mega_battle_HP        = 0x02008A94; -- 2 bytes

--addresses.                    = 0x0200EEF0; -- 1 byte, battle data
--addresses.                    = 0x0200EEF0; -- 1 byte, battle data
--addresses.                    = 0x0200EEF1; -- 1 byte, custom menu state: 0x04 chip select 0x0C OK 0x10 ADD
--addresses.                    = 0x0200EEF4; -- 1 byte, battle data
addresses.custom_hover_slot     = 0x0200EEF5; -- 1 byte
addresses.chip_window_size      = 0x0200EEF9; -- 1 byte, number of chips available in the custom menu currently
addresses.custom_hover_slot     = 0x0200EF38; -- 1 byte each, select visual state: 0x00 normal 0x01 selected 0x02 black out
addresses.custom_folder_slot    = 0x0200EF42; -- 1 byte each, the selected folder slots (in order)
addresses.custom_select_slot    = 0x0200EF47; -- 1 byte each, the selected  chip  slots (in order)
addresses.custom_select_code    = 0x0200EF51; -- 1 byte each, the selected  chip  codes (in order)
addresses.custom_gauge_fill     = 0x0200EF91; -- 1 byte, counts up to 0x80
addresses.custom_gauge_visual   = 0x0200EF92; -- 1 byte, loops
addresses.battle_visual_state   = 0x0200EFA5; -- 1 byte, normal, BATTLE START!, PAUSE
addresses.mega_battle_HP_text   = 0x0200EFA6; -- 2 bytes
addresses.battle_timer          = 0x0200EFBA; -- 2 bytes, frame counter from load in to load out

addresses.enemy[1].HP_text      = 0x0200EFD2; -- 2 bytes, which_enemy * 0x08, for counting down HP over time
addresses.enemy[2].HP_text      = 0x0200EFDA; -- 2 bytes, which_enemy * 0x08, for counting down HP over time
addresses.enemy[3].HP_text      = 0x0200EFE2; -- 2 bytes, which_enemy * 0x08, for counting down HP over time

addresses.delete_timer          = 0x02004F1C; -- 2 bytes, frame counter for current battle

addresses.menu_mode             = 0x02007EA0; -- 1 byte
addresses.menu_state            = 0x02007EA1; -- 1 byte
addresses.cursor_ID             = 0x02007EA8; -- 1 byte, chip  ID  of cursor
addresses.cursor_code           = 0x02007EAA; -- 1 byte, chip code of cursor
addresses.folder_count          = 0x02007EA5; -- 1 byte, number of chips in folder
addresses.cursor_pack           = 0x02007EBC; -- 2 bytes, cursor value in the pack
addresses.cursor_pack_copy      = 0x02007EBE; -- 2 bytes
addresses.offset_pack           = 0x02007EC0; -- 2 bytes, offset value in the pack
addresses.offset_pack_copy      = 0x02007EC2; -- 2 bytes
addresses.offset_selected_pack  = 0x02007EF0; -- 2 bytes, offset value of selected chip
addresses.cursor_selected_pack  = 0x02007EF2; -- 2 bytes, cursor value of selected chip
addresses.offset_selected_folder = 0x02007EE8; -- 2 bytes, offset value of selected chip
addresses.cursor_selected_folder = 0x02007EEA; -- 2 bytes, cursor value of selected chip

addresses.cursor_folder         = 0x02007EB2; -- 2 bytes, cursor value in the folder
addresses.cursor_folder_copy    = 0x02007EB4; -- 2 bytes
addresses.offset_folder         = 0x02007EB6; -- 2 bytes, offset value in the folder
addresses.offset_folder_copy    = 0x02007EB8; -- 2 bytes
addresses.cursor_sort           = 0x0200EC06; -- 2 bytes, sort menu cursor position (both folder and pack)
addresses.cursor_sort_copy      = 0x0200EC08; -- 2 bytes

addresses.steps_menu            = 0x02008828; -- 4 bytes? steps since last menu?
addresses.power_on_frames       = 0x02008880; -- 2 bytes, session counter

addresses.enemy[1].HP           = 0x02008B54; -- 2 bytes, which_enemy * 0xC0
addresses.enemy[1].HP_max       = 0x02008B56; -- 2 bytes, for healing

addresses.enemy[2].HP           = 0x02008C14; -- 2 bytes, which_enemy * 0xC0
addresses.enemy[2].HP_max       = 0x02008C16; -- 2 bytes, for healing

addresses.enemy[3].HP           = 0x02008CD4; -- 2 bytes, which_enemy * 0xC0
addresses.enemy[3].HP_max       = 0x02008CD6; -- 2 bytes, for healing

--addresses.                    = 0x02009070; -- 4 bytes, state transition related?
addresses.game_state            = 0x02009078; -- 1 byte
addresses.main_RNG              = 0x02009080; -- 4 bytes, restarts on the title screen

addresses.color_palette         = 0x02009090; -- 1024 bytes, ends 948F

-- Each pack slot covers 32 bytes or 0x20 addresses
addresses.pack_ID               = 0x0201901C; -- 2 bytes each, 0x20 offset
addresses.pack_code             = 0x0201900A; -- 1 byte each, 0x20 offset
addresses.pack_quantity         = 0x02019016; -- 1 byte each, number of copies
-- Ends at 23FFF? 291FF? Many of these values appear to be duplicates, possibly to help with sorting

-- 0x0203FFFF end of WRAM?
-- 0x02047FFF end of WRAM?

---------------------------------------- Verion Dependent ----------------------------------------

-- A0 A1 A2 A3 A4 A5 A6 A7 A8 A9 AA AB AC AD AE AF - ROM Address
-- 52 4F 43 4B 4D 41 4E 5F 45 58 45 32 41 45 32 4A - ROCKMAN_EXE2AE2J - JP
-- 4D 45 47 41 4D 41 4E 5F 45 58 45 32 41 45 32 45 - MEGAMAN_EXE2AE2E - US
-- 4D 45 47 41 4D 41 4E 42 4E 32 00 00 41 4D 32 50 - MEGAMANBN2  AM2P - PAL

local region_byte = memory.read_u8(addresses.region_byte);

if     region_byte == 0x4A then -- J
    addresses.version_name      = "JP";
    addresses.encounter_odds    = 0x0800A0BC;
    addresses.encounter_curve   = 0x0800A144;
elseif region_byte == 0x45 then -- E
    addresses.version_name      = "US";
    addresses.encounter_odds    = 0x0800A1FC;
    addresses.encounter_curve   = 0x0800A284;
elseif region_byte == 0x50 then -- P
    addresses.version_name      = "PAL";
    addresses.encounter_odds    = 0x0800A1FC;
    addresses.encounter_curve   = 0x0800A284;
else
    print("\nRAM: Warning! Unrecognized game version! Unable to set certain addresses!");
end

return addresses;

