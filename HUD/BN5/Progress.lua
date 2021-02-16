-- Progress values for MMBN 5 scripting, enjoy.

-- https://forums.therockmanexezone.com/bn5-story-progression-value-list-t5352.html

local progress = {};

progress.scenarios = {
    { value = 0x00; description = "Liberation 1"};
};

progress[0x00] = "New Game";
progress[0x01] = "Tutorial Done";

progress[0x88] = "Final State";

progress[0xFF] = "No Save Data";

return progress;

