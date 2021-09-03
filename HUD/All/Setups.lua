-- Specific Sequences of Inputs for MMBN scripting, enjoy.

-- Note: When setting A in Lua, it happens before next_frame();
-- Note: When pressing A on Controller, it happens after next_frame();
-- Note: Game load (RNG freeze) happens 17 frames after Controller A, but 18 frames after Lua A

local setups = {};

setups.groups = {};
setups.these_buttons = {};

local settings = require("All/Settings");

settings.override_inputs = false;

local all_buttons_to_false = { Up=false; Down=false; Left=false; Right=false; Start=false; Select=false; B=false; A=false; L=false; R=false; };

local function input_override_BN_HUD()
    if settings.override_inputs then
        joypad.set(all_buttons_to_false);
        joypad.set(setups.these_buttons);
    end
end

setups.input_override_BN_HUD_reference = event.onframestart(input_override_BN_HUD, "input_override_BN_HUD");

function setups.setup_wrapper(some_setup)
    settings.override_inputs = true;
    some_setup();
    --setups.press_buttons(1, "Command Menu Setup Loop Prevention");
    settings.override_inputs = false;
end

function setups.create_group(description)
    local group = {};
    group.setups = {};
    group.description = description;
    table.insert(setups.groups, group);
    return group;
end

function setups.add_setup(group, text, some_setup)
    table.insert(group.setups, { description = text; doit = function() setups.setup_wrapper(some_setup); end; });
end

function setups.press_buttons(frames, text, buttons)
    for i=1,frames do
        gui.text(2,  2, string.format("Currently: %-22s", text));
        gui.text(2, 18, string.format("Remaining: %3i", frames-i));
        setups.these_buttons = buttons or {};
        emu.frameadvance();
    end
end

setups.delay_bios   = 282; -- BN 1
setups.delay_capcom =  31; -- BN 1
setups.delay_title  =  65; -- BN 1

function setups.PRESS_START(delay)
    setups.press_buttons(setups.delay_title, "WAIT FOR IT");
    setups.press_buttons(delay or 0, "delaying");
    setups.press_buttons(1, "START", {Start=true});
end

function setups.CONTINUE(delay)
    setups.PRESS_START(delay);
    setups.press_buttons(1, "PressA", {A=true});
end

function setups.soft_reset()
    setups.press_buttons(1, "Soft Reset", {A=true; B=true; Start=true; Select=true});
end

function setups.hard_reset()
    setups.press_buttons(1, "Hard Reset", {Power=true});
    setups.press_buttons(setups.delay_bios, "BIOS");
    setups.press_buttons(setups.delay_capcom, "Capcom", {Start=true});
end

function setups.folder_edit_button(button)
    -- Up, Down, L, and R require 2 frames to fire
    setups.press_buttons(1, "Waiting..", {});
    setups.press_buttons(2, "Press It!", button);
    if button.Right or button.Left then
        setups.press_buttons(15, "Sliding..", {});
    end
end

function setups.folder_edit_buttons(buttons)
    for i,button in pairs(buttons) do
        setups.folder_edit_button(button);
    end
end

---------------------------------------- Miscellaneous Group ----------------------------------------

setups.group_misc = setups.create_group("Miscellaneous");

setups.add_setup(setups.group_misc, "Open & Close Menu", function()
    setups.press_buttons( 2, "Menu", {Start=true});
    setups.press_buttons(20, "Menu");
    setups.press_buttons( 2, "Menu", {A=true});
    setups.press_buttons(40, "Menu");
    setups.press_buttons( 2, "Menu", {B=true});
    setups.press_buttons(60, "Menu");
    setups.press_buttons( 2, "Menu", {B=true});
    setups.press_buttons(30, "Menu");
end);

setups.add_setup(setups.group_misc, "START A", function()
    setups.press_buttons(2, "PRESS START", {Start=true});
    setups.press_buttons(2, "PRESS A", {A=true});
end);

setups.add_setup(setups.group_misc, "One Step Up, Pause", function()
    setups.press_buttons( 2, "Step", {Up=true});
    setups.press_buttons( 1, "Start", {Start=true});
end);

setups.add_setup(setups.group_misc, "One Step Down, Pause", function()
    setups.press_buttons( 2, "Step", {Down=true});
    setups.press_buttons( 1, "Start", {Start=true});
end);

setups.add_setup(setups.group_misc, "One Step Left, Pause", function()
    setups.press_buttons( 2, "Step", {Left=true});
    setups.press_buttons( 1, "Start", {Start=true});
end);

setups.add_setup(setups.group_misc, "One Step Right, Pause", function()
    setups.press_buttons( 2, "Step", {Right=true});
    setups.press_buttons( 1, "Start", {Start=true});
end);

return setups;

