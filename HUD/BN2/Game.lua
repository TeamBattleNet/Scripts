-- Functions for MMBN 2 scripting, enjoy.

local game = require("All/Game");

game.number = 2;

game.ram      = require("BN2/RAM"     );
game.areas    = require("BN2/Areas"   );
game.chips    = require("BN2/Chips"   );
game.enemies  = require("BN2/Enemies" );
game.progress = require("BN2/Progress");

game.fun_flags = {}; -- set in Commands, used in RAM

---------------------------------------- Game State ----------------------------------------

-- Game Mode

game.game_state_names[0x00] = "Title";         -- or BIOS
game.game_state_names[0x04] = "World";         -- real and digital
game.game_state_names[0x08] = "Battle";
game.game_state_names[0x0C] = "Player Change"; -- jack-in / out
game.game_state_names[0x10] = "Demo End";      -- what is this?
game.game_state_names[0x14] = "Capcom Logo";
game.game_state_names[0x18] = "Menu";
game.game_state_names[0x1C] = "Shop";
game.game_state_names[0x20] = "GAME OVER";
game.game_state_names[0x24] = "Chip Trader";
game.game_state_names[0x28] = "Request Board"; -- new
game.game_state_names[0x2C] = "Credits";
game.game_state_names[0x30] = "Unused?";
game.game_state_names[0x34] = "Ubisoft Logo";  -- PAL only

function game.in_title()
    return game.ram.get.game_state() == 0x00;
end

function game.in_world()
    return game.ram.get.game_state() == 0x04;
end

function game.in_battle()
    return game.ram.get.game_state() == 0x08;
end

function game.in_transition()
    return game.ram.get.game_state() == 0x0C;
end

function game.in_splash()
    return (game.ram.get.game_state() == 0x14 or game.ram.get.game_state() == 0x34);
end

function game.in_menu()
    return game.ram.get.game_state() == 0x18;
end

function game.in_shop()
    return game.ram.get.game_state() == 0x1C;
end

function game.in_game_over()
    return game.ram.get.game_state() == 0x20;
end

function game.in_chip_trader()
    return game.ram.get.game_state() == 0x24;
end

function game.in_request_board()
    return game.ram.get.game_state() == 0x28;
end

function game.in_credits()
    return game.ram.get.game_state() == 0x2C;
end

-- Battle Mode

game.battle_mode_names[0x00] = "TBD";
game.battle_mode_names[0x04] = "TBD";
game.battle_mode_names[0x08] = "TBD";
game.battle_mode_names[0x0C] = "TBD";

function game.in_chip_select()
    return game.ram.get.battle_mode() == 0x04;
end

function game.in_combat()
    return game.ram.get.battle_mode() == 0x08;
end

-- Battle State

game.battle_state_names[0x00] = "TBD";
game.battle_state_names[0x04] = "TBD";
game.battle_state_names[0x08] = "TBD";
game.battle_state_names[0x0C] = "TBD";
game.battle_state_names[0x10] = "TBD";
game.battle_state_names[0x14] = "TBD";
game.battle_state_names[0x18] = "TBD";

-- Menu Mode

game.menu_mode_names[0x00] = "Folder Select";
game.menu_mode_names[0x04] = "Sub Chips";
game.menu_mode_names[0x08] = "Library";
game.menu_mode_names[0x0C] = "MegaMan";
game.menu_mode_names[0x10] = "E-Mail";
game.menu_mode_names[0x14] = "Key Items";
game.menu_mode_names[0x18] = "Network";
game.menu_mode_names[0x1C] = "Save";
game.menu_mode_names[0x20] = "Folder Edit";

function game.in_menu_folder_select()
    return game.ram.get.menu_mode() == 0x00;
end

function game.in_menu_subchips()
    return game.ram.get.menu_mode() == 0x04;
end

function game.in_menu_library()
    return game.ram.get.menu_mode() == 0x08;
end

function game.in_menu_megaman()
    return game.ram.get.menu_mode() == 0x0C;
end

function game.in_menu_email()
    return game.ram.get.menu_mode() == 0x10;
end

function game.in_menu_keyitems()
    return game.ram.get.menu_mode() == 0x14;
end

function game.in_menu_network()
    return game.ram.get.menu_mode() == 0x18;
end

function game.in_menu_save()
    return game.ram.get.menu_mode() == 0x1C;
end

function game.in_menu_folder_edit()
    return game.ram.get.menu_mode() == 0x20;
end

function game.in_menu_folder()
    return (game.in_menu_folder_select() or game.in_menu_folder_edit());
end

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

---------------------------------------- Inventory ----------------------------------------

function game.get_PowerUPs()
    return game.ram.get.PowerUP();
end

function game.set_PowerUPs(new_PowerUPs)
    if new_PowerUPs < 0 then
        new_PowerUPs = 0
    elseif new_PowerUPs > 50 then
        new_PowerUPs = 50;
    end
    game.ram.set.PowerUP(new_PowerUPs);
end

function game.add_PowerUPs(some_PowerUPs)
    game.set_PowerUPs(game.get_PowerUPs() + some_PowerUPs);
end

function game.set_bug_frags(new_bug_frags)
    if new_bug_frags < 0 then
        new_bug_frags = 0
    elseif new_bug_frags > 255 then
        new_bug_frags = 255; -- only need 32
    end
    game.ram.set.bug_frags(new_bug_frags);
end

----------------------------------------Mega Modifications ----------------------------------------

function game.calculate_mega_level()
    level = 1; -- starting level
    level = level +     game.ram.get.HPMemory();
    level = level + 4 * game.ram.get.buster_attack();
    level = level + 4 * game.ram.get.buster_rapid();
    level = level + 4 * game.ram.get.buster_charge();
    if game.ram.has_style() then
        level = level + 6;
    end
    return level;
end

function game.reset_styles()
    game.ram.reset_styles();
end

function game.hub_style_level_up()
    game.ram.adjust_hub_style_level(1);
end

function game.hub_style_level_down()
    game.ram.adjust_hub_style_level(-1);
end

function game.set_style_guts()
    game.ram.change_active_style(1);
end

function game.set_style_cust()
    game.ram.change_active_style(2);
end

function game.set_style_team()
    game.ram.change_active_style(3);
end

function game.set_style_shld()
    game.ram.change_active_style(4);
end

function game.set_style_elec()
    game.ram.change_active_element(1);
end

function game.set_style_heat()
    game.ram.change_active_element(2);
end

function game.set_style_aqua()
    game.ram.change_active_element(3);
end

function game.set_style_wood()
    game.ram.change_active_element(4);
end

---------------------------------------- Flags ----------------------------------------

function game.get_ice_flags()
    return game.ram.get.ice_flags();
end

function game.set_ice_flags(ice_flags)
    game.ram.set.ice_flags(ice_flags);
end

---------------------------------------- Draw Slots ----------------------------------------

function game.shuffle_folder_simulate_from_battle(offset)
    local RNG_index = game.get_main_RNG_index();
    if RNG_index ~= nil then
        offset = offset or 0;
        return game.ram.shuffle_folder_simulate_from_main_index(RNG_index-60+1+offset, 30);
    end
end

---------------------------------------- Battlechips ----------------------------------------

function game.count_library()
    local count = 0;
    for i=0,0x20 do -- 33 bytes? (not all are real chips)
        count = count + game.bit_counter(game.ram.get.library(i));
    end
    return count;
end

function game.overwrite_folder_dalus_special()
    game.overwrite_folder_to(1, {
        { ID=111; code=26 }; -- Guard G
        { ID=111; code=26 }; -- Guard G
        { ID=111; code=26 }; -- Guard G
        { ID=111; code=26 }; -- Guard G
        { ID=111; code=26 }; -- Guard G
        { ID= 50; code= 6 }; -- DashAtk G
        { ID= 50; code= 6 }; -- DashAtk G
        { ID= 50; code= 6 }; -- DashAtk G
        { ID= 50; code= 6 }; -- DashAtk G
        { ID= 50; code= 6 }; -- DashAtk G
        { ID=199; code= 6 }; -- GutsManV3 G
        { ID=199; code= 6 }; -- GutsManV3 G
        { ID=199; code= 6 }; -- GutsManV3 G
        { ID=199; code= 6 }; -- GutsManV3 G
        { ID=199; code= 6 }; -- GutsManV3 G
        { ID=152; code=26 }; -- FullCust *
        { ID=152; code=26 }; -- FullCust *
        { ID=152; code=26 }; -- FullCust *
        { ID=152; code=26 }; -- FullCust *
        { ID=152; code=26 }; -- FullCust *
        { ID=188; code=26 }; -- Atk+10 *
        { ID=188; code=26 }; -- Atk+10 *
        { ID=188; code=26 }; -- Atk+10 *
        { ID=188; code=26 }; -- Atk+10 *
        { ID=188; code=26 }; -- Atk+10 *
        { ID=138; code= 5 }; -- Escape
        { ID=138; code= 7 }; -- Escape
        { ID=138; code= 9 }; -- Escape
        { ID=138; code=11 }; -- Escape
        { ID=138; code=13 }; -- Escape
    });
end

function game.overwrite_folder_press_a()
    game.overwrite_folder_to(1, {
        { ID= 19; code=0 }; -- BigBomb
        { ID= 19; code=0 }; -- BigBomb
        { ID= 19; code=0 }; -- BigBomb
        { ID= 19; code=0 }; -- BigBomb
        { ID= 19; code=0 }; -- BigBomb
        { ID= 44; code=0 }; -- Quake3
        { ID= 44; code=0 }; -- Quake3
        { ID= 44; code=0 }; -- Quake3
        { ID= 44; code=0 }; -- Quake3
        { ID= 44; code=0 }; -- Quake3
        { ID= 59; code=0 }; -- Ratton3
        { ID= 59; code=0 }; -- Ratton3
        { ID= 59; code=0 }; -- Ratton3
        { ID= 59; code=0 }; -- Ratton3
        { ID= 59; code=0 }; -- Ratton3
        { ID= 73; code=0 }; -- Satelit3
        { ID= 73; code=0 }; -- Satelit3
        { ID= 73; code=0 }; -- Satelit3
        { ID= 73; code=0 }; -- Satelit3
        { ID= 73; code=0 }; -- Satelit3
        { ID=152; code=0 }; -- FullCust
        { ID=152; code=0 }; -- FullCust
        { ID=152; code=0 }; -- FullCust
        { ID=152; code=0 }; -- FullCust
        { ID=152; code=0 }; -- FullCust
        { ID=202; code=0 }; -- Protoman V3
        { ID=202; code=0 }; -- Protoman V3
        { ID=202; code=0 }; -- Protoman V3
        { ID=202; code=0 }; -- Protoman V3
        { ID=202; code=0 }; -- Protoman V3
    });
end

---------------------------------------- Miscellaneous ----------------------------------------

function game.title_screen_A()
    if game.did_leave_title_screen() then
        print(string.format("\nPressed A on frame: %u", emu.framecount()-17));
    end
end

function game.randomize_color_palette()
    for offset=0,0x3FF do
        game.ram.set.color_palette(offset, math.random(0x00, 0xFF));
    end
end

function game.use_fun_flags(fun_flags)
    if fun_flags.randomize_colors then
        if game.did_game_state_change() or game.did_menu_mode_change() or game.did_area_change() then game.doit_later[emu.framecount()+3] = game.randomize_color_palette; end
    end
end

---------------------------------------- Module Controls ----------------------------------------

local settings = require("All/Settings");

function game.initialize(options)
    settings.set_display_text("gui"); -- TODO: Remove when gui.text fully supported
    game.ram.initialize(options);
end

function game.pre_update(options)
    game.title_screen_A();
    options.fun_flags = game.fun_flags;
    game.ram.pre_update(options);
    game.use_fun_flags(game.fun_flags);
end

function game.post_update(options)
    game.track_game_state();
    game.ram.post_update(options);
end

return game;

