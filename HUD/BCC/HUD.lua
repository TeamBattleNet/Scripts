-- HUD Script for Mega Man Battle Chip Challenge, enjoy.

-- https://drive.google.com/drive/folders/17ChWI6aJoaY6aWvDnK9oyHnTkbA78GCt Did you check The Notes?

local hud = require("All/HUD");

hud.version = hud.version .. ".0.0";

hud.game = require("BCC/Game");

-- https://www.twitch.tv/videos/152857527
-- https://www.therockmanexezone.com/ncgen/
-- Show name above text box (& program deck?)
-- Show slot in % target
-- Show win % prediction? (use in game function?)
-- How to change music?
-- Separate window with tournament info?
-- ROM hacking? Randomizer?

---------------------------------------- Display Functions ----------------------------------------

function hud.display_RNG(and_value) -- overridding
    if and_value then
        hud.to_screen(string.format("RNG:  0x%04X", hud.game.get_main_RNG_value()));
    end
    --hud.to_screen(string.format("Index: %5s", (hud.game.get_main_RNG_index() or "?????")));
    --hud.to_screen(string.format("Delta: %5s", (hud.game.get_main_RNG_delta() or     "?")));
end

---------------------------------------- HUD Modes ----------------------------------------

local function HUD_auto()
    --hud.set_position(1, 17);
    --hud.set_offset(8, 0);
    if true or hud.game.in_title() then
        hud.display_RNG(true);
    else
        hud.to_screen("Unknown Game State!");
    end
end

hud.HUDs = {}; -- in order
table.insert(hud.HUDs, HUD_auto);

---------------------------------------- Module Controls ----------------------------------------

function hud.Up()
    -- TODO
end

function hud.Down()
    -- TODO
end

function hud.B()
    -- TODO
end

function hud.A()
    -- TODO
end

function hud.update_local_state()
    -- TODO
end

return hud;

