-- RAM addresses for MMBN 1 scripting, enjoy.

local addresses = require("All/Addresses");

---------------------------------------- WRAM 02000000-0203FFFF ----------------------------------------

addresses.title_star_byte       = 0x02000000; -- 0x04 1 bit for 1 star :)
addresses.flags_0000            = 0x02000000; -- 00000 star 00
addresses.flags_0001            = 0x02000001; -- 000 try_access_internet_2 0000
addresses.flags_0002            = 0x02000002; -- 00000000
addresses.flags_0003            = 0x02000003; -- 00000000
addresses.flags_0004            = 0x02000004; -- 00000000

-- 004-00F ??? WWW Pin Doors

addresses.metro_ticket          = 0x02000005; -- TBD

addresses.fire_flags_oven       = 0x02000014; -- 30 bit flags, shared use
addresses.fire_flags_www        = 0x0200001B; -- 23 bit flags, shared use
addresses.elevator_flag         = 0x0200001C; -- 1-------b
addresses.magic_byte            = 0x0200001D; -- ---10---b (progress must be == 0x54)

addresses.library               = 0x02000020; -- bit flags (with gaps) ends at 0x38
addresses.library_bass          = 0x02000038; -- 00000001b

--  39-3F  Reserved for library (included in count)

addresses.emails_gave_flags     = 0x02000040; -- maybe? ends at 47
addresses.emails_read_flags     = 0x02000048; -- maybe? ends at 4F

addresses.BMD_flags             = 0x02000050; -- ends at 6F? 0x80 is shelf PET

addresses.fire_flags            = 0x02000070; -- 4 bytes, 32 fire bit flags

--  70-8B  ??? flags

addresses.pause_menu_flags      = 0x02000080; -- 1 byte, TBD

--  8C-8F  ??? all 1's

-- 110-120 ??? all 1's

-- 120-170 ??? no idea

-- 170-1BF ??? all 1's

addresses.folder_ID             = 0x020001C0; -- every other byte, chip  ID  of folder slot 1, ends at 1FA
addresses.folder_code           = 0x020001C1; -- every other byte, chip code of folder slot 1, ends at 1FB
addresses.folder[1].ID          = 0x020001C0; -- for use with common RAM
addresses.folder[1].code        = 0x020001C1; -- for use with common RAM
addresses.folder[2].ID          = 0x020001C0; -- there is no folder 2
addresses.folder[2].code        = 0x020001C1; -- there is no folder 2
addresses.folder[3].ID          = 0x020001C0; -- there is no folder 3
addresses.folder[3].code        = 0x020001C1; -- there is no folder 3

-- 1FC-203 ??? 1FF changes a lot

-- 204-213 ??? mostly 1's

addresses.game_loading_flags    = 0x02000210; -- 1 byte
--addresses.                    = 0x02000211; -- 1 byte FF
--addresses.                    = 0x02000212; -- 1 byte FF
--addresses.                    = 0x02000213; -- 1 byte FF
addresses.main_area             = 0x02000214; -- 1 byte
addresses.sub_area              = 0x02000215; -- 1 byte
addresses.progress              = 0x02000216; -- 1 byte
addresses.music_progress        = 0x02000217; -- 1 byte
--addresses.                    = 0x02000218; -- ? byte
addresses.battle_paused         = 0x02000219; -- 1 byte, flag 0x01
--addresses.                    = 0x0200021A; -- ? byte
--addresses.                    = 0x0200021B; -- ? byte
--addresses.                    = 0x0200021C; -- ? byte
--addresses.                    = 0x0200021D; -- ? byte
--addresses.                    = 0x0200021E; -- ? byte
--addresses.                    = 0x0200021F; -- ? byte
--addresses.                    = 0x02000220; -- ? byte
--addresses.                    = 0x02000221; -- ? byte
--addresses.                    = 0x02000222; -- ? byte
--addresses.                    = 0x02000223; -- ? byte
addresses.buster_attack         = 0x02000224; -- 1 byte, 0 indexed, can't change mid-battle
addresses.buster_rapid          = 0x02000225; -- 1 byte, 0 indexed, can't change mid-battle
addresses.buster_charge         = 0x02000226; -- 1 byte, 0 indexed, can't change mid-battle
addresses.armor_equipped        = 0x02000227; -- 1 byte
addresses.loading_state         = 0x02000228; -- 1 byte TBD
--addresses.                    = 0x02000229; -- ? byte
--addresses.                    = 0x0200022A; -- ? byte
--addresses.                    = 0x0200022B; -- ? byte
addresses.HP_max_1              = 0x0200022C; -- 2 bytes, max is 0x03E8
addresses.HP_max_2              = 0x0200022E; -- 2 bytes, max is 0x03E8
--addresses.                    = 0x02000230; -- ? byte

-- 230+ more flags?

--addresses.                    = 0x02000234; -- ? byte HP & Internet links

-- 21D ???

addresses.zenny                 = 0x02000284; -- 4 bytes, 999999 "max"

-- 2AC-2CF divider

-- Key Items are 1 byte each, some are counters
addresses.key_PET               = 0x020002D0; -- 1 byte
addresses.key_IceBlock_count    = 0x020002D1; -- 1 byte, for both Oven and WWW 1
addresses.key_WaterGun          = 0x020002D2; -- 1 byte value of 0x05?
addresses.key_SchoolID          = 0x020002D3; -- 1 byte
addresses.key_SciLabID          = 0x020002D4; -- 1 byte, snip snip
addresses.key_Handle            = 0x020002D5; -- 1 byte
addresses.key_Message           = 0x020002D6; -- 1 byte, from 5th grade Froid
addresses.key_Response          = 0x020002D7; -- 1 byte, to Mayl's email
addresses.key_WWW_PIN           = 0x020002D8; -- 1 byte
addresses.key_BatteryA          = 0x020002D9; -- 1 byte
addresses.key_BatteryB          = 0x020002DA; -- 1 byte
addresses.key_BatteryC          = 0x020002DB; -- 1 byte
addresses.key_BatteryD          = 0x020002DC; -- 1 byte
addresses.key_BatteryE          = 0x020002DD; -- 1 byte
addresses.key_Charger           = 0x020002DE; -- 1 byte
addresses.key_WWW_Pass          = 0x020002DF; -- 1 byte, expired?
--addresses.key_invalid         = 0x020002E0; -- 1 byte
addresses.key_Dentures          = 0x020002E1; -- 1 byte
--addresses.key_invalid         = 0x020002E2 to 0x020002EF
--addresses.key_invalid         = 0x020002F0; -- 1 byte
addresses.key_at_Mayl           = 0x020002F1; -- 1 byte
addresses.key_at_Yai            = 0x020002F2; -- 1 byte
addresses.key_at_Dex            = 0x020002F3; -- 1 byte
--addresses.key_invalid         = 0x020002F4; -- 1 byte
addresses.key_at_Dad            = 0x020002F5; -- 1 byte
addresses.key_at_Sal            = 0x020002F6; -- 1 byte
--addresses.key_invalid         = 0x020002F7; -- 1 byte
addresses.key_at_Miyu           = 0x020002F8; -- 1 byte
--addresses.key_invalid         = 0x020002F9; -- 1 byte
--addresses.key_invalid         = 0x020002FA; -- 1 byte
addresses.key_at_Masa           = 0x020002FB; -- 1 byte
--addresses.key_invalid         = 0x020002FC; -- 1 byte
addresses.key_at_WWW            = 0x020002FD; -- 1 byte
--addresses.key_invalid         = 0x020002FE; -- 1 byte
--addresses.key_invalid         = 0x020002FF; -- 1 byte
addresses.key_slash_Dex         = 0x02000300; -- 1 byte, 0x21 and 0x02000010 -> 0x00200000
addresses.key_slash_Sal         = 0x02000301; -- 1 byte
addresses.key_slash_Miyu        = 0x02000302; -- 1 byte
--addresses.key_invalid         = 0x02000303; -- 1 byte
addresses.key_Hig_Memo          = 0x02000304; -- 1 byte
addresses.key_Lab_Memo          = 0x02000305; -- 1 byte
addresses.key_Pa_Memo           = 0x02000306; -- 1 byte
addresses.key_Yuri_Memo         = 0x02000307; -- 1 byte
--addresses.key_invalid         = 0x02000308; -- 1 byte
--addresses.key_invalid         = 0x02000309; -- 1 byte
--addresses.key_invalid         = 0x0200030A; -- 1 byte
--addresses.key_invalid         = 0x0200030B; -- 1 byte
addresses.key_ACDCPass          = 0x0200030C; -- 1 byte
addresses.key_GovtPass          = 0x0200030D; -- 1 byte
addresses.key_TownPass          = 0x0200030E; -- 1 byte
--addresses.key_invalid         = 0x0200030F; -- 1 byte

addresses.HPMemory              = 0x02000310; -- 1 byte, collected
addresses.PowerUP               = 0x02000311; -- 1 byte, available
--addresses.                    = 0x02000312; -- 1 byte
--addresses.                    = 0x02000313; -- 1 byte
addresses.armor_heat            = 0x02000314; -- 1 byte
addresses.armor_aqua            = 0x02000315; -- 1 byte
addresses.armor_wood            = 0x02000316; -- 1 byte
--addresses.                    = 0x02000317; -- 1 byte

-- 370-3CF divider

addresses.player_data           = 0x020003D0; -- many bytes

addresses.steps_total           = 0x020003E0; -- 3 bytes, since new game
addresses.play_time_frames      = 0x020003E8; -- 4 bytes, check for skipped frames
addresses.battle_timer          = 0x020003EC; -- 4? bytes, frame counter from load in to load out
--addresses.                    = 0x020003F0; -- 4 bytes TBD
addresses.steps                 = 0x020003F4; -- 4 bytes
addresses.check                 = 0x020003F8; -- 4 bytes, steps at the last encounter check

-- 448-49F big divider

-- 5AA broken divider?

-- 13A0 first usable? textures/animations?

-- 13B9 sayonara mom

-- 1500 repair man

-- 3140 Title Screen Continue Audio
-- 3199 RAMdom address for checking title screen A?

--addresses.                    = 0x02003710; -- ? byte start of battle info
addresses.battle_mode           = 0x02003711; -- 1 byte
addresses.battle_state          = 0x02003712; -- 1 byte
addresses.battle_turns          = 0x0200371C; -- 1 byte, number of custom gauge opens + 1
addresses.chip_window_size      = 0x02003720; -- 1 byte, number of chips in the custom menu
addresses.battle_paused_also    = 0x02003724; -- 1 byte, flag 0x08 (no effect on write)
addresses.delete_timer          = 0x02003730; -- 2 bytes, frame counter for current battle
addresses.battle_pointer        = 0x02003784; -- 2 bytes? ROM offset?
addresses.battle_custom_gauge   = 0x0200374E; -- 2 bytes, counts up to 0x4000
addresses.enemy[1].ID           = 0x02003774; -- 1 byte
addresses.enemy[2].ID           = 0x02003775; -- 1 byte
addresses.enemy[3].ID           = 0x02003776; -- 1 byte

-- 37E0-449F mostly 1's?

-- 44A0+ TBD

-- 4713 animation timer
-- 4718 dog know

addresses.battle_object_spawns  = 0x02004890; -- 1 bit each, which battle objects are allocated

-- 4904 & 4906 fade in and out

addresses.battle_draw_slots     = 0x02004910; -- 1 byte each, in battle chip draws, ends at 492D
addresses.your_X                = 0x02004954; -- 2 bytes
addresses.your_Y                = 0x02004956; -- 2 bytes
addresses.your_X2               = 0x02004958; -- 2 bytes
addresses.your_Y2               = 0x0200495A; -- 2 bytes

addresses.enemy[1].HP_text      = 0x02004D30; -- 2 bytes, for counting down HP over time
addresses.enemy[2].HP_text      = 0x020050A0; -- 2 bytes, for counting down HP over time
addresses.enemy[3].HP_text      = 0x02005200; -- 2 bytes, for counting down HP over time

-- 49A2+ textures? marked by 0x83 and a counter up to 0x0F, ending around 62E0

addresses.menu_mode             = 0x020062E0; -- 1 byte
addresses.menu_state            = 0x020062E1; -- 1 byte
--addresses.                    = 0x020062E2; -- 1 byte, unused?
--addresses.                    = 0x020062E3; -- 1 byte, unused?
addresses.cursor_ID             = 0x020062E4; -- 1 byte, chip  ID  of cursor
addresses.cursor_code           = 0x020062E5; -- 1 byte, chip code of cursor
--addresses.                    = 0x020062E6; -- 1 byte, unused?
--addresses.                    = 0x020062E7; -- 1 byte, unused?
--addresses.                    = 0x020062E8; -- 1 byte, chip graphics offset?
--addresses.                    = 0x020062E9; -- 1 byte, chip graphics offset?
--addresses.                    = 0x020062EA; -- 1 byte, unused?
--addresses.                    = 0x020062EB; -- 1 byte, always 0x08?
addresses.folder_to_pack        = 0x020062EC; -- 1 byte, menu transition and tracker
addresses.folder_to_pack_copy   = 0x020062ED; -- 1 byte, copy
--addresses.                    = 0x020062EE; -- 1 byte, unused?
addresses.cursor_animation      = 0x020062EF; -- 1 byte

addresses.folder_count          = 0x020062F0; -- 1 byte, number of chips in folder
addresses.chip_selected_flag    = 0x020062F1; -- 1 byte, flag: 0x00 none 0x01 folder 0x02 pack
addresses.cursor_folder         = 0x020062F2; -- 2 bytes, cursor value in the folder
addresses.cursor_folder_copy    = 0x020062F4; -- 2 bytes, copy
addresses.offset_folder         = 0x020062F6; -- 2 bytes, offset value in the folder
addresses.offset_folder_copy    = 0x020062F8; -- 2 bytes, copy
addresses.bottom_index_folder   = 0x020062FA; -- 2 bytes, to limit cursor
addresses.cursor_pack           = 0x020062FC; -- 2 bytes, cursor value in the pack
addresses.cursor_pack_copy      = 0x020062FE; -- 2 bytes, copy
addresses.offset_pack           = 0x02006300; -- 2 bytes, offset value in the pack
addresses.offset_pack_copy      = 0x02006302; -- 2 bytes, copy
addresses.bottom_index_pack     = 0x02006304; -- 2 bytes, to limit cursor
addresses.chip_selected_state   = 0x02006306; -- 1 byte, flag: 0x12 folder 0x1C pack
addresses.offset_selected       = 0x02006308; -- 2 bytes, offset value of selected chip
addresses.cursor_selected       = 0x0200630A; -- 2 bytes, cursor value of selected chip
addresses.cursor_sort           = 0x0200631C; -- 2 bytes, sort menu cursor position
addresses.cursor_sort_copy      = 0x0200631E; -- 2 bytes, copy
--addresses.                    = 0x02006324; -- ? bytes, 0x06 ???

-- 6312 & 631A some kind of counters, flanked by matching flags

-- 632C-632F folder transition timer/offset & flags?

-- 6338 flashing cursor (can't freeze?)

addresses.GMD_reward            = 0x02006380; -- 2 bytes, how to decode?

addresses.text_box_state        = 0x02006350; -- multiple bytes, TBD
addresses.number_door_display   = 0x02006353; -- bit flag, 0x20

addresses.step_related          = 0x02006448; -- 2 bytes? from the TAS notes
addresses.power_on_frames       = 0x020064A0; -- 2 bytes, session counter

addresses.button_flags          = 0x020065F0; -- many bytes, many flags

-- 6610 shop menu data
addresses.shop_cursor_index     = 0x02006615; -- position + offset
addresses.shop_cursor_position  = 0x02006616; -- 0x00 - 0x03
addresses.shop_cursor_offset    = 0x02006619; -- 1 byte

addresses.chip_cooldown         = 0x02006719; -- 1 byte, BstrBomb HYPE

addresses.enemy[1].HP           = 0x02006790; -- 2 bytes, which_enemy * 0xC0
addresses.boss_object_reference = 0x020067E0; -- 1 byte, ProtoMan charge attack object reference
addresses.enemy[2].HP           = 0x02006850; -- 2 bytes, which_enemy * 0xC0
addresses.enemy[3].HP           = 0x02006910; -- 2 bytes, which_enemy * 0xC0

addresses.game_state            = 0x02006CB8; -- 1 byte
addresses.main_RNG              = 0x02006CC0; -- 4 bytes, resets and pauses on the title screen
addresses.lazy_RNG              = 0x02006CC0; -- to support shared functions with later games

addresses.color_palette         = 0x02006CD0; -- 512 bytes, 0x1FF bytes, ends at 6ECF

-- 7200-7220 sometimes 1's, sprite related?
-- 7200-74C7 all 1's

-- 74CD sprite animation counter?
-- 74D4 sprite animation timer

-- 8010 more texture animation timers

addresses.number_door_code      = 0x02009A90; -- 1 byte, only set when entering a number

-- Each pack slot covers 32 bytes or 0x20 addresses starting at 19000
addresses.pack_ID               = 0x02019018; -- 1 byte each, 0x20 offset
addresses.pack_code             = 0x0201900A; -- 1 byte each, 0x20 offset
addresses.pack_quantity         = 0x02019016; -- 1 byte each, number of copies
-- Ends at 22FFF? Many of these values appear to be duplicates, possibly to help with sorting

-- 0x0203FFFF end of WRAM?
-- 0x02047FFF end of WRAM?

---------------------------------------- ROM  08000000-09FFFFFF ----------------------------------------

addresses.player_data_offset_US = 0x080004E4; -- 1 byte, 03D0 in US, 4211 in JP
addresses.player_data_offset_JP = 0x080004D4; -- 1 byte, 03D0 in JP, 65D0 in US

---------------------------------------- Verion Dependent ----------------------------------------

-- A0 A1 A2 A3 A4 A5 A6 A7 A8 A9 AA AB AC AD AE AF - ROM Address
-- 52 4F 43 4B 4D 41 4E 5F 45 58 45 00 41 52 45 4A - ROCKMAN_EXE AREJ - JP
-- 4D 45 47 41 4D 41 4E 5F 42 4E 00 00 41 52 45 45 - MEGAMAN_BN  AREE - US
-- 4D 45 47 41 4D 41 4E 45 58 45 42 4E 41 52 45 50 - MEGAMANEXEBNAREP - PAL

local region_byte = memory.read_u8(addresses.region_byte);

if     region_byte == 0x4A then -- J
    addresses.version_name      = "JP";
    addresses.encounter_odds    = 0x08009900;
    addresses.encounter_curve   = 0x08009988;
elseif region_byte == 0x45 then -- E
    addresses.version_name      = "US";
    addresses.encounter_odds    = 0x08009934;
    addresses.encounter_curve   = 0x080099BC;
elseif region_byte == 0x50 then -- P
    addresses.version_name      = "PAL";
    addresses.encounter_odds    = 0x08009940;
    addresses.encounter_curve   = 0x080099C8;
else
    print("\nRAM: Warning! Unrecognized game version! Unable to set certain addresses!");
end

return addresses;

