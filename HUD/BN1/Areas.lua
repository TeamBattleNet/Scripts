-- Area names for MMBN 1 scripting, enjoy.

-- https://forums.therockmanexezone.com/list-of-mmbn1-oss-areas-and-subareas-t5342.html

local areas = {};

areas.names = {};

areas.real_groups    = {0x00, 0x01, 0x02, 0x03, 0x04, 0x05};
areas.digital_groups = {0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x88, 0x89, 0x8A, 0x8B, 0x8C, 0x90};

areas.names[0x00] = {};
areas.names[0x00].group = "ACDC Elementary";
areas.names[0x00][0x00] = "Class 5-A";
areas.names[0x00][0x01] = "Class 5-B";
areas.names[0x00][0x02] = "Library";
areas.names[0x00][0x03] = "2F Hallway";
--areas.names[0x00][0x04] = "Invalid";
areas.names[0x00][0x05] = "Class 1-A";
areas.names[0x00][0x06] = "Class 1-B";
areas.names[0x00][0x07] = "AV Room";
areas.names[0x00][0x08] = "Infirmary";
areas.names[0x00][0x09] = "1F Hallway";
--areas.names[0x00][0x0A] = "Invalid";
areas.names[0x00][0x0B] = "Cross Hallway";
areas.names[0x00][0x0C] = "Storage";
areas.names[0x00][0x0D] = "Staff Lounge";
areas.names[0x00][0x0E] = "Staff Lounge Hallway";

areas.names[0x01] = {};
areas.names[0x01].group = "ACDC"
areas.names[0x01][0x00] = "ACDC Town";
areas.names[0x01][0x01] = "School Gate";
areas.names[0x01][0x02] = "Lan's Living Room";
areas.names[0x01][0x03] = "Lan's Room";
--areas.names[0x01][0x04] = "Invalid";
areas.names[0x01][0x05] = "Mayl's Living Room";
areas.names[0x01][0x06] = "Mayl's Room";
areas.names[0x01][0x07] = "Dex's Room";
--areas.names[0x01][0x08] = "Invalid";
areas.names[0x01][0x09] = "Yai's Room";
--areas.names[0x01][0x0A] = "Invalid";
areas.names[0x01][0x0B] = "Higsby's";
areas.names[0x01][0x0C] = "ACDC Station";
areas.names[0x01][0x0D] = "Secret Station";

areas.names[0x02] = {};
areas.names[0x02].group = "Government Complex";
areas.names[0x02][0x00] = "Front of Government Complex";
areas.names[0x02][0x01] = "Government Complex Station";
areas.names[0x02][0x02] = "Waterworks Lobby";
areas.names[0x02][0x03] = "SciLab Lobby";
areas.names[0x02][0x04] = "Government Complex Hallway";
areas.names[0x02][0x05] = "Dad's Lab";
areas.names[0x02][0x06] = "Waterworks Office";
areas.names[0x02][0x07] = "Waterworks Control Room";
--areas.names[0x02][0x08] = "Invalid";
areas.names[0x02][0x09] = "Waterworks Pump Room";
--areas.names[0x02][0x0A] = "Invalid";
areas.names[0x02][0x0B] = "Waterworks Purification Room";

areas.names[0x03] = {};
areas.names[0x03].group = "Dentown";
areas.names[0x03][0x00] = "Dentown Center";
areas.names[0x03][0x01] = "Dentown Station";
areas.names[0x03][0x02] = "Dentown Block 1";
areas.names[0x03][0x03] = "Dentown Block 2";
areas.names[0x03][0x04] = "Dentown Block 3";
areas.names[0x03][0x05] = "Dentown Block 4";
areas.names[0x03][0x06] = "Miyu's Antiques";
areas.names[0x03][0x07] = "Summer School";

areas.names[0x04] = {};
areas.names[0x04].group = "SciLab Basement";
areas.names[0x04][0x00] = "Restaurant Hallway";
areas.names[0x04][0x01] = "Restaurant";
areas.names[0x04][0x02] = "Power Plant Hallway";
areas.names[0x04][0x03] = "Power Plant";
areas.names[0x04][0x04] = "Power Plant Control Room";
areas.names[0x04][0x05] = "Generator Room";

areas.names[0x05] = {};
areas.names[0x05].group = "WWW HQ";
areas.names[0x05][0x00] = "WWW Base";
areas.names[0x05][0x01] = "Wily's Lab";
areas.names[0x05][0x02] = "Rocket Hanger";
areas.names[0x05][0x03] = "WWW Passage 1";
areas.names[0x05][0x04] = "WWW Passage 2";
areas.names[0x05][0x05] = "WWW Passage 3";

areas.names[0x80] = {};
areas.names[0x80].group = "School Comps";
areas.names[0x80][0x00] = "School Comp 1";
areas.names[0x80][0x01] = "School Comp 2";
areas.names[0x80][0x02] = "School Comp 3";
areas.names[0x80][0x03] = "School Comp 4";
areas.names[0x80][0x04] = "School Comp 5";

areas.names[0x81] = {};
areas.names[0x81].group = "Oven Comps";
areas.names[0x81][0x00] = "Oven Comp 1";
areas.names[0x81][0x01] = "Oven Comp 2";

areas.names[0x82] = {};
areas.names[0x82].group = "Waterworks Comps";
areas.names[0x82][0x00] = "Waterworks Comp 1";
areas.names[0x82][0x01] = "Waterworks Comp 2";
areas.names[0x82][0x02] = "Waterworks Comp 3";
areas.names[0x82][0x03] = "Waterworks Comp 4";
areas.names[0x82][0x04] = "Waterworks Comp 5";
areas.names[0x82][0x05] = "Waterworks Comp 6";

areas.names[0x83] = {};
areas.names[0x83].group = "Traffic Light Comps";
areas.names[0x83][0x00] = "Traffic Light Comp 1";
areas.names[0x83][0x01] = "Traffic Light Comp 2";
areas.names[0x83][0x02] = "Traffic Light Comp 3";
areas.names[0x83][0x03] = "Traffic Light Comp 4";
areas.names[0x83][0x04] = "Traffic Light Comp 5";

areas.names[0x84] = {};
areas.names[0x84].group = "Power Plant Comps";
areas.names[0x84][0x00] = "Power Plant Comp 1";
areas.names[0x84][0x01] = "Power Plant Comp 2";
areas.names[0x84][0x02] = "Power Plant Comp 3";
areas.names[0x84][0x03] = "Power Plant Comp 4";

areas.names[0x85] = {};
areas.names[0x85].group = "WWW Comps";
areas.names[0x85][0x00] = "WWW Comp 1";
areas.names[0x85][0x01] = "WWW Comp 2";
areas.names[0x85][0x02] = "WWW Comp 3";
areas.names[0x85][0x03] = "WWW Comp 4";
areas.names[0x85][0x04] = "WWW Comp 5";
areas.names[0x85][0x05] = "Rocket Comp";

areas.names[0x88] = {};
areas.names[0x88].group = "ACDC Homepages";
areas.names[0x88][0x00] = "Lan's PC Comp";
areas.names[0x88][0x01] = "Mayl's Piano Comp";
areas.names[0x88][0x02] = "Yai's Portrait Comp";
areas.names[0x88][0x03] = "Dex's PC Comp";

areas.names[0x89] = {};
areas.names[0x89].group = "Government Homepages 1";
areas.names[0x89][0x00] = "Dad's PC Comp";
areas.names[0x89][0x01] = "Lunch Cart Comp";

areas.names[0x8A] = {};
areas.names[0x8A].group = "Dentown Homepages";
areas.names[0x8A][0x00] = "Antique Comp";

areas.names[0x8B] = {};
areas.names[0x8B].group = "Government Homepages 2";
areas.names[0x8B][0x00] = "Fish Cart Comp";

areas.names[0x8C] = {};
areas.names[0x8C].group = "Miscellaneous Sub Comps";
areas.names[0x8C][0x00] = "Doghouse Comp";
areas.names[0x8C][0x01] = "Servbot Comp";
areas.names[0x8C][0x02] = "New Game Machine Comp";
areas.names[0x8C][0x03] = "Telephone Comp";
areas.names[0x8C][0x04] = "Car Comp";
areas.names[0x8C][0x05] = "Vending Machine (Waterworks)";
areas.names[0x8C][0x06] = "Lobby TV Comp";
areas.names[0x8C][0x07] = "Large Monitor Comp";
areas.names[0x8C][0x08] = "Control Equipment Comp";
areas.names[0x8C][0x09] = "Vending Machine (SciLab)";
areas.names[0x8C][0x0A] = "Recycled PET Comp";
areas.names[0x8C][0x0B] = "Big Vase Comp";
areas.names[0x8C][0x0C] = "Blackboard Comp";

areas.names[0x90] = {};
areas.names[0x90].group = "Internet";
areas.names[0x90][0x00] = "Internet 1";
areas.names[0x90][0x01] = "Internet 2";
areas.names[0x90][0x02] = "Internet 3";
areas.names[0x90][0x03] = "Internet 4";
areas.names[0x90][0x04] = "Undernet 1";
areas.names[0x90][0x05] = "Undernet 2";
areas.names[0x90][0x06] = "Undernet 3";
areas.names[0x90][0x07] = "Undernet 4";
areas.names[0x90][0x08] = "Undernet 5";
areas.names[0x90][0x09] = "Undernet 6";
areas.names[0x90][0x0A] = "Undernet 7";
areas.names[0x90][0x0B] = "Undernet 8";
areas.names[0x90][0x0C] = "Undernet 9";
areas.names[0x90][0x0D] = "Undernet 10";
areas.names[0x90][0x0E] = "Undernet 11";
areas.names[0x90][0x0F] = "Undernet 12";

return areas;

