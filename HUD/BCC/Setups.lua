-- Specific Sequences of Inputs for BCC scripting, enjoy.

local setups = require("All/Setups");

setups.delay_bios   = 282; -- BN 1
setups.delay_capcom =  31; -- BN 1
setups.delay_title  =  65; -- BN 1

setups.add_setup(setups.group_misc, "TEST BUTTONS", function()
    --setups.soft_reset();
    --setups.hard_reset();
    --setups.CONTINUE(0);
    setups.press_buttons(37+8, "Loading...."); -- area loading varies
    setups.press_buttons( 1, "PRESS START", {Start=true});
end);

return setups.groups;

