-- Specific Sequences of Inputs for MMBN 3 gambling, enjoy.

-- US Visuals https://imgur.com/a/SVvau29
-- JP Visuals https://imgur.com/a/0HsEwqK

-- US  Audio  https://www.youtube.com/watch?v=WoCDQ2RJZYA
-- JP  Audio  https://www.twitch.tv/videos/1168903086?t=1h38m51s

local game   = require("BN3/Game");
local setups = require("All/Setups");

local function start_gambling() -- takes 51 total frames
    setups.press_buttons( 1, "Talk to Gambler"   , {A=true});
    setups.press_buttons( 9, "wait for text box" , {      });
    setups.press_buttons( 1, "scroll text"       , {B=true});
    setups.press_buttons( 9, "wait for text"     , {      });
    setups.press_buttons( 1, "advance text"      , {A=true});
    setups.press_buttons( 6, "wait for text"     , {      });
    setups.press_buttons( 1, "scroll text"       , {B=true});
    setups.press_buttons(10, "wait for control"  , {      });
    setups.press_buttons( 1, "select OK"         , {A=true});
    setups.press_buttons( 5, "wait for text"     , {      });
    setups.press_buttons( 1, "scroll text"       , {B=true});
    setups.press_buttons( 5, "wait for text"     , {      });
    setups.press_buttons( 1, "advance text"      , {A=true});
end

local function pick_winner() -- takes 251 total frames
    local winner = game.get_gamble_win();
    
    if     winner == 0 then
        setups.press_buttons( 2, "Bottom Left");
    elseif winner == 1 then
        setups.press_buttons( 1, "Top Left"      , {          });
        setups.press_buttons( 1, "Top Left"      , {   Up=true});
    elseif winner == 2 then
        setups.press_buttons( 1, "Top Right"     , {   Up=true});
        setups.press_buttons( 1, "Top Right"     , {Right=true});
    elseif winner == 3 then
        setups.press_buttons( 1, "Bottom Right"  , {Right=true});
        setups.press_buttons( 1, "Bottom Right"  , {          });
    end
    
    setups.press_buttons(  1, "pick panel"       , {A=true});
    setups.press_buttons(  4, "wait for text"    , {      });
    setups.press_buttons(  1, "scroll text"      , {B=true});
    setups.press_buttons(  5, "wait for text"    , {      });
    setups.press_buttons(  1, "advance text"     , {A=true});
    setups.press_buttons(  6, "wait for text"    , {      });
    setups.press_buttons(  1, "scroll text"      , {B=true});
    setups.press_buttons( 10, "wait for control" , {      });
    setups.press_buttons(  1, "select Yes"       , {A=true});
    setups.press_buttons(  7, "wait for text"    , {      });
    setups.press_buttons(  1, "scroll text"      , {B=true});
    setups.press_buttons(  9, "wait for text"    , {      });
    setups.press_buttons(  1, "advance text"     , {A=true});
    setups.press_buttons(190, "wait for winner"  , {      });
    setups.press_buttons(  1, "scroll text"      , {B=true});
    setups.press_buttons(  9, "wait for text"    , {      });
    setups.press_buttons(  1, "advance text"     , {A=true});
end

local function next_winner(screenshot, target_index, control_delay)
    local wait_for = target_index - control_delay - game.get_main_RNG_index();
    setups.press_buttons(wait_for, "waiting on Main RNG...");
    if screenshot then
        client.screenshot();
    end
    print(string.format("Pressing A on %4d -> %4d", game.get_main_RNG_index(), game.get_main_RNG_index()+control_delay));
    setups.press_buttons(1, "Pressing A!", {A=true});
    setups.press_buttons(control_delay, "waiting for control...");
    pick_winner();
end

local function gamble_manip(hard, screenshot, press_A, target_1, target_2, target_3, target_4)
    setups.press_A_on(hard, false, 0, press_A);
    
    setups.press_buttons(42, "waiting for game to load...");
    
    start_gambling();
    
    next_winner(screenshot, target_1, 237);
    next_winner(screenshot, target_2, 195);
    next_winner(screenshot, target_3, 195);
    next_winner(screenshot, target_4, 195);
end

local group_gamble = setups.create_group("Gamble US");
setups.add_setup(group_gamble, "M???: Gamble JP", function() gamble_manip(false, false, 119, 625, 1271, 1854, 2444); end);
setups.add_setup(group_gamble, "M136: Gamble US", function() gamble_manip(false, false, 136, 625, 1271, 2190, 2820); end);

