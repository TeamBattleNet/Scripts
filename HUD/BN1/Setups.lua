-- Specific Sequences of Inputs for MMBN 1 scripting, enjoy.

local setups = require("All/Setups");

setups.add_sequence("Open & Close Menu", function()
    setups.press_buttons( 2, "Menu", {Start=true});
    setups.press_buttons(20, "Menu", {});
    setups.press_buttons( 2, "Menu", {A=true});
    setups.press_buttons(40, "Menu", {});
    setups.press_buttons( 2, "Menu", {B=true});
    setups.press_buttons(60, "Menu", {});
    setups.press_buttons( 2, "Menu", {B=true});
    setups.press_buttons(30, "Menu", {});
end);

setups.add_sequence("359: GutsMan", function()
    setups.soft_reset(); -- RNG Index: 354-364 (359)
    setups.press_buttons(  40, "Area Loading..", {});
    setups.press_buttons(   1, "Talk to Dex"   , {A=true});
    setups.press_buttons(  20, "Wait on text..", {});
    setups.press_buttons(   1, "Textbox"       , {A=true});
    setups.press_buttons(  10, "Wait on text..", {});
    setups.press_buttons(   1, "Textbox"       , {A=true});
    setups.press_buttons(  15, "Wait on text..", {});
    setups.press_buttons(   1, "Textbox"       , {A=true});
    setups.press_buttons(  20, "Wait on text..", {});
    setups.press_buttons(   2, "Move to Yes"   , {Left=true});
    setups.press_buttons(   1, "Select Yes"    , {A=true});
    setups.press_buttons(  15, "Wait on text..", {});
    setups.press_buttons(   1, "Textbox"       , {A=true});
    setups.press_buttons(87+6, "Wait on RNG...", {});
    setups.press_buttons(   1, "Start fight!"  , {A=true});
end);

setups.add_sequence("359: SkullMan (2nd Talk)", function()
    setups.soft_reset(); -- RNG Index: 354-364 (359)
    setups.press_buttons(  40, "Area Loading..", {});
    setups.press_buttons(   1, "Talk to Miyu"  , {A=true});
    setups.press_buttons(  20, "Wait on text..", {});
    setups.press_buttons(   1, "Textbox"       , {A=true});
    setups.press_buttons(  10, "Wait on text..", {});
    setups.press_buttons(   1, "Textbox"       , {A=true});
    setups.press_buttons(  15, "Wait on text..", {});
    setups.press_buttons(   1, "Textbox"       , {A=true});
    setups.press_buttons(  20, "Wait on text..", {});
    setups.press_buttons(   2, "Move to Yes"   , {Left=true});
    setups.press_buttons(   1, "Select Yes"    , {A=true});
    setups.press_buttons(  15, "Wait on text..", {});
    setups.press_buttons(   1, "Textbox"       , {A=true});
    setups.press_buttons(93-6, "Wait on RNG...", {});
    setups.press_buttons(   1, "Start fight!"  , {A=true});
end);

setups.add_sequence("740: ColorMan", function()
    setups.soft_reset(); -- RNG Index: 735-746 (740)
    setups.press_buttons( 40, "Loading..."    , {});
    setups.press_buttons(279, "Wait on RNG..."     , {});
    setups.press_buttons(  1, "Jack in to the bus", {R=true});
    setups.press_buttons(400, "Wait on animation...", {});
    setups.press_buttons(120, "Skip Cutscene..."     , {Start=true});
end);

setups.add_folder_edit("Folder 0: Remove All Chips", function()
    for i=1,30 do
        setups.folder_edit_buttons({
            {A=true};
            {A=true};
            {Down=true};
        });
    end
end);

setups.add_folder_edit("Folder 1: Tutorial", function()
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

setups.add_folder_edit("Folder 2: School", function()
    setups.folder_edit_buttons({
        {Down=true};
        {A=true};
        {R=true};
        {Down=true};
        {A=true};
        {L=true};
        {Down=true};
        {A=true};
        {Down=true};
        {A=true};
        {R=true};
        {Down=true};
        {Down=true};
        {Down=true};
        {A=true};
        {A=true};
        {Up=true};
        {Up=true};
        {A=true};
        {R=true};
        {R=true};
        {R=true};
        {A=true};
        {Down=true};
        {A=true};
        {A=true};
        {Right=true};
        {Down=true};
        {Down=true};
        {A=true};
        {A=true};
        {A=true};
        {A=true};
    });
end);

setups.add_folder_edit("Folder 3: NumberMan", function()
    setups.folder_edit_buttons({
        {A=true};
        {R=true};
        {Down=true};
        {A=true};
        {A=true};
        {Down=true};
        {Down=true};
        {A=true};
        {A=true};
        {R=true};
        {R=true};
        {Down=true};
        {A=true};
        {A=true};
        {R=true};
        {L=true};
        {A=true};
        {Right=true};
        {A=true};
        {A=true};
        {A=true};
        {A=true};
        {A=true};
        {A=true};
        {A=true};
    });
end);

setups.add_folder_edit("Folder 4: GutsMan", function()
    setups.folder_edit_buttons({
        {R=true};
        {A=true};
        {Down=true};
        {A=true};
        {Down=true};
        {Down=true};
        {A=true};
        {R=true};
        {A=true};
        {Up=true};
        {A=true};
        {R=true};
        {A=true};
        {Down=true};
        {A=true};
        {R=true};
        {L=true};
        {Down=true};
        {A=true};
        {L=true};
        {Up=true};
        {A=true};
        {L=true};
        {L=true};
        {Up=true};
        {A=true};
    });
end);

setups.add_folder_edit("Folder 5: StoneMan", function()
    setups.folder_edit_buttons({
        {A=true};
        {A=true};
        {Down=true};
        {A=true};
        {A=true};
        {Down=true};
        {A=true};
        {A=true};
        {Down=true};
        {Down=true};
        {A=true};
        {A=true};
        {R=true};
        {R=true};
        {A=true};
        {A=true};
        {Up=true};
        {A=true};
        {A=true};
        {Up=true};
        {Up=true};
        {A=true};
        {A=true};
        {Right=true};
        {Down=true};
        {A=true};
        {A=true};
        {A=true};
        {A=true};
        {A=true};
        {A=true};
        {A=true};
        {A=true};
        {A=true};
        {A=true};
        {Down=true};
        {A=true};
        {A=true};
        {Up=true};
        {A=true};
        {A=true};
    });
end);

setups.add_folder_edit("Folder 6: StoneMan", function()
    setups.folder_edit_buttons({
        {A=true};
        {R=true};
        {A=true};
        {R=true};
        {R=true};
        {R=true};
        {Down=true};
        {A=true};
        {A=true};
        {Down=true};
        {A=true};
        {L=true};
        {L=true};
        {L=true};
        {L=true};
        {A=true};
        {Up=true};
        {A=true};
        {R=true};
        {Down=true};
        {Down=true};
        {Down=true};
        {A=true};
        {R=true};
        {Down=true};
        {Down=true};
        {A=true};
        {Right=true};
        {A=true};
        {Down=true};
        {Down=true};
        {A=true};
        {A=true};
    });
end);

setups.add_folder_edit("Folder 7: Traffice 3", function()
    setups.folder_edit_buttons({
        {R=true};
        {Up=true};
        {A=true};
        {A=true};
        {Down=true};
        {Down=true};
        {Down=true};
        {A=true};
        {R=true};
        {Down=true};
        {Down=true};
        {Down=true};
        {Down=true};
        {A=true};
        {R=true};
        {R=true};
        {A=true};
        {L=true};
        {Down=true};
        {Down=true};
        {A=true};
        {L=true};
        {Up=true};
        {A=true};
        {A=true};
        {Down=true};
        {Down=true};
        {Down=true};
        {A=true};
        {Right=true};
        {Down=true};
        {Down=true};
        {A=true};
        {Down=true};
        {Down=true};
        {A=true};
        {A=true};
        {Up=true};
        {Up=true};
        {Up=true};
        {Up=true};
        {A=true};
        {A=true};
    });
end);

setups.add_folder_edit("Folder 8: Power 4", function()
    setups.folder_edit_buttons({
        {R=true};
        {Down=true};
        {A=true};
        {A=true};
        {Down=true};
        {Down=true};
        {A=true};
        {A=true};
        {Up=true};
        {A=true};
        {Down=true};
        {Down=true};
        {Down=true};
        {Down=true};
        {A=true};
        {R=true};
        {R=true};
        {R=true};
        {A=true};
        {L=true};
        {Down=true};
        {Down=true};
        {A=true};
        {Right=true};
        {R=true};
        {Down=true};
        {A=true};
        {A=true};
        {Down=true};
        {A=true};
        {A=true};
    });
end);

setups.add_folder_edit("Folder 9: Undernet", function()
    setups.folder_edit_buttons({
        {Down=true};
        {Down=true};
        {Down=true};
        {Down=true};
        {Down=true};
        {A=true};
        {R=true};
        {R=true};
        {Up=true};
        {Up=true};
        {A=true};
        {Up=true};
        {A=true};
        {L=true};
        {Down=true};
        {Down=true};
        {Down=true};
        {Down=true};
        {A=true};
        {Down=true};
        {A=true};
        {R=true};
        {R=true};
        {R=true};
        {A=true};
        {Up=true};
        {A=true};
        {Up=true};
        {Up=true};
        {Up=true};
        {Up=true};
        {A=true};
    });
end);

setups.add_folder_edit("Folder 10: WWW", function()
    setups.folder_edit_buttons({
        {R=true};
        {R=true};
        {Up=true};
        {A=true};
        {R=true};
        {R=true};
        {Down=true};
        {A=true};
    });
end);

return { sequences=setups.sequences; folder_edits= setups.folder_edits};

