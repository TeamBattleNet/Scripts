-- Progress values for MMBN 3 scripting, enjoy.

-- TODO: TREZ Post

local progress = {};

progress.scenarios = {
    { value = 0x00; description = "Scenario 1.. at night" };
    { value = 0x10; description = "TBD" };
    { value = 0x20; description = "TBD" };
    { value = 0x30; description = "TBD" };
    { value = 0x40; description = "TBD" };
    { value = 0x50; description = "TBD" };
    { value = 0x60; description = "TBD" };
    { value = 0x70; description = "Final Scenario" };
};

progress[0x00] = "New Game";
progress[0x01] = "Tutorial Done";
progress[0x79] = "Final State";
progress[0x7A] = "Credits";
progress[0xFF] = "No Save Data";

return progress;

