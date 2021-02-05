-- Specific Sequences of Inputs for MMBN 2 scripting, enjoy.

local setups = {};

local function next_frame(message, ...)
    message = message or "";
    gui.pixelText(0, 0, string.format(message, ...));
    emu.frameadvance();
end

local function wait_for(what, frames, buttons)
    buttons = buttons or {};
    for i=1,frames do
        joypad.set(buttons);
        next_frame("Waiting for %s: %4i", what, frames-i);
    end
end

local function soft_reset()
    joypad.set({A=true, B=true, Start=true, Select=true});
    next_frame();
    
    wait_for("START", 65+5);
    
    joypad.set({Start=true});
    next_frame();
    
    joypad.set({A=true});
    next_frame();
end

local setup_teleport = {description = "Open & Close Menu"};
function setup_teleport.doit()
    joypad.set({Start=true});
    next_frame();
    joypad.set({Start=true});
    next_frame();
    wait_for("Menu", 20);
    
    joypad.set({A=true});
    next_frame();
    joypad.set({A=true});
    next_frame();
    wait_for("Menu", 40);
    
    joypad.set({B=true});
    next_frame();
    joypad.set({B=true});
    next_frame();
    wait_for("Menu", 60);
    
    joypad.set({B=true});
    next_frame();
    joypad.set({B=true});
    next_frame();
    wait_for("Menu", 30);
end
table.insert(setups, setup_teleport);

local setup_gutsman = {description = "GutsMan"};
function setup_gutsman.doit()
    soft_reset();
    
    wait_for("Area Load", 40);
    
    joypad.set({A=true});
    next_frame();
    wait_for("Text", 20);
    
    joypad.set({A=true});
    next_frame();
    wait_for("Text", 10);
    
    joypad.set({A=true});
    next_frame();
    wait_for("Text", 15);
    
    joypad.set({A=true});
    next_frame();
    wait_for("Text", 20);
    
    joypad.set({Left=true});
    next_frame();
    joypad.set({Left=true});
    next_frame();
    joypad.set({A=true});
    next_frame();
    wait_for("Text", 15);
    
    joypad.set({A=true});
    next_frame();
    
    wait_for("RNG", 87+6);
    
    joypad.set({A=true}); -- RNG Index: 354-364 (359)
    next_frame();
end
table.insert(setups, setup_gutsman);

local function folder_edit_button(button)
    -- Up, Down, L, and R require 2 frames to fire
    next_frame();
    joypad.set(button);
    next_frame();
    joypad.set(button);
    next_frame();
    if button.Right or button.Left then
        wait_for("Folder Transition", 15);
    end
end

local function folder_edit_buttons(buttons)
    for i,button in pairs(buttons) do
        folder_edit_button(button);
    end
end

local setup_folder_empty = {description = "Folder 0: Remove All Chips"};
function setup_folder_empty.doit()
    for i=1,30 do
        folder_edit_buttons({
            {A=true};
            {A=true};
            {Down=true};
        });
    end
end
table.insert(setups, setup_folder_empty);

local setup_folder_template = {description = "Folder #: Name"};
function setup_folder_template.doit()
    folder_edit_buttons({
        {A=true};
        {B=true};
        {L=true};
        {R=true};
        {Up=true};
        {Down=true};
        {Left=true};
        {Right=true};
        {Start=true};
    });
end
--table.insert(setups, setup_folder_template);

return setups;

