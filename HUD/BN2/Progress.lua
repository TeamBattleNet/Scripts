-- Progress values for MMBN 2 scripting, enjoy.

-- TODO: TREZ Post

local progress = {};

progress.scenarios = {
    { value = 0x00; description = "Yai's Fan Collection"    };
    { value = 0x10; description = "Bees, Bears, and Bombs!" };
    { value = 0x20; description = "TBD" };
    { value = 0x30; description = "TBD" };
    { value = 0x40; description = "Final Scenario" };
};

progress[0x00] = "New Game";
progress[0x01] = "Talked to Dex";
progress[0x02] = "Tutorial Done";
progress[0x03] = "ZLicense Exam";
progress[0x04] = "ZLicense Pass";
progress[0x05] = "Talked to Dex";
progress[0x06] = "Ventilator Cleared";
progress[0x07] = "AirMan Deleted";
progress[0x08] = "Gone to bed";

progress[0x10] = "TBD";

progress[0x20] = "TBD";

progress[0x30] = "TBD";

progress[0x40] = "TBD";
progress[0x41] = "TBD";
progress[0x42] = "TBD";
progress[0x43] = "TBD";
progress[0x44] = "TBD";
progress[0x45] = "TBD";
progress[0x46] = "TBD";
progress[0x47] = "Final State";
progress[0x48] = "Credits"; -- ?

progress[0xFF] = "No Save Data";

return progress;

