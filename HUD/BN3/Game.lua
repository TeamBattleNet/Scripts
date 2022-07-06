-- Functions for MMBN 3 scripting, enjoy.

local game = require("All/Game");

game.number = 3;
game.name = "BN3";

game.ram      = require("BN3/RAM"     );
game.areas    = require("BN3/Areas"   );
game.chips    = require("BN3/Chips"   );
game.enemies  = require("BN3/Enemies" );
game.progress = require("BN3/Progress");

game.fun_flags = {}; -- set in Commands, used in RAM

--- Check if the game version is EXE3 vanilla / MMBN3 White.
-- @return true if version is vanilla / White, otherwise false
function game.is_version_white()
    return game.ram.addr.version_white
end

--- Check if the game version is EXE3 Black / MMBN3 Blue.
-- @return true if version is Black / Blue, otherwise false
function game.is_version_blue()
    return game.ram.addr.version_blue
end

---------------------------------------- Game State ----------------------------------------

-- Game Mode

game.state.title         = 0x00; -- or BIOS
game.state.world         = 0x04; -- real and digital
game.state.battle        = 0x08;
game.state.transition    = 0x0C; -- jack-in / out
game.state.demo_end      = 0x10; -- what is this?
game.state.splash        = 0x14;
game.state.menu          = 0x18;
game.state.shop          = 0x1C;
game.state.game_over     = 0x20;
game.state.chip_trader   = 0x24;
game.state.request_board = 0x28;
game.state.load_navicust = 0x2C; -- new
game.state.credits       = 0x30;

game.game_state_names[0x00] = "Title";
game.game_state_names[0x04] = "World";
game.game_state_names[0x08] = "Battle";
game.game_state_names[0x0C] = "Player Change";
game.game_state_names[0x10] = "Demo End";
game.game_state_names[0x14] = "Capcom Logo";
game.game_state_names[0x18] = "Menu";
game.game_state_names[0x1C] = "Shop";
game.game_state_names[0x20] = "GAME OVER";
game.game_state_names[0x24] = "Chip Trader";
game.game_state_names[0x28] = "Request Board";
game.game_state_names[0x2C] = "Loading NaviCust?";
game.game_state_names[0x30] = "Credits";

-- Battle Mode

game.battle_mode_names[0x00] = "Loading";
game.battle_mode_names[0x03] = "Chip Select & Reward";
game.battle_mode_names[0x12] = "Loading";
game.battle_mode_names[0x13] = "First Chip Select";
game.battle_mode_names[0xCF] = "Time Stop";
game.battle_mode_names[0xEF] = "Combat";

function game.in_chip_select()
    return (game.ram.get.battle_mode() == 0x03 or game.ram.get.battle_mode() == 0x13);
end

function game.in_combat()
    return (game.ram.get.battle_mode() == 0xCF or game.ram.get.battle_mode() == 0xEF);
end

-- Battle State

game.battle_state_names[0x00] = "Waiting";
game.battle_state_names[0x02] = "Time Stop";
game.battle_state_names[0x03] = "Time Stop Name";
game.battle_state_names[0x41] = "ENEMY DELETED!";
game.battle_state_names[0x42] = "Combat";
game.battle_state_names[0x43] = "BATTLE START!";
game.battle_state_names[0x4A] = "PAUSE";

-- Menu Mode

game.menu.folder_select = 0x00;
game.menu.subchips      = 0x04;
game.menu.library       = 0x08;
game.menu.megaman       = 0x0C;
game.menu.email         = 0x10;
game.menu.key_items     = 0x14;
game.menu.network       = 0x18;
game.menu.save          = 0x1C;
game.menu.navicust      = 0x20;
game.menu.folder_edit   = 0x24;

game.menu_mode_names[0x00] = "Folder Select";
game.menu_mode_names[0x04] = "Sub Chips";
game.menu_mode_names[0x08] = "Library";
game.menu_mode_names[0x0C] = "MegaMan";
game.menu_mode_names[0x10] = "E-Mail";
game.menu_mode_names[0x14] = "Key Items";
game.menu_mode_names[0x18] = "Network";
game.menu_mode_names[0x1C] = "Save";
game.menu_mode_names[0x20] = "NaviCust";
game.menu_mode_names[0x24] = "Folder Edit";

-- Menu State

game.menu_state_names[0x04] = "Editing Folder";
game.menu_state_names[0x08] = "Editing Pack";
game.menu_state_names[0x0C] = "Exiting";
game.menu_state_names[0x10] = "To Folder";
game.menu_state_names[0x14] = "To Pack";
game.menu_state_names[0x18] = "Sorting Folder";
game.menu_state_names[0x1C] = "Sorting Pack";

function game.in_folder()
    return game.in_menu_folder_edit() and (game.ram.get.menu_state() == 0x04 or game.ram.get.menu_state() == 0x18);
end

function game.in_pack()
    return game.in_menu_folder_edit() and (game.ram.get.menu_state() == 0x08 or game.ram.get.menu_state() == 0x1C);
end

game.previous_gamble_win = 255;
game.gamble_panels = {"Bottom Left", "Top Left", "Top Right", "Bottom Right"};

game.elements = {"Elec","Heat","Aqua","Wood"};

----------------------------------------Mega Modifications ----------------------------------------

function game.set_style(style)
	local current_style = game.ram.get.style_active();
	local level = bit.band(current_style, 0xC0);
	local element = bit.band(current_style, 0x07);
	game.ram.set.style_stored(level + bit.lshift(style, 3) + element);
    return game.ram.set.style_active(level + bit.lshift(style, 3) + element);
end

function game.set_style_element(element)
	local current_style = game.ram.get.style_active();
	local level = bit.band(current_style, 0xC0);
	local style = bit.band(current_style, 0x38);
	game.ram.set.style_stored(level + style + element);
    return game.ram.set.style_active(level + style + element);
end

function game.get_next_element()
    return game.elements[game.ram.get.next_element() % 256] or "??";
end

function game.get_style_type()
    return bit.rshift(bit.band(game.ram.get.style_active(), 0x38), 3);
end
--[[

function game.get_current_element()
    return bit.band(memory.read_u8(style_stored), 0x07);
end

function game.get_style_name()
    return ram.get_current_element_name() .. ram.get_style_type_name();
end

function game.get_next_element()
    return memory.read_u8(next_element);
end

function game.get_next_element_name()
    return style_elements[ram.get_next_element()] or "????";
end

function game.set_next_element(new_next_element)
    return memory.write_u8(next_element, bit.band(new_next_element, 0x07));
end

function game.get_battle_count()
    return memory.read_u8(battle_count);
end

function game.set_battle_count(new_battle_count)
    return memory.write_u8(battleCount, new_battle_count);
end

function game.add_battle_count(some_battles)
    return ram.set_battle_count(ram.get_battle_count() + some_battles);
end

--]]

---------------------------------------- Flags ----------------------------------------

function game.get_fire_flags()
    return game.ram.get.fire_flags();
end

function game.set_fire_flags(fire_flags)
    game.ram.set.fire_flags(fire_flags);
end

function game.get_magic_byte()
    return 0x00; -- game.ram.get.magic_byte();
end

function game.is_go_mode()
    return false; -- (game.ram.get.progress() == 0x47 and bit.band(game.get_magic_byte(), 0x04) > 0);
end

---------------------------------------- Draw Slots ----------------------------------------

function game.shuffle_folder_simulate_from_battle(offset)
    local lazy_RNG_index = game.get_lazy_RNG_index();
    if lazy_RNG_index ~= nil then
        offset = offset or 0;
        return game.shuffle_folder_simulate_from_lazy_index(lazy_RNG_index-60+1+offset, 30);
    end
end

---------------------------------------- Styles ----------------------------------------

--- Calculate total Guts Style points gained during a battle.
-- @return number of points
function game.calc_battle_guts_points()
    if game.get_style_type() == 1 then
        return 0;
    else
        local pts =  1 * memory.read_u8(game.ram.addr.count_used_mega_buster);
        pts = pts + 10 * memory.read_u8(game.ram.addr.count_used_charge_shot);
        pts = pts +  1 * memory.read_u8(game.ram.addr.count_flinched);
        pts = pts + 30 * memory.read_u8(game.ram.addr.count_used_guts_mg);
        return pts;
    end
end

--- Calculate total Custom Style points gained during a battle.
-- @return number of points
function game.calc_battle_custom_points()
    if game.get_style_type() == 2 then
        return 0;
    else
        local pts =  5 * memory.read_u8(game.ram.addr.count_sent_2_chips);
        pts = pts + 20 * memory.read_u8(game.ram.addr.count_sent_3_chips);
        pts = pts + 50 * memory.read_u8(game.ram.addr.count_sent_4_chips);
        pts = pts + 70 * memory.read_u8(game.ram.addr.count_sent_5_chips);
        pts = pts + 20 * memory.read_u8(game.ram.addr.count_formed_pas);
        pts = pts + 30 * memory.read_u8(game.ram.addr.count_used_add);
        return pts;
    end
end

--- Calculate total Team Style points gained during a battle.
-- @return number of points
function game.calc_battle_team_points()
    if game.get_style_type() == 3 then
        return 0;
    else
        local count = memory.read_u8(game.ram.addr.count_sent_navi_chips);
        local pts = 0;
        if count >= 1 then
            pts = pts + 45;
        end
        if count >= 2 then
            pts = pts + 50;
        end
        if count >= 3 then
            pts = pts + 40 * (count - 2);
        end
        return pts;
    end
end

--- Calculate total Shield Style points gained during a battle.
-- @return number of points
function game.calc_battle_shield_points()
    if game.get_style_type() == 4 then
        return 0;
    else
        local pts = 55 * memory.read_u8(game.ram.addr.count_used_guard_chips);
        pts = pts + 55 * memory.read_u8(game.ram.addr.count_used_barr_chips);
        pts = pts + 40 * memory.read_u8(game.ram.addr.count_used_recov_chips);
        pts = pts + 20 * memory.read_u8(game.ram.addr.count_used_block);
        pts = pts + 20 * memory.read_u8(game.ram.addr.count_used_shield);
        pts = pts + 20 * memory.read_u8(game.ram.addr.count_used_reflect);
        if memory.read_u8(game.ram.addr.count_flinched) == 0 then
            pts = pts + 1;
        end
        return pts;
    end
end

--- Calculate total Ground Style points gained during a battle.
-- @return number of points
function game.calc_battle_ground_points()
    if game.get_style_type() == 5 then
        return 0;
    else
        local pts = 70 * memory.read_u8(game.ram.addr.count_used_field_chips);
        pts = pts + 70 * memory.read_u8(game.ram.addr.count_used_crack_chips);
        return pts
    end
end

--- Calculate total Shadow Style points gained during a battle.
-- @return number of points
function game.calc_battle_shadow_points()
    if game.get_style_type() == 6 then
        return 0;
    else
        local pts = 70 * memory.read_u8(game.ram.addr.count_used_invul_chips);
        pts = pts + 70 * memory.read_u8(game.ram.addr.count_used_invis_pwr);
        return pts;
    end
end

--- Calculate total Bug Style points gained during a battle.
-- @return number of points
function game.calc_battle_bug_points()
    if game.get_style_type() == 7 then
        return 0;
    else
        local pts = 20 * memory.read_u8(game.ram.addr.count_turns_bug_lv1);
        pts = pts + 30 * memory.read_u8(game.ram.addr.count_turns_bug_lv2);
        pts = pts + 40 * memory.read_u8(game.ram.addr.count_turns_bug_lv3);
        return pts;
    end
end

---------------------------------------- Battlechips ----------------------------------------

function game.count_library()
    local count = 0;
    for i=0,0x1F do -- TODO: determine total bytes
        count = count + game.bit_counter(game.ram.get.library(i));
    end
    return count;
end

function game.fill_library_standard()
    game.ram.set_bits   (0x7F, game.ram.addr.library_S_begin      );
    game.ram.write_bytes(0xFF, game.ram.addr.library_S_begin+1, 23);
    game.ram.set_bits   (0x80, game.ram.addr.library_S_end        );
end

function game.fill_library_mega()
    game.ram.set_bits   (0x7F, game.ram.addr.library_M_begin      );
    game.ram.write_bytes(0xFF, game.ram.addr.library_M_begin+1, 10);
    game.ram.set_bits   (0xF8, game.ram.addr.library_M_end        );
end

function game.fill_library_mist_bowl()
    game.ram.set_bits   (0x3D, game.ram.addr.library_mist_bowl_men  );
    game.ram.set_bits   (0xE0, game.ram.addr.library_mist_bowl_men+1);
end

function game.overwrite_folder_press_a()
    game.overwrite_folder_to(1, {
        { ID=211; code=26 }; -- FullCust *
        { ID=114; code= 0 }; -- Volcano A
        { ID=114; code= 0 }; -- Volcano A
        { ID=114; code= 0 }; -- Volcano A
        { ID=114; code= 0 }; -- Volcano A
        { ID=160; code=26 }; -- Invis *
        { ID=160; code=26 }; -- Invis *
        { ID=160; code=26 }; -- Invis *
        { ID=160; code=26 }; -- Invis *
        { ID=125; code=26 }; -- Recov120 *
        { ID=126; code=15 }; -- Recov150 P
        { ID=181; code=26 }; -- GrassStg *
        { ID=181; code=26 }; -- GrassStg *
        { ID=181; code=26 }; -- GrassStg *
        { ID=181; code=26 }; -- GrassStg *
        { ID=195; code=26 }; -- Atk+10 *
        { ID=195; code=26 }; -- Atk+10 *
        { ID=195; code=26 }; -- Atk+10 *
        { ID=195; code=26 }; -- Atk+10 *
        { ID=199; code=26 }; -- Wood+30 *
        { ID=199; code=26 }; -- Wood+30 *
        { ID=199; code=26 }; -- Wood+30 *
        { ID=199; code=26 }; -- Wood+30 *
        { ID=200; code=26 }; -- Navi+20 *
        { ID=208; code=25 }; -- ZeusHamr Z
        { ID=252; code=15 }; -- PlantMan V1 P
        { ID=253; code=15 }; -- PlantMan V2 P
        { ID=254; code=15 }; -- PlantMan V3 P
        { ID=255; code=15 }; -- PlantMan V4 P
        { ID=256; code=15 }; -- PlantMan V5 P
    });
end

function game.overwrite_folder_manip()
    game.overwrite_folder_to(1, {
        { ID=199; code=26 }; -- 01  Wood+30 *
        { ID= 38; code= 1 }; -- 02  VarSwrd B
        { ID= 38; code= 1 }; -- 03  VarSwrd B
        { ID= 40; code=17 }; -- 04 StepCros R
        { ID= 38; code= 3 }; -- 05  VarSwrd D
        { ID= 40; code=17 }; -- 06 StepCros R
        { ID=195; code=26 }; -- 07   Atk+10 *
        { ID= 38; code= 1 }; -- 08  VarSwrd B
        { ID= 39; code=15 }; -- 09 StepSwrd P
        { ID=194; code=26 }; -- 10  CopyDmg *
        { ID=141; code=26 }; -- 11 RockCube *
        { ID=160; code=26 }; -- 12    Invis *
        { ID=160; code=26 }; -- 13    Invis *
        { ID=160; code=26 }; -- 14    Invis *
        { ID=160; code=26 }; -- 15    Invis *
        { ID=207; code=15 }; -- 16 HeroSwrd P
        { ID=  4; code=26 }; -- 17 AirShot1 *
        { ID= 48; code=14 }; -- 18 GutStrgt O
        { ID= 48; code=14 }; -- 19 GutStrgt O
        { ID=194; code=26 }; -- 20  CopyDmg *
        { ID=110; code=17 }; -- 21   Shake1 R
        { ID=194; code=26 }; -- 22  CopyDmg *
        { ID= 36; code=15 }; -- 23 BambSwrd P
        { ID= 43; code= 3 }; -- 24  Slasher D
        { ID=195; code=26 }; -- 25   Atk+10 *
        { ID=195; code=26 }; -- 26   Atk+10 *
        { ID=  4; code=26 }; -- 27 AirShot1 *
        { ID=  4; code=26 }; -- 28 AirShot1 *
        { ID=  4; code=26 }; -- 29 AirShot1 *
        { ID= 48; code=14 }; -- 30 GutStrgt O
    });
end

---------------------------------------- Miscellaneous ----------------------------------------

function game.is_sneakrun_bugged()
    return game.ram.get.bug_run() > 0;
end

function game.get_GMD_value()
    return game.ram.get.GMD_value();
end

function game.get_GMD_RNG()
    return game.ram.get.GMD_RNG();
end

function game.get_GMD_RNG_lower()
    return bit.band(game.get_GMD_RNG(), 0xFF);
end

function game.set_GMD_RNG(new_GMD_RNG)
    game.ram.set.GMD_RNG(new_GMD_RNG);
end

function game.randomize_GMD_RNG()
    game.set_GMD_RNG(game.get_main_RNG_value());
end

function game.get_GMD_RNG_index()
    return game.ram.get.main_RNG_index_of(game.get_GMD_RNG());
end

local previous_GMD_p1 = 0;
local previous_GMD_p2 = 0;
function game.did_GMD_spawn()
    if     game.ram.get.GMD_1_xy() + game.ram.get.GMD_1_yx() ~= previous_GMD_p1 and previous_GMD_p1 == 0x0800 then
        return true;
    elseif game.ram.get.GMD_2_xy() + game.ram.get.GMD_2_yx() ~= previous_GMD_p2 and previous_GMD_p2 == 0x0800 then
        return true;
    end
    return false;
end

function game.get_GMD_spawns()
    local MRNG_Index = game.get_main_RNG_index();
    local GMD_1_xy = game.ram.get.GMD_1_xy();
    local GMD_1_yx = game.ram.get.GMD_1_yx();
    local GMD_2_xy = game.ram.get.GMD_2_xy();
    local GMD_2_yx = game.ram.get.GMD_2_yx();
    return string.format("%04u: GMDs spawned at 0x%04x 0x%04x and 0x%04x 0x%04x",
        MRNG_Index or 0, GMD_1_xy, GMD_1_yx, GMD_2_xy, GMD_2_yx);
end

--        vv vtv               i iii      
-- 0000 0000 0000 0000 0000 0000 0000 0000

function game.get_GMD_is_virus()
    return bit.band(game.get_GMD_RNG(), 0x03A00000) >= 0; -- this is wrong!
end

function game.get_GMD_is_chips()
    return bit.band(game.get_GMD_RNG(), 0x00400000) == 0;
end

function game.get_GMD_is_zenny()
    return not game.get_GMD_is_chips();
end

function game.get_GMD_index_from_value(GMD_RNG)
    local GMD_index = bit.rshift(GMD_RNG, 5) % 16 + 1;
    if game.get_GMD_is_zenny() then
        return GMD_index + 16;
    end
    return GMD_index;
end

function game.get_GMD_index()
    return game.get_GMD_index_from_value(game.get_GMD_RNG());
end

function game.set_GMD_index(new_GMD_index)
    local GMD_index = bit.lshift((new_GMD_index - 1) % 16, 5);
    if new_GMD_index > 16 then
        GMD_index = bit.bor(GMD_index, 0x00400000);
    end
    game.set_GMD_RNG(GMD_index);
end

function game.increase_GMD_index()
    game.set_GMD_index(game.get_GMD_index()+1);
end

function game.decrease_GMD_index()
    game.set_GMD_index(game.get_GMD_index()-1);
end

function game.get_gamble_pick()
    return game.ram.get.gamble_pick();
end

function game.get_gamble_win()
    return game.ram.get.gamble_win();
end

function game.get_previous_gamble_win()
    return game.previous_gamble_win;
end

function game.get_gamble_panel_pick()
    return game.gamble_panels[game.get_gamble_pick()+1] or "??";
end

function game.get_gamble_panel_win()
    return game.gamble_panels[game.get_gamble_win()+1] or "??";
end

function game.is_gambling()
    return game.get_main_area() == 0x8C and -- Sub Comps
          (game.get_sub_area() == 0x02 or   -- Vending Comp (SciLab)
           game.get_sub_area() == 0x08 or   -- TV Board Comp
           game.get_sub_area() == 0x0C );   -- Vending Comp (Hospital)
end

function game.in_Secret_3()
    return (game.get_main_area() == 0x95 and game.get_sub_area() == 0x02);
end

---------------------------------------- Fun Flags  ----------------------------------------

function game.title_screen_A()
    if game.did_leave_title_screen() then
        print("");
        local lazy_RNG_index = game.get_lazy_RNG_index();
        local main_RNG_index = game.get_main_RNG_index();
        local on_A_RNG_index = (main_RNG_index and main_RNG_index - 17);
        game.broadcast(string.format("%u: Pressed A on M RNG Index %s", emu.framecount(), on_A_RNG_index or "?????"));
        game.broadcast(string.format("%u: Loaded in on M RNG Index %s", emu.framecount(), main_RNG_index or "?????"));
        game.broadcast(string.format("%u: Loaded in on L RNG Index %s", emu.framecount(), lazy_RNG_index or "?????"));
    end
end

function game.use_fun_flags(fun_flags) -- TODO: Rename
    game.title_screen_A();
    
    if fun_flags.randomize_colors then
        if game.did_game_state_change() or game.did_menu_mode_change() or game.did_area_change() then game.doit_later[emu.framecount()+5] = game.randomize_color_palette; end
    end
    
    if fun_flags.maybe_encounters then
        fun_flags.encounter_threshold = game.get_encounter_threshold_specific(fun_flags.test_level);
    end
    
    if fun_flags.is_routing and not game.in_title() then
        if game.did_progress_change() then
            game.broadcast(game.get_progress_change());
        end
        
        if game.did_magic_byte_change() then
            game.broadcast_magic_byte();
        end
    end
end

---------------------------------------- State Tracking ----------------------------------------

function game.track_game_state_bn3()
    if game.did_GMD_spawn() then
        print(game.get_GMD_spawns());
    end
    previous_GMD_p1 = game.ram.get.GMD_1_xy() + game.ram.get.GMD_1_yx();
    previous_GMD_p2 = game.ram.get.GMD_2_xy() + game.ram.get.GMD_2_yx();
    
    if  game.previous_gamble_win ~= game.get_gamble_win() then
        game.previous_gamble_win  = game.get_gamble_win();
        local MRNG_Index = game.get_main_RNG_index();
        if game.get_gamble_win() ~= 255 and MRNG_Index then
            print(string.format("New Gamble Option: %4s -> %4s: %d %s",
                MRNG_Index - 1 - 195,
                MRNG_Index - 1,
                game.get_gamble_win(),
                game.get_gamble_panel_win()
            ));
        end
    end
end

---------------------------------------- Module Controls ----------------------------------------

function game.initialize(options)
    game.ram.initialize(options);
    require("All/Settings").set_display_text("gui"); -- TODO: Remove when gui.text fully supported
end

function game.pre_update(options)
    options.fun_flags = game.fun_flags;
    game.ram.pre_update(options);
    game.use_fun_flags(game.fun_flags);
end

function game.post_update(options)
    game.track_game_state_bn3();
    game.ram.post_update(options);
end

return game;

