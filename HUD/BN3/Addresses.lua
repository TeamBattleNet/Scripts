-- RAM addresses for MMBN 3 scripting, enjoy.

local addresses = require("All/Addresses");

-- GMD_value and number_code use the same address
-- Pressing LButton during CopyMan skip could be an exploit
-- Flags to find: Beta Navis, Key Items, MDs, Jobs, Trades, Vines, Fires, Animals, Jack-Out Lock Out

-- https://github.com/XKirby/MMBN3-Randomizer/blob/master/notes/MMBN3%20Various%20Offsets.txt

---------------------------------------- WRAM 02000000-0203FFFF ----------------------------------------

addresses.water_fire_flags      = 0x02000000; -- 1 byte TBD
addresses.plant_fire_flags      = 0x02000000; -- 1 byte TBD

addresses.navi_cust_bugged      = 0x0200003B; -- 1 bit, 0x80, maybe?
addresses.viruses_captured      = 0x0200003B; -- 1 digit per virus 0x7 ends 3F

addresses.folder_state          = 0x02000040; -- 1 byte
addresses.navi_deleted_flags    = 0x02000050; -- 1 bit per navi (alpha / beta / cubes) format tbd
addresses.HP_memory_value       = 0x02000150; -- 1 byte ???

addresses.viruses_breeder       = 0x02000164; -- 1 bit, must be set before jack-in

addresses.email_read            = 0x02000260; -- 1 bit per email, 1 if unread, 0 if read

addresses.library               = 0x02000330; -- 1 bit per chip, runs for ~44 bytes
addresses.library_S_begin       = 0x02000330; -- 0x80 for Navi+20
addresses.library_S_end         = 0x02000349; -- 0x80 for Navi+20
addresses.library_M_begin       = 0x02000349; -- 0x7F for TBD
addresses.library_plantmen      = 0x0200034F; -- 0x0F for PlantMan 1-4
addresses.library_mist_bowl_men = 0x02000353; -- 0x3DE0 for MistMan & BowlMan chips
addresses.library_M_end         = 0x02000355; -- 0x78 for JapanMan chips
addresses.library_giga_1        = 0x02000355; -- 1 bit per chip: 0x03 FoldrBak, DeltaRay
addresses.library_giga_2        = 0x02000356; -- 1 bit per chip: 0x07 Bass+, DarkAura, AlphArmO
addresses.library_giga_3        = 0x02000357; -- 1 bit per chip: 0x80 BassGS followed by 7 invalid IDs
addresses.library_PA_1          = 0x02000358; -- 0xFF for (in actual order of library)
addresses.library_PA_2          = 0x02000359; -- 0xFF for (in actual order of library)
addresses.library_PA_3          = 0x0200035A; -- 0xFF for (in actual order of library)
addresses.library_PA_4          = 0x0200035B; -- 0xFF for (in actual order of library)

addresses.battles_guts          = 0x02000E60; -- 1 byte
addresses.battles_cust          = 0x02000E61; -- 1 byte
addresses.battles_team          = 0x02000E62; -- 1 byte
addresses.battles_shld          = 0x02000E63; -- 1 byte
addresses.battles_grnd          = 0x02000E64; -- 1 byte
addresses.battles_shdw          = 0x02000E65; -- 1 byte
addresses.battles_bug           = 0x02000E66; -- 1 byte
--addresses.                    = 0x02000E67; -- 1 byte TBD
addresses.GMD_RNG               = 0x02000E68; -- 4 bytes, drop table index

addresses.navi_cust_programs    = 0x02001300; -- 8 bytes per program, ID and location, indexed by 1D90, ends 13C7

-- 13D0 - 140F TBD

addresses.folder[1].ID          = 0x02001410; -- 2 bytes, chip  ID  of folder 1 slot 1, ends 1484
addresses.folder[1].code        = 0x02001412; -- 2 bytes, chip Code of folder 1 slot 1, ends 1486
addresses.folder[2].ID          = 0x02001500; -- 2 bytes, chip  ID  of folder 1 slot 1, ends 1574
addresses.folder[2].code        = 0x02001502; -- 2 bytes, chip Code of folder 1 slot 1, ends 1576
addresses.folder[3].ID          = 0x02001488; -- 2 bytes, chip  ID  of folder 1 slot 1, ends 14FC
addresses.folder[3].code        = 0x0200148A; -- 2 bytes, chip Code of folder 1 slot 1, ends 14FE

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
addresses.reg_capacity          = 0x02001897; -- 1 byte
addresses.world_HP_current      = 0x020018A0; -- 2 bytes
addresses.world_HP_max          = 0x020018A2; -- 2 bytes

addresses.battle_pointer        = 0x020018AC; -- 2 bytes? ROM offset? TBD
addresses.battle_pointer_copy   = 0x02006D0C; -- 2 bytes? ROM offset? TBD
addresses.battle_pointer_fixed  = 0x0200F8C8; -- 2 bytes? ROM offset? TBD

--addresses.                    = 0x020018DE; -- 2 bytes TBD

--addresses.                    = 0x020018F0; -- 4 bytes TBD
addresses.zenny                 = 0x020018F4; -- 4 bytes, 999999 "max"
addresses.bug_frags             = 0x020018F8; -- 4 bytes,   9999 "max"
--addresses.                    = 0x020018FC; -- 4 bytes TBD

-- 1990 - 19BF TBD

-- 19C0 - 1B6F Flags?

addresses.battle_escape_lvl     = 0x02001A20; -- 1 byte ???

-- 1B66 NaviCust bugged flag?

-- 1B70 - 1D6F @

-- 1D70 - 1DF0 various data

addresses.navi_cust             = 0x02001D90; -- 1 byte per square, value is program index, ends 1DA8?
addresses.navi_cust_commands    = 0x02001D9A; -- 1 byte per square, value is program index, the 5 command tiles

addresses.next_element          = 0x02001DBB; -- 1 byte, next element
addresses.library_anti_cheat    = 0x02001DC3; -- 1 byte, write 0xFF to fix flashcart bug - mars
addresses.battle_count          = 0x02001DCA; -- 1 byte, number of battles since last style change
addresses.play_time_frames      = 0x02001DD0; -- 4 bytes, check for skipped frames
addresses.steps                 = 0x02001DDC; -- 4 bytes
addresses.check                 = 0x02001DE0; -- 4 bytes, steps at the last encounter check
addresses.sneak                 = 0x02001DEC; -- 4 bytes, starts at 6000
addresses.loc_enemy_steps       = 0x02001DF0; -- 4 bytes, starts at 6000
addresses.loc_enemy_id          = 0x02001DF4; -- 4 bytes, encounter ID (ROM Address?)

-- 1E00 ROCKMANEXE3 20021002

-- 1E14 - 1F5F all 1's

addresses.pack_chip_counts      = 0x02001f60; -- 18*312 bytes, first 6 of every 18 bytes are used, ends at 35D0?

-- 35EF end of pack?

-- 44FF end of something?

-- 4560 area temps?

addresses.GMD_1_xy              = 0x02004586; -- 2 bytes iso coords
addresses.GMD_1_yx              = 0x0200458A; -- 2 bytes iso coords
addresses.GMD_2_xy              = 0x0200464A; -- 2 bytes iso coords
addresses.GMD_2_yx              = 0x0200464E; -- 2 bytes iso coords

addresses.credits_cutscene      = 0x020050A8; -- 1 byte ???

-- 5220 - 575F all 1's

-- 5760 NaviCust status

addresses.buster_attack         = 0x02005778; -- 1 byte
addresses.buster_rapid          = 0x02005779; -- 1 byte
addresses.buster_charge         = 0x0200577A; -- 1 byte
addresses.bug_run               = 0x02005789; -- 1 bit
addresses.sneak_run             = 0x0200578A; -- 1 bit
addresses.max_HP_over_five      = 0x0200579C; -- 1 byte, Maximum HP Check for HP Memory (Max HP/5)

-- 5C00 counting?

addresses.sneak_run_also        = 0x02005C49; -- 1 bit, probably not though

-- 6A20 - 6B0F textbox data?

-- 6CA0 - 6D1F battle data?

addresses.battle_custom_check   = 0x02006CAC; -- 1 byte, flag for full custom gauge 0x01
addresses.chip_window_size_next = 0x02006CAE; -- 1 byte, number of chips available in the custom menu next time
addresses.battle_custom_gauge   = 0x02006CCC; -- 2 bytes, counts up to 0x4000
addresses.delete_timer          = 0x02006CE0; -- 2 bytes, counts up to 0x4000

addresses.enemy[1].ID           = 0x02006D00; -- 1 byte per enemy, up to 3
addresses.enemy[2].ID           = 0x02006D01; -- 1 byte per enemy, up to 3
addresses.enemy[3].ID           = 0x02006D02; -- 1 byte per enemy, up to 3

addresses.cursor_ID             = 0x02007D14; -- 2 bytes? chip ID of cursor
addresses.cursor_code           = 0x02007D18; -- 2 bytes? chip Code of cursor
addresses.folder_or_pack        = 0x02007DD3; -- 1 byte, 26 == folder, 8 == pack

-- 8F20 - 8F9F positional graphic values?

addresses.your_X                = 0x02008F54; -- 2 bytes freezing doesn't prevent movement???
addresses.your_Y                = 0x02008F56; -- 2 bytes freezing doesn't prevent movement???
addresses.map_offset_x          = 0x02008F58; -- 2 bytes % 256 to scroll screen
addresses.map_offset_y          = 0x02008F5A; -- 2 bytes % 256 to scroll screen

addresses.battle_field_modifier = 0x02008F98; -- 1 byte, weird effects

-- 8FA0 - 939F graphics?

-- 93A0 - 947F Menu stuff?

addresses.menu_mode             = 0x020093D0; -- 1 byte
addresses.menu_state            = 0x020093D1; -- 1 byte

addresses.cursor_folder         = 0x020093E2; -- 2 bytes?, cursor value in the folder
addresses.offset_folder         = 0x020093E6; -- 2 bytes?, offset value in the folder
addresses.cursor_pack           = 0x020093EC; -- 2 bytes?, cursor value in the pack
addresses.offset_pack           = 0x020093F0; -- 2 bytes?, offset value in the pack
addresses.folder_count          = 0x020093DA; -- 1 byte, number of chips in folder being edited

addresses.selected_offset_folder = 0x02009420; -- 2 bytes?, offset value of selected chip in folder
addresses.selected_cursor_folder = 0x02009422; -- 2 bytes?, cursor value of selected chip in folder
addresses.selected_offset_pack   = 0x02009428; -- 2 bytes?, offset value of selected chip in pack
addresses.selected_cursor_pack   = 0x0200942A; -- 2 bytes?, cursor value of selected chip in pack

-- 9480 - 955F Textbox stuff?

addresses.is_interacting        = 0x02009480; -- 1 byte ???
addresses.interact_with         = 0x02009481; -- 1 byte ???
addresses.interact_offset       = 0x020094AC; -- 4 bytes ???
addresses.GMD_value             = 0x020094B8; -- 2 bytes, how to decode?
addresses.number_code           = 0x020094B8; -- 1 byte per 8 digits

-- 9560 - 95FF Graphics stuff?

addresses.power_on_frames       = 0x02009604; -- 2 bytes
addresses.lazy_RNG              = 0x02009730; -- 4 bytes, controls encounter ID and chip draws
addresses.bbs_jobs_new          = 0x020097A5; -- 1 byte TBD
addresses.bbs_jobs_total        = 0x020097BA; -- 1 byte TBD
addresses.game_state            = 0x020097F8; -- 1 byte
addresses.main_RNG              = 0x02009800; -- 4 bytes, controls everything else
addresses.gamble_pick           = 0x02009DB1; -- 1 byte, current value
addresses.gamble_win            = 0x02009DB2; -- 1 byte, winning value

addresses.color_palette         = 0x02009810; -- 1024 bytes, 0x3FF bytes, ends at 9C0F

addresses.title_star_flags      = 0x0200A30A; -- 1 bit per star 0xFE

--addresses.battle_             = 0x0200F332; -- 2 bytes, something battle related
addresses.battle_reward         = 0x0200F332; -- 2 bytes, how to decode? (mask 0x40 means zenny)
--addresses.battle_             = 0x0200F334; -- 2 bytes, stats? S+?
addresses.battle_field          = 0x0200F47E; -- 8*3 bytes, current battlefield

-- F7F0 battle information

addresses.chip_window_size      = 0x0200F7F9; -- 1 byte, number of chips available in the custom menu

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

addresses.navi_cust_previous    = 0x02017800; -- 1 byte per square, where to drop the held NCP on B
addresses.navi_cust_prog_prev   = 0x02017820; -- 8 bytes per program, last placed ID and location, ends at 178E7

addresses.navi_cust_active      = 0x02018800; -- 1 byte per square, the last run configuration (to cancel edit)

addresses.pack                  = 0x02018800; -- top of pack, 0x20 bytes per chip
addresses.pack_ID               = 0x0201881C; -- 2 bytes, chip ID of pack
addresses.pack_code             = 0x0201880A; -- 2 bytes, chip code of pack

-- ends by 22FFF

addresses.battle_draw_slots     = 0x02034040; -- 1 byte each, in battle chip draws, ends at 0x0203405D

addresses.battle_HP_current     = 0x02037294; -- 2 bytes
addresses.battle_HP_max         = 0x02037296; -- 2 bytes

addresses.enemy[1].HP           = 0x02037368; -- 2 bytes, which_enemy * 0xC0
addresses.enemy[1].HP_max       = 0x0203736A; -- 2 bytes, for healing?

addresses.enemy[2].HP           = 0x0203743C; -- 2 bytes, which_enemy * 0xC0
addresses.enemy[2].HP_max       = 0x0203743E; -- 2 bytes, for healing?

addresses.enemy[3].HP           = 0x02037510; -- 2 bytes, which_enemy * 0xC0
addresses.enemy[3].HP_max       = 0x02037512; -- 2 bytes, for healing?

addresses.counter_hits          = 0x020384EA; -- 1 byte

addresses.count_used_mega_buster= 0x0203B320; -- 1 byte, times used Mega Buster; counter +10 if custom gauge full
addresses.count_used_charge_shot= 0x0203B321; -- 1 byte, times used Charge Shot
addresses.count_flinched        = 0x0203B322; -- 1 byte, times flinched by attack
addresses.count_used_guts_mg    = 0x0203B323; -- 1 byte, times used Guts MG
addresses.count_sent_0_chips    = 0x0203B324; -- 1 byte, times sent 0 chips
addresses.count_sent_1_chips    = 0x0203B325; -- 1 byte, times sent 1 chips
addresses.count_sent_2_chips    = 0x0203B326; -- 1 byte, times sent 2 chips
addresses.count_sent_3_chips    = 0x0203B327; -- 1 byte, times sent 3 chips
addresses.count_sent_4_chips    = 0x0203B328; -- 1 byte, times sent 4 chips
addresses.count_sent_5_chips    = 0x0203B329; -- 1 byte, times sent 5 chips
addresses.count_used_add        = 0x0203B32A; -- 1 byte, times used ADD
addresses.count_formed_pas      = 0x0203B32B; -- 1 byte, times formed P.A.
addresses.count_sent_navi_chips = 0x0203B32D; -- 1 byte, total sent Navi chips
addresses.count_used_misc_chips = 0x0203B32E; -- 1 byte, total used misc chips
addresses.count_used_guard_chips= 0x0203B32F; -- 1 byte, total used guard chips
addresses.count_used_barr_chips = 0x0203B330; -- 1 byte, total used barrier chips
addresses.count_used_recov_chips= 0x0203B331; -- 1 byte, total used recovery chips
addresses.count_used_crack_chips= 0x0203B332; -- 1 byte, total used panel cracking chips
addresses.count_used_field_chips= 0x0203B333; -- 1 byte, total used field reliant chips
addresses.count_used_invul_chips= 0x0203B334; -- 1 byte, total used invulnerability chips
addresses.count_used_sword_chips= 0x0203B335; -- 1 byte, total used sword chips
addresses.count_used_block      = 0x0203B337; -- 1 byte, total used Block
addresses.count_used_shield     = 0x0203B338; -- 1 byte, total used Shield
addresses.count_used_reflect    = 0x0203B339; -- 1 byte, total used Reflect
addresses.count_used_invis_pwr  = 0x0203B33A; -- 1 byte, total used Invis Power Attack
addresses.count_turns_bug_lv1   = 0x0203B33B; -- 1 byte, turns LV 1 bug(s) in NC
addresses.count_turns_bug_lv2   = 0x0203B33C; -- 1 byte, turns LV 2 bug(s) in NC
addresses.count_turns_bug_lv3   = 0x0203B33D; -- 1 byte, turns LV 3 bug(s) in NC

--addresses.                    = 0x0203B380; -- 4 bytes, battle timer?
--addresses.                    = 0x0203B390; -- 4 bytes, 5 copies of button flags?

-- 0x0203FFFF end of WRAM

---------------------------------------- ROM  08000000-09FFFFFF ----------------------------------------

addresses.GMD_pick_table = 0x0802769C; -- BN3 Blue (U)
addresses.GMD_pick_zenny = 0x08027DC2; -- BN3 Blue (U)
addresses.GMD_pick_chips = 0x08027E02; -- BN3 Blue (U)

---------------------------------------- Verion Dependent ----------------------------------------

addresses.main_loop             = 0x080002B4; -- series of instructions, easy to break

-- A0 A1 A2 A3 A4 A5 A6 A7 A8 A9 AA AB AC AD AE AF - ROM Address
-- 52 4F 43 4B 4D 41 4E 5F 45 58 45 33 41 36 42 4A - ROCKMAN_EXE3A6BJ - JP  White
-- 52 4F 43 4B 5F 45 58 45 33 5F 42 4B 41 33 58 4A - ROCK_EXE3_BKA3XJ - JP  Black
-- 4D 45 47 41 5F 45 58 45 33 5F 57 48 41 36 42 45 - MEGA_EXE3_WHA6BE - US  White
-- 4D 45 47 41 5F 45 58 45 33 5F 42 4C 41 33 58 45 - MEGA_EXE3_BLA3XE - US  Blue
-- 4D 45 47 41 5F 45 58 45 33 5F 57 48 41 36 42 50 - MEGA_EXE3_WHA6BP - PAL White
-- 4D 45 47 41 5F 45 58 45 33 5F 42 4C 41 33 58 50 - MEGA_EXE3_BLA3XP - PAL Blue

local version_byte = memory.read_u32_le(addresses.version_byte);

addresses.version_white = false;
addresses.version_blue  = false;

if     version_byte == 0x4A423641 then
    addresses.version_name      = "JP White";
    addresses.version_white     = true;
    addresses.encounter_odds    = 0x0800D1E8;
    addresses.encounter_curve   = 0x0800D270;
elseif version_byte == 0x4A583341 then
    addresses.version_name      = "JP Black";
    addresses.version_blue      = true;
    addresses.encounter_odds    = 0x0800D1E8;
    addresses.encounter_curve   = 0x0800D270;
elseif version_byte == 0x45423641 then
    addresses.version_name      = "US White";
    addresses.version_white     = true;
    addresses.encounter_odds    = 0x0800D26C;
    addresses.encounter_curve   = 0x0800D2F4;
elseif version_byte == 0x45583341 then
    addresses.version_name      = "US Blue";
    addresses.version_blue      = true;
    addresses.encounter_odds    = 0x0800D26C;
    addresses.encounter_curve   = 0x0800D2F4;
elseif version_byte == 0x50423641 then
    addresses.version_name      = "PAL White";
    addresses.version_white     = true;
    addresses.encounter_odds    = 0x0800D26C;
    addresses.encounter_curve   = 0x0800D2F4;
elseif version_byte == 0x50583341 then
    addresses.version_name      = "PAL Blue";
    addresses.version_blue      = true;
    addresses.encounter_odds    = 0x0800D26C;
    addresses.encounter_curve   = 0x0800D2F4;
else
    print("\nRAM: Warning! Unrecognized game version! Unable to set certain addresses!");
end

return addresses;

