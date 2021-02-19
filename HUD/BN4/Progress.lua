-- Progress values for MMBN 4 scripting, enjoy.

-- https://forums.therockmanexezone.com/bn1-story-progression-value-list-t5340.html

local progress = {};

progress.scenarios = {
    { value = 0x00; description = "TBD" };
    { value = 0x10; description = "TBD" };
    { value = 0x20; description = "TBD" };
    { value = 0x30; description = "TBD" };
    { value = 0x40; description = "TBD" };
    { value = 0x50; description = "TBD" };
    { value = 0x60; description = "TBD" };
};

progress[0x00] = "New Game";
progress[0x01] = "Tutorial Finished";

progress[0xFF] = "No Save Data";

return progress;

