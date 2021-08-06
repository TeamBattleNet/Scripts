-- Common Functions for MMBN scripting, enjoy.

local game = {};

game.ram      = {}; -- overridden later
game.areas    = {}; -- overridden later
game.chips    = {}; -- overridden later
game.enemies  = {}; -- overridden later
game.progress = {}; -- overridden later

---------------------------------------- Game State ----------------------------------------

-- Style Info

game.styles = {"Guts", "Cust", "Team", "Shld", "Grnd", "Shdw", "Bug"};
game.style_names = {};
game.style_names[0x00] = "Norm"; -- 000b
game.style_names[0x01] = "Guts"; -- 001b
game.style_names[0x02] = "Cust"; -- 010b
game.style_names[0x03] = "Team"; -- 011b
game.style_names[0x04] = "Shld"; -- 100b
game.style_names[0x05] = "Grnd"; -- 101b HubStyle in BN 2
game.style_names[0x06] = "Shdw"; -- 110b looks cursed in BN 2
game.style_names[0x07] = "Bug";  -- 111b looks cursed in BN 2

function game.get_style_name(style)
    return game.style_names[style] or "????";
end

game.elements = {"Elec", "Heat", "Aqua", "Wood"};
game.element_names = {}; -- FWEG but Elec is first
game.element_names[0x00] = "None"; -- 000b looks like wood
game.element_names[0x01] = "Elec"; -- 001b
game.element_names[0x02] = "Heat"; -- 010b
game.element_names[0x03] = "Aqua"; -- 011b
game.element_names[0x04] = "Wood"; -- 100b
game.element_names[0x05] = "Shok"; -- 101b looks like elec, weak to normal, no charge shot
game.element_names[0x06] = "Haet"; -- 110b looks like heat, weak to normal, charge shot crashes game
game.element_names[0x07] = "Agua"; -- 111b looks like aqua, takes 62x damage, no charge shot

function game.get_element_name(element)
    return game.element_names[element] or "????";
end

-- Game Info

function game.get_version_name()
    return game.ram.version_name;
end

function game.get_play_time()
    return game.ram.get.play_time();
end

function game.set_play_time(new_play_time)
    game.ram.set.play_time(new_play_time);
end

function game.get_power_on_frames()
    return game.ram.get.power_on_frames();
end

function game.set_power_on_frames(new_power_on_frames)
    return game.ram.set.power_on_frames(new_power_on_frames);
end

-- Progress

function game.get_progress()
    return game.ram.get.progress();
end

function game.get_progress_name(progress_value)
    return game.progress[progress_value] or "Unknown Progress Value";
end

function game.get_progress_name_current()
    return game.get_progress_name(game.get_progress());
end

function game.is_progress_valid(progress_value)
    return game.progress[progress_value];
end

function game.set_progress(new_progress)
    game.ram.set.progress(new_progress);
end

function game.set_progress_safe(new_progress)
    if game.is_progress_valid(new_progress) then
        game.set_progress(new_progress);
    end
end

-- Game Mode

game.state = { title=0x00 }; -- defined per game

function game.in_title()
    return game.ram.get.game_state() == game.state.title;
end

function game.in_world()
    return game.ram.get.game_state() == game.state.world;
end

function game.in_battle()
    return game.ram.get.game_state() == game.state.battle;
end

function game.in_transition()
    return game.ram.get.game_state() == game.state.transition;
end

function game.in_splash()
    return (game.ram.get.game_state() == game.state.splash or game.ram.get.game_state() == game.state.splash_pal);
end

function game.in_menu()
    return game.ram.get.game_state() == game.state.menu;
end

function game.in_shop()
    return game.ram.get.game_state() == game.state.shop;
end

function game.in_game_over()
    return game.ram.get.game_state() == game.state.game_over;
end

function game.in_chip_trader()
    return game.ram.get.game_state() == game.state.chip_trader;
end

function game.in_request_board()
    return game.ram.get.game_state() == game.state.request_board;
end

function game.in_loading_navicust()
    return game.ram.get.game_state() == game.state.load_navicust;
end

function game.in_credits()
    return game.ram.get.game_state() == game.state.credits;
end

-- Menu Mode

game.menu = {}; -- defined per game

function game.in_menu_folder_select()
    return game.ram.get.menu_mode() == game.menu.folder_select;
end

function game.in_menu_subchips()
    return game.ram.get.menu_mode() == game.menu.subchips;
end

function game.in_menu_library()
    return game.ram.get.menu_mode() == game.menu.library;
end

function game.in_menu_megaman()
    return game.ram.get.menu_mode() == game.menu.megaman;
end

function game.in_menu_email()
    return game.ram.get.menu_mode() == game.menu.email;
end

function game.in_menu_keyitems()
    return game.ram.get.menu_mode() == game.menu.key_items;
end

function game.in_menu_network()
    return game.ram.get.menu_mode() == game.menu.network;
end

function game.in_menu_save()
    return game.ram.get.menu_mode() == game.menu.save;
end

function game.in_menu_navicust()
    return game.ram.get.menu_mode() == game.menu.navicust;
end

function game.in_menu_folder_edit()
    return game.ram.get.menu_mode() == game.menu.folder_edit;
end

function game.in_menu_folder()
    return (game.in_menu_folder_select() or game.in_menu_folder_edit());
end

-- State Names (skip 2 bits, add 1)

game.game_state_names = {};
function game.get_game_state_name()
    return game.game_state_names[game.ram.get.game_state()] or "Unknown Game State";
end

game.battle_mode_names = {};
function game.get_battle_mode_name()
    return game.battle_mode_names[game.ram.get.battle_mode()] or "Unknown Battle Mode";
end

game.battle_state_names = {};
function game.get_battle_state_name()
    return game.battle_state_names[game.ram.get.battle_state()] or "Unknown Battle State";
end

game.menu_mode_names = {};
function game.get_menu_mode_name()
    return game.menu_mode_names[game.ram.get.menu_mode()] or "Unknown Menu Mode";
end

game.menu_state_names = {};
function game.get_menu_state_name()
    return game.game.menu_state_names[game.ram.get.menu_state()] or "Unknown Menu State";
end

---------------------------------------- State Tracking ----------------------------------------

local previous_progress = 0x00;
function game.did_progress_change()
    return game.get_progress() ~= previous_progress;
end

local previous_magic_byte = 0x00;
function game.did_magic_byte_change()
    return game.ram.get.magic_byte() ~= previous_magic_byte;
end

game.previous_game_state = 0x00;
function game.did_game_state_change()
    return game.ram.get.game_state() ~= game.previous_game_state;
end

function game.did_leave_title_screen()
    return (game.did_game_state_change() and game.previous_game_state == 0x00);
end

local previous_battle_state = 0x00;
function game.did_battle_state_change()
    return game.ram.get.battle_state() ~= previous_battle_state;
end

local previous_battle_pointer = 0x00;
function game.did_load_new_battle()
    return (game.ram.get.battle_pointer() ~= previous_battle_pointer and game.ram.get.battle_pointer() ~= 0x00);
end

local previous_menu_mode = 0x00;
function game.did_menu_mode_change()
    return game.ram.get.menu_mode() ~= previous_menu_mode;
end

local previous_menu_state = 0x00;
function game.did_menu_state_change()
    return game.ram.get.menu_state() ~= previous_menu_state;
end

local previous_main_area = 0x00;
function game.did_main_area_change()
    return game.ram.get.main_area() ~= previous_main_area;
end

local previous_sub_area = 0x00;
function game.did_sub_area_change()
    return game.ram.get.sub_area() ~= previous_sub_area;
end

function game.did_area_change()
    return (game.did_main_area_change() or game.did_sub_area_change());
end

---------------------------------------- RNG Wrapper ----------------------------------------

-- Main RNG

function game.get_main_RNG_value()
    return game.ram.get.main_RNG_value();
end

function game.set_main_RNG_value(new_value)
    game.ram.set.main_RNG_value(new_value);
end

function game.get_main_RNG_index()
    return game.ram.get.main_RNG_index();
end

function game.set_main_RNG_index(new_index)
    game.ram.set.main_RNG_index(new_index);
end

function game.reset_main_RNG()
    game.set_main_RNG_index(1);
end

function game.get_main_RNG_delta()
    return game.ram.get.main_RNG_delta();
end

function game.adjust_main_RNG(steps)
    game.ram.adjust_main_RNG(steps);
end

-- Lazy RNG

function game.get_lazy_RNG_value()
    return game.ram.get.lazy_RNG_value();
end

function game.set_lazy_RNG_value(new_value)
    game.ram.set.lazy_RNG_value(new_value);
end

function game.get_lazy_RNG_index()
    return game.ram.get.lazy_RNG_index();
end

function game.set_lazy_RNG_index(new_index)
    game.ram.set.lazy_RNG_index(new_index);
end

function game.reset_lazy_RNG()
    game.set_lazy_RNG_index(1);
end

function game.get_lazy_RNG_delta()
    return game.ram.get.lazy_RNG_delta();
end

function game.adjust_lazy_RNG(steps)
    game.ram.adjust_lazy_RNG(steps);
end

---------------------------------------- Miscellaneous ----------------------------------------

function game.get_progress_change()
    return string.format("Progress changed from 0x%02X to 0x%02X - %s", previous_progress, game.get_progress(), game.get_progress_name_current());
end

function game.broadcast_magic_byte()
    print("");
    game.broadcast(string.format("MAGIC BYTE 0x%02X changed from  0x%02X     to  0x%02X    !", game.get_magic_addr(), previous_magic_byte, game.get_magic_byte()));
    game.broadcast(string.format("MAGIC BYTE 0x%02X changed from %sb to %sb!", game.get_magic_addr(), game.byte_to_binary(previous_magic_byte), game.byte_to_binary(game.get_magic_byte())));
    print("");
end

---------------------------------------- Module Controls ----------------------------------------

function game.track_game_state()
    previous_progress       = game.ram.get.progress();
    previous_magic_byte     = game.ram.get.magic_byte();
    game.previous_game_state     = game.ram.get.game_state();
    previous_battle_state   = game.ram.get.battle_state();
    previous_battle_pointer = game.ram.get.battle_pointer();
    previous_menu_mode      = game.ram.get.menu_mode();
    previous_menu_state     = game.ram.get.menu_state();
    previous_main_area      = game.ram.get.main_area();
    previous_sub_area       = game.ram.get.sub_area();
end

return game;

