-- Functions for MMBN 6 scripting, enjoy.

local game = require("All/Game");

game.number = 6;
game.name = "BN6";

game.ram      = require("BN6/RAM"     );
game.areas    = require("BN6/Areas"   );
game.chips    = require("BN6/Chips"   );
game.enemies  = require("BN6/Enemies" );
game.progress = require("BN6/Progress");

game.fun_flags = {}; -- set in Commands, used in RAM

---------------------------------------- Game State ----------------------------------------

-- Game Mode

game.state.title         = 0x00; -- or BIOS
game.state.world         = 0x04; -- real and digital
game.state.battle        = 0x0C;
game.state.transition    = 0x14; -- jack-in / out
game.state.menu          = 0x18;
game.state.shop          = 0x20;
game.state.chip_trader   = 0x24;

game.game_state_names[0x00] = "World Init";
game.game_state_names[0x04] = "World";
game.game_state_names[0x08] = "Battle Init";
game.game_state_names[0x0C] = "Battle";
game.game_state_names[0x10] = "Map Change";
game.game_state_names[0x14] = "Player Change";
game.game_state_names[0x18] = "Menu";
game.game_state_names[0x1C] = "BBS";
game.game_state_names[0x20] = "Shop";
game.game_state_names[0x24] = "Chip Trader";
game.game_state_names[0x30] = "Request BBS";
game.game_state_names[0x34] = "Mailbox";
game.game_state_names[0x38] = "Chargeman Minigame";

game.battle_state_names[0x00] = "loading";
game.battle_state_names[0x04] = "busy";
game.battle_state_names[0x08] = "combat";
game.battle_state_names[0x1C] = "PAUSE";
game.battle_state_names[0x20] = "opening_custom";
game.battle_state_names[0x24] = "custom";

function game.in_chip_select()
    return game.ram.get.battle_mode() == 0x04;
end

function game.in_combat()
    return game.ram.get.battle_mode() == 0x08;
end

game.menu_state_names[0x04] = "editing";
game.menu_state_names[0x14] = "sorting";
game.menu_state_names[0x10] = "to_pack";
game.menu_state_names[0x0C] = "to_folder";
game.menu_state_names[0x08] = "exited";

---------------------------------------- Battle Chips ----------------------------------------

function game.count_library()
    local count = 0;
    for i=0,0x1F do -- TODO: determine total bytes
        count = count + game.bit_counter(game.ram.get.library(i));
    end
    return count;
end

---------------------------------------- Miscellaneous ----------------------------------------

function game.use_fun_flags(fun_flags)
    if fun_flags.randomize_colors then
        if game.did_game_state_change() or game.did_menu_mode_change() or game.did_area_change() then game.doit_later[emu.framecount()+4] = game.randomize_color_palette; end
    end
end

function game.simulate_folder_shuffle()
    local seed = game.ram.get.lazy_RNG_value();

    for i=0,135 do
        seed = game.ram.simulate_RNG(seed);
    end

    local draw_slots = game.ram.shuffle_folder_simulate_from_value(seed, 30);
end

---------------------------------------- Module Controls ----------------------------------------

local settings = require("All/Settings");

function game.initialize(options)
    settings.set_display_text("gui"); -- TODO: Remove when gui.text fully supported
    game.ram.initialize(options);
end

function game.pre_update(options)
    options.fun_flags = game.fun_flags;
    game.ram.pre_update(options);
    game.use_fun_flags(game.fun_flags);
end

function game.post_update(options)
    game.track_game_state();
    game.ram.post_update(options);
end

return game;

