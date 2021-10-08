-- Specific Sequences of Inputs for MMBN 3 GMDs, enjoy.

local game   = require("BN3/Game");
local setups = require("All/Setups");

local function jack_in(hard, pause, delay_start, title_A_index, target_index)
    setups.press_A_on(hard, false, delay_start, title_A_index);
    local wait_for = target_index - game.get_main_RNG_index() - 214; -- jackin delay
    setups.press_buttons(wait_for, "waiting on Main RNG...");
    if pause then
        client.pause();
    else
        setups.press_buttons( 1, "Plug in, RockMan.EXE! Transmit!", {R=true});
    end
end

local function grab_GMD(hard, pause, delay_start, title_A_index, target_index)
    setups.press_A_on(hard, false, delay_start, title_A_index);
    setups.press_buttons(50, "waiting on control...");
    setups.press_buttons( 1, "GMD Text!", {A=true});
    setups.press_buttons(12, "waiting on Text...");
    setups.press_buttons( 1, "GMD Text!", {B=true});
    setups.press_buttons(35, "waiting on Text...");
    local wait_for = target_index - game.get_main_RNG_index() - 3; -- ignores rerolls
    setups.press_buttons(wait_for, "waiting on Main RNG...");
    if pause then
        client.pause();
    else
        setups.press_buttons( 1, "GMD Get!", {A=true});
    end
end

local function print_GMD_locations_ACDC_Area_1(text, GMD_1_xy, GMD_1_yx, GMD_2_xy, GMD_2_yx)
    if     GMD_1_xy == 0x0000 and GMD_1_yx == 0x0000 then
        return text + ": Extra GMD";
    elseif GMD_1_xy == 0x0000 and GMD_1_yx == 0x0000 then
        return text + ": Train GMD";
    end
    if     GMD_2_xy == 0x0000 and GMD_2_yx == 0x0000 then
        return text + ": Far Left";
    end
    return text; -- TODO: Find relevant values
end

local function print_GMD_locations_ACDC_Area_2(text, GMD_1_xy, GMD_1_yx, GMD_2_xy, GMD_2_yx)
    if     GMD_1_xy == 0xFF10 and GMD_1_yx == 0x00B0 and GMD_2_xy == 0xFFB0 and GMD_2_yx == 0x0014 then
        return text .. ": SHOPTIMAL";
    elseif GMD_1_xy == 0x00F2 and GMD_1_yx == 0xFECC and GMD_2_xy == 0xFF70 and GMD_2_yx == 0xFED4 then
        return text .. ": Upper Mid";
    elseif GMD_1_xy == 0x00F2 and GMD_1_yx == 0xFECC and GMD_2_xy == 0xFF74 and GMD_2_yx == 0xFE6A then
        return text .. ": Upper Top";
    end
    return text;
end

local function dump_GMD_locations(index_start, index_end)
    local GMD_data = {};
    
    RNG_start = index_start - 22; -- TODO: Must manually update loading offset based on current test state
    
    game.set_main_RNG_value(game.ram.iterate_RNG_capped(0xA338244F, RNG_start-1, index_end));
    
    savestate.saveslot(0);
    
    client.speedmode(400);
    for i=index_start,index_end do
        setups.press_buttons(10, "Entering Area!", {Up=true});
        setups.press_buttons(28, "Spawning  GMD!");
        
        local GMD_1_xy = game.ram.get.GMD_1_xy();
        local GMD_1_yx = game.ram.get.GMD_1_yx();
        local GMD_2_xy = game.ram.get.GMD_2_xy();
        local GMD_2_yx = game.ram.get.GMD_2_yx();
        
        GMD_data[i] = {};
        GMD_data.GMD_1_xy = GMD_1_xy;
        GMD_data.GMD_1_yx = GMD_1_yx;
        GMD_data.GMD_2_xy = GMD_2_xy;
        GMD_data.GMD_2_yx = GMD_2_yx;
        
        local text = string.format("%04u: 0x%04x 0x%04x, 0x%04x 0x%04x", i, GMD_1_xy, GMD_1_yx, GMD_2_xy, GMD_2_yx);
        
      --text = print_GMD_locations_ACDC_Area_1(text, GMD_1_xy, GMD_1_yx, GMD_2_xy, GMD_2_yx);
        text = print_GMD_locations_ACDC_Area_2(text, GMD_1_xy, GMD_1_yx, GMD_2_xy, GMD_2_yx);
        
        print(text);
        
        savestate.loadslot(0);
        emu.frameadvance();
        savestate.saveslot(0);
    end
    client.speedmode(100);
    
    --print(GMD_data);
    
    return GMD_data;
end

local group_GMD = setups.create_group("GMD Jackin US");
--jack_in(hard, pause, delay_start, title_A_index, target_index)
setups.add_setup(group_GMD, "M319: First R",       function()  jack_in(false, false,  0,   0,   0); end);
setups.add_setup(group_GMD, "M319: First R Pause", function()  jack_in(false,  true,  0,   0,   0); end);
setups.add_setup(group_GMD, "M472: 1st, Bop 3, 1", function()  jack_in(false, false,  0, 104, 472); end);
setups.add_setup(group_GMD, "M473: 1st, Bop 3, 2", function()  jack_in(false, false,  0, 104, 473); end);
setups.add_setup(group_GMD, "M474: 1st, Bop 3, 3", function()  jack_in(false, false,  0, 104, 474); end);
setups.add_setup(group_GMD, "M475: 1st, Bop 3, 4", function()  jack_in(false, false,  0, 104, 475); end);
setups.add_setup(group_GMD, "M476: 1st, Bop 3, 5", function()  jack_in(false, false,  0, 104, 476); end);
setups.add_setup(group_GMD, "M472: 5th, Bop  , 1", function()  jack_in(false, false,  0, 153, 472); end);
setups.add_setup(group_GMD, "M473: 5th, Bop  , 2", function()  jack_in(false, false,  0, 153, 473); end);
setups.add_setup(group_GMD, "M474: 5th, Bop  , 3", function()  jack_in(false, false,  0, 153, 474); end);
setups.add_setup(group_GMD, "M475: 5th, Bop  , 4", function()  jack_in(false, false,  0, 153, 475); end);
setups.add_setup(group_GMD, "M476: 5th, Bop  , 5", function()  jack_in(false, false,  0, 153, 476); end);

local group_GMD = setups.create_group("GMD Reroll US");
--grab_GMD(hard, pause, delay_start, title_A_index, target_index)
setups.add_setup(group_GMD, "M156: GMD First A",  function() grab_GMD( true, false, 0,   0,   0); end);
setups.add_setup(group_GMD, "M156: GMD A Pause",  function() grab_GMD( true,  true, 0,   0,   0); end);
setups.add_setup(group_GMD, "M470: 300z Frame 0", function() grab_GMD( true, false, 0, 220, 467); end);
setups.add_setup(group_GMD, "M472: 2000 Frame 1", function() grab_GMD( true, false, 0, 220, 468); end);
setups.add_setup(group_GMD, "M474: 2000 Frame 2", function() grab_GMD( true, false, 0, 220, 469); end);
setups.add_setup(group_GMD, "M472: 2000 Frame 3", function() grab_GMD( true, false, 0, 220, 470); end);
setups.add_setup(group_GMD, "M474: 2000 Frame 4", function() grab_GMD( true, false, 0, 220, 471); end);
setups.add_setup(group_GMD, "M476: 2000 Frame 5", function() grab_GMD( true, false, 0, 220, 472); end);
setups.add_setup(group_GMD, "M478: 1000 Frame 6", function() grab_GMD( true, false, 0, 220, 473); end);
setups.add_setup(group_GMD, "M476: 2000 Frame 7", function() grab_GMD( true, false, 0, 220, 474); end);
setups.add_setup(group_GMD, "M478: 1000 Frame 8", function() grab_GMD( true, false, 0, 220, 475); end);
setups.add_setup(group_GMD, "M480: 100z Frame 9", function() grab_GMD( true, false, 0, 220, 476); end);

local group_GMD = setups.create_group("GMD Location Logging");
--dump_GMD_locations(index_start, index_end)
setups.add_setup(group_GMD, "Spawn GMDs  100 to  250", function() dump_GMD_locations( 100,  250); end);
setups.add_setup(group_GMD, "Spawn GMDs  250 to  500", function() dump_GMD_locations( 250,  500); end);
setups.add_setup(group_GMD, "Spawn GMDs  500 to 1000", function() dump_GMD_locations( 500, 1000); end);
setups.add_setup(group_GMD, "Spawn GMDs 1000 to 2000", function() dump_GMD_locations(1000, 2000); end);
setups.add_setup(group_GMD, "Spawn GMDs    1 to 5000", function() dump_GMD_locations(   1, 5000); end);

