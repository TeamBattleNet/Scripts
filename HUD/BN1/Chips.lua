-- Battlechip names for MMBN 1 scripting, enjoy.

-- https://docs.google.com/spreadsheets/d/18qUmXQP_w6g7Guy_fpzaCCWph17cxSetR29n5WOxXKI/pubhtml

local chips = {};

chips.codes = {};
chips.codes[-1] = '-';
chips.codes[ 0] = 'A';
chips.codes[ 1] = 'B';
chips.codes[ 2] = 'C';
chips.codes[ 3] = 'D';
chips.codes[ 4] = 'E';
chips.codes[ 5] = 'F';
chips.codes[ 6] = 'G';
chips.codes[ 7] = 'H';
chips.codes[ 8] = 'I';
chips.codes[ 9] = 'J';
chips.codes[10] = 'K';
chips.codes[11] = 'L';
chips.codes[12] = 'M';
chips.codes[13] = 'N';
chips.codes[14] = 'O';
chips.codes[15] = 'P';
chips.codes[16] = 'Q';
chips.codes[17] = 'R';
chips.codes[18] = 'S';
chips.codes[19] = 'T';
chips.codes[20] = 'U';
chips.codes[21] = 'V';
chips.codes[22] = 'W';
chips.codes[23] = 'X';
chips.codes[24] = 'Y';
chips.codes[25] = 'Z';
chips.codes[26] = '*';
chips.codes['-'] = -1;
chips.codes['A'] =  0;
chips.codes['B'] =  1;
chips.codes['C'] =  2;
chips.codes['D'] =  3;
chips.codes['E'] =  4;
chips.codes['F'] =  5;
chips.codes['G'] =  6;
chips.codes['H'] =  7;
chips.codes['I'] =  8;
chips.codes['J'] =  9;
chips.codes['K'] = 10;
chips.codes['L'] = 11;
chips.codes['M'] = 12;
chips.codes['N'] = 13;
chips.codes['O'] = 14;
chips.codes['P'] = 15;
chips.codes['Q'] = 16;
chips.codes['R'] = 17;
chips.codes['S'] = 18;
chips.codes['T'] = 19;
chips.codes['U'] = 20;
chips.codes['V'] = 21;
chips.codes['W'] = 22;
chips.codes['X'] = 23;
chips.codes['Y'] = 24;
chips.codes['Z'] = 25;
chips.codes['*'] = 26;

chips.names = {};
chips.names[ -1] = "-";
chips.names[  0] = "Empty";
chips.names[  1] = "Cannon";
chips.names[  2] = "HiCannon";
chips.names[  3] = "M-Cannon";
chips.names[  4] = "Sword";
chips.names[  5] = "WideSwrd";
chips.names[  6] = "LongSwrd";
chips.names[  7] = "LilBomb";
chips.names[  8] = "CrosBomb";
chips.names[  9] = "BigBomb";
chips.names[ 10] = "Spreader";
chips.names[ 11] = "Bubbler";
chips.names[ 12] = "Heater";
chips.names[ 13] = "MiniBomb";
chips.names[ 14] = "Shotgun";
chips.names[ 15] = "CrossGun";
chips.names[ 16] = "ShokWave";
chips.names[ 17] = "SoniWave";
chips.names[ 18] = "DynaWave";
chips.names[ 19] = "FireTowr";
chips.names[ 20] = "AquaTowr";
chips.names[ 21] = "WoodTowr";
chips.names[ 22] = "Quake1";
chips.names[ 23] = "Quake2";
chips.names[ 24] = "Quake3";
chips.names[ 25] = "FireSwrd";
chips.names[ 26] = "ElecSwrd";
chips.names[ 27] = "AquaSwrd";
chips.names[ 28] = "GutsPnch";
chips.names[ 29] = "IcePunch";
chips.names[ 30] = "FtrSword";
chips.names[ 31] = "Dash";
chips.names[ 32] = "KngtSwrd";
chips.names[ 33] = "HeroSwrd";
chips.names[ 34] = "MetGuard";
chips.names[ 35] = nil; -- unused ID
chips.names[ 36] = nil; -- unused ID
chips.names[ 37] = "TriArrow";
chips.names[ 38] = "TriSpear";
chips.names[ 39] = "TriLance";
chips.names[ 40] = "Typhoon";
chips.names[ 41] = "Huricane";
chips.names[ 42] = "Cyclone";
chips.names[ 43] = "Howitzer";
chips.names[ 44] = "Thunder1";
chips.names[ 45] = "Thunder2";
chips.names[ 46] = "Thunder3";
chips.names[ 47] = nil; -- unused ID
chips.names[ 48] = nil; -- unused ID
chips.names[ 49] = "Snakegg1";
chips.names[ 50] = "Snakegg2";
chips.names[ 51] = "Snakegg3";
chips.names[ 52] = "Hammer";
chips.names[ 53] = nil; -- unused ID
chips.names[ 54] = nil; -- unused ID
chips.names[ 55] = "BodyBurn";
chips.names[ 56] = nil; -- unused ID
chips.names[ 57] = nil; -- unused ID
chips.names[ 58] = "Ratton1";
chips.names[ 59] = "Ratton2";
chips.names[ 60] = "Ratton3";
chips.names[ 61] = "Lockon1";
chips.names[ 62] = "Lockon2";
chips.names[ 63] = "Lockon3";
chips.names[ 64] = "X-Panel1";
chips.names[ 65] = "X-Panel3";
chips.names[ 66] = nil; -- unused ID
chips.names[ 67] = "Recov10";
chips.names[ 68] = "Recov30";
chips.names[ 69] = "Recov50";
chips.names[ 70] = "Recov80";
chips.names[ 71] = "Recov120";
chips.names[ 72] = "Recov150";
chips.names[ 73] = "Recov200";
chips.names[ 74] = "Recov300";
chips.names[ 75] = nil; -- unused ID
chips.names[ 76] = "Steal";
chips.names[ 77] = nil; -- unused ID
chips.names[ 78] = nil; -- unused ID
chips.names[ 79] = "Geddon1";
chips.names[ 80] = "Geddon2";
chips.names[ 81] = nil; -- unused ID
chips.names[ 82] = "Escape";
chips.names[ 83] = "Interupt";
chips.names[ 84] = "LifeAura";
chips.names[ 85] = "AquaAura";
chips.names[ 86] = "FireAura";
chips.names[ 87] = "WoodAura";
chips.names[ 88] = "Repair";
chips.names[ 89] = nil; -- unused ID
chips.names[ 90] = nil; -- unused ID
chips.names[ 91] = "Cloud";
chips.names[ 92] = "Cloudier";
chips.names[ 93] = "Cloudest";
chips.names[ 94] = "IceCube";
chips.names[ 95] = "RockCube";
chips.names[ 96] = nil; -- unused ID
chips.names[ 97] = "TimeBom1";
chips.names[ 98] = "TimeBom2";
chips.names[ 99] = "TimeBom3";
chips.names[100] = "Invis1";
chips.names[101] = "Invis2";
chips.names[102] = "Invis3";
chips.names[103] = "IronBody";
chips.names[104] = nil; -- unused ID
chips.names[105] = "Remobit1";
chips.names[106] = "Remobit2";
chips.names[107] = "Remobit3";
chips.names[108] = "BstrGard";
chips.names[109] = "BstrBomb";
chips.names[110] = "BstrSwrd";
chips.names[111] = "BstrPnch";
chips.names[112] = "RingZap1";
chips.names[113] = "RingZap2";
chips.names[114] = "RingZap3";
chips.names[115] = "Candle1";
chips.names[116] = "Candle2";
chips.names[117] = "Candle3";
chips.names[118] = "SloGauge";
chips.names[119] = "FstGauge";
chips.names[120] = nil; -- unused ID
chips.names[121] = "Drain1";
chips.names[122] = "Drain2";
chips.names[123] = "Drain3";
chips.names[124] = "Mine1";
chips.names[125] = "Mine2";
chips.names[126] = "Mine3";
chips.names[127] = "Gaia1";
chips.names[128] = "Gaia2";
chips.names[129] = "Gaia3";
chips.names[130] = "BblWrap1";
chips.names[131] = "BblWrap2";
chips.names[132] = "BblWrap3";
chips.names[133] = "Wave";
chips.names[134] = "RedWave";
chips.names[135] = "BigWave";
chips.names[136] = "Muramasa";
chips.names[137] = "Dropdown";
chips.names[138] = "Popup";
chips.names[139] = "Dynamyt1";
chips.names[140] = "Dynamyt2";
chips.names[141] = "Dynamyt3";
chips.names[142] = "Anubis";
chips.names[143] = nil; -- unused ID
chips.names[144] = nil; -- unused ID
chips.names[145] = "IronShld";
chips.names[146] = "LeafShld";
chips.names[147] = "Barrier";
chips.names[148] = "PharoMan";
chips.names[149] = "PharoMn2";
chips.names[150] = "PharoMn3";
chips.names[151] = "ShadoMan";
chips.names[152] = "ShadoMn2";
chips.names[153] = "ShadoMn3";
chips.names[154] = nil; -- unused ID
chips.names[155] = nil; -- unused ID
chips.names[156] = nil; -- unused ID
chips.names[157] = "MagicMan";
chips.names[158] = "MagicMn2";
chips.names[159] = "MagicMn3";
chips.names[160] = "Roll";
chips.names[161] = "Roll2";
chips.names[162] = "Roll3";
chips.names[163] = "GutsMan";
chips.names[164] = "GutsMan2";
chips.names[165] = "GutsMan3";
chips.names[166] = "ProtoMan";
chips.names[167] = "ProtoMn2";
chips.names[168] = "ProtoMn3";
chips.names[169] = "WoodMan";
chips.names[170] = "WoodMan2";
chips.names[171] = "WoodMan3";
chips.names[172] = "FireMan";
chips.names[173] = "FireMan2";
chips.names[174] = "FireMan3";
chips.names[175] = "NumbrMan";
chips.names[176] = "NumbrMn2";
chips.names[177] = "NumbrMn3";
chips.names[178] = "StoneMan";
chips.names[179] = "StoneMn2";
chips.names[180] = "StoneMn3";
chips.names[181] = "IceMan";
chips.names[182] = "IceMan2";
chips.names[183] = "IceMan3";
chips.names[184] = "SkullMan";
chips.names[185] = "SkullMn2";
chips.names[186] = "SkullMn3";
chips.names[187] = "ColorMan";
chips.names[188] = "ColorMn2";
chips.names[189] = "ColorMn3";
chips.names[190] = "BombMan";
chips.names[191] = "BombMan2";
chips.names[192] = "BombMan3";
chips.names[193] = "SharkMan";
chips.names[194] = "SharkMn2";
chips.names[195] = "SharkMn3";
chips.names[196] = "ElecMan";
chips.names[197] = "ElecMan2";
chips.names[198] = "ElecMan3";
chips.names[199] = "Bass";

chips.names[202] = "Z-Canon1";
chips.names[203] = "Z-Canon2";
chips.names[204] = "Z-Canon3";
chips.names[205] = "Z-Spread";
chips.names[206] = "Z-Raton1";
chips.names[207] = "Z-Raton2";
chips.names[208] = "Z-Raton3";
chips.names[209] = "Z-Arrow";
chips.names[210] = "Z-Spear";
chips.names[211] = "Z-Lance";
chips.names[212] = "O-Canon1";
chips.names[213] = "O-Canon2";
chips.names[214] = "O-Canon3";
chips.names[215] = "O-Spread";
chips.names[216] = "O-Raton1";
chips.names[217] = "O-Raton2";
chips.names[218] = "O-Raton3";
chips.names[219] = "O-Arrow";
chips.names[220] = "O-Spear";
chips.names[221] = "O-Lance";
chips.names[222] = "B-Bomb";
chips.names[223] = "B-Sword";
chips.names[224] = "B-Wave";
chips.names[225] = "B-Quake";
chips.names[226] = "S-Bomb";
chips.names[227] = "S-Sword";
chips.names[228] = "S-Wave";
chips.names[229] = "S-Quake";
chips.names[230] = "PwrCanon";
chips.names[231] = "HvyStamp";
chips.names[232] = "BgStrait";
chips.names[233] = "BloodSuk";
chips.names[234] = "Storm";
chips.names[235] = "GtsShoot";
chips.names[236] = "LifeSavr";
chips.names[237] = "2xHero";

function chips.get_random_code()
    return math.random(0,25);
end

function chips.get_random_ID_standard()
    local ID = nil;
    while not chips.names[ID] do
        ID = math.random(1,147);
    end
    return ID;
end

function chips.get_random_ID_navi()
    local ID = nil;
    while not chips.names[ID] do
        ID = math.random(148,199);
    end
    return ID;
end

function chips.get_random_ID_PA()
    return math.random(202,237);
end

function chips.get_random_ID_all()
    local ID = nil;
    while not chips.names[ID] do
        ID = math.random(1,237);
    end
    return ID;
end

return chips;

