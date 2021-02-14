-- RAM addresses for MMBN scripting, enjoy.

local addresses = {}; -- mostly to prevent passing nil to memory.write()

---------------------------------------- WRAM 02000000-0203FFFF ----------------------------------------

addresses.enemy                 = {};
addresses.enemy[1]              = {};
addresses.enemy[1].ID           = 0x02000000;
addresses.enemy[1].HP           = 0x02000000;
addresses.enemy[1].HP_text      = 0x02000000;
addresses.enemy[2]              = {};
addresses.enemy[2].ID           = 0x02000000;
addresses.enemy[2].HP           = 0x02000000;
addresses.enemy[2].HP_text      = 0x02000000;
addresses.enemy[3]              = {};
addresses.enemy[3].HP           = 0x02000000;
addresses.enemy[3].ID           = 0x02000000;
addresses.enemy[3].HP_text      = 0x02000000;

addresses.folder                = {};
addresses.folder[1]             = {};
addresses.folder[1].ID          = 0x02000000;
addresses.folder[1].code        = 0x02000000;
addresses.folder[2]             = {};
addresses.folder[2].ID          = 0x02000000;
addresses.folder[2].code        = 0x02000000;
addresses.folder[3]             = {};
addresses.folder[3].ID          = 0x02000000;
addresses.folder[3].code        = 0x02000000;

addresses.battle_custom_gauge   = 0x02000000;
addresses.battle_draw_slots     = 0x02000000;
addresses.battle_mode           = 0x02000000;
addresses.battle_pointer        = 0x02000000;
addresses.battle_state          = 0x02000000;
addresses.battle_timer          = 0x02000000;

addresses.bug_frags             = 0x02000000;
addresses.buster_attack         = 0x02000000;
addresses.buster_charge         = 0x02000000;
addresses.buster_rapid          = 0x02000000;
addresses.button_flags          = 0x02000000;
addresses.check                 = 0x02000000;
addresses.chip_window_size      = 0x02000000;
addresses.chip_cooldown         = 0x02000000;
addresses.color_palette         = 0x02000000; -- 512 / 1024 bytes
addresses.cursor_code           = 0x02000000;
addresses.cursor_folder         = 0x02000000;
addresses.cursor_ID             = 0x02000000;
addresses.cursor_pack           = 0x02000000;
addresses.cursor_selected       = 0x02000000;
addresses.delete_timer          = 0x02000000;
addresses.game_state            = 0x02000000;
addresses.HPMemory              = 0x02000000;
addresses.library               = 0x02000000;
addresses.magic_byte            = 0x02000000;
addresses.main_area             = 0x02000000;
addresses.menu_mode             = 0x02000000;
addresses.menu_state            = 0x02000000;
addresses.music_progress        = 0x02000000;
addresses.offset_folder         = 0x02000000;
addresses.offset_pack           = 0x02000000;
addresses.offset_selected       = 0x02000000;
addresses.pack_ID               = 0x02000000;
addresses.pack_code             = 0x02000000;
addresses.pack_quantity         = 0x02000000;
addresses.play_time_frames      = 0x02000000;
addresses.PowerUP               = 0x02000000;
addresses.power_on_frames       = 0x02000000;
addresses.progress              = 0x02000000;
addresses.RNG                   = 0x02000000;
addresses.sneak                 = 0x02000000;
addresses.steps                 = 0x02000000;
addresses.steps_total           = 0x02000000;
addresses.sub_area              = 0x02000000;
addresses.your_X                = 0x02000000;
addresses.your_Y                = 0x02000000;
addresses.your_X2               = 0x02000000;
addresses.your_Y2               = 0x02000000;
addresses.zenny                 = 0x02000000;

---------------------------------------- ROM  08000000-09FFFFFF ----------------------------------------

addresses.version_name          = "Unknown";
addresses.version_byte          = 0x080000AC;
addresses.region_byte           = 0x080000AF;
addresses.encounter_odds        = 0x08000000;
addresses.encounter_curve       = 0x08000000;

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

return addresses;

