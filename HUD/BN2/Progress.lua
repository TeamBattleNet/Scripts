-- Progress values for MMBN 2 scripting, enjoy.

-- TODO: TREZ Post

local progress = {};

progress.scenarios = {
    { value = 0x00; description = "Gas, Bees, and Bombs" };
    { value = 0x10; description = "Mercenaries For Hire" };
    { value = 0x20; description = "International Theft"  };
    { value = 0x30; description = "Flying Through Ice"   };
    { value = 0x40; description = "Internet Radiation"   };
};

progress[0x00] = "New Game";
progress[0x01] = "Talked to Dex";
progress[0x02] = "Tutorial Done";
progress[0x03] = "ZLicense Exam";
progress[0x04] = "ZLicense Passed";
progress[0x05] = "Dex Breaks Into Yai's";
progress[0x06] = "Ventilator Cleared";
progress[0x07] = "AirMan Deleted";
progress[0x08] = "Gone to Bed";
progress[0x09] = "BLicense Gauntlet 1";
progress[0x0A] = "Gone to Bed";
progress[0x0B] = "Gone Camping";
progress[0x0C] = "BEEEEEEEEEEEEEEEEEEEEEES";
progress[0x0D] = "Bear Defeated";
progress[0x0E] = "Cookout Cancelled";
progress[0x0F] = "Scavenger Hunt Begins";

progress[0x10] = "QuickMan Deleted";
progress[0x11] = "YumLand Access Denied";
progress[0x12] = "Request Missions";
progress[0x13] = "ALicense Exam";
progress[0x14] = "ALicense Passed";
progress[0x15] = "YumLand Square";
progress[0x16] = "CutMan Deleted";
progress[0x17] = "TalkToDad";
progress[0x18] = "IronMan BBS";
progress[0x19] = "YumLand Treasure Get";
progress[0x1A] = "Escaped From YumLand";
progress[0x1B] = "Goofball Attacks";
progress[0x1C] = "ShadowMan Attacks";
progress[0x1D] = "Official Beam Cannon!";
progress[0x1E] = "Meeting With ProtoMan";
progress[0x1F] = "ShadowMan Fight";

progress[0x20] = "ShadowMan Deleted";
progress[0x21] = "Entered Airport";
progress[0x22] = "PET Stolen";
progress[0x23] = "Money Stolen";
progress[0x24] = "Now In Netopia!"; -- Namaste!!
progress[0x25] = "Chips Stolen";
progress[0x26] = "MegaDummy!";
progress[0x27] = "Passport Stolen";
progress[0x28] = "Passport Recovered";
progress[0x29] = "SnakeMan Deleted";
progress[0x2A] = "Gone to Bed";
progress[0x2B] = "Ceiling Panic!";
progress[0x2C] = "Burning Ring Of Fire";
progress[0x2D] = "Raoul Gets Crispy";

progress[0x30] = "Souveniers";
progress[0x31] = "Gigantic Aeroplane";
progress[0x32] = "Airplane Food";
progress[0x33] = "BathroomSplits";
progress[0x34] = "Gigantic Spider";
progress[0x35] = "Helping MacGyver";
progress[0x36] = "ProbablyAVirus";
progress[0x37] = "MagnetMan Deleted";
progress[0x38] = "One Cold Morning";
progress[0x39] = "RedCure Get";
progress[0x3A] = "UnderBBS Doc";
progress[0x3B] = "Undernet 3";
progress[0x3C] = "Null & Void";
progress[0x3D] = "FreezeMan Deleted";

progress[0x40] = "Final Day";
progress[0x41] = "Gospel HQ";
progress[0x42] = "TalkToDad";
progress[0x43] = "Internet Radiation";
--progress[0x44] = "Unused";
progress[0x45] = "Apartment Comps";
progress[0x46] = "Penthouse Suite";
progress[0x47] = "Final State";
progress[0x48] = "You Can't Go Back";

progress[0xFF] = "No Save Data";

return progress;

