-- Area names for BCC scripting, enjoy.

-- TODO

local areas = {};

areas.names = {};

areas.real_groups    = {0x00};
areas.digital_groups = {0x80};

areas.names[0x00] = {};
areas.names[0x00].group = "ACDC Town";
areas.names[0x00][0x00] = "Lan's Room";

areas.names[0x80] = {};
areas.names[0x80].group = "BCHIP GP";
areas.names[0x80][0x00] = "BCHIP GP";

return areas;

