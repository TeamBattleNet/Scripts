-- Specific Sequences of Inputs for MMBN scripting, enjoy.

local setups = {};

setups.groups = {};
setups.these_buttons = {};

local settings = require("All/Settings");

settings.override_inputs = false;

local function input_override_BN_HUD()
    if settings.override_inputs then
        joypad.set({ Up=false; Down=false; Left=false; Right=false; Start=false; Select=false; B=false; A=false; L=false; R=false; });
        joypad.set(setups.these_buttons);
    end
end

setups.input_override_BN_HUD_reference = event.onframestart(input_override_BN_HUD, "input_override_BN_HUD");

function setups.setup_wrapper(some_setup)
    settings.override_inputs = true;
    some_setup();
    setups.these_buttons = {}; -- one frame with no inputs to prevent looping
    emu.frameadvance();
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
        gui.text(2,  2, string.format("%-23s", text));
        gui.text(2, 18, string.format("Frames Remaining: %5i", frames-i));
        setups.these_buttons = buttons or {};
        emu.frameadvance();
    end
end

function setups.PRESS_START(delay)
    setups.press_buttons(65,        "WAIT FOR IT");
    setups.press_buttons(delay or 0,   "delaying");
    setups.press_buttons(1, "START", {Start=true});
    setups.press_buttons(1, "PressA",    {A=true});
end

function setups.soft_reset(delay)
    setups.press_buttons(1, "Soft Reset", {A=true; B=true; Start=true; Select=true});
    setups.PRESS_START(delay or 0);
end

function setups.hard_reset(delay)
    setups.press_buttons(1, "Hard Reset", {Power=true});
    setups.press_buttons(282, "BIOS");
    setups.press_buttons( 31, "Capcom", {Start=true});
    setups.PRESS_START(delay or 0);
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

return setups;

