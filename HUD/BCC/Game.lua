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

---------------------------------------- Inventory ----------------------------------------

---------------------------------------- Battlechips ----------------------------------------

function game.count_library()
    local count = 0;
    for i=0,0x1F do -- TODO: 243 Library Chips
        count = count + game.bit_counter(game.ram.get.library(i));
    end
    return count;
end

---------------------------------------- Miscellaneous ----------------------------------------

---------------------------------------- Fun Flags  ----------------------------------------

function game.title_screen_A()
    if game.did_leave_title_screen() then
        print(string.format("\nRNG Froze on frame: %u", emu.framecount())); -- 17 frames after A
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
    game.track_game_state();
    game.ram.post_update(options);
end

return game;

