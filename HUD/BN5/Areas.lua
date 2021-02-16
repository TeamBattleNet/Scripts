-- Area names for MMBN 5 scripting, enjoy.

-- https://forums.therockmanexezone.com/list-of-mmbn5-areas-and-subareas-t5343.html

local areas = {};

areas.names = {};

areas.real_groups    = {0x00};
areas.digital_groups = {0x80};

areas.names[0x00] = {};
areas.names[0x00].group = "ACDC Town";
areas.names[0x00][0x00] = "ACDC Town";
areas.names[0x00][0x01] = "Lan's House";
areas.names[0x00][0x02] = "Lan's Room";
areas.names[0x00][0x03] = "Mayl's Room";
areas.names[0x00][0x04] = "Dex's Room";
areas.names[0x00][0x05] = "Yai's Room";
areas.names[0x00][0x06] = "Higsby's";
areas.names[0x00][0x07] = "Higsby's Base";

areas.names[0x01] = {};
areas.names[0x01].group = "SciLab";
areas.names[0x01][0x00] = "Dad's Lab";
areas.names[0x01][0x01] = "SciLab Front";
areas.names[0x01][0x02] = "SciLab Lobby";
areas.names[0x01][0x03] = "Op Room";
areas.names[0x01][0x04] = "Mission Control";

areas.names[0x02] = {};
areas.names[0x02].group = "Oran Isle";
areas.names[0x02][0x00] = "Oran Isle";
areas.names[0x02][0x01] = "Old Mine";
areas.names[0x02][0x02] = "Big Cave";
areas.names[0x02][0x03] = "Old Mine 1";
areas.names[0x02][0x04] = "Old Mine 2";
areas.names[0x02][0x05] = "Old Mine 3";
areas.names[0x02][0x06] = "Old Mine 4";
areas.names[0x02][0x07] = "Old Mine 5";
areas.names[0x02][0x08] = "Old Mine 6";
areas.names[0x02][0x09] = "Old Mine 7";
areas.names[0x02][0x0A] = "Old Mine 8";
areas.names[0x02][0x0B] = "Old Mine 9";

areas.names[0x03] = {};
areas.names[0x03].group = "Queen Bohemia";
areas.names[0x03][0x00] = "Dock";
areas.names[0x03][0x01] = "Hall";
areas.names[0x03][0x02] = "Deck";
areas.names[0x03][0x03] = "Engine Room";
areas.names[0x03][0x04] = "Fiesta Room";
areas.names[0x03][0x05] = "Bridge";

areas.names[0x04] = {};
areas.names[0x04].group = "End City";
areas.names[0x04][0x00] = "End City";
areas.names[0x04][0x01] = "Mum Room";
areas.names[0x04][0x02] = "Lily Room";
areas.names[0x04][0x03] = "Castle Keep";
areas.names[0x04][0x04] = "Castle Exterior";

areas.names[0x05] = {};
areas.names[0x05].group = "Mt. Belenus";
areas.names[0x05][0x00] = "Nebula Control";
areas.names[0x05][0x01] = "Factory Exterior";
areas.names[0x05][0x02] = "Factory Hall";
areas.names[0x05][0x03] = "DarkChip Factory";
areas.names[0x05][0x04] = "Server Room";

areas.names[0x80] = {};
areas.names[0x80].group = "Main Comp";
areas.names[0x80][0x00] = "Main Comp 1";
areas.names[0x80][0x01] = "Main Comp 2";

areas.names[0x81] = {};
areas.names[0x81].group = "Drill Comp";
areas.names[0x81][0x00] = "Drill Comp 1";
areas.names[0x81][0x01] = "Drill Comp 2";
areas.names[0x81][0x02] = "Drill Comp 3";
areas.names[0x81][0x03] = "Drill Comp 4";

areas.names[0x82] = {};
areas.names[0x82].group = "Ship Comp";
areas.names[0x82][0x00] = "Ship Comp 1";
areas.names[0x82][0x01] = "Ship Comp 2";
areas.names[0x82][0x02] = "Ship Comp 3";
areas.names[0x82][0x03] = "Ship Comp 4";

areas.names[0x83] = {};
areas.names[0x83].group = "Gargoyle Comp";
areas.names[0x83][0x00] = "Gargoyle Comp 1";
areas.names[0x83][0x01] = "Gargoyle Comp 2";
areas.names[0x83][0x02] = "Gargoyle Comp 3";
areas.names[0x83][0x03] = "Gargoyle Comp 4";

areas.names[0x84] = {};
areas.names[0x84].group = "Factory Comp";
areas.names[0x84][0x00] = "Factory Comp 1";
areas.names[0x84][0x01] = "Factory Comp 2";
areas.names[0x84][0x02] = "Factory Comp 3";
areas.names[0x84][0x03] = "Factory Comp 4";
areas.names[0x84][0x04] = "SoulServer Comp";

areas.names[0x86] = {};
areas.names[0x86].group = "Liberation Missions";
areas.names[0x86][0x00] = "ACDC Area 3";
areas.names[0x86][0x01] = "Oran Area 3";
areas.names[0x86][0x02] = "SciLab Area 3";
areas.names[0x86][0x03] = "End Area 2";
areas.names[0x86][0x04] = "End Area 5";
areas.names[0x86][0x05] = "Undernet 4";
areas.names[0x86][0x06] = "Nebula Area 1";
areas.names[0x86][0x07] = "Nebula Area 3";
areas.names[0x86][0x08] = "Nebula Area 5";

areas.names[0x88] = {};
areas.names[0x88].group = "Homepages";
areas.names[0x88][0x00] = "Lan's HP";
areas.names[0x88][0x01] = "Mayl's HP";
areas.names[0x88][0x02] = "Dex's HP";
areas.names[0x88][0x03] = "Yai's HP";
areas.names[0x88][0x04] = "SciLab HP";
areas.names[0x88][0x05] = "Gargoyle Castle HP";
--areas.names[0x88][0x06] = "NaviChange Machine Comp (DS only)";

areas.names[0x00] = {};
areas.names[0x8A].group = "Vision Burst";
areas.names[0xFF][0x00] = "ACDC Town Vision Burst";
areas.names[0xFF][0x01] = "SciLab Vision Burst";
areas.names[0xFF][0x02] = "Oran Isle Vision Burst";

areas.names[0x8C] = {};
areas.names[0x8C].group = "Miscellaneous Comps 1";
areas.names[0x8C][0x00] = "Doghouse Comp";
areas.names[0x8C][0x01] = "Old Terminal Comp";
areas.names[0x8C][0x02] = "Kitchen Comp";
areas.names[0x8C][0x03] = "Electric Lock Comp";
areas.names[0x8C][0x04] = "Radar Comp";
areas.names[0x8C][0x05] = "Air Conditioning Comp";
areas.names[0x8C][0x06] = "Screw Comp";
areas.names[0x8C][0x07] = "Engine Comp";
areas.names[0x8C][0x08] = "View Comp";
areas.names[0x8C][0x09] = "Chip Maker Comp";
areas.names[0x8C][0x0A] = "Air Filter Comp";
areas.names[0x8C][0x0B] = "Armor Comp";
areas.names[0x8C][0x0C] = "Helmet Comp";
areas.names[0x8C][0x0D] = "Katana Comp";
areas.names[0x8C][0x0E] = "Server Comp";
areas.names[0x8C][0x0F] = "Furnace Comp";

areas.names[0x8D] = {};
areas.names[0x8D].group = "Miscellaneous Comps 2";
areas.names[0x8D][0x00] = "Elevator Comp";
areas.names[0x8D][0x01] = "Crane Comp";
areas.names[0x8D][0x02] = "Tree Comp";
areas.names[0x8D][0x03] = "Old Comp";
areas.names[0x8D][0x04] = "Dad's Comp";
areas.names[0x8D][0x05] = "Sculpture Comp";
areas.names[0x8D][0x06] = "Terminal Comp";
areas.names[0x8D][0x07] = "NetBattle Comp";
areas.names[0x8D][0x08] = "Wine Case Comp";
areas.names[0x8D][0x09] = "Dumpling Comp";
areas.names[0x8D][0x0A] = "Experiment Server Comp";
areas.names[0x8D][0x0B] = "Wind God Comp";
areas.names[0x8D][0x0C] = "Pipe Comp";
areas.names[0x8D][0x0D] = "Message Comp";

areas.names[0x8E] = {};
areas.names[0x8E].group = "Squirrel Comp";
areas.names[0x8E][0x00] = "Squirrel Comp 1";
areas.names[0x8E][0x01] = "Squirrel Comp 2";
areas.names[0x8E][0x02] = "Squirrel Comp 3";
areas.names[0x8E][0x03] = "Squirrel Comp 4";
areas.names[0x8E][0x04] = "Squirrel Comp 5";
areas.names[0x8E][0x05] = "Squirrel Comp 6";
areas.names[0x8E][0x06] = "Squirrel Comp 7";
areas.names[0x8E][0x07] = "Squirrel Comp 8";
areas.names[0x8E][0x08] = "Squirrel Comp 9";
areas.names[0x8E][0x09] = "Squirrel Comp 10";
areas.names[0x8E][0x0A] = "Squirrel Comp 11";
areas.names[0x8E][0x0B] = "Squirrel Comp 12";
areas.names[0x8E][0x0C] = "Squirrel Comp 13";
areas.names[0x8E][0x0D] = "Squirrel Comp 14";
areas.names[0x8E][0x0E] = "Squirrel Comp 15";
areas.names[0x8E][0x0F] = "Squirrel Comp 16";

areas.names[0x90] = {};
areas.names[0x90].group = "ACDC Area";
areas.names[0x90][0x00] = "ACDC Area 1";
areas.names[0x90][0x01] = "ACDC Area 2";

areas.names[0x91] = {};
areas.names[0x91].group = "Oran Area";
areas.names[0x91][0x00] = "Oran Area 1";
areas.names[0x91][0x01] = "Oran Area 2";

areas.names[0x92] = {};
areas.names[0x92].group = "SciLab Area";
areas.names[0x92][0x00] = "SciLab Area 1";
areas.names[0x92][0x01] = "SciLab Area 2";
areas.names[0x92][0x02] = "SciLab Area 4";

areas.names[0x93] = {};
areas.names[0x93].group = "End Area";
areas.names[0x93][0x00] = "End Area 1";
areas.names[0x93][0x01] = "End Area 3";
areas.names[0x93][0x02] = "End Area 4";

areas.names[0x94] = {};
areas.names[0x94].group = "The Dark Web";
areas.names[0x94][0x00] = "Undernet 1";
areas.names[0x94][0x01] = "Undernet 2";
areas.names[0x94][0x02] = "Undernet 3";
areas.names[0x94][0x03] = "Nebula Area 2";
areas.names[0x94][0x04] = "Nebula Area 4";
areas.names[0x94][0x05] = "Nebula Area 6";

return areas;

