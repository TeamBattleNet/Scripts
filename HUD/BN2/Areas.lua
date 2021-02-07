-- Area names for MMBN 2 scripting, enjoy.

-- https://forums.therockmanexezone.com/list-of-mmbn2-areas-and-subareas-t5341.html

local areas = {};

areas.names = {};

areas.real_groups    = {0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08};
areas.digital_groups = {0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x88, 0x8C, 0x8D, 0x90, 0x91, 0x92, 0x93, 0x94};

areas.names[0x00] = {};
areas.names[0x00].group = "ACDC Town";
areas.names[0x00][0x00] = "ACDC Town";
areas.names[0x00][0x01] = "ACDC Metro Station";
areas.names[0x00][0x02] = "Lan's House";
areas.names[0x00][0x03] = "Lan's Room";
areas.names[0x00][0x04] = "Mayl's House";
areas.names[0x00][0x05] = "Mayl's Room";
areas.names[0x00][0x06] = "Dex's Room";
areas.names[0x00][0x07] = "Yai's Room";
areas.names[0x00][0x08] = "Yai's Bath";
areas.names[0x00][0x09] = "Room 5A";
areas.names[0x00][0x0A] = "Yai's Hall";

areas.names[0x01] = {};
areas.names[0x01].group = "Marine Harbor";
areas.names[0x01][0x00] = "Marine Harbor";
areas.names[0x01][0x01] = "Marine Metro Station";
areas.names[0x01][0x02] = "Lobby";
areas.names[0x01][0x03] = "License Office";
areas.names[0x01][0x04] = "Test Room";
areas.names[0x01][0x05] = "Dad's Lab";
--areas.names[0x01][0x06] = "Fake Message (crash)";
areas.names[0x01][0x07] = "Mother Computer Room";

areas.names[0x02] = {};
areas.names[0x02].group = "Okuden Valley";
areas.names[0x02][0x00] = "Okuden Metro Station";
areas.names[0x02][0x01] = "Camp Entrance";
areas.names[0x02][0x02] = "Camp Road 1";
areas.names[0x02][0x03] = "Camp Road 2";
areas.names[0x02][0x04] = "Camp";
areas.names[0x02][0x05] = "Okuden Dam";

areas.names[0x03] = {};
areas.names[0x03].group = "Den Airport";
areas.names[0x03][0x00] = "Den Airport";
areas.names[0x03][0x01] = "Boarding Floor";
areas.names[0x03][0x02] = "Airport Metro Station";

areas.names[0x04] = {};
areas.names[0x04].group = "Netopia Aiport";
areas.names[0x04][0x00] = "Netopia Airport";
areas.names[0x04][0x01] = "Boarding Floor";

areas.names[0x05] = {};
areas.names[0x05].group = "Netopia";
areas.names[0x05][0x00] = "Netopia Park";
areas.names[0x05][0x01] = "Netopia Town";
areas.names[0x05][0x02] = "Underground Alley";
areas.names[0x05][0x03] = "Hotel Room";
areas.names[0x05][0x04] = "Jewelry Shop";
areas.names[0x05][0x05] = "Netopia Castle";
areas.names[0x05][0x06] = "Banquet Room";
areas.names[0x05][0x07] = "Trap Room";
areas.names[0x05][0x08] = "Arrow Room";
areas.names[0x05][0x09] = "Arch Room";
areas.names[0x05][0x0A] = "Lower Stairs";
areas.names[0x05][0x0B] = "Fire Room";
areas.names[0x05][0x0C] = "Confusion Room";
areas.names[0x05][0x0D] = "Above Ground Stairs";
areas.names[0x05][0x0E] = "Watchtower";

areas.names[0x06] = {};
areas.names[0x06].group = "Airplane";
areas.names[0x06][0x00] = "Crew Room";
areas.names[0x06][0x01] = "Economy Class";
areas.names[0x06][0x02] = "Business Class";
areas.names[0x06][0x03] = "First Class";
areas.names[0x06][0x04] = "Cockpit";

areas.names[0x07] = {};
areas.names[0x07].group = "Kotobuki";
areas.names[0x07][0x00] = "Kotobuki";
areas.names[0x07][0x01] = "Apartment 1F";
areas.names[0x07][0x02] = "Apartment 2F";
areas.names[0x07][0x03] = "Apartment 8F";
areas.names[0x07][0x04] = "Apartment 25F";
areas.names[0x07][0x05] = "Apartment 27F";
areas.names[0x07][0x06] = "Apartment 4F";
areas.names[0x07][0x07] = "Apartment 9F";
areas.names[0x07][0x08] = "Apartment 20F";
areas.names[0x07][0x09] = "Apartment 23F";
areas.names[0x07][0x0A] = "Apartment 24F";
areas.names[0x07][0x0B] = "Apartment 30F";

areas.names[0x08] = {};
areas.names[0x08].group = "Kotobuki Rooms";
areas.names[0x08][0x00] = "Penthouse";
areas.names[0x08][0x01] = "Last Room";
areas.names[0x08][0x02] = "Room 021";
areas.names[0x08][0x03] = "Room 082";
areas.names[0x08][0x04] = "Room 253";
areas.names[0x08][0x05] = "Room 271";
areas.names[0x08][0x06] = "Room 042";
areas.names[0x08][0x07] = "Room 093";
areas.names[0x08][0x08] = "Room 201";
areas.names[0x08][0x09] = "Room 232";
areas.names[0x08][0x0A] = "Room 243";

areas.names[0x80] = {};
areas.names[0x80].group = "Gas Comps";
areas.names[0x80][0x00] = "Gas Water Heater Comp 1";
areas.names[0x80][0x01] = "Gas Water Heater Comp 2";

areas.names[0x81] = {};
areas.names[0x81].group = "Bomb Comps";
areas.names[0x81][0x00] = "Detonator Comp 1";
areas.names[0x81][0x01] = "Detonator Comp 2";
areas.names[0x81][0x02] = "Detonator Comp 3";
areas.names[0x81][0x03] = "Detonator Comp 4";

areas.names[0x82] = {};
areas.names[0x82].group = "Mother Comps";
areas.names[0x82][0x00] = "Mother Computer Comp 1";
areas.names[0x82][0x01] = "Mother Computer Comp 2";
areas.names[0x82][0x02] = "Mother Computer Comp 3";
areas.names[0x82][0x03] = "Mother Computer Comp 4";
areas.names[0x82][0x04] = "Mother Computer Comp 5";

areas.names[0x83] = {};
areas.names[0x83].group = "Castle Comps";
areas.names[0x83][0x00] = "Castle Comp 1";
areas.names[0x83][0x01] = "Castle Comp 2";
areas.names[0x83][0x02] = "Castle Comp 3";
areas.names[0x83][0x03] = "Castle Comp 4";
areas.names[0x83][0x04] = "Castle Comp 5";

areas.names[0x84] = {};
areas.names[0x84].group = "Air Comps";
areas.names[0x84][0x00] = "Airplane Comp 1";
areas.names[0x84][0x01] = "Airplane Comp 2";
areas.names[0x84][0x02] = "Airplane Comp 3";
areas.names[0x84][0x03] = "Airplane Comp 4";
areas.names[0x84][0x04] = "Airplane Comp 5";

areas.names[0x85] = {};
areas.names[0x85].group = "Apartment Comps";
areas.names[0x85][0x00] = "Apartment Comp 1";
areas.names[0x85][0x01] = "Apartment Comp 2";
areas.names[0x85][0x02] = "Apartment Comp 3";
areas.names[0x85][0x03] = "Apartment Comp 4";
areas.names[0x85][0x04] = "Gospel Server 1";
areas.names[0x85][0x05] = "Gospel Server 2";

areas.names[0x88] = {};
areas.names[0x88].group = "Homepages";
areas.names[0x88][0x00] = "Lan's PC";
areas.names[0x88][0x01] = "Mayl's PC";
areas.names[0x88][0x02] = "Dex's PC";
areas.names[0x88][0x03] = "Yai's PC";
areas.names[0x88][0x04] = "Ribitta's Van";
areas.names[0x88][0x05] = "Raoul's Radio";
areas.names[0x88][0x06] = "Millions' Bag";

areas.names[0x8C] = {};
areas.names[0x8C].group = "Small Comps 1";
areas.names[0x8C][0x00] = "Blackboard Comp";
areas.names[0x8C][0x01] = "Broken Toy Comp";
areas.names[0x8C][0x02] = "Doghouse Comp";
areas.names[0x8C][0x03] = "Control Panel Comp";
areas.names[0x8C][0x04] = "Piano Comp";
areas.names[0x8C][0x05] = "Coffee Machine Comp";
areas.names[0x8C][0x06] = "Portable Game Comp";
areas.names[0x8C][0x07] = "Telephone Comp";
areas.names[0x8C][0x08] = "Guardian Comp";
areas.names[0x8C][0x09] = "Gas Stove Comp";
areas.names[0x8C][0x0A] = "Bear Comp";
areas.names[0x8C][0x0B] = "Monitor Comp";
areas.names[0x8C][0x0C] = "Wide Monitor Comp";
areas.names[0x8C][0x0D] = "Flight Board Comp";
areas.names[0x8C][0x0E] = "Gift Shop Comp";
areas.names[0x8C][0x0F] = "Bronze Statue Comp";

areas.names[0x8D] = {};
areas.names[0x8D].group = "Small Comp 2";
areas.names[0x8D][0x00] = "Refrigerator Comp";
areas.names[0x8D][0x01] = "Goddess Comp";
areas.names[0x8D][0x02] = "Television Comp";
areas.names[0x8D][0x03] = "Vending Machine Comp";
areas.names[0x8D][0x04] = "Autolock Comp";

areas.names[0x90] = {};
areas.names[0x90].group = "Den Areas";
areas.names[0x90][0x00] = "Den Area 1";
areas.names[0x90][0x01] = "Den Area 2";
areas.names[0x90][0x02] = "Den Area 3";
areas.names[0x90][0x03] = "Official Square Entrance";
areas.names[0x90][0x04] = "Official Square";
areas.names[0x90][0x05] = "Official BBS";

areas.names[0x91] = {};
areas.names[0x91].group = "Kotobuki Areas";
areas.names[0x91][0x00] = "Kotobuki Area";
areas.names[0x91][0x01] = "Under Kotobuki Area";
areas.names[0x91][0x02] = "Kotobuki Square Entrance";
areas.names[0x91][0x03] = "Kotobuki Square 1";
areas.names[0x91][0x04] = "Kotobuki Square 2";
areas.names[0x91][0x05] = "Gospel HQ";

areas.names[0x92] = {};
areas.names[0x92].group = "Yumland Areas";
areas.names[0x92][0x00] = "Yumland Area 1";
areas.names[0x92][0x01] = "Yumland Area 2";
areas.names[0x92][0x02] = "Yumland Square Entrance";
areas.names[0x92][0x03] = "Yumland Square";
areas.names[0x92][0x04] = "Treasure Room";

areas.names[0x93] = {};
areas.names[0x93].group = "Netopia Areas";
areas.names[0x93][0x00] = "Netopia Area 1";
areas.names[0x93][0x01] = "Netopia Area 2";
areas.names[0x93][0x02] = "Netopia Area 3";
areas.names[0x93][0x03] = "Netopia Square Entrance";
areas.names[0x93][0x04] = "Netopia Square";

areas.names[0x94] = {};
areas.names[0x94].group = "Undernet";
areas.names[0x94][0x00] = "Undernet 1";
areas.names[0x94][0x01] = "Undernet 2";
areas.names[0x94][0x02] = "Undernet 3";
areas.names[0x94][0x03] = "Undernet 4";
areas.names[0x94][0x04] = "Undernet 5";
areas.names[0x94][0x05] = "Undernet 6";
areas.names[0x94][0x06] = "Undernet 7";
areas.names[0x94][0x07] = "WWW Area 1";
areas.names[0x94][0x08] = "WWW Area 2";
areas.names[0x94][0x09] = "WWW Area 3";
areas.names[0x94][0x0A] = "UnderSquare Entrance";
areas.names[0x94][0x0B] = "UnderSquare";
areas.names[0x94][0x0C] = "Under BBS";

return areas;

