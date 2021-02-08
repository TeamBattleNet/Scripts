-- Area names for MMBN 3 scripting, enjoy.

-- https://forums.therockmanexezone.com/list-of-mmbn3-areas-and-subareas-t5354.html

local areas = {};

areas.names = {};

areas.real_groups    = {0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07};
areas.digital_groups = {0x80, 0x81, 0x82, 0x83, 0x88, 0x8A, 0x8C, 0x8D, 0x90, 0x91, 0x92, 0x93, 0x94, 0x95};

areas.names[0x00] = {};
areas.names[0x00].group = "ACDC Town";
areas.names[0x00][0x00] = "ACDC Town";
areas.names[0x00][0x01] = "ACDC Metro Station";
areas.names[0x00][0x02] = "Lan's Living Room";
areas.names[0x00][0x03] = "Lan's Room";
areas.names[0x00][0x04] = "Mayl's Living Room";
areas.names[0x00][0x05] = "Mayl's Room";
areas.names[0x00][0x06] = "Dex's Room";
areas.names[0x00][0x07] = "Yai's Room";
areas.names[0x00][0x08] = "Higsby's Shop";

areas.names[0x01] = {};
areas.names[0x01].group = "ACDC Elementary";
areas.names[0x01][0x00] = "Class 5-A";
areas.names[0x01][0x01] = "Class 5-B";
areas.names[0x01][0x02] = "Class Hall";
areas.names[0x01][0x03] = "Cross Hall";
areas.names[0x01][0x04] = "Staff Lounge";
areas.names[0x01][0x05] = "Principal's Office";
areas.names[0x01][0x06] = "Staff Lounge Hall";

areas.names[0x02] = {};
areas.names[0x02].group = "SciLab";
areas.names[0x02][0x00] = "SciLab Metro Station";
areas.names[0x02][0x01] = "SciLab Lobby";
areas.names[0x02][0x02] = "Virus Lab";
areas.names[0x02][0x03] = "Dad's Lab";
areas.names[0x02][0x04] = "Archives";

areas.names[0x03] = {};
areas.names[0x03].group = "Yoka";
areas.names[0x03][0x00] = "Yoka Metro Station";
areas.names[0x03][0x01] = "Front of Zoo";
areas.names[0x03][0x02] = "Hotel Front";
areas.names[0x03][0x03] = "Hotel Lobby";
areas.names[0x03][0x04] = "Hall";
areas.names[0x03][0x05] = "Guest Room";
areas.names[0x03][0x06] = "Outdoor Bath";
areas.names[0x03][0x07] = "Zoo 1";
areas.names[0x03][0x08] = "Zoo 2";
areas.names[0x03][0x09] = "Secret Cave";

areas.names[0x04] = {};
areas.names[0x04].group = "Beach";
areas.names[0x04][0x00] = "Beach Metro Station";
areas.names[0x04][0x01] = "Beach Street";
areas.names[0x04][0x02] = "TV Station Lobby";
areas.names[0x04][0x03] = "TV Station Hall 1F";
areas.names[0x04][0x04] = "TV Station Studio";
areas.names[0x04][0x05] = "TV Station Hall 2F";
areas.names[0x04][0x06] = "TV Station Editing Room";

areas.names[0x05] = {};
areas.names[0x05].group = "Hades Isle";
areas.names[0x05][0x00] = "Hades Isle";
areas.names[0x05][0x01] = "Hades Mountain";
areas.names[0x05][0x02] = "Four Hades";
areas.names[0x05][0x03] = "Eternal Hades";

areas.names[0x06] = {};
areas.names[0x06].group = "Hospital";
areas.names[0x06][0x00] = "Shoreline";
areas.names[0x06][0x01] = "Hospital Lobby";
areas.names[0x06][0x02] = "Hospital 2F";
areas.names[0x06][0x03] = "Hospital Room";
areas.names[0x06][0x04] = "Hospital 3F";
areas.names[0x06][0x05] = "Basement";

areas.names[0x07] = {};
areas.names[0x07].group = "WWW Base";
areas.names[0x07][0x00] = "SciLab (past)";
areas.names[0x07][0x01] = "Castle Wily";
areas.names[0x07][0x02] = "Wily Lab";
areas.names[0x07][0x03] = "Monitor Room";
areas.names[0x07][0x04] = "Wily Lab Hall";
areas.names[0x07][0x05] = "WWW Server Room";

areas.names[0x80] = {};
areas.names[0x80].group = "Principal's PC";
areas.names[0x80][0x00] = "Principal's PC Comp 1";
areas.names[0x80][0x01] = "Principal's PC Comp 2";

areas.names[0x81] = {};
areas.names[0x81].group = "Zoo Comps";
areas.names[0x81][0x00] = "Zoo Comp 1";
areas.names[0x81][0x01] = "Zoo Comp 2";
areas.names[0x81][0x02] = "Zoo Comp 3";
areas.names[0x81][0x03] = "Zoo Comp 4";

areas.names[0x82] = {};
areas.names[0x82].group = "Hospital Comps";
areas.names[0x82][0x00] = "Hospital Comp 1";
areas.names[0x82][0x01] = "Hospital Comp 2";
areas.names[0x82][0x02] = "Hospital Comp 3";
areas.names[0x82][0x03] = "Hospital Comp 4";
areas.names[0x82][0x04] = "Hospital Comp 5";

areas.names[0x83] = {};
areas.names[0x83].group = "WWW Comps";
areas.names[0x83][0x00] = "WWW Comp 1";
areas.names[0x83][0x01] = "WWW Comp 2";
areas.names[0x83][0x02] = "WWW Comp 3";
areas.names[0x83][0x03] = "WWW Comp 4";
areas.names[0x83][0x04] = "Alpha";

areas.names[0x88] = {};
areas.names[0x88].group = "Homepages";
areas.names[0x88][0x00] = "Lan's HP";
areas.names[0x88][0x01] = "Mayl's HP";
areas.names[0x88][0x02] = "Dex's HP";
areas.names[0x88][0x03] = "Yai's HP";
areas.names[0x88][0x04] = "Tamako's HP";

areas.names[0x8A] = {};
areas.names[0x8A].group = "Special Comps";
areas.names[0x8A][0x00] = "EduComputer";
areas.names[0x8A][0x01] = "Hot Springs Lion Comp";
areas.names[0x8A][0x02] = "Demon Statue Comp";
areas.names[0x8A][0x03] = "Editing Equipment Comp";
areas.names[0x8A][0x08] = "Monitor Room Comp";

areas.names[0x8C] = {};
areas.names[0x8C].group = "Small Comps 1";
areas.names[0x8C][0x00] = "Doghouse Comp";
areas.names[0x8C][0x01] = "Blackboard Comp";
areas.names[0x8C][0x02] = "Vending Machine Comp (SciLab)";
areas.names[0x8C][0x03] = "Computer Comp";
areas.names[0x8C][0x04] = "Board Comp";
areas.names[0x8C][0x05] = "School Server Comp";
areas.names[0x8C][0x06] = "Relay Van Comp";
areas.names[0x8C][0x07] = "NetBattle Machine Comp";
areas.names[0x8C][0x08] = "TV Board Comp";
areas.names[0x8C][0x09] = "Phone Comp";
areas.names[0x8C][0x0A] = "TV Comp";
areas.names[0x8C][0x0B] = "Bed Comp";
areas.names[0x8C][0x0C] = "Vending Machine Comp (Hospital)";
areas.names[0x8C][0x0D] = "Ticket Machine Comp";
areas.names[0x8C][0x0E] = "Tank Comp";
areas.names[0x8C][0x0F] = "Old TV Comp";

areas.names[0x8D] = {};
areas.names[0x8D].group = "Small Comps 2";
areas.names[0x8D][0x00] = "Armor Comp";
areas.names[0x8D][0x01] = "Sign Comp";
areas.names[0x8D][0x02] = "Alarm Comp";
areas.names[0x8D][0x03] = "Door Sensor Comp";
areas.names[0x8D][0x04] = "Wall Comp";

areas.names[0x90] = {};
areas.names[0x90].group = "ACDC Area";
areas.names[0x90][0x00] = "ACDC Area 1";
areas.names[0x90][0x01] = "ACDC Area 2";
areas.names[0x90][0x02] = "ACDC Area 3";
areas.names[0x90][0x03] = "ACDC Square";

areas.names[0x91] = {};
areas.names[0x91].group = "SciLab Area";
areas.names[0x91][0x00] = "SciLab Area 1";
areas.names[0x91][0x01] = "SciLab Area 2";
areas.names[0x91][0x02] = "SciLab Square";

areas.names[0x92] = {};
areas.names[0x92].group = "Yoka Area";
areas.names[0x92][0x00] = "Yoka Area 1";
areas.names[0x92][0x01] = "Yoka Area 2";
areas.names[0x92][0x02] = "Yoka Square";

areas.names[0x93] = {};
areas.names[0x93].group = "Beach Area";
areas.names[0x93][0x00] = "Beach Area 1";
areas.names[0x93][0x01] = "Beach Area 2";
areas.names[0x93][0x02] = "Beach Square";
areas.names[0x93][0x03] = "Hades Isle";

areas.names[0x94] = {};
areas.names[0x94].group = "Undernet";
areas.names[0x94][0x00] = "Undernet 1";
areas.names[0x94][0x01] = "Undernet 2";
areas.names[0x94][0x02] = "Undernet 3";
areas.names[0x94][0x03] = "Undernet 4";
areas.names[0x94][0x04] = "Undernet 5";
areas.names[0x94][0x05] = "Undernet 6";
areas.names[0x94][0x06] = "Undernet 7";
areas.names[0x94][0x07] = "Under Square";

areas.names[0x95] = {};
areas.names[0x95].group = "Secret Area";
areas.names[0x95][0x00] = "Secret Area 1";
areas.names[0x95][0x01] = "Secret Area 2";
areas.names[0x95][0x02] = "Secret Area 3";

return areas;

