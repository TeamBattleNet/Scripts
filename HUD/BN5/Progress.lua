-- Progress values for MMBN 5 scripting, enjoy.

-- TODO

local progress = {};

progress.scenarios = {
    { value = 0x00; description = "Liberation 1"};
};

progress[0x00] = "New Game";
progress[0x01] = "Tutorial Start";
progress[0x02] = "Tutorial Finished";

progress[0x88] = "Final State";

progress[0xFF] = "No Save Data";

return progress;

