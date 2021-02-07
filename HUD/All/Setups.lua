-- Specific Sequences of Inputs for MMBN scripting, enjoy.

local setups = {};

setups.sequences = {};
setups.folder_edits = {};
setups.these_buttons = {};
setups.override_inputs = false;

local function input_override_BN_HUD()
    if setups.override_inputs then
        joypad.set({ Up=false; Down=false; Left=false; Right=false; Start=false; Select=false; B=false; A=false; L=false; R=false; });
        joypad.set(setups.these_buttons);
    end
end

setups.input_override_BN_HUD_reference = event.onframestart(input_override_BN_HUD, "input_override_BN_HUD");

function setups.setup_wrapper(some_setup)
    setups.override_inputs = true;
    some_setup();
    setups.these_buttons = {}; -- one frame with no inputs to prevent looping
    emu.frameadvance();
    setups.override_inputs = false;
end

function setups.add_sequence(text, some_setup)
    table.insert(setups.sequences, { description = text; doit = function() setups.setup_wrapper(some_setup); end; });
end

function setups.add_folder_edit(text, some_setup)
    table.insert(setups.folder_edits, { description = text; doit = function() setups.setup_wrapper(some_setup); end; });
end

function setups.press_buttons(frames, text, buttons)
    for i=1,frames do
        gui.pixelText(0, 0, string.format("%-22s", text));
        gui.pixelText(0, 9, string.format("Frames Remaining: %4i", frames-i));
        setups.these_buttons = buttons or {};
        emu.frameadvance();
    end
end

function setups.soft_reset()
    setups.press_buttons(   1, "Soft Reset", {A=true, B=true, Start=true, Select=true});
    setups.press_buttons(65+5, "START",      {});
    setups.press_buttons(   1, "Start",      {Start=true});
    setups.press_buttons(   1, "PressA",     {A=true});
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

