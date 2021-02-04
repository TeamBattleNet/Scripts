-- Area names for MMBN 6 scripting, enjoy.

-- https://forums.therockmanexezone.com/list-of-mmbn6-areas-and-subareas-t5241.html

local areas = {};

areas.names = {};

areas.real_groups    = {0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06};
areas.digital_groups = {0x80, 0x81, 0x82, 0x83, 0x85, 0x88, 0x8C, 0x8D, 0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96};

areas.names[0x00] = {}; -- ACDC Town
areas.names[0x00].group = "ACDC Town";
areas.names[0x00][0x00] = "ACDC Town";
areas.names[0x00][0x01] = "Class 6-A";

areas.names[0x01] = {}; -- Central Town
areas.names[0x01].group = "Central Town";
areas.names[0x01][0x00] = "Central Town";
areas.names[0x01][0x01] = "Lan's House";
areas.names[0x01][0x02] = "Lan's Room";
areas.names[0x01][0x03] = "Bathroom";
areas.names[0x01][0x04] = "AsterLand";

areas.names[0x02] = {}; -- Cyber Academy
areas.names[0x02].group = "Cyber Academy";
areas.names[0x02][0x00] = "Class 6-1";
areas.names[0x02][0x01] = "Class 6-2";
areas.names[0x02][0x02] = "Class 1-1";
areas.names[0x02][0x03] = "Class 1-2";
areas.names[0x02][0x04] = "1F Hallway";
areas.names[0x02][0x05] = "2F Hallway";
areas.names[0x02][0x06] = "Foyer Hall";
areas.names[0x02][0x07] = "Teachers' Room";
areas.names[0x02][0x08] = "Principal's Office";
areas.names[0x02][0x09] = "Research Lab1";
areas.names[0x02][0x0A] = "Research Lab2";

areas.names[0x03] = {}; -- Seaside Town
areas.names[0x03].group = "Seaside Town";
areas.names[0x03][0x00] = "Seaside Town";
areas.names[0x03][0x01] = "Aquarium1";
areas.names[0x03][0x02] = "Aquarium2";
areas.names[0x03][0x03] = "Auditorium";
areas.names[0x03][0x04] = "Control Room";

areas.names[0x04] = {}; -- Green Town
areas.names[0x04].group = "Green Town";
areas.names[0x04][0x00] = "Green Town";
areas.names[0x04][0x01] = "Court Foyer";
areas.names[0x04][0x02] = "Courtroom";
areas.names[0x04][0x03] = "Punishment Room";
areas.names[0x04][0x04] = "Underground Room";

areas.names[0x05] = {}; -- Sky Town
areas.names[0x05].group = "Sky Town";
areas.names[0x05][0x00] = "Admin";
areas.names[0x05][0x01] = "Sky Town";
areas.names[0x05][0x02] = "Operator Room";
areas.names[0x05][0x03] = "Force Room";

areas.names[0x06] = {}; -- Expo Site
areas.names[0x06].group = "Expo Site";
areas.names[0x06][0x00] = "Expo Site";
areas.names[0x06][0x01] = "Central Hall";
areas.names[0x06][0x02] = "Seaside Hall";
areas.names[0x06][0x03] = "Green Hall";
areas.names[0x06][0x04] = "Sky Hall";
areas.names[0x06][0x05] = "CopyBot Control Room";

areas.names[0x80] = {}; -- Robot Control Comp
areas.names[0x80].group = "Robot Control Comps";
areas.names[0x80][0x00] = "Robot Control Comp1";
areas.names[0x80][0x01] = "Robot Control Comp2";

areas.names[0x81] = {}; -- Aquarium Comp
areas.names[0x81].group = "Aquarium Comps";
areas.names[0x81][0x00] = "Aquarium Comp1";
areas.names[0x81][0x01] = "Aquarium Comp2";
areas.names[0x81][0x02] = "Aquarium Comp3";

areas.names[0x82] = {}; -- Judgetree Comp
areas.names[0x82].group = "JudgeTree Comps";
areas.names[0x82][0x00] = "JudgeTree Comp1";
areas.names[0x82][0x01] = "JudgeTree Comp2";
areas.names[0x82][0x02] = "JudgeTree Comp3";

areas.names[0x83] = {}; -- Mr. Weather Comps
areas.names[0x83].group = "Mr. Weather Comps";
areas.names[0x83][0x00] = "Mr. Weather Comp1";
areas.names[0x83][0x01] = "Mr. Weather Comp2";
areas.names[0x83][0x02] = "Mr. Weather Comp3";

areas.names[0x85] = {}; -- Pavilion Comp
areas.names[0x85].group = "Pavilion Comps";
areas.names[0x85][0x00] = "Pavilion Comp1";
areas.names[0x85][0x01] = "Pavilion Comp2";
areas.names[0x85][0x02] = "Pavilion Comp3";
areas.names[0x85][0x03] = "Pavilion Comp4";
areas.names[0x85][0x04] = "CopyBot Comp";

areas.names[0x88] = {}; -- HomePages
areas.names[0x88].group = "HomePages";
areas.names[0x88][0x00] = "Lan's HP";
areas.names[0x88][0x01] = "ACDC HP";
areas.names[0x88][0x03] = "Aquarium HP";
areas.names[0x88][0x03] = "Green HP";
areas.names[0x88][0x04] = "Sky HP";

areas.names[0x8C] = {}; -- Small Comps 1
areas.names[0x8C].group = "Small Comps 1";
areas.names[0x8C][0x00] = "RoboDog Comp";
areas.names[0x8C][0x01] = "Lab's Comp1";
areas.names[0x8C][0x02] = "Class 6-1 Comp";
areas.names[0x8C][0x03] = "Class 6-2 Comp";
areas.names[0x8C][0x04] = "Class 1-1 Comp";
areas.names[0x8C][0x05] = "Class 1-2 Comp";
areas.names[0x8C][0x06] = "Bathroom Comp";
areas.names[0x8C][0x07] = "Elevator Comp";
areas.names[0x8C][0x08] = "Fish Stick Comp";
areas.names[0x8C][0x09] = "Security Camera Comp";
areas.names[0x8C][0x0A] = "Book Comp";
areas.names[0x8C][0x0B] = "Fan Comp";
areas.names[0x8C][0x0C] = "Air Conditioner Comp";
areas.names[0x8C][0x0D] = "Heater Comp";
areas.names[0x8C][0x0E] = "Shower Comp";
areas.names[0x8C][0x0F] = "Heliport Comp";

areas.names[0x8D] = {}; -- Small Comps 2
areas.names[0x8D].group = "Small Comps 2";
areas.names[0x8D][0x00] = "Lab's Comp2";
areas.names[0x8D][0x01] = "Vending Machine Comp";
areas.names[0x8D][0x02] = "Punish Chair Comp";
areas.names[0x8D][0x03] = "Water Machine Comp";
areas.names[0x8D][0x04] = "Symbol Comp";
areas.names[0x8D][0x05] = "Monitor Comp";
areas.names[0x8D][0x06] = "Popcorn Shop Comp";
areas.names[0x8D][0x07] = "Teachers' Room Comp";
areas.names[0x8D][0x08] = "Pipe Comp";
areas.names[0x8D][0x09] = "Observation Comp";
areas.names[0x8D][0x0A] = "Oxygen Tank Comp";
areas.names[0x8D][0x0B] = "Principal's Office Comp";
areas.names[0x8D][0x0C] = "Mascot Comp";
areas.names[0x8D][0x0D] = "Stuffed Toy Shop Comp";
areas.names[0x8D][0x0E] = "Dog House Comp";
areas.names[0x8D][0x0F] = "Guide Panel Comp";

areas.names[0x90] = {}; -- Central Area
areas.names[0x90].group = "Central Internet Areas";
areas.names[0x90][0x00] = "Central Area1";
areas.names[0x90][0x01] = "Central Area2";
areas.names[0x90][0x02] = "Central Area3";

areas.names[0x91] = {}; -- Seaside Area
areas.names[0x91].group = "Seaside Internet Areas";
areas.names[0x91][0x00] = "Seaside Area1";
areas.names[0x91][0x01] = "Seaside Area2";
areas.names[0x91][0x02] = "Seaside Area3";

areas.names[0x92] = {}; -- Green Area
areas.names[0x92].group = "Green Internet Areas";
areas.names[0x92][0x00] = "Green Area1";
areas.names[0x92][0x01] = "Green Area2";

areas.names[0x93] = {}; -- Underground Area
areas.names[0x93].group = "Underground Internet Areas";
areas.names[0x93][0x00] = "Underground1";
areas.names[0x93][0x01] = "Underground2";

areas.names[0x94] = {}; -- Sky/ACDC Area
areas.names[0x94].group = "Sky/ACDC Internet Areas";
areas.names[0x94][0x00] = "Sky Area1";
areas.names[0x94][0x01] = "Sky Area2";
areas.names[0x94][0x02] = "ACDC Area";

areas.names[0x95] = {}; -- Undernet
areas.names[0x95].group = "Undernet Areas";
areas.names[0x95][0x00] = "Undernet1";
areas.names[0x95][0x01] = "Undernet Zero";
areas.names[0x95][0x02] = "Undernet2";
areas.names[0x95][0x02] = "Undernet3";

areas.names[0x96] = {}; -- Graveyard/Immortal Area
areas.names[0x96].group = "Graveyard/Immortal Areas";
areas.names[0x96][0x00] = "Graveyard1";
areas.names[0x96][0x01] = "Graveyard1";
areas.names[0x96][0x02] = "Immortal Area";

--areas.names[ram.get_area()][ram.get_sub_area()];

return areas;

