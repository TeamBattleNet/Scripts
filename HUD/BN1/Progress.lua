-- Story Progress Byte values for MMBN 1 scripting, enjoy.

-- https://forums.therockmanexezone.com/viewtopic.php?p=346421#p346421

local progress_names = {};

progress_names[0x00] = "";

progress_names[0x00] = "New Game";
progress_names[0x01] = "Tutorial Start";
progress_names[0x02] = "Tutorial Finished";
progress_names[0x03] = "Oven on fire";
progress_names[0x04] = "Oven explosion";
progress_names[0x05] = "Water Gun";
progress_names[0x06] = "FireMan Deleted";

progress_names[0x10] = "FireMan Bedtime";
progress_names[0x11] = "Class 5-A Chat";
progress_names[0x12] = "Talked to Dex";
progress_names[0x13] = "Unlocked 1st Number Door";
progress_names[0x14] = "Unlocked 3rd Number Door";
progress_names[0x15] = "MegaMan Trapped";

progress_names[0x20] = "NumberMan Deleted";
progress_names[0x21] = "Talked to Conductor";
progress_names[0x22] = "StoneMan Deleted";
progress_names[0x23] = "Dad's PowerUP";
progress_names[0x24] = "School Cancelled";
progress_names[0x25] = "SciLab (At Night)";
progress_names[0x26] = "ColdBears Deleted";
progress_names[0x27] = "Freed OSG from car";

progress_names[0x30] = "IceMan Deleted";
progress_names[0x31] = "Traffic Lights Hijacked";
progress_names[0x32] = "1st Light Fixed";
progress_names[0x33] = "WWW Exposed";
progress_names[0x34] = "2nd Light Fixed";
progress_names[0x35] = "3rd Light Fixed";
progress_names[0x36] = "4th Light Fixed";
progress_names[0x37] = "5th Light Fixed";

progress_names[0x40] = "ColorMan Deleted";
progress_names[0x41] = "Count Zap Appears";
progress_names[0x42] = "Generator Control Room";
progress_names[0x43] = "Battery Puzzles Solved";

progress_names[0x50] = "ProtoMan Deleted";
progress_names[0x51] = "Door Virus Deleted";
progress_names[0x52] = "BombMan Deleted";
progress_names[0x53] = "BombMan Bedtime";
progress_names[0x54] = "Expired WWW Pass Secret Station";

--ram.progress_names[ram.get_progress()];

return progress_names;

