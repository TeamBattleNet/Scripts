-- Area names for MMBN 5 scripting, enjoy.

-- TODO

local areas = {};

areas.names = {};

areas.real_groups    = {0x00};
areas.digital_groups = {0x80};

areas.names[0x00] = {};
areas.names[0x00].group = "ACDC Town";
areas.names[0x00][0x00] = "ACDC Town";

areas.names[0x80] = {};
areas.names[0x80].group = "ACDC Areas";
areas.names[0x80][0x00] = "ACDC Area 1";

return areas;

