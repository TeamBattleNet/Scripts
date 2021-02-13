-- RAM addresses for MMBN 3 scripting, enjoy.

local addresses = require("All/Addresses");

-- GMD_value and number_code use the same address
-- Pressing LButton during CopyMan skip could be an exploit
-- Flags to find: Beta Navis, Key Items, MDs, Jobs, Trades, Vines, Fires, Animals, Jack-Out Lock Out

-- https://github.com/XKirby/MMBN3-Randomizer/blob/master/notes/MMBN3%20Various%20Offsets.txt

---------------------------------------- WRAM 02000000-0203FFFF ----------------------------------------

addresses.fire_flags            = 0x02000000; -- 1 byte TBD

addresses.folder_state          = 0x02000040; -- 1 byte
addresses.HP_memory_value       = 0x02000150; -- 1 byte ???

addresses.library               = 0x02000330; -- 1 bit per chip, runs for ~44 bytes

addresses.battles_guts          = 0x02000E60; -- 1 byte
addresses.battles_cust          = 0x02000E61; -- 1 byte
addresses.battles_team          = 0x02000E62; -- 1 byte
addresses.battles_shld          = 0x02000E63; -- 1 byte
addresses.battles_grnd          = 0x02000E64; -- 1 byte
addresses.battles_shdw          = 0x02000E65; -- 1 byte
addresses.battles_bug           = 0x02000E66; -- 1 byte
--addresses.                    = 0x02000E67; -- 1 byte TBD
addresses.GMD_RNG               = 0x02000E68; -- 4 bytes, drop table index

addresses.folder[1].ID           = 0x02001410; -- 2 bytes, chip  ID  of folder 1 slot 1, ends 1484
addresses.folder[1].code         = 0x02001412; -- 2 bytes, chip Code of folder 1 slot 1, ends 1486
addresses.folder[2].ID           = 0x02001500; -- 2 bytes, chip  ID  of folder 1 slot 1, ends 1574
addresses.folder[2].code         = 0x02001502; -- 2 bytes, chip Code of folder 1 slot 1, ends 1576
addresses.folder[3].ID           = 0x02001488; -- 2 bytes, chip  ID  of folder 1 slot 1, ends 14FC
addresses.folder[3].code         = 0x0200148A; -- 2 bytes, chip Code of folder 1 slot 1, ends 14FE

addresses.control_flags         = 0x02001880; -- 1 byte ???
addresses.style_active          = 0x02001881; -- 1 byte
--addresses.                    = 0x02001882; -- 1 byte TBD
--addresses.                    = 0x02001883; -- 1 byte TBD
addresses.main_area             = 0x02001884; -- 1 byte
addresses.sub_area              = 0x02001885; -- 1 byte
addresses.progress              = 0x02001886; -- 1 byte
--addresses.                    = 0x02001887; -- 1 byte TBD music???
--addresses.                    = 0x02001888; -- 1 byte TBD
addresses.battle_paused         = 0x02001889; -- 1 byte, paused or custom menu in battle
addresses.style_stored          = 0x02001894; -- 1 byte
addresses.world_HP_current      = 0x020018A0; -- 2 bytes
addresses.world_HP_max          = 0x020018A2; -- 2 bytes
addresses.zenny                 = 0x020018F4; -- 4 bytes, 999999 "max"
addresses.bug_frags             = 0x020018F8; -- 4 bytes,   9999 "max"

addresses.battle_pointer        = 0x020018AC; -- 2 bytes? ROM offset? TBD
addresses.battle_pointer_copy   = 0x02006D0C; -- 2 bytes? ROM offset? TBD
addresses.battle_pointer_fixed  = 0x0200F8C8; -- 2 bytes? ROM offset? TBD

addresses.next_element          = 0x02001DBB; -- 1 byte, next element
addresses.battle_count          = 0x02001DCA; -- 1 byte, number of battles since last style change
addresses.steps                 = 0x02001DDC; -- 4 bytes
addresses.check                 = 0x02001DE0; -- 4 bytes, steps at the last encounter check
addresses.sneak                 = 0x02001DEC; -- 4 bytes, starts at 6000

addresses.battle_escape_lvl     = 0x02001A20; -- 1 byte ???

addresses.pack_chip_counts      = 0x02001f60; -- 18*312 bytes, first 6 of every 18 bytes are used, ends 0x02003550?

addresses.credits_cutscene      = 0x020050A8; -- 1 byte ???

addresses.buster1               = 0x02005778; -- 1 byte ??? attack?
addresses.buster2               = 0x02005779; -- 1 byte ??? rapid ?
addresses.buster3               = 0x0200577A; -- 1 byte ??? charge?
addresses.max_HP_over_five      = 0x0200579C; -- 1 byte, Maximum HP Check for HP Memory (Max HP/5)

addresses.enemy[1].ID           = 0x02006D00; -- 1 byte per enemy, up to 3
addresses.enemy[2].ID           = 0x02006D01; -- 1 byte per enemy, up to 3
addresses.enemy[3].ID           = 0x02006D02; -- 1 byte per enemy, up to 3

addresses.battle_custom_check   = 0x02006CAC; -- 1 byte, flag for full custom gauge 0x01
addresses.chip_window_size      = 0x02006CAE; -- 1 byte, number of chips available in the custom menu
addresses.battle_custom_gauge   = 0x02006CCC; -- 2 bytes, counts up to 0x4000

addresses.cursor_ID             = 0x02007D14; -- 2 bytes? chip ID of cursor
addresses.cursor_code           = 0x02007D18; -- 2 bytes? chip Code of cursor
addresses.folder_or_pack        = 0x02007DD3; -- 1 byte, 26 == folder, 8 == pack

addresses.your_X                = 0x02008F54; -- 2 bytes freezing doesn't prevent movement???
addresses.your_Y                = 0x02008F56; -- 2 bytes freezing doesn't prevent movement???
addresses.map_offset_x          = 0x02008F58; -- 2 bytes % 256 to scroll screen
addresses.map_offset_y          = 0x02008F5A; -- 2 bytes % 256 to scroll screen

addresses.battle_field_modifier = 0x02008F98; -- 1 byte, weird effects

addresses.folder_cursor         = 0x020093E2; -- 2 bytes?, cursor value in the folder
addresses.folder_offset         = 0x020093E6; -- 2 bytes?, offset value in the folder
addresses.pack_cursor           = 0x020093EC; -- 2 bytes?, cursor value in the pack
addresses.pack_offset           = 0x020093F0; -- 2 bytes?, offset value in the pack
addresses.folder_count          = 0x020093DA; -- 1 byte, number of chips in folder being edited

addresses.selected_offset_folder     = 0x02009420; -- 2 bytes?, offset value of selected chip in folder
addresses.selected_cursor_folder     = 0x02009422; -- 2 bytes?, cursor value of selected chip in folder
addresses.selected_offset_pack       = 0x02009428; -- 2 bytes?, offset value of selected chip in pack
addresses.selected_cursor_pack       = 0x0200942A; -- 2 bytes?, cursor value of selected chip in pack

addresses.is_interacting        = 0x02009480; -- 1 byte ???
addresses.interact_with         = 0x02009481; -- 1 byte ???
addresses.interact_offset       = 0x020094AC; -- 4 bytes ???
addresses.GMD_value             = 0x020094B8; -- 2 bytes, how to decode?
addresses.number_code           = 0x020094B8; -- 1 byte per 8 digits
addresses.lazy_RNG              = 0x02009730; -- 4 bytes, controls encounter ID and chip draws
addresses.bbs_jobs_new          = 0x020097A5; -- 1 byte ???
addresses.bbs_jobs_total        = 0x020097BA; -- 1 byte ???
addresses.game_state            = 0x020097F8; -- 1 byte
addresses.main_RNG              = 0x02009800; -- 4 bytes, controls everything else
addresses.gamble_pick           = 0x02009DB1; -- 1 byte, current value
addresses.gamble_win            = 0x02009DB2; -- 1 byte, winning value

addresses.title_star_flags      = 0x0200A30A; -- 1 bit per star 0xFE

--addresses.battle_             = 0x0200F332; -- 2 bytes, something battle related
addresses.battle_reward         = 0x0200F332; -- 2 bytes, how to decode? (mask 0x40 means zenny)
--addresses.battle_             = 0x0200F334; -- 2 bytes, stats? S+?
addresses.battle_field          = 0x0200F47E; -- 8*3 bytes, current battlefield

-- F800 battle information

addresses.custom_gauge_animate  = 0x0200F872; -- 1 byte
addresses.display_chip_name     = 0x0200F873; -- 1 bit
addresses.battle_mode           = 0x0200F886; -- 1 byte
addresses.battle_state          = 0x0200F887; -- 1 byte
addresses.battle_HP_text        = 0x0200F888; -- 2 bytes, for HP change animation
addresses.battle_timer          = 0x0200F89C; -- 2 bytes

addresses.enemy[1].HP_text      = 0x0200F8B2; -- 2 bytes, for HP change animation
addresses.enemy[2].HP_text      = 0x0200F8BA; -- 2 bytes, for HP change animation
addresses.enemy[3].HP_text      = 0x0200F8C2; -- 2 bytes, for HP change animation

-- 0x2001f60 (18*312 Bytes): Battlechip Pack Counts (The first 6 out of 18 Bytes per Chip are used.)

addresses.pack_ID               = 0x0201881C; -- 2 bytes, chip ID of pack
addresses.pack_code             = 0x0201880A; -- 2 bytes, chip code of pack

addresses.battle_draw_slots     = 0x02034040; -- 1 byte each, in battle chip draws, ends at 0x0203405D

addresses.battle_HP_current     = 0x02037294; -- 2 bytes
addresses.battle_HP_max         = 0x02037296; -- 2 bytes

addresses.enemy[1].HP           = 0x02037368; -- 2 bytes, which_enemy * 0xC0
addresses.enemy[1].HP_max       = 0x0203736A; -- 2 bytes, for healing?

addresses.enemy[2].HP           = 0x0203743C; -- 2 bytes, which_enemy * 0xC0
addresses.enemy[2].HP_max       = 0x0203743E; -- 2 bytes, for healing?

addresses.enemy[3].HP           = 0x02037510; -- 2 bytes, which_enemy * 0xC0
addresses.enemy[3].HP_max       = 0x02037512; -- 2 bytes, for healing?

--addresses.                    = 0x0203B380; -- 4 bytes, battle timer?
--addresses.                    = 0x0203B390; -- 4 bytes, 5 copies of button flags?

-- 0x0203FFFF end of WRAM

---------------------------------------- Verion Dependent ----------------------------------------

-- A0 A1 A2 A3 A4 A5 A6 A7 A8 A9 AA AB AC AD AE AF - ROM Address
-- 52 4F 43 4B 4D 41 4E 5F 45 58 45 33 41 36 42 4A - ROCKMAN_EXE3A6BJ - JP White
-- 52 4F 43 4B 5F 45 58 45 33 5F 42 4B 41 33 58 4A - ROCK_EXE3_BKA3XJ - JP Black
-- 4D 45 47 41 5F 45 58 45 33 5F 57 48 41 36 42 45 - MEGA_EXE3_WHA6BE - US White
-- 4D 45 47 41 5F 45 58 45 33 5F 42 4C 41 33 58 45 - MEGA_EXE3_BLA3XE - US Blue
-- 4D 45 47 41 5F 45 58 45 33 5F 57 48 41 36 42 50 - MEGA_EXE3_WHA6BP - PAL
-- 4D 45 47 41 5F 45 58 45 33 5F 42 4C 41 33 58 50 - MEGA_EXE3_BLA3XP - PAL

local version_byte = memory.read_u32_le(addresses.version_byte);

if     version_byte == 0x4A423641 then
    addresses.version_name = "JP White";
    addresses.encounter_odds    = 0x0800D1E8;
    addresses.encounter_curve   = 0x0800D270;
elseif version_byte == 0x4A583341 then
    addresses.version_name = "JP Black";
    addresses.encounter_odds    = 0x0800D1E8;
    addresses.encounter_curve   = 0x0800D270;
elseif version_byte == 0x45583341 then
    addresses.version_name      = "US White";
    addresses.encounter_odds    = 0x0800D26C;
    addresses.encounter_curve   = 0x0800D2F4;
elseif version_byte == 0x45423641 then
    addresses.version_name      = "US Blue";
    addresses.encounter_odds    = 0x0800D26C;
    addresses.encounter_curve   = 0x0800D2F4;
elseif version_byte == 0x50423641 then
    addresses.version_name = "PAL White";
    addresses.encounter_odds    = 0x0800D26C;
    addresses.encounter_curve   = 0x0800D2F4;
elseif version_byte == 0x50583341 then
    addresses.version_name = "PAL Blue";
    addresses.encounter_odds    = 0x0800D26C;
    addresses.encounter_curve   = 0x0800D2F4;
else
    print("\nRAM: Warning! Unrecognized game version! Unable to set certain addresses!");
end

return addresses;

