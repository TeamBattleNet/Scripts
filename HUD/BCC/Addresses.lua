-- RAM addresses for BCC scripting, enjoy.

local addresses = require("All/Addresses");

---------------------------------------- WRAM 02000000-0203FFFF ----------------------------------------

addresses.game_mode             = 0x02000000; -- 1 byte
addresses.game_state            = 0x02000000; -- 1 byte

addresses.menu_mode             = 0x02000000; -- 1 byte
addresses.menu_state            = 0x02000000; -- 1 byte

addresses.chip_purchased        = 0x02007060; -- 2 bytes?

addresses.main_RNG              = 0x020070F8; -- 2 bytes

addresses.play_time_frames      = 0x02007100; -- 4 bytes

-- 0x0203FFFF end of WRAM

---------------------------------------- ROM  08000000-09FFFFFF ----------------------------------------

addresses.version_byte          = 0x080000AC;
addresses.region_byte           = 0x080000AF;

---------------------------------------- Verion Dependent ----------------------------------------

-- A0 A1 A2 A3 A4 A5 A6 A7 A8 A9 AA AB AC AD AE AF - ROM Address
-- 42 41 54 54 4C 45 43 48 49 50 47 50 41 38 39 4A - BATTLECHIPGPA89J - JP
-- 42 41 54 54 4C 45 43 48 49 50 47 50 41 38 39 45 - BATTLECHIPGPA89E - US
-- 42 41 54 54 4C 45 43 48 49 50 47 50 41 38 39 50 - BATTLECHIPGPA89P - PAL

local region_byte = memory.read_u8(addresses.region_byte);

if     region_byte == 0x4A then -- J
    addresses.version_name      = "JP";
elseif region_byte == 0x45 then -- E
    addresses.version_name      = "US";
elseif region_byte == 0x50 then -- P
    addresses.version_name      = "PAL";
else
    addresses.version_name      = "Unknown";
    print("\nRAM: Warning! Unrecognized game version! Unable to set certain addresses!");
end

return addresses;

