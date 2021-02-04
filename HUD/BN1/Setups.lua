-- Specific Sequences of Inputs for MMBN 1 scripting, enjoy.

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

local setup_skullman = {description = "SkullMan (2nd Talk)"};
function setup_skullman.doit()
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
    
    wait_for("RNG", 87);
    
    joypad.set({A=true}); -- RNG Index: 354-364 (359)
    next_frame();
end
table.insert(setups, setup_skullman);

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

local setup_folder_tutorial = {description = "Folder 1: Tutorial"};
function setup_folder_tutorial.doit()
    folder_edit_buttons({
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
end
table.insert(setups, setup_folder_tutorial);

local setup_folder_school = {description = "Folder 2: School"};
function setup_folder_school.doit()
    folder_edit_buttons({
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
end
table.insert(setups, setup_folder_school);

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

--[[

NumberMan:
R V A A
V V A A
R R V A A
R L A
> A A A A A A A

GutsMan:
R A
V A
V V A
R A
^ A
R A
V A
R L V A
L ^ A
L L ^ A

StoneMan:
A A
V A A
V A A
V V A A
R R A A
^ A A
^ ^ A A
> V A A A A A A A A A A
V A A
^ A A

SkullMan:
A R A
R R R V A A
V A
L L L L A
^ A
R V V V A
R V V A
> A
V V A A

Traffic 3:
R ^ A A
V V V A
R V V V V A
R R A
L V V A
L ^ A A
V V V A
> V V A
V V A A
^ ^ ^ ^ A A

Power 4:
R V A A
V V A A
^ A
V V V V A
R R R A
L V V A
> R V A A
V A A

Undernet:
V V V V V A
R R ^ ^ A
^ A
L V V V V A
V A
R R R A
^ A
^ ^ ^ ^ A

--]]

