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

local group_RNG = setups.create_group("RNG Manipulation");

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

setups.add_setup(group_folders, "Folder  1: FlashMan", function()
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

