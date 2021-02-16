-- Progress values for MMBN 5 scripting, enjoy.

-- https://forums.therockmanexezone.com/bn5-story-progression-value-list-t5352.html

local progress = {};

progress.scenarios = {
    { value = 0x00; description = "Liberation 1"};
    { value = 0x10; description = "Liberation 2"};
    { value = 0x20; description = "Liberation 3"};
    { value = 0x30; description = "Liberation 4"};
    { value = 0x40; description = "Liberation 5"};
    { value = 0x50; description = "Liberation 6"};
    { value = 0x60; description = "Nebula Gray"};
};

progress[0x00] = "New Game";
progress[0x01] = "Tutorial Done";
progress[0x02] = "Deliver StewRec.";
progress[0x03] = "Dad gets kidnapped";
progress[0x04] = "Defeat HeelNavi in ACDC Area2";
progress[0x05] = "Get Dad's ID";
progress[0x06] = "Meet Team Leader";
progress[0x07] = "Sleep";
progress[0x10] = "Delete BlizzardMan";

progress[0x11] = "Complete Patrol of ACDC Area3";
progress[0x12] = "\"Houdini of the Beach\"!";
progress[0x13] = "Get shot at by Turrets in Oran Area1";
progress[0x14] = "Friends Fall into Mine";
progress[0x15] = "Enter DrillComp1";
progress[0x16] = "Defeat KnightMan";
progress[0x17] = "Exit the Mine";
progress[0x20] = "Delete ShadeMan";

progress[0x21] = "Find ShadowMan";
progress[0x22] = "Enter SciLab1";
progress[0x23] = "Sleep";
progress[0x24] = "Chat with Team Leader";
progress[0x25] = "Defeat ShadowMan";
progress[0x30] = "Delete CloudMan";

progress[0x31] = "Get Colonel";
progress[0x32] = "Encounter DarkMega in End Area1";
progress[0x33] = "Sleep";
progress[0x34] = "Input Engine Room Code";
progress[0x35] = "Confront HeelNavi in EngineComp";
progress[0x36] = "Enter ShipComp1";
progress[0x37] = "Defeat TomahawkMan";
progress[0x40] = "Defeat Dark Mega";

progress[0x41] = "Approach Number Door in End Area4";
progress[0x42] = "Discover Door to ACDC Past";
progress[0x43] = "Delete all HeelNavis in ACDC Past";
progress[0x44] = "Sleep";
progress[0x45] = "Reach Castle Roof";
progress[0x46] = "Defeat NumberMan";
progress[0x50] = "Delete CosmoMan";

progress[0x51] = "Talk to Mom about Gow";
progress[0x52] = "Discover Door to Oran Past";
progress[0x53] = "BlizzardMan Steals Gow";
progress[0x54] = "Defend SciLab HP";
progress[0x55] = "Deliver DataFile to Higsby";
progress[0x56] = "Sleep";
progress[0x60] = "Defeat Dark Colonel";

progress[0x61] = "Defeat NumberMan";
progress[0x62] = "Destroy all Micro Servers";
progress[0x63] = "Destroy the Server in Undernet 4";
progress[0x64] = "Sleep";
progress[0x65] = "Enter DrkChpFactry";
progress[0x66] = "Final State";
progress[0x67] = "Epilogue";

progress[0xFF] = "No Save Data";

return progress;

