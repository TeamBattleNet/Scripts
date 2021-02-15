-- Specific Sequences of Inputs for MMBN 2 scripting, enjoy.

local setups = require("All/Setups");

setups.delay_bios   = 282;    -- BN 1 & 2
setups.delay_capcom =  31+75; -- BN 1 + 2
setups.delay_title  =  65+ 3; -- BN 1 + 2

setups.add_setup(setups.group_misc, "TEST BUTTONS", function()
    --setups.soft_reset();
    --setups.hard_reset();
    --setups.CONTINUE(0);
    setups.press_buttons(37+8, "Loading...."); -- area loading varies
    setups.press_buttons( 1, "PRESS START", {Start=true});
end);

local group_RNG = setups.create_group("RNG Manipulation");

setups.add_setup(group_RNG, "BN1: 359: GutsMan", function()
    setups.soft_reset(); -- RNG Index: 354-364 (359)
    setups.CONTINUE(0);
    setups.press_buttons(  45, "Area Loading..");
    setups.press_buttons(   1, "Talk to Dex"   , {A=true});
    setups.press_buttons(  20, "Wait on text..");
    setups.press_buttons(   1, "Textbox"       , {A=true});
    setups.press_buttons(  10, "Wait on text..");
    setups.press_buttons(   1, "Textbox"       , {A=true});
    setups.press_buttons(  15, "Wait on text..");
    setups.press_buttons(   1, "Textbox"       , {A=true});
    setups.press_buttons(  20, "Wait on text..");
    setups.press_buttons(   2, "Move to Yes"   , {Left=true});
    setups.press_buttons(   1, "Select Yes"    , {A=true});
    setups.press_buttons(  15, "Wait on text..");
    setups.press_buttons(   1, "Textbox"       , {A=true});
    setups.press_buttons(82+6, "Wait on RNG...");
    setups.press_buttons(   1, "Start fight!"  , {A=true});
end);

setups.add_setup(group_RNG, "BN1: 359: SkullMan (2nd Talk)", function()
    setups.soft_reset(); -- RNG Index: 354-364 (359)
    setups.CONTINUE(0);
    setups.press_buttons(  45, "Area Loading..");
    setups.press_buttons(   1, "Talk to Miyu"  , {A=true});
    setups.press_buttons(  20, "Wait on text..");
    setups.press_buttons(   1, "Textbox"       , {A=true});
    setups.press_buttons(  10, "Wait on text..");
    setups.press_buttons(   1, "Textbox"       , {A=true});
    setups.press_buttons(  15, "Wait on text..");
    setups.press_buttons(   1, "Textbox"       , {A=true});
    setups.press_buttons(  20, "Wait on text..");
    setups.press_buttons(   2, "Move to Yes"   , {Left=true});
    setups.press_buttons(   1, "Select Yes"    , {A=true});
    setups.press_buttons(  15, "Wait on text..");
    setups.press_buttons(   1, "Textbox"       , {A=true});
    setups.press_buttons(88-6, "Wait on RNG...");
    setups.press_buttons(   1, "Start fight!"  , {A=true});
end);

setups.add_setup(group_RNG, "BN1: 740: ColorMan", function()
    setups.soft_reset(); -- RNG Index: 735-746 (740)
    setups.CONTINUE(0);
    setups.press_buttons( 45, "Loading...");
    setups.press_buttons(274, "Wait on RNG...");
    setups.press_buttons(  1, "Jack in to the bus", {R=true});
    setups.press_buttons(400, "Wait on animation...");
    setups.press_buttons(120, "Skip Cutscene...", {Start=true});
end);

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

setups.add_setup(group_folders, "BN1: Folder  1: Tutorial", function()
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

