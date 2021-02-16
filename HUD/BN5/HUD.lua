-- HUD Script for Mega Man Battle Network 5, enjoy.

-- https://drive.google.com/drive/folders/1TWCr27-usF4kJqQ5pK-8BdQ8-ID21-Cy Did you check The Notes?

local hud = require("All/HUD");

hud.version = hud.version .. ".0.0";

hud.game = require("BN5/Game");

local total_fights = 0;

---------------------------------------- Display Functions ----------------------------------------

local function display_player_info()
    hud.to_screen(string.format("Zenny  : %5u", hud.game.get_zenny()));
    hud.to_screen(string.format("BugFrag: %5u", hud.game.get_bug_frags()));
end

---------------------------------------- HUD Modes ----------------------------------------

local function HUD_auto()
    hud.display_game_info();
    
    hud.to_screen(string.format("EnCounter: %3u", total_fights));
    
    hud.to_screen("");
    
    display_player_info();
    
    hud.to_screen("");
    
    hud.display_both_RNG(true, true);
    
    hud.to_screen("");
    
    hud.display_steps(true);
    
    if hud.game.get_sneak() > 0 then
        hud.to_screen(string.format("Sneak: %5u", hud.game.get_sneak()));
    end
    
    hud.display_area();
    --hud.display_enemies();
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

function hud.update_local_state()
    if hud.game.did_game_state_change() and hud.game.in_battle() then
        total_fights = total_fights + 1;
    end
end

return hud;

