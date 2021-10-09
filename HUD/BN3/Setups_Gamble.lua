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
    setups.press_buttons(wait_for-1, "waiting on Main RNG...");
    if screenshot then
        client.screenshot();
    end
    setups.press_buttons(1, "Pressing A!", {A=true});
    print(string.format("Pressing A on %4d -> %4d", game.get_main_RNG_index(), game.get_main_RNG_index()+control_delay));
    setups.press_buttons(control_delay, "waiting for control...");
    pick_winner();
end

local function gamble_manip(hard, screenshot, title_A, target_1, target_2, target_3, target_4)
    setups.press_A_on(hard, false, 0, title_A);
    
    setups.press_buttons(42, "waiting for game to load...");
    
    start_gambling();
    
    next_winner(screenshot, target_1, 237);
    next_winner(screenshot, target_2, 195);
    next_winner(screenshot, target_3, 195);
    next_winner(screenshot, target_4, 195);
end

local group_gamble = setups.create_group("Gamble US");
setups.add_setup(group_gamble, "M???: Gamble JP"     , function() gamble_manip(false, false, 119, 625, 1271, 1854, 2444); end);
setups.add_setup(group_gamble, "M136: Gamble US"     , function() gamble_manip(false, false, 136, 625, 1271, 2190, 2820); end);

setups.add_setup(group_gamble, "M104: Gamble Beat 1", function() gamble_manip(false, false, 104, 555, 1271, 1854, 2475); end); -- ok
setups.add_setup(group_gamble, "M119: Gamble Beat 2", function() gamble_manip(false, false, 119, 555, 1271, 1854, 2444); end); -- bad
setups.add_setup(group_gamble, "M129: Gamble Beat 3", function() gamble_manip(false, false, 129, 625, 1271, 1854, 2444); end); -- off
setups.add_setup(group_gamble, "M142: Gamble Beat 4", function() gamble_manip(false, false, 142, 625, 1271, 1854, 2444); end); -- ok
setups.add_setup(group_gamble, "M153: Gamble Beat 5", function() gamble_manip(false, false, 153, 555, 1271, 1854, 2444); end); -- ok

setups.add_setup(group_gamble, "M167: Gamble Beat 6", function() gamble_manip(false, false, 167, 625, 1271, 1854, 2444); end); -- bad
setups.add_setup(group_gamble, "M174: Gamble Beat 7", function() gamble_manip(false, false, 174, 625, 1271, 1854, 2444); end); -- ok
setups.add_setup(group_gamble, "M205: Gamble Beat 8", function() gamble_manip(false, false, 205, 625, 1271, 1854, 2444); end); -- eh
setups.add_setup(group_gamble, "M220: Gamble Beat 9", function() gamble_manip(false, false, 220, 625, 1271, 1854, 2444); end); -- off

--[[
 553- 557: TL   5  555
 623- 627: BL   5  625

1102-1108: BL   7 1105 needs 555
1134-1139: BL   6 1136 needs 555
1269-1274: TL   6 1271

1852-1856: TL   5 1854

2440-2448: TL   9 2444
2472-2478: TL   7 2475
--]]

