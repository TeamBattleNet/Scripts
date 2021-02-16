-- Progress values for BCC scripting, enjoy.

-- TODO

local progress = {};

progress.scenarios = {
    { value = 0x00; description = "BCCplaysBCC"};
};

progress[0x00] = "New Game";

progress[0xFF] = "No Save Data";

return progress;

