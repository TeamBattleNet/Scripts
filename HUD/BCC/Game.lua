-- Functions for MMBN 1 scripting, enjoy.

local game = require("All/Game");

game.number = 0;
game.name = "BCC";

game.ram      = require("BCC/RAM"     );
game.areas    = require("BCC/Areas"   );
game.chips    = require("BCC/Chips"   );
game.enemies  = require("BCC/Enemies" );
game.progress = require("BCC/Progress");

game.fun_flags = {}; -- set in Commands, used in RAM

---------------------------------------- Game State ----------------------------------------

-- TODO: Copied from BN 1

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
game.state.credits       = 0x28;
game.state.splash_pal    = 0x2C; -- Ubisoft Logo (PAL only)

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
game.game_state_names[0x28] = "Credits";
game.game_state_names[0x2C] = "Ubisoft Logo";

-- Battle Mode

game.battle_mode_names[0x00] = "Loading";
game.battle_mode_names[0x04] = "Chip Select";
game.battle_mode_names[0x08] = "Combat";
game.battle_mode_names[0x0C] = "Reward";

function game.in_chip_select()
    return game.ram.get.battle_mode() == 0x04;
end

function game.in_combat()
    return game.ram.get.battle_mode() == 0x08;
end

-- Battle State

game.battle_state_names[0x00] = "Loading";
game.battle_state_names[0x04] = "Busy";
game.battle_state_names[0x08] = "Transition";
game.battle_state_names[0x0C] = "Combat";
game.battle_state_names[0x10] = "PAUSE";
game.battle_state_names[0x14] = "Time Stop";
game.battle_state_names[0x18] = "Opening Custom";

-- Menu Mode

game.menu.folder_select = 0x00;
game.menu.library       = 0x04;
game.menu.megaman       = 0x08;
game.menu.email         = 0x0C;
game.menu.key_items     = 0x10;
game.menu.network       = 0x14;
game.menu.save          = 0x18;
game.menu.folder_edit   = 0x00;

game.menu_mode_names[0x00] = "Folder";
game.menu_mode_names[0x04] = "Library";
game.menu_mode_names[0x08] = "MegaMan";
game.menu_mode_names[0x0C] = "E-Mail";
game.menu_mode_names[0x10] = "Key Items";
game.menu_mode_names[0x14] = "Network";
game.menu_mode_names[0x18] = "Save";

-- Menu State

game.menu_state_names[0x04] = "Editing";
game.menu_state_names[0x14] = "Sorting";
game.menu_state_names[0x10] = "To Pack";
game.menu_state_names[0x0C] = "To Folder";
game.menu_state_names[0x08] = "Exiting";

function game.in_folder()
    return game.ram.get.folder_to_pack() == 0x20;
end

function game.in_pack()
    return game.ram.get.folder_to_pack() == 0x02;
end

---------------------------------------- Inventory ----------------------------------------

---------------------------------------- Battlechips ----------------------------------------

function game.count_library()
    local count = 0;
    for i=0,0x1F do -- TODO: 243 (244?) Library Chips
        count = count + game.bit_counter(game.ram.get.library(i));
    end
    return count;
end

---------------------------------------- Miscellaneous ----------------------------------------

---------------------------------------- Fun Flags  ----------------------------------------

function game.title_screen_A()
    if game.did_leave_title_screen() then
        print(string.format("\nCONTINUE fade out on frame: %u", emu.framecount())); -- 17 frames after A?
    end
end

function game.randomize_color_palette()
    for offset=0,0x1FF do -- TBD
        game.ram.set.color_palette(offset, math.random(0x00, 0xFF));
    end
end

function game.use_fun_flags(fun_flags) -- TODO: Rename
    game.title_screen_A();
    
    if fun_flags.randomize_colors then
        if game.did_game_state_change() or game.did_menu_mode_change() or game.did_area_change() then game.doit_later[emu.framecount()+5] = game.randomize_color_palette; end
    end
end

---------------------------------------- Module Controls ----------------------------------------

function game.initialize(options)
    game.ram.initialize(options);
    require("All/Settings").set_display_text("gui");
end

function game.pre_update(options)
    options.fun_flags = game.fun_flags;
    game.ram.pre_update(options);
    game.use_fun_flags(game.fun_flags);
end

function game.post_update(options)
    game.update(); --game.track_game_state();
    game.ram.post_update(options);
end

return game;

