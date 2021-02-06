-- Area names for MMBN 4 scripting, enjoy.

-- https://forums.therockmanexezone.com/list-of-mmbn4-areas-and-subareas-t5312.html

local areas = {};

areas.names = {};

areas.real_groups    = {0x00, 0x01, 0x02, 0x03, 0x04, 0x05};
areas.digital_groups = {0x80, 0x81, 0x82, 0x88, 0x8C, 0x8D, 0x8E, 0x90, 0x91, 0x92, 0x93, 0x94};

areas.names[0x00] = {}; -- ACDC Town
areas.names[0x00].group = "ACDC Town";
areas.names[0x00][0x00] = "ACDC Town";
areas.names[0x00][0x01] = "Lan's House";
areas.names[0x00][0x02] = "Lan's Room";
areas.names[0x00][0x03] = "Mayl's Room";
areas.names[0x00][0x04] = "Dex's Room";
areas.names[0x00][0x05] = "Yai's Room";
areas.names[0x00][0x06] = "Higsby's";

areas.names[0x01] = {}; -- Elec Town
areas.names[0x01].group = "Elec Town";
areas.names[0x01][0x00] = "Elec Town 1";
areas.names[0x01][0x01] = "Elec Town 2";
areas.names[0x01][0x02] = "Sqaure";

areas.names[0x02] = {}; -- DenDome
areas.names[0x02].group = "DenDome";
areas.names[0x02][0x00] = "DenDome";
areas.names[0x02][0x01] = "Alleyway";
areas.names[0x02][0x02] = "Dome Room";
areas.names[0x02][0x03] = "Stadium";

areas.names[0x03] = {}; -- Castillo
areas.names[0x03].group = "Castillo";
areas.names[0x03][0x00] = "Entrance";
areas.names[0x03][0x01] = "Center Square";
areas.names[0x03][0x02] = "Waiting Room";
areas.names[0x03][0x03] = "Air Stadium";
areas.names[0x03][0x04] = "Mel Square";
areas.names[0x03][0x05] = "Vampire Manor";

areas.names[0x04] = {}; -- Abroad
areas.names[0x04].group = "Abroad";
areas.names[0x04][0x00] = "Netopia";
areas.names[0x04][0x01] = "Colloseum Avenue";
areas.names[0x04][0x02] = "Guest Room";
areas.names[0x04][0x03] = "Colloseum Room";
areas.names[0x04][0x04] = "Colloseum";
areas.names[0x04][0x05] = "YumLand";
areas.names[0x04][0x06] = "Yum Ruins";
areas.names[0x04][0x07] = "NetFrica";
areas.names[0x04][0x08] = "Sharo";
areas.names[0x04][0x09] = "Space Center";

areas.names[0x05] = {}; -- NAXA
areas.names[0x05].group = "NAXA";
areas.names[0x05][0x00] = "Observation Room";
areas.names[0x05][0x01] = "Roof";
areas.names[0x05][0x02] = "NAXA";
areas.names[0x05][0x03] = "NAXA Lobby";

areas.names[0x80] = {}; -- Elec Tower Comps
areas.names[0x80].group = "Elec Tower Comps";
areas.names[0x80][0x00] = "Elec Tower Comp 1";
areas.names[0x80][0x01] = "Elec Tower Comp 2";

areas.names[0x81] = {}; -- Toy Robo Comps
areas.names[0x81].group = "Toy Robo Comps";
areas.names[0x81][0x00] = "Toy Robo Comp 1";
areas.names[0x81][0x01] = "Toy Robo Comp 2";
areas.names[0x81][0x02] = "Toy Robo Comp 3";

areas.names[0x82] = {}; -- Meteor Comps
areas.names[0x82].group = "Meteor Comps";
areas.names[0x82][0x00] = "Meteor Comp 1";
areas.names[0x82][0x01] = "Meteor Comp 2";
areas.names[0x82][0x02] = "Meteor Comp 3";
areas.names[0x82][0x03] = "Meteor Comp 4";
areas.names[0x82][0x04] = "Control Area";

areas.names[0x88] = {}; -- HomePages
areas.names[0x88].group = "HomePages";
areas.names[0x88][0x00] = "Lan's HP";
areas.names[0x88][0x01] = "Mayl's HP";
areas.names[0x88][0x02] = "Dex's HP";
areas.names[0x88][0x03] = "Yai's HP";
areas.names[0x88][0x04] = "Hotel HP";
areas.names[0x88][0x05] = "Castillo HP";
areas.names[0x88][0x06] = "JomonElec HP";
areas.names[0x88][0x07] = "Space Center HP";

areas.names[0x8C] = {}; -- Small Comps 1
areas.names[0x8C].group = "Small Comps 1";
areas.names[0x8C][0x00] = "Microwave Comp";
areas.names[0x8C][0x01] = "Stereo Comp1";
areas.names[0x8C][0x02] = "Hotdog Comp";
areas.names[0x8C][0x03] = "Dome NetBattle Machine Comp";
areas.names[0x8C][0x04] = "CyberTop Comp";
areas.names[0x8C][0x05] = "LCD Comp";
areas.names[0x8C][0x06] = "Castillo NetBattle Machine Comp";
areas.names[0x8C][0x07] = "Statue Comp";
areas.names[0x8C][0x08] = "Nupopo Comp";
areas.names[0x8C][0x09] = "Computer Comp";
areas.names[0x8C][0x0A] = "Toy Comp";
areas.names[0x8C][0x0B] = "Colosseum NetBattle Machine Comp";
areas.names[0x8C][0x0C] = "Lion Comp";
areas.names[0x8C][0x0D] = "Dog House Comp";
areas.names[0x8C][0x0E] = "Game Comp";
areas.names[0x8C][0x0F] = "Vending machine Comp";

areas.names[0x8D] = {}; -- Small Comps 2
areas.names[0x8D].group = "Small Comps 2";
areas.names[0x8D][0x00] = "Card Comp2";
areas.names[0x8D][0x01] = "Water Comp";
areas.names[0x8D][0x02] = "Ticket Comp";
areas.names[0x8D][0x03] = "Stand Comp";
areas.names[0x8D][0x04] = "Antenna Comp 1";
areas.names[0x8D][0x05] = "Antenna Comp 2";
areas.names[0x8D][0x06] = "Antenna Comp 3";
areas.names[0x8D][0x07] = "Antenna Comp 4";
areas.names[0x8D][0x08] = "Buddha Comp";
areas.names[0x8D][0x09] = "Goddess Comp";
areas.names[0x8D][0x0A] = "Hero Comp";
areas.names[0x8D][0x0B] = "Cook Comp";

areas.names[0x8E] = {}; -- Small Comps 2
areas.names[0x8E].group = "Water God Comps";
areas.names[0x8E][0x00] = "Water God Comp 1";
areas.names[0x8E][0x01] = "Water God Comp 2";
areas.names[0x8E][0x02] = "Water God Comp 3";
areas.names[0x8E][0x03] = "Water God Comp 4";
areas.names[0x8E][0x04] = "Water God Comp 5";
areas.names[0x8E][0x05] = "Water God Comp 6";
areas.names[0x8E][0x06] = "Water God Comp 7";
areas.names[0x8E][0x07] = "Water God Comp 8";
areas.names[0x8E][0x08] = "Water God Comp 9";
areas.names[0x8E][0x09] = "Water God Comp 10";
areas.names[0x8E][0x0A] = "Water God Comp 11";
areas.names[0x8E][0x0B] = "Water God Comp 12";
areas.names[0x8E][0x0C] = "Water God Comp 13";
areas.names[0x8E][0x0D] = "Water God Comp 14";
areas.names[0x8E][0x0E] = "Water God Comp 15";
areas.names[0x8E][0x0F] = "Water God Comp 16";

areas.names[0x90] = {}; -- ACDC Area
areas.names[0x90].group = "ACDC Internet Areas";
areas.names[0x90][0x00] = "ACDC Area 1";
areas.names[0x90][0x01] = "ACDC Area 2";
areas.names[0x90][0x02] = "ACDC Area 3";

areas.names[0x91] = {}; -- Town Area
areas.names[0x91].group = "Town Internet Areas";
areas.names[0x91][0x00] = "Town Area 1";
areas.names[0x91][0x01] = "Town Area 2";
areas.names[0x91][0x02] = "Town Area 3";
areas.names[0x91][0x03] = "Town Area 4";

areas.names[0x92] = {}; -- Park Area
areas.names[0x92].group = "Park Internet Areas";
areas.names[0x92][0x00] = "Park Area 1";
areas.names[0x92][0x01] = "Park Area 2";
areas.names[0x92][0x02] = "Park Area 3";

areas.names[0x93] = {}; -- Foreign Area
areas.names[0x93].group = "Foreign Internet Areas";
areas.names[0x93][0x00] = "Yumland Area";
areas.names[0x93][0x01] = "Netopia Area";
areas.names[0x93][0x02] = "NetFrica Area";
areas.names[0x93][0x03] = "Sharo Area";

areas.names[0x94] = {}; -- Undernet/Black Earth
areas.names[0x94].group = "Undernet/Black Earth";
areas.names[0x94][0x00] = "Undernet 1";
areas.names[0x94][0x01] = "Undernet 2";
areas.names[0x94][0x02] = "Undernet 3";
areas.names[0x94][0x03] = "Undernet 4";
areas.names[0x94][0x04] = "Undernet 5";
areas.names[0x94][0x05] = "Undernet 6";
areas.names[0x94][0x06] = "Black Earth 1";
areas.names[0x94][0x07] = "Black Earth 2";

--areas.names[ram.get_area()][ram.get_sub_area()];

return areas;

