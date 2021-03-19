-- Functions for MMBN 5 scripting, enjoy.

local game = require("All/Game");

game.number = 5;
game.name = "BN5";

game.ram      = require("BN5/RAM"     );
game.areas    = require("BN5/Areas"   );
game.chips    = require("BN5/Chips"   );
game.enemies  = require("BN5/Enemies" );
game.progress = require("BN5/Progress");

game.fun_flags = {}; -- set in Commands, used in RAM

---------------------------------------- Game State ----------------------------------------

game.state.splash        = 0x00; -- or BIOS or loading
game.state.world_init    = 0x00; -- real and digital
game.state.world         = 0x04; -- real and digital
game.state.battle_init   = 0x08;
game.state.battle        = 0x0C;
game.state.transition    = 0x14; -- jack-in / out
game.state.title         = 0x1C;
game.state.menu          = 0x1C;
game.state.liberation    = 0x18;
game.state.shop          = 0x28;

game.game_state_names[0x00] = "World Init";
game.game_state_names[0x04] = "World";
game.game_state_names[0x08] = "Battle Init";
game.game_state_names[0x0C] = "Battle";
game.game_state_names[0x10] = "Map Change";
game.game_state_names[0x14] = "Player Change";
game.game_state_names[0x18] = "Liberation";
game.game_state_names[0x1C] = "Menu";
game.game_state_names[0x20] = "BBS";
game.game_state_names[0x28] = "Shop";
game.game_state_names[0x2C] = "Liberation Init";
game.game_state_names[0x30] = "Chip Trader";

function game.in_liberation()
    return game.ram.get.game_state() == game.state.liberation;
end

--game.state.game_over     = 0xFF;
--game.state.chip_trader   = 0xFF;
--game.state.request_board = 0xFF;
--game.state.load_navicust = 0xFF;
--game.state.credits       = 0xFF;

-- Battle Mode

function game.in_chip_select()
    return (true);
end

function game.in_combat()
    return (false);
end

-- Battle State

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

-- Menu State

function game.in_folder()
    return game.in_menu_folder_edit() and (true);
end

function game.in_pack()
    return game.in_menu_folder_edit() and (false);
end

---------------------------------------- Battle Chips ----------------------------------------

function game.count_library()
    local count = 0;
    for i=0,0x1F do -- TODO: determine total bytes
        count = count + game.bit_counter(game.ram.get.library(i));
    end
    return count;
end

function game.simulate_folder_shuffle()
    local seed = game.ram.get.lazy_RNG_value();

    -- TODO: Determine actual number of seeds to advance.
    for i=0,247 do
        seed = game.ram.simulate_RNG(seed);
    end

    local draw_slots = game.ram.shuffle_folder_simulate_from_value(seed, 30);
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
    --game.title_screen_A();
    
    if fun_flags.randomize_colors then
        if game.did_game_state_change() or game.did_menu_mode_change() or game.did_area_change() then game.doit_later[emu.framecount()+5] = game.randomize_color_palette; end
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

---------------------------------------- GMD Generation ----------------------------------------

function game.on_spawn_gmds()
    local r14 = emu.getregister("R14");
    if r14 ~= 0x8004b01 then
        local RNG_value = game.ram.get.main_RNG_value();

        game.ram.generate_gmds_simulate_from_value(RNG_value);
    end
end

if game.on_spawn_gmds and game.ram.addr.gmd_function then
    event.onmemoryexecute(game.on_spawn_gmds, game.ram.addr.gmd_function);
end

---------------------------------------- Module Controls ----------------------------------------

function game.initialize(options)
    require("All/Settings").set_display_text("gui"); -- TODO: Remove when gui.text fully supported
    game.ram.initialize(options);
end

function game.pre_update(options)
    options.fun_flags = game.fun_flags;
    game.ram.pre_update(options);
    game.use_fun_flags(game.fun_flags);
end

function game.post_update(options)
    game.update();
    game.ram.post_update(options);
end

return game;

