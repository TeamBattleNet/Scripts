-- Input wrapper for MMBN HUD.

local buttons = {};

local settings = require("All/Settings");

buttons.keys = {};
buttons.keys.held = {};
buttons.keys.previous = {};
buttons.keys.down = {};

buttons.held = {};
buttons.previous = {};
buttons.down = {};

local buttons_ignore = {};

local function disable_button(button, to_false)
    if buttons_ignore[button] then
        if buttons.held[button] then
            joypad.set(to_false);
            buttons.down[button] = false;
        elseif buttons.previous[button] then
            -- wait 1 more frame
        else
            buttons_ignore[button] = false;
        end
    elseif buttons.down[button] then
        joypad.set(to_false);
        buttons_ignore[button] = true;
    end
end

local function disable_buttons_in_command_mode()
    disable_button("Up"    , {Up=false}    );
    disable_button("Down"  , {Down=false}  );
    disable_button("Left"  , {Left=false}  );
    disable_button("Right" , {Right=false} );
    disable_button("Start" , {Start=false} );
    disable_button("Select", {Select=false});
    disable_button("B"     , {B=false}     );
    disable_button("A"     , {A=false}     );
    disable_button("L"     , {L=false}     );
    disable_button("R"     , {R=false}     );
end

local function process_inputs_BN_HUD()
    buttons.held = joypad.get(); -- controller only
    buttons.keys.held = input.get(); -- controller, keyboard, and mouse
    
    buttons.down.Up     = (buttons.held.Up     and not buttons.previous.Up    );
    buttons.down.Down   = (buttons.held.Down   and not buttons.previous.Down  );
    buttons.down.Left   = (buttons.held.Left   and not buttons.previous.Left  );
    buttons.down.Right  = (buttons.held.Right  and not buttons.previous.Right );
    buttons.down.Start  = (buttons.held.Start  and not buttons.previous.Start );
    buttons.down.Select = (buttons.held.Select and not buttons.previous.Select);
    buttons.down.B      = (buttons.held.B      and not buttons.previous.B     );
    buttons.down.A      = (buttons.held.A      and not buttons.previous.A     );
    buttons.down.L      = (buttons.held.L      and not buttons.previous.L     );
    buttons.down.R      = (buttons.held.R      and not buttons.previous.R     );
    buttons.down.Power  = (buttons.held.Power  and not buttons.previous.Power );
    
    buttons.keys.down.Up           = (buttons.keys.held.Up           and not buttons.keys.previous.Up          );
    buttons.keys.down.Down         = (buttons.keys.held.Down         and not buttons.keys.previous.Down        );
    buttons.keys.down.Left         = (buttons.keys.held.Left         and not buttons.keys.previous.Left        );
    buttons.keys.down.Right        = (buttons.keys.held.Right        and not buttons.keys.previous.Right       );
    buttons.keys.down.Tab          = (buttons.keys.held.Tab          and not buttons.keys.previous.Tab         );
    buttons.keys.down.Keypad0      = (buttons.keys.held.Keypad0      and not buttons.keys.previous.Keypad0     );
    buttons.keys.down.Keypad1      = (buttons.keys.held.Keypad1      and not buttons.keys.previous.Keypad1     );
    buttons.keys.down.Keypad2      = (buttons.keys.held.Keypad2      and not buttons.keys.previous.Keypad2     );
    buttons.keys.down.Keypad3      = (buttons.keys.held.Keypad3      and not buttons.keys.previous.Keypad3     );
    buttons.keys.down.Keypad4      = (buttons.keys.held.Keypad4      and not buttons.keys.previous.Keypad4     );
    buttons.keys.down.Keypad5      = (buttons.keys.held.Keypad5      and not buttons.keys.previous.Keypad5     );
    buttons.keys.down.Keypad6      = (buttons.keys.held.Keypad6      and not buttons.keys.previous.Keypad6     );
    buttons.keys.down.Keypad7      = (buttons.keys.held.Keypad7      and not buttons.keys.previous.Keypad7     );
    buttons.keys.down.Keypad8      = (buttons.keys.held.Keypad8      and not buttons.keys.previous.Keypad8     );
    buttons.keys.down.Keypad9      = (buttons.keys.held.Keypad9      and not buttons.keys.previous.Keypad9     );
    buttons.keys.down.KeypadPeriod = (buttons.keys.held.KeypadPeriod and not buttons.keys.previous.KeypadPeriod);
    
    if settings.command_mode then
        disable_buttons_in_command_mode();
    end
    
    buttons.previous = buttons.held;
    buttons.keys.previous = buttons.keys.held;
end

buttons.process_inputs_BN_HUD_reference = event.onframestart(process_inputs_BN_HUD, "process_inputs_BN_HUD");

return buttons;

