-- Specific Sequences of Inputs for MMBN 3 GMDs, enjoy.

local game   = require("BN3/Game");
local setups = require("All/Setups");

local function reset_and_wait_new(hard, pause, delay_start, delay_A)
    if hard then
        setups.hard_reset();
    else
        setups.soft_reset();
    end
    if pause then
        setups.PRESS_START(delay_start);
        client.pause();
    else
        setups.CONTINUE(delay_start, delay_A);
    end
end

local function reset_and_wait(hard, pause, delay_A)
    reset_and_wait_new(hard, pause, 0, delay_A)
end

local function manip_but_easy(hard, pause, target_index)
    reset_and_wait(hard, pause, target_index - 66);
end

local function press_A_on(hard, target_index)
    reset_and_wait(hard, false, target_index - 66);
end

local function print_GMD_1200(GMD_RNG_index, GMD_index)
    local GMDi = GMD_index;
    if GMDi == 31 or GMDi == 32 then
        print(string.format("%04u: OPTIMAL", GMD_RNG_index)); -- 1200z
    elseif 28 <= GMDi and GMDi <= 30 then
        print(string.format("%04u: GOOD", GMD_RNG_index));    --  800z
    elseif 21 <= GMDi and GMDi <= 27 then
        print(string.format("%04u: OKAY", GMD_RNG_index));    --  400z
    else
        print(string.format("%04u: bad", GMD_RNG_index));
    end
end

local function print_GMD_2000(GMD_RNG_index, GMD_index)
    local GMDi = GMD_index;
    if GMDi == 16 or GMDi == 32 then
        print(string.format("%04u: OPTIMAL", GMD_RNG_index)); -- 2000z
    elseif 29 <= GMDi and GMDi <= 31 then
        print(string.format("%04u: GOOD", GMD_RNG_index));    -- 1200z / 800z
    elseif 13 <= GMDi and GMDi <= 15 then
        print(string.format("%04u: OKAY", GMD_RNG_index));    -- 1000z
    else
        print(string.format("%04u: bad", GMD_RNG_index));
    end
end

local function dump_GMDs(index_start, index_end)
    local GMD_data = {};
    
    local GMD_RNG = game.ram.iterate_RNG_capped(0xA338244F, index_start-1, index_end);
    
    savestate.saveslot(0);
    
    for i=index_start,index_end do
        game.set_GMD_RNG(GMD_RNG);
        game.set_main_RNG_value(GMD_RNG);
        local GMD_index = game.get_GMD_index();
        local GMD_RNG_index = game.get_GMD_RNG_index();
        local is_zenny = game.get_GMD_is_zenny();
        setups.press_buttons(3, "GMD Get!", {A=true});
        
        local GMD_value = game.get_GMD_value();
        local GMD_RNG_next = game.get_GMD_RNG();
        local GMD_RNG_delta = game.get_main_RNG_delta();
        local GMD_index_next = game.get_GMD_index();
        
        GMD_data[GMD_RNG_index] = GMD_index;
        print_GMD_1200(GMD_RNG_index, GMD_index);
        
        GMD_data[GMD_RNG_index] = {};
        GMD_data[GMD_RNG_index].index = GMD_index;
        GMD_data[GMD_RNG_index].value = GMD_value;
        GMD_data[GMD_RNG_index].delta = GMD_RNG_delta;
        GMD_data[GMD_RNG_index].next  = GMD_RNG_next;
        GMD_data[GMD_RNG_index].is_zenny = is_zenny;
        
        savestate.loadslot(0);
        GMD_RNG = game.ram.simulate_RNG(GMD_RNG);
    end
    
    --print(GMD_data);
    
    return GMD_data;
end

--local GMD_locations = {};
--GMD_locations["ACDC Area 1"] = {};
--GMD_locations["ACDC Area 1"][bit.xor(GMD_1_xy, GMD_1_yx)] = "Position Name";
--GMD_locations["ACDC Area 1"][bit.xor(GMD_2_xy, GMD_2_yx)] = "Position Name";
--GMD_locations["ACDC Area 1"][bit.xor(GMD_1_xy, GMD_1_yx) * bit.xor(GMD_2_xy, GMD_2_yx)] = "Combo Name";
--GMD_locations[area][bit.xor(GMD_1_xy, GMD_1_yx)]
--GMD_locations[area][bit.xor(GMD_2_xy, GMD_2_yx)]
--GMD_locations[area][bit.xor(GMD_1_xy, GMD_1_yx) * bit.xor(GMD_2_xy, GMD_2_yx)]

local function print_GMD_xy_ACDC2(i, GMD_1_xy, GMD_1_yx, GMD_2_xy, GMD_2_yx)
    if GMD_1_xy == 0xFF10 and GMD_1_yx == 0x00B0 and GMD_2_xy == 0xFFB0 and GMD_2_yx == 0x0014 then
        print(string.format("%04u: OPTIMAL", i)); -- shop set
    elseif GMD_1_xy == 0x00F2 and GMD_1_yx == 0xFECC and GMD_2_xy == 0xFF70 and GMD_2_yx == 0xFED4 then
        print(string.format("%04u: GOOD", i)); -- upper set a
    elseif GMD_1_xy == 0x00F2 and GMD_1_yx == 0xFECC and GMD_2_xy == 0xFF74 and GMD_2_yx == 0xFE6A then
        print(string.format("%04u: GOOD", i)); -- upper set b
    else
        print(string.format("%04u: bad", i));
    end
    --print(string.format("%04u: %04X %04X %04X %04X", i, GMD_1_xy, GMD_1_yx, GMD_2_xy, GMD_2_yx));
end

local function dump_GMDs_xy(index_start, index_end)
    local GMD_data = {};
    
    RNG_start = index_start - 20; -- ACDC2 area loading offset
    
    game.set_main_RNG_value(game.ram.iterate_RNG_capped(0xA338244F, RNG_start-1, index_end));
    
    savestate.saveslot(0);
    
    for i=index_start,index_end do
        setups.press_buttons(10, "Movin' on up!", {Up=true});
        setups.press_buttons(28, "Spawning GMD!", {});
        
        local GMD_1_xy = game.ram.get.GMD_1_xy();
        local GMD_1_yx = game.ram.get.GMD_1_yx();
        local GMD_2_xy = game.ram.get.GMD_2_xy();
        local GMD_2_yx = game.ram.get.GMD_2_yx();
        
        GMD_data[i] = {};
        GMD_data.GMD_1_xy = GMD_1_xy;
        GMD_data.GMD_1_yx = GMD_1_yx;
        GMD_data.GMD_2_xy = GMD_2_xy;
        GMD_data.GMD_2_yx = GMD_2_yx;
        print_GMD_xy_ACDC2(i, GMD_1_xy, GMD_1_yx, GMD_2_xy, GMD_2_yx);
        
        savestate.loadslot(0);
        emu.frameadvance();
        savestate.saveslot(0);
    end
    
    --print(GMD_data);
    
    return GMD_data;
end

local function jack_in(hard, pause, delay_start, delay_A, delay_jackin)
    reset_and_wait_new(hard, false, delay_start, delay_A)
    setups.press_buttons(delay_jackin, "waiting on Main RNG...");
    if pause then
        client.pause();
    else
        setups.press_buttons( 1, "Plug in!", {R=true});
    end
end

local function grab_GMD(pause, delay_title, delay_pressA)
    reset_and_wait(true, false, delay_title)
    setups.press_buttons(50, "waiting on control...");
    setups.press_buttons( 1, "GMD Text!", {A=true});
    setups.press_buttons(12, "waiting on Text...");
    setups.press_buttons( 1, "GMD Text!", {B=true});
    setups.press_buttons(35, "waiting on Text...");
    setups.press_buttons(delay_pressA, "waiting on Main RNG...");
    if pause then
        client.pause();
    else
        setups.press_buttons( 1, "GMD Get!", {A=true});
    end
end

local group_GMD = setups.create_group("GMD Reroll US");
setups.add_setup(group_GMD, "M156: GMD First A",       function() grab_GMD(      false,    0,    0); end);
setups.add_setup(group_GMD, "M470:  300 Frame 0",      function() grab_GMD(      false,  155,  157); end);
setups.add_setup(group_GMD, "M472: 2000 Frame 1",      function() grab_GMD(      false,  156,  157); end);
setups.add_setup(group_GMD, "M474: 2000 Frame 2",      function() grab_GMD(      false,  157,  157); end);
setups.add_setup(group_GMD, "M472: 2000 Frame 3",      function() grab_GMD(      false,  158,  157); end);
setups.add_setup(group_GMD, "M474: 2000 Frame 4",      function() grab_GMD(      false,  159,  157); end);
setups.add_setup(group_GMD, "M476: 2000 Frame 5",      function() grab_GMD(      false,  160,  157); end);
setups.add_setup(group_GMD, "M478: 1000 Frame 6",      function() grab_GMD(      false,  161,  157); end);
setups.add_setup(group_GMD, "M476: 2000 Frame 7",      function() grab_GMD(      false,  162,  157); end);
setups.add_setup(group_GMD, "M478: 1000 Frame 8",      function() grab_GMD(      false,  163,  157); end);
setups.add_setup(group_GMD, "M480:  100 Frame 9",      function() grab_GMD(      false,  164,  157); end);

local group_GMD = setups.create_group("GMD Jackin US");
setups.add_setup(group_GMD, "M319: First  R",          function() jack_in(false, false,  0,  0,  39); end);
setups.add_setup(group_GMD, "M319: First  R  Pause",   function() jack_in(false,  true,  0,  0,  39); end);
setups.add_setup(group_GMD, "M418: Wind then Pause",   function() jack_in(false,  true,  0, 34, 104); end);
setups.add_setup(group_GMD, "M420: Wind then Bop A",   function() jack_in(false, false,  0, 36, 104); end);
setups.add_setup(group_GMD, "M422: Wind then Bop B",   function() jack_in(false, false,  0, 38, 104); end);
setups.add_setup(group_GMD, "M424: Wind then Bop C",   function() jack_in(false, false,  0, 40, 104); end);
setups.add_setup(group_GMD, "M474: Wind then Bop 3",   function() jack_in(false, false,  0, 38, 156); end);
setups.add_setup(group_GMD, "M470: 5 then Pause",      function() jack_in(false,  true,  0, 86, 104); end);
setups.add_setup(group_GMD, "M472: 5 then Bop A",      function() jack_in(false, false,  0, 88, 104); end);
setups.add_setup(group_GMD, "M474: 5 then Bop B",      function() jack_in(false, false,  0, 90, 104); end);
setups.add_setup(group_GMD, "M476: 5 then Bop C",      function() jack_in(false, false,  0, 92, 104); end);

local group_GMD = setups.create_group("GMD Logging");
setups.add_setup(group_GMD, "Print GMDs  150 to 1000", function() dump_GMDs(             150, 1000); end);
setups.add_setup(group_GMD, "Print GMDs 1000 to 2000", function() dump_GMDs(            1000, 2000); end);
setups.add_setup(group_GMD, "Spawn GMDs  120 to  240", function() dump_GMDs_xy(          120,  240); end);
setups.add_setup(group_GMD, "Spawn GMDs  100 to  500", function() dump_GMDs_xy(          100,  500); end);
setups.add_setup(group_GMD, "Spawn GMDs 1000 to 2000", function() dump_GMDs_xy(         1000, 2000); end);

