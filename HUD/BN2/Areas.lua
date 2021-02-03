-- TODO: Area names for MMBN 2 scripting, enjoy.

-- https://forums.therockmanexezone.com/list-of-mmbn2-areas-and-subareas-t5341.html

local areas = {};

areas.names = {};

areas.real_groups    = {0x00};
areas.digital_groups = {0x80};

areas.names[0x00] = {};
areas.names[0x00].group = "ACDC Town";
areas.names[0x00][0x00] = "ACDC Town";

areas.names[0x80] = {};
areas.names[0x80].group = "Gas Comp";
areas.names[0x80][0x00] = "Gas Water Heater Comp 1";
areas.names[0x80][0x01] = "Gas Water Heater Comp 2";

return areas;

