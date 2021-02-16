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

-- Copied from BN 6

game.game_state_names[0x00] = "world_init";
game.game_state_names[0x04] = "world";
game.game_state_names[0x08] = "battle_init";
game.game_state_names[0x0C] = "battle";
game.game_state_names[0x10] = "map_change";
game.game_state_names[0x14] = "player_change";
game.game_state_names[0x18] = "menu";
game.game_state_names[0x1C] = "bbs";
game.game_state_names[0x20] = "shop";
game.game_state_names[0x24] = "trader";
game.game_state_names[0x30] = "request_bbs";
game.game_state_names[0x34] = "mailbox";
game.game_state_names[0x38] = "chargeman_minigame";

game.battle_state_names[0x00] = "loading";
game.battle_state_names[0x04] = "busy";
game.battle_state_names[0x08] = "combat";
game.battle_state_names[0x1C] = "PAUSE";
game.battle_state_names[0x20] = "opening_custom";
game.battle_state_names[0x24] = "custom";

game.menu_state_names[0x04] = "editing";
game.menu_state_names[0x14] = "sorting";
game.menu_state_names[0x10] = "to_pack";
game.menu_state_names[0x0C] = "to_folder";
game.menu_state_names[0x08] = "exited";

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
    
    if fun_flags.is_routing and not game.in_title() then
        if game.did_progress_change() then
            game.broadcast(game.get_progress_change());
        end
        
        if game.did_magic_byte_change() then
            game.broadcast_magic_byte();
        end
    end
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

