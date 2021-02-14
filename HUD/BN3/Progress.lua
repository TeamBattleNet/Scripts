-- Progress values for MMBN 3 scripting, enjoy.

-- TODO: TREZ Post

local progress = {};

progress.scenarios = {
    { value = 0x00; description = "Scenario 1.. at night" };
    { value = 0x10; description = "Prelims, Pandas, and Dex" };
    { value = 0x20; description = "TBD" };
    { value = 0x30; description = "TBD" };
    { value = 0x40; description = "TBD" };
    { value = 0x50; description = "TBD" };
    { value = 0x60; description = "TBD" };
    { value = 0x70; description = "Final Scenario" };
};

--progress[0x] = "WWWWWWWWWWWWWWWWWWWWW";
--progress[0x] = "WWWWWWWWWWWWWWWWWWWWWWWWW";

progress[0x00] = "New Game";
progress[0x01] = "Tutorial Done";
progress[0x02] = "ACDC Park Meeting";
progress[0x03] = "ACDC Prelims Cleared";
progress[0x04] = "ACDC Town.. at night";
progress[0x05] = "School Gate Open";
progress[0x06] = "Class 5-A.. at night";
progress[0x07] = "Spoooky Noises";
progress[0x08] = "Hypno Flash!";
progress[0x09] = "Parasol Wins Again";
progress[0x0A] = "FlashMan Deleted";

progress[0x10] = "Bedtime.. at night";
progress[0x11] = "Best ACDC Netbattler";
progress[0x12] = "Fought With Dex";
progress[0x13] = "TBD";

progress[0x20] = "TBD";

progress[0x30] = "TBD";

progress[0x40] = "TBD";

progress[0x50] = "TBD";

progress[0x60] = "TBD";

progress[0x70] = "TBD";
progress[0x71] = "TBD";
progress[0x72] = "TBD";
progress[0x73] = "TBD";
progress[0x74] = "TBD";
progress[0x75] = "TBD";
progress[0x76] = "TBD";
progress[0x77] = "TBD";
progress[0x78] = "TBD";
progress[0x79] = "Final State";
progress[0x7A] = "Credits";
progress[0xFF] = "No Save Data";

return progress;

