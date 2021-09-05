-- Specific Sequences of Inputs for MMBN 3 scripting, enjoy.

local setups = require("All/Setups");

setups.delay_bios   = 282+ 5; -- BN 1 + 3
setups.delay_capcom =  31+11; -- BN 1 + 3
setups.delay_title  =  65+16; -- BN 1 + 3

setups.add_setup(setups.group_misc, "TEST BUTTONS", function()
    --setups.soft_reset();
    --setups.hard_reset();
    --setups.CONTINUE(0);
    setups.press_buttons(37+8, "Loading...."); -- area loading varies
    setups.press_buttons( 1, "PRESS START", {Start=true});
end);

local function reset_and_wait(hard, pause, delay)
    if hard then
        setups.hard_reset();
    else
        setups.soft_reset();
    end
    if pause then
        setups.PRESS_START(delay);
        client.pause();
    else
        setups.CONTINUE(delay);
    end
end

local group_RNG = setups.create_group("RNG Manipulation");
setups.add_setup(group_RNG, " 66 ->  83: First  A",          function() reset_and_wait( true, false,   0); end);
setups.add_setup(group_RNG, " 66 ->  83: First  A  (Pause)", function() reset_and_wait( true,  true,   0); end);
setups.add_setup(group_RNG, " 83 -> 100: 100 Load  (Pause)", function() reset_and_wait( true,  true,  17); end);
setups.add_setup(group_RNG, "100 -> 117: 100 On A  (Pause)", function() reset_and_wait( true,  true,  34); end);
setups.add_setup(group_RNG, "100 -> 117: Yort Encounter",    function() reset_and_wait( true, false,  34); end);
setups.add_setup(group_RNG, "128 -> 145: CopyMan   (Pause)", function() reset_and_wait( true,  true,  62); end);
setups.add_setup(group_RNG, "129 -> 146: Wind Star (Pause)", function() reset_and_wait( true,  true,  63); end);
setups.add_setup(group_RNG, "132 -> 149: CopyMan",           function() reset_and_wait( true, false,  66); end);
setups.add_setup(group_RNG, "132 -> 149: Wind Star",         function() reset_and_wait( true, false,  66); end);
setups.add_setup(group_RNG, "135 -> 152: Gamble    (Pause)", function() reset_and_wait(false,  true,  69); end);
setups.add_setup(group_RNG, "137 -> 154: Gamble",            function() reset_and_wait(false, false,  71); end);
setups.add_setup(group_RNG, "168 -> 185: IceBall   (Pause)", function() reset_and_wait( true,  true, 102); end);
setups.add_setup(group_RNG, "170 -> 187: IceBall    (Hard)", function() reset_and_wait( true, false, 104); end);
setups.add_setup(group_RNG, "170 -> 187: IceBall    (Soft)", function() reset_and_wait(false, false, 104); end);

local game = require("BN3/Game");

local function print_GMD(GMD_RNG_index, GMD_index)
    local GMDi = GMD_index;
    if GMDi == 16 or GMDi == 32 then
        print(string.format("%04u: OPTIMAL", GMD_RNG_index));
    elseif (13 <= GMDi and GMDi <= 15) or (29 <= GMDi and GMDi <= 31) then
        print(string.format("%04u: GOOD", GMD_RNG_index));
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
        print_GMD(GMD_RNG_index, GMD_index);
        
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

local function jack_in(hard, pause, delay_title, delay_jackin)
    reset_and_wait(hard, false, delay_title)
    setups.press_buttons(delay_jackin, "waiting on Main RNG...");
    if pause then
        client.pause();
    else
        setups.press_buttons( 1, "Plug in!", {R=true});
    end
end

local group_GMD = setups.create_group("GMD Manipulation");
setups.add_setup(group_GMD, "L235  M319: First  R",          function() jack_in( true, false,    0,   39); end);
setups.add_setup(group_GMD, "L235  M319: First  R  (Pause)", function() jack_in( true,  true,    0,   39); end);
setups.add_setup(group_GMD, "L???  M319: First  R",          function() jack_in(false, false,    0,   39); end);
setups.add_setup(group_GMD, "L???  M319: First  R  (Pause)", function() jack_in(false,  true,    0,   39); end);
setups.add_setup(group_GMD, "L???  M385: Wind Star",         function() jack_in(false, false,   66,   39); end);
setups.add_setup(group_GMD, "L???  M385: Wind Star No R",    function() reset_and_wait(false, false,  66); end);
setups.add_setup(group_GMD, "L???  M385: Wind Star (Pause)", function() jack_in(false,  true,   66,   39); end);
setups.add_setup(group_GMD, "L???  M448: Wind Bop (Pause)",  function() jack_in(false,  true,   66,  100); end);
setups.add_setup(group_GMD, "L???  M448: Wind Bop",          function() jack_in(false, false,   66,  102); end);
setups.add_setup(group_GMD, "L???  M390: Gamble",            function() jack_in(false, false,   71,   39); end);
setups.add_setup(group_GMD, "L???  M390: Gamble No R",       function() reset_and_wait(false, false,  71); end);
setups.add_setup(group_GMD, "L???  M390: Gamble (Pause)",    function() jack_in(false,  true,   71,   39); end);
setups.add_setup(group_GMD, "L???  M448: Gamble Bop",        function() jack_in(false, false,   71,   97); end);
setups.add_setup(group_GMD, "Print GMD Values  315 to  325", function() dump_GMDs(             315,  325); end);
setups.add_setup(group_GMD, "Print GMD Values  150 to  400", function() dump_GMDs(             150,  500); end);
setups.add_setup(group_GMD, "Print GMD Values 4500 to 5000", function() dump_GMDs(            4500, 5000); end);

local group_folders = setups.create_group("Folder Edits");

setups.add_setup(group_folders, "Folder  0: Remove All Chips", function()
    for i=1,30 do
        setups.folder_edit_buttons({
            {A=true};
            {A=true};
            {Down=true};
        });
    end
end);

setups.add_setup(group_folders, "Folder  1: Rock, Paper, FlashMan", function()
    setups.folder_edit_buttons({
        {A=true};
        {R=true};
        {R=true};
        {Down=true};
        {Down=true};
        {A=true};
        {L=true};
        {Up=true};
        {A=true};
        {L=true};
        {Down=true};
        {A=true};
        {A=true};
        {Up=true};
        {A=true};
        {A=true};
        {R=true};
        {R=true};
        {R=true};
        {Up=true};
        {Up=true};
        {Up=true};
        {A=true};
        {Down=true};
        {A=true};
        {Up=true};
        {Up=true};
        {A=true};
        {L=true};
        {A=true};
        {Down=true};
        {A=true};
        {L=true};
        {Down=true};
        {A=true};
        {R=true};
        {Down=true};
        {Down=true};
        {A=true};
        {A=true};
        {R=true};
        {A=true};
        {R=true};
        {Down=true};
        {A=true};
        {L=true};
        {A=true};
    });
end);

return setups.groups;

