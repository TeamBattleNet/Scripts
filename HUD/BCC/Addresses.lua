-- RAM addresses for BCC scripting, enjoy.

local addresses = require("All/Addresses");

---------------------------------------- WRAM 02000000-0203FFFF ----------------------------------------

-- 0000 - 07FF ??? C0 03 on loop

-- 0800 - 0ECF TBD Stuff

-- 0ED0 - 114F ??? F8 FF on loop

-- 1150 - 1ECF ??? All 0's

-- 1ED0 - 214F ??? F8 FF on loop

-- 2150 - 2ECF ??? All 0's

-- 2ED0 - 33CF TBD Stuff

-- 33D0 - 369F TBD Menu Stuff? Program Deck?

-- 3670 Menu Timer? Power On Frames?

-- 3D10 - 460F ??? Folder 1?

-- 5048 ??? 6 Bytes

addresses.battle_state4         = 0x020051A4; -- ???

-- 7460 - 761F Folders & Program Decks

-- 7620 - 7718 ??? 00 83 All 81's

-- 7719 - 77D9 Counter?

-- 77DA - 7811 All FF's

-- 7812 - 7925 TBD Folder Stuff?

addresses.chip_purchased        = 0x02007060; -- 2 bytes?

addresses.tourney_setup1        = 0x020070B8; -- 0x0200878E ???
addresses.tourney_setup2        = 0x020070BC; -- 0x001D0082 ???

addresses.game_state            = 0x020070F0; -- 1 byte 0x13 is StateSwitch
addresses.game_state_next       = 0x020070F1; -- 1 byte 0x12 is BattleChipGP

addresses.menu_mode             = 0x02000000; -- 1 byte
addresses.menu_state            = 0x02000000; -- 1 byte

addresses.main_RNG              = 0x020070F8; -- 2 bytes

addresses.play_time_frames      = 0x02007100; -- 4 bytes

addresses.zenny                 = 0x02007110; -- 4 bytes

addresses.tournament_data       = 0x020086F0; -- Complicated

addresses.tourney_setup3        = 0x0200878F; -- for i = 0, 15 do memory.writebyte(0x0878F + i, 0x7F - i) end

addresses.zenny_save1           = 0x02008844; -- 4 bytes
addresses.zenny_save2           = 0x02009F78; -- 4 bytes

-- Stuff

addresses.battle_state1         = 0x0200B78C; -- TBD
addresses.battle_state2         = 0x0200B78D; -- TBD
addresses.battle_state3         = 0x0200B7A0; -- ???

addresses.battle_background     = 0x0200B81A; -- 0x00 - 0x1F

-- 8BA0 - 8D51 Copy of Program Decks?

-- Stuff

-- A2D0 - A485 Copy of Program Decks?

addresses.tournament_navis      = 0x0200B824; -- 2 bytes each

-- B9C0 Interesting?

-- BDD0 - CD7F ??? Graphics? Palette?

-- DODF End of WRAM? All 00's after



-- progress
-- main_area
-- sub_area

-- hp left
-- hp right

-- program deck left
-- program deck right
-- navi (MB limit), 9 chips, 2 slot-ins
-- slot MB limit (progress based?)

-- folder 1
-- folder 2
-- folder 3

-- 0x0203FFFF end of WRAM?

---------------------------------------- ROM  08000000-09FFFFFF ----------------------------------------

addresses.interruptNames1       = 0x0801EF32; -- From NMarkro
addresses.interruptNames2       = 0x0801EFC6; -- From NMarkro

addresses.interruptMusic1       = 0x08002FC6; -- mute intro  music (From NMarkro)
addresses.interruptMusic2       = 0x0804A2DE; -- mute battle music (From NMarkro)

---------------------------------------- BCCplaysBCC Functions ----------------------------------------

local function getNavi(is_left)
    if is_left then
        return tournament[16 - (memory.read_u16_le(0x0B824) - 0x2070)]
    else
        return tournament[16 - (memory.read_u16_le(0x0B826) - 0x2070)]
    end
end

local function writeNavis()
    codes = loadTournament()
    if codes == nil then
        return
    end
    for i = 0, 15 do
        code = tournament[i + 1]
        memory.writebyte(0x086F0 - 28 * i + 0, code.navi[0])   -- Operator
        memory.writebyte(0x086F0 - 28 * i + 1, code.navi[1])   -- Base Navi
        for j = 1, 12 do                                       -- Chips
            memory.writebyte(0x086F0 - 28 * i + 1 + j, code.navi[j])
        end
        writeString(0x086F0 - 28 * i + 14,  code.deckname, true, 4)
        memory.writebyte(0x086F0 - 28 * i + 23, 0x80)          -- ???
        memory.writebyte(0x086F0 - 28 * i + 24, code.navi[13]) -- Code type ???
        memory.writebyte(0x086F0 - 28 * i + 25, 1)             -- Enabler ???
     end
end

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
    print("\nRAM: Warning! Unrecognized game version! Unable to set certain addresses!");
end

return addresses;

