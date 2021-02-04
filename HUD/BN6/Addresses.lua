-- RAM addresses for MMBN 1 scripting, enjoy.

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

addresses.title_star_byte     = 0; -- 0x04 1 bit for 1 star :)
addresses.flags_0000          = 0; -- 00000 star 00
addresses.flags_0001          = 0; -- 000 try_access_internet_2 0000 | internet_2_access?
addresses.flags_0002          = 0; -- 00000000
addresses.flags_0003          = 0; -- 00000000
addresses.flags_0004          = 0; -- 00000000

-- 004-00F ??? WWW Pin Doors

addresses.metro_ticket        = 0; -- TBD

addresses.fire_flags_oven     = 0; -- 30 bit flags, shared use
addresses.fire_flags_www      = 0; -- 23 bit flags, shared use
addresses.elevator_flag       = 0; -- 1-------b
addresses.magic_byte          = 0; -- ---10---b (progress must be == 0x54)

addresses.library             = 0; -- bit flags (with gaps) ends at 0x38
addresses.library_bass        = 0; -- 00000001b

--  39-3F  Reserved for library (included in count)

addresses.emails_gave_flags   = 0; -- maybe? ends at 47
addresses.emails_read_flags   = 0; -- maybe? ends at 4F

addresses.BMD_flags           = 0; -- ends at 6F? 0x80 is shelf PET

addresses.fire_flags          = 0; -- 4 bytes, 32 fire bit flags

--  70-8B  ??? flags

--  8C-8F  ??? all 1's

-- 110-120 ??? all 1's

-- 120-170 ??? no idea

-- 170-1BF ??? all 1's

addresses.folder_ID           = 0; -- every other byte, chip  ID  of folder slot 1, ends at 0x020001FA
addresses.folder_code         = 0; -- every other byte, chip code of folder slot 1, ends at 0x020001FB

-- 1FC-203 ??? 1FF changes a lot

-- 204-213 ??? mostly 1's

addresses.main_area           = 0x02001B84; -- 1 byte
addresses.sub_area            = 0x02001B85; -- 1 byte
addresses.progress            = 0x02001B86; -- 1 byte
addresses.music_progress      = 0; -- 1 byte
--addresses.                  = 0x02000218; -- ? byte
addresses.battle_paused       = 0; -- 1 byte, flag 0x01
--addresses.                  = 0x0200021A; -- ? byte
--addresses.                  = 0x0200021B; -- ? byte
--addresses.                  = 0x0200021C; -- ? byte
--addresses.                  = 0x0200021D; -- ? byte
--addresses.                  = 0x0200021E; -- ? byte
--addresses.                  = 0x0200021F; -- ? byte
--addresses.                  = 0x02000220; -- ? byte
--addresses.                  = 0x02000221; -- ? byte
--addresses.                  = 0x02000222; -- ? byte
--addresses.                  = 0x02000223; -- ? byte
addresses.buster_attack       = 0; -- 1 byte, 0 indexed, can't change mid-battle
addresses.buster_rapid        = 0; -- 1 byte, 0 indexed, can't change mid-battle
addresses.buster_charge       = 0; -- 1 byte, 0 indexed, can't change mid-battle
--addresses.                  = 0x02000228; -- ? byte
--addresses.                  = 0x02000229; -- ? byte
--addresses.                  = 0x0200022A; -- ? byte
--addresses.                  = 0x0200022B; -- ? byte
addresses.HP_max_1            = 0; -- 2 bytes, max is 0x03E8
addresses.HP_max_2            = 0; -- 2 bytes, max is 0x03E8
--addresses.                  = 0x02000230; -- ? byte

-- 230+ more flags?

--addresses.                  = 0x02000234; -- ? byte HP & Internet links

-- 21D ???

addresses.zenny               = 0x02001BDC; -- 4 bytes, 999999 "max"
addresses.bugfrags			  = 0x02001BE0; -- 4 bytes, 9999 "max"
addresses.bugfrags_copy_1	  = 0x02001BE0; -- 4 bytes, copy 1?
addresses.bugfrags_copy_2	  = 0x02001BE0; -- 4 bytes, copy 2?

-- 2AC-2CF

-- Key Items are 1 byte each, some are counters
addresses.HPMemory            = 0x02000310; -- 1 byte, collected

-- 370-3CF divider

addresses.steps_total         = 0; -- 3 bytes, since new game
addresses.play_time_frames    = 0; -- 4 bytes, check for skipped frames
addresses.battle_timer_total  = 0; -- 4 bytes, from load in to load out
--addresses.                  = 0x020003F0; -- 4 bytes TBD
addresses.steps               = 0x02001C16; -- 4 bytes
addresses.check               = 0x02001C18; -- 4 bytes, steps at the last encounter check
addresses.sneak               = 0x02001C28; -- 4 bytes, starts at 6000
addresses.encounter_odds  	  = 0x08020C5C;
addresses.encounter_curve 	  = 0x08020CE4;

-- 448-49F big divider

-- 5AA broken divider?

-- 13A0 first usable? textures/animations?

-- 13B9 sayonara mom

-- 1500 repair man

--addresses.                  = 0x02003710; -- ? byte TBD
--addresses.                  = 0x02003711; -- ? byte TBD
addresses.battle_state        = 0x0203CA70; -- 1 byte 0x04 chip_menu/dead 0x08 transition 0x0C normal 0x10 PAUSE 
addresses.battle_turns        = 0; -- 1 byte, number of custom gauge opens + 1
addresses.chip_window_count   = 0; -- 1 byte, number of chips in the custom menu
addresses.battle_paused_also  = 0; -- 1 byte, flag 0x08 (no effect on write)
addresses.battle_timer        = 0; -- 2 bytes, frame counter for current battle
addresses.battle_pointer      = 0; -- 2 bytes? ROM offset?
addresses.battle_custom_gauge = 0; -- 2 bytes, counts up to 0x4000
addresses.enemy_ID            = 0x020348D4; -- 2 bytes
addresses.enemy_ID_2          = 0x020348D6; -- 2 bytes
addresses.enemy_ID_3          = 0x020348D8; -- 2 bytes

-- 37E0-449F mostly 1's?

-- 44A0+ TBD

-- 4713 animation timer
-- 4718 dog know

-- 4904 & 4906 fade in and out

addresses.your_X              = 0x0200AC50; -- 2 bytes
addresses.your_Y              = 0x0200AC52; -- 2 bytes
addresses.your_X2             = 0; -- 2 bytes
addresses.your_Y2             = 0; -- 2 bytes

addresses.enemy_HP_text_1     = 0; -- 2 bytes, for counting down HP over time
addresses.enemy_HP_text_2     = 0; -- 2 bytes, for counting down HP over time
addresses.enemy_HP_text_3     = 0; -- 2 bytes, for counting down HP over time

-- 49A2+ textures? marked by 0x83 and a counter up to 0x0F, ending around 62E0

--addresses.                  = 0x020062E0; -- 1 byte, unused?
addresses.folder_menu_state   = 0x02019A67; -- 1 byte, 0x04 normal 0x14 sorting 0x10 go right 0x0C go left 0x08 left
--addresses.                  = 0x020062E2; -- 1 byte, unused?
--addresses.                  = 0x020062E3; -- 1 byte, unused?
addresses.cursor_ID           = 0x0200845E; -- 1 byte, chip  ID  of cursor
addresses.cursor_code         = 0x0200845C; -- 1 byte, chip code of cursor
--addresses.                  = 0x020062E6; -- 1 byte, unused?
--addresses.                  = 0x020062E7; -- 1 byte, unused?
--addresses.                  = 0x020062E8; -- 1 byte, chip graphics offset?
--addresses.                  = 0x020062E9; -- 1 byte, chip graphics offset?
--addresses.                  = 0x020062EA; -- 1 byte, unused?
--addresses.                  = 0x020062EB; -- 1 byte, always 0x08?
addresses.folder_to_pack      = 0; -- 1 byte, menu transition and tracker
addresses.folder_to_pack_copy = 0; -- 1 byte, copy
--addresses.                  = 0x020062EE; -- 1 byte, unused?
addresses.cursor_animation    = 0; -- 1 byte

addresses.folder_count        = 0; -- 1 byte, number of chips in folder
addresses.chip_selected       = 0; -- 1 byte, flag: 0x01 folder 0x02 pack
addresses.cursor_folder       = 0; -- 2 bytes, cursor value in the folder
addresses.cursor_folder_copy  = 0; -- 2 bytes, copy
addresses.offset_folder       = 0x02009A54; -- 2 bytes, offset value in the folder
addresses.offset_folder_copy  = 0; -- 2 bytes, copy
addresses.folder_bottom_index = 0; -- 2 bytes, to limit cursor
addresses.cursor_pack         = 0; -- 2 bytes, cursor value in the pack
addresses.cursor_pack_copy    = 0; -- 2 bytes, copy
addresses.offset_pack         = 0x02009A5E; -- 2 bytes, offset value in the pack
addresses.offset_pack_copy    = 0; -- 2 bytes, copy
addresses.pack_bottom_index   = 0; -- 2 bytes, to limit cursor
addresses.chip_selected_flag  = 0; -- 1 byte, flag: 0x12 folder 0x1C pack
addresses.offset_selected     = 0; -- 2 bytes, offset value of selected chip
addresses.cursor_selected     = 0; -- 2 bytes, cursor value of selected chip
addresses.reg_slot			  = 0x020047FA; -- 1 byte, Reg Chip. 255 if no reg

-- 6312 & 631A some kind of counters, flanked by matching flags

-- 632C-632F folder transition timer/offset & flags?

-- 6338 flashing cursor (can't freeze?)

addresses.GMD_reward          = 0; -- 2 bytes, how to decode?

addresses.power_on_frames     = 0; -- 2 bytes, session counter

addresses.button_flags        = 0; -- many bytes, many flags

addresses.chip_cooldown       = 0; -- 1 byte, BstrBomb HYPE

addresses.enemy_HP            = 0x0203AAAC; -- 2 bytes, which_enemy * 0xC0
addresses.enemy_HP_2          = 0x0203AB84; -- 2 bytes, which_enemy * 0xC0
addresses.enemy_HP_3          = 0x0203AC5C; -- 2 bytes, which_enemy * 0xC0

addresses.game_state          = 0x02001B80; -- 1 byte
addresses.main_RNG            = 0x020013F0; -- 4 bytes, resets and pauses on the title screen
addresses.lazy_RNG            = 0x02001120; -- 4 bytes, resets and pauses on the title screen

-- 7210-74C6 all 1's

-- 74CD sprite animation counter?
-- 74D4 sprite animation timer

-- 8010 more texture animation timers

addresses.pack_ID             = 0; -- 1 byte, chip  ID  of pack slot 1
addresses.pack_code           = 0; -- 1 byte, chip code of pack slot 1

-- 0x0203FFFF end of WRAM?
-- 0x02047FFF end of WRAM?

---------------------------------------- ROM  08000000-09FFFFFF ----------------------------------------

addresses.version_byte        = 0;

addresses.battle_data         = 0; -- plus offset from TBD?

-- https://forums.therockmanexezone.com/mmbn1-mystery-data-t5326.html

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

