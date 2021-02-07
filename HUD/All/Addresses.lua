-- RAM addresses for MMBN scripting, enjoy.

local addresses = {}; -- These are only here to avoid passing nil to memory.write()

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

addresses.library               = 0x02000000;

addresses.folder                = {};
addresses.folder[1]             = {};
addresses.folder[1].ID          = 0x020001C0;
addresses.folder[1].code        = 0x020001C1;
addresses.folder[2]             = {};
addresses.folder[2].ID          = 0x020001C0;
addresses.folder[2].code        = 0x020001C1;
addresses.folder[3]             = {};
addresses.folder[3].ID          = 0x020001C0;
addresses.folder[3].code        = 0x020001C1;

addresses.main_area             = 0x02000214; -- 1 byte
addresses.sub_area              = 0x02000215; -- 1 byte
addresses.progress              = 0x02000216; -- 1 byte
addresses.music_progress        = 0x02000217; -- 1 byte

addresses.buster_attack         = 0x02000224; -- 1 byte, 0 indexed, can't change mid-battle
addresses.buster_rapid          = 0x02000225; -- 1 byte, 0 indexed, can't change mid-battle
addresses.buster_charge         = 0x02000226; -- 1 byte, 0 indexed, can't change mid-battle

addresses.zenny                 = 0x02000284; -- 4 bytes, 999999 "max"
addresses.bug_frags             = 0x02000284; -- 4 bytes, 999999 "max"

addresses.HPMemory              = 0x02000310; -- 1 byte, collected
addresses.PowerUP               = 0x02000311; -- 1 byte, available

addresses.steps_total           = 0x020003E0; -- 3 bytes, since new game
addresses.play_time_frames      = 0x020003E8; -- 4 bytes, check for skipped frames
addresses.battle_timer          = 0x020003EC; -- 4? bytes, frame counter from load in to load out

addresses.steps                 = 0x020003F4; -- 4 bytes
addresses.check                 = 0x020003F8; -- 4 bytes, steps at the last encounter check

addresses.battle_state          = 0x02003712; -- 1 byte 0x04 chip_menu/dead 0x08 transition 0x0C normal 0x10 PAUSE 
addresses.chip_window_size      = 0x02003720; -- 1 byte, number of chips in the custom menu
addresses.delete_timer          = 0x02003730; -- 2 bytes, frame counter for current battle
addresses.battle_pointer        = 0x02003784; -- 2 bytes? ROM offset?
addresses.battle_custom_gauge   = 0x0200374E; -- 2 bytes, counts up to 0x4000

addresses.enemy                 = {};
addresses.enemy[1]              = {};
addresses.enemy[1].ID           = 0x02003774; -- 1 byte
addresses.enemy[1].HP           = 0x02006790; -- 2 bytes, which_enemy * 0xC0
addresses.enemy[1].HP_text      = 0x02004D30; -- 2 bytes, for counting down HP over time
addresses.enemy[2]              = {};
addresses.enemy[2].ID           = 0x02003775; -- 1 byte
addresses.enemy[2].HP           = 0x02006850; -- 2 bytes, which_enemy * 0xC0
addresses.enemy[2].HP_text      = 0x020050A0; -- 2 bytes, for counting down HP over time
addresses.enemy[3]              = {};
addresses.enemy[3].HP           = 0x02006910; -- 2 bytes, which_enemy * 0xC0
addresses.enemy[3].ID           = 0x02003776; -- 1 byte
addresses.enemy[3].HP_text      = 0x02005200; -- 2 bytes, for counting down HP over time




addresses.battle_draw_slots     = 0x02004910; -- 1 byte each, in battle chip draws, ends at 492D

addresses.your_X                = 0x02004954; -- 2 bytes
addresses.your_Y                = 0x02004956; -- 2 bytes
addresses.your_X2               = 0x02004958; -- 2 bytes
addresses.your_Y2               = 0x0200495A; -- 2 bytes

addresses.menu_mode             = 0x020062E0; -- 1 byte
addresses.menu_state            = 0x020062E1; -- 1 byte

addresses.cursor_ID             = 0x020062E4; -- 1 byte, chip  ID  of cursor
addresses.cursor_code           = 0x020062E5; -- 1 byte, chip code of cursor

addresses.cursor_folder         = 0x020062F2; -- 2 bytes, cursor value in the folder
addresses.offset_folder         = 0x020062F6; -- 2 bytes, offset value in the folder

addresses.cursor_pack           = 0x020062FC; -- 2 bytes, cursor value in the pack
addresses.offset_pack           = 0x02006300; -- 2 bytes, offset value in the pack

addresses.offset_selected       = 0x02006308; -- 2 bytes, offset value of selected chip
addresses.cursor_selected       = 0x0200630A; -- 2 bytes, cursor value of selected chip

addresses.power_on_frames       = 0x020064A0; -- 2 bytes, session counter

addresses.chip_cooldown         = 0x02006719; -- 1 byte, BstrBomb HYPE

addresses.game_state            = 0x02006CB8; -- 1 byte
addresses.RNG                   = 0x02006CC0; -- 4 bytes, resets and pauses on the title screen

addresses.pack_ID               = 0x02019018; -- 1 byte each, 0x20 offset
addresses.pack_code             = 0x0201900A; -- 1 byte each, 0x20 offset
addresses.pack_quantity         = 0x02019016; -- 1 byte each, number of copies

---------------------------------------- ROM  08000000-09FFFFFF ----------------------------------------

addresses.version_name          = "Unknown";
addresses.version_byte          = 0x080000AF;
addresses.encounter_odds        = 0x08000000;
addresses.encounter_curve       = 0x08000000;

return addresses;

