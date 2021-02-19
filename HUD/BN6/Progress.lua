-- Progress values for MMBN 1 scripting, enjoy.

-- https://forums.therockmanexezone.com/bn1-story-progression-value-list-t5340.html

local progress = {};

progress.scenarios = {
    { value = 0x00; description = "BlastMan Scenario" };
    { value = 0x10; description = "DiveMan Scenario" };
    { value = 0x20; description = "CircusMan Scenario" };
    { value = 0x30; description = "JudgeMan Scenario" };
    { value = 0x40; description = "ElementMan Scenario" };
    { value = 0x50; description = "TBD" };
    { value = 0x60; description = "TBD" };
};

progress[0x00] = "New Game";
progress[0x01] = "Tutorial Finished";
progress[0x02] = "First Day Finished";
progress[0x03] = "School on FIRE";
progress[0x04] = "Robo Control Comps Started";
progress[0x05] = "BlastMan Deleted";

progress[0xFF] = "No Save Data";

return progress;

