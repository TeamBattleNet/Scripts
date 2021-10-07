-- Specific Sequences of Inputs for MMBN 3 scripting, enjoy.

local game   = require("BN3/Game");
local setups = require("All/Setups");

setups.delay_bios   = 282+ 5; -- BN 1 + 3
setups.delay_capcom =  31+11; -- BN 1 + 3
setups.delay_title  =  65+16; -- BN 1 + 3
setups.align_RNG    =  66   ; -- BN 3

setups.add_setup(setups.group_misc, "TEST BUTTONS", function()
    --setups.soft_reset();
    --setups.hard_reset();
    --setups.CONTINUE(0);
    setups.press_buttons(37+8, "Loading...."); -- area loading varies; fix with skip_lag_frames?
    setups.press_buttons( 1, "PRESS START", {Start=true});
end);


local group_RNG = setups.create_group("RNG Both");
setups.add_setup(group_RNG, " 66 ->  83: First  A",          function() reset_and_wait( true, false,   0); end);
setups.add_setup(group_RNG, " 66 ->  83: First  A  (Soft)",  function() reset_and_wait(false, false,   0); end);
setups.add_setup(group_RNG, " 66 ->  83: First  A  (Pause)", function() reset_and_wait( true,  true,   0); end);
setups.add_setup(group_RNG, " 83 -> 100: 100 Load  (Pause)", function() reset_and_wait( true,  true,  17); end);
setups.add_setup(group_RNG, "100 -> 117: 100 On A  (Pause)", function() reset_and_wait( true,  true,  34); end);
setups.add_setup(group_RNG, "100 -> 117: 100 On A",          function()     press_A_on( true,        100); end);
setups.add_setup(group_RNG, "200 -> 217: 200 On A",          function()     press_A_on( true,        200); end);
setups.add_setup(group_RNG, "300 -> 317: 300 On A",          function()     press_A_on( true,        300); end);

local group_RNG = setups.create_group("RNG US");
setups.add_setup(group_RNG, "102 -> 119: Wind Box 1",        function() reset_and_wait( true, false,  36); end);
setups.add_setup(group_RNG, "104 -> 121: Wind Box 2",        function() reset_and_wait( true, false,  38); end);
setups.add_setup(group_RNG, "106 -> 123: Wind Box 3",        function() reset_and_wait( true, false,  40); end);
setups.add_setup(group_RNG, "104 -> 121: Yort Encounters",   function() reset_and_wait( true, false,  38); end);
setups.add_setup(group_RNG, "128 -> 145: CopyMan   (Pause)", function() reset_and_wait( true,  true,  62); end);
setups.add_setup(group_RNG, "132 -> 149: CopyMan",           function() reset_and_wait( true, false,  66); end);
setups.add_setup(group_RNG, "132 -> 149: Wind Star Old",     function() reset_and_wait( true, false,  66); end);
setups.add_setup(group_RNG, "135 -> 152: Gamble    (Pause)", function() reset_and_wait(false,  true,  69); end);
setups.add_setup(group_RNG, "137 -> 154: Gamble",            function() reset_and_wait(false, false,  71); end);
setups.add_setup(group_RNG, "162 -> 179: IceBall Fast A",    function() reset_and_wait( true, false,  96); end);
setups.add_setup(group_RNG, "174 -> 191: IceBall Fast B",    function() reset_and_wait( true, false, 108); end);
setups.add_setup(group_RNG, "170 -> 187: IceBall    (Hard)", function() reset_and_wait( true, false, 104); end);
setups.add_setup(group_RNG, "170 -> 187: IceBall    (Soft)", function() reset_and_wait(false, false, 104); end);
setups.add_setup(group_RNG, "232 -> 249: IceBall Slide",     function() reset_and_wait( true, false, 166); end);

local group_RNG = setups.create_group("RNG JP");
setups.add_setup(group_RNG, " 66 ->  83: First  A",          function() reset_and_wait( true, false,   0); end);

setups.add_setup(setups.group_folders, "Folder  1: Rock, Paper, FlashMan", function()
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

--require("BN3/Setups_GMD");

return setups.groups;

