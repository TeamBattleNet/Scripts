-- Battlechip names for MMBN 2 scripting, enjoy.

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
chips.names[  4] = "Shotgun";
chips.names[  5] = "V-Gun";
chips.names[  6] = "CrossGun";
chips.names[  7] = "Spreader";
chips.names[  8] = "Bubbler";
chips.names[  9] = "Bub-V";
chips.names[ 10] = "BubCross";
chips.names[ 11] = "BubSprd";
chips.names[ 12] = "HeatShot";
chips.names[ 13] = "Heat-V";
chips.names[ 14] = "HeatCros";
chips.names[ 15] = "HeatSprd";
chips.names[ 16] = "MiniBomb";
chips.names[ 17] = "LilBomb";
chips.names[ 18] = "CrosBomb";
chips.names[ 19] = "BigBomb";
chips.names[ 20] = "TreeBom1";
chips.names[ 21] = "TreeBom2";
chips.names[ 22] = "TreeBom3";
chips.names[ 23] = "Sword";
chips.names[ 24] = "WideSwrd";
chips.names[ 25] = "LongSwrd";
chips.names[ 26] = "FireSwrd";
chips.names[ 27] = "AquaSwrd";
chips.names[ 28] = "ElecSwrd";
chips.names[ 29] = "FireBlde";
chips.names[ 30] = "AquaBlde";
chips.names[ 31] = "ElecBlde";
chips.names[ 32] = "StepSwrd";
chips.names[ 33] = "Muramasa";
chips.names[ 34] = "CustSwrd";
chips.names[ 35] = "Kunai1";
chips.names[ 36] = "Kunai2";
chips.names[ 37] = "Kunai3";
chips.names[ 38] = "Slasher";
chips.names[ 39] = "Shockwav";
chips.names[ 40] = "Sonicwav";
chips.names[ 41] = "Dynawave";
chips.names[ 42] = "Quake1";
chips.names[ 43] = "Quake2";
chips.names[ 44] = "Quake3";
chips.names[ 45] = "GutPunch";
chips.names[ 46] = "ColdPnch";
chips.names[ 47] = "Atk+20";
chips.names[ 48] = "Atk+30";
chips.names[ 49] = "Navi+40";
chips.names[ 50] = "DashAtk";
chips.names[ 51] = "Wrecker";
chips.names[ 52] = "CannBall";
chips.names[ 53] = "DoubNdl";
chips.names[ 54] = "TripNdl";
chips.names[ 55] = "QuadNdl";
chips.names[ 56] = "Trident";
chips.names[ 57] = "Ratton1";
chips.names[ 58] = "Ratton2";
chips.names[ 59] = "Ratton3";
chips.names[ 60] = "FireRat";
chips.names[ 61] = "Tornado";
chips.names[ 62] = "Twister";
chips.names[ 63] = "Blower";
chips.names[ 64] = "Burner";
chips.names[ 65] = "ZapRing1";
chips.names[ 66] = "ZapRing2";
chips.names[ 67] = "ZapRing3";
chips.names[ 68] = "Spice1";
chips.names[ 69] = "Spice2";
chips.names[ 70] = "Spice3";
chips.names[ 71] = "Satelit1";
chips.names[ 72] = "Satelit2";
chips.names[ 73] = "Satelit3";
chips.names[ 74] = "Yo-Yo1";
chips.names[ 75] = "Yo-Yo2";
chips.names[ 76] = "Yo-Yo3";
chips.names[ 77] = "MagBomb1";
chips.names[ 78] = "MagBomb2";
chips.names[ 79] = "MagBomb3";
chips.names[ 80] = "Meteor9";
chips.names[ 81] = "Meteor12";
chips.names[ 82] = "Meteor15";
chips.names[ 83] = "Meteor18";
chips.names[ 84] = "Hammer";
chips.names[ 85] = "CrsShld1";
chips.names[ 86] = "CrsShld2";
chips.names[ 87] = "CrsShld3";
chips.names[ 88] = "TimeBom1";
chips.names[ 89] = "TimeBom2";
chips.names[ 90] = "TimeBom3";
chips.names[ 91] = "LilCloud";
chips.names[ 92] = "MedCloud";
chips.names[ 93] = "BigCloud";
chips.names[ 94] = "Mine";
chips.names[ 95] = "FrntSnsr";
chips.names[ 96] = "DblSnsr";
chips.names[ 97] = "Remobit1";
chips.names[ 98] = "Remobit2";
chips.names[ 99] = "Remobit3";
chips.names[100] = "AquaBall";
chips.names[101] = "ElecBall";
chips.names[102] = "HeatBall";
chips.names[103] = "Geyser";
chips.names[104] = "LavaDrag";
chips.names[105] = "GodStone";
chips.names[106] = "OldWood";
chips.names[107] = "PoisMask";
chips.names[108] = "PoisFace";
chips.names[109] = "Whirlpl";
chips.names[110] = "Blckhole";
chips.names[111] = "Guard";
chips.names[112] = "Barrier";
chips.names[113] = "PanlOut1";
chips.names[114] = "PanlOut3";
chips.names[115] = "LineOut";
chips.names[116] = "Lance";
chips.names[117] = "ZeusHamr";
chips.names[118] = "BrnzFist";
chips.names[119] = "SilvFist";
chips.names[120] = "GoldFist";
chips.names[121] = "VarSwrd";
chips.names[122] = "Recov10";
chips.names[123] = "Recov30";
chips.names[124] = "Recov50";
chips.names[125] = "Recov80";
chips.names[126] = "Recov120";
chips.names[127] = "Recov150";
chips.names[128] = "Recov200";
chips.names[129] = "Recov300";
chips.names[130] = "PanlGrab";
chips.names[131] = "AreaGrab";
chips.names[132] = "GrabRvng";
chips.names[133] = "Geddon1";
chips.names[134] = "Geddon2";
chips.names[135] = "Geddon3";
chips.names[136] = "Catcher";
chips.names[137] = "Mindbndr";
chips.names[138] = "Escape";
chips.names[139] = "AirShoes";
chips.names[140] = "Repair";
chips.names[141] = "Candle1";
chips.names[142] = "Candle2";
chips.names[143] = "Candle3";
chips.names[144] = "RockCube";
chips.names[145] = "Prism";
chips.names[146] = "Guardian";
chips.names[147] = "Wind";
chips.names[148] = "Fan";
chips.names[149] = "Anubis";
chips.names[150] = "SloGauge";
chips.names[151] = "FstGauge";
chips.names[152] = "FullCust";
chips.names[153] = "Invis1";
chips.names[154] = "Invis2";
chips.names[155] = "Invis3";
chips.names[156] = "DropDown";
chips.names[157] = "PopUp";
chips.names[158] = "StoneBod";
chips.names[159] = "Shadow1";
chips.names[160] = "Shadow2";
chips.names[161] = "Shadow3";
chips.names[162] = "UnderSht";
chips.names[163] = "BblWrap";
chips.names[164] = "LeafShld";
chips.names[165] = "AquaAura";
chips.names[166] = "FireAura";
chips.names[167] = "WoodAura";
chips.names[168] = "ElecAura";
chips.names[169] = "LifeAur1";
chips.names[170] = "LifeAur2";
chips.names[171] = "LifeAur3";
chips.names[172] = "MagLine";
chips.names[173] = "LavaLine";
chips.names[174] = "IceLine";
chips.names[175] = "GrassLne";
chips.names[176] = "LavaStge";
chips.names[177] = "IceStage";
chips.names[178] = "GrassStg";
chips.names[179] = "HolyPanl";
chips.names[180] = "Jealosy";
chips.names[181] = "AntiFire";
chips.names[182] = "AntiElec";
chips.names[183] = "AntiWatr";
chips.names[184] = "AntiDmg";
chips.names[185] = "AntiSwrd";
chips.names[186] = "AntiNavi";
chips.names[187] = "AntiRecv";
chips.names[188] = "Atk+10";
chips.names[189] = "Fire+40";
chips.names[190] = "Aqua+40";
chips.names[191] = "Wood+40";
chips.names[192] = "Elec+40";
chips.names[193] = "Navi+20";

chips.names[194] = "Roll V1";
chips.names[195] = "Roll V2";
chips.names[196] = "Roll V3";
chips.names[197] = "GutsMan V1";
chips.names[198] = "GutsMan V2";
chips.names[199] = "GutsMan V3";
chips.names[200] = "Protoman V1";
chips.names[201] = "Protoman V2";
chips.names[202] = "Protoman V3";
chips.names[203] = "AirMan V1";
chips.names[204] = "AirMan V2";
chips.names[205] = "AirMan V3";
chips.names[206] = "QuickMan V1";
chips.names[207] = "QuickMan V2";
chips.names[208] = "QuickMan V3";
chips.names[209] = "CutMan V1";
chips.names[210] = "CutMan V2";
chips.names[211] = "CutMan V3";
chips.names[212] = "ShadowMan V1";
chips.names[213] = "ShadowMan V2";
chips.names[214] = "ShadowMan V3";
chips.names[215] = "KnightMan V1";
chips.names[216] = "KnightMan V2";
chips.names[217] = "KnightMan V3";
chips.names[218] = "MagnetMan V1";
chips.names[219] = "MagnetMan V2";
chips.names[220] = "MagnetMan V3";
chips.names[221] = "FreezeMan V1";
chips.names[222] = "FreezeMan V2";
chips.names[223] = "FreezeMan V3";
chips.names[224] = "HeatMan V1";
chips.names[225] = "HeatMan V2";
chips.names[226] = "HeatMan V3";
chips.names[227] = "ToadMan V1";
chips.names[228] = "ToadMan V2";
chips.names[229] = "ToadMan V3";
chips.names[230] = "ThunderMan V1";
chips.names[231] = "ThunderMan V2";
chips.names[232] = "ThunderMan V3";
chips.names[233] = "SnakeMan V1";
chips.names[234] = "SnakeMan V2";
chips.names[235] = "SnakeMan V3";
chips.names[236] = "GateMan V1";
chips.names[237] = "GateMan V2";
chips.names[238] = "GateMan V3";
chips.names[239] = "PlanetMan V1";
chips.names[240] = "PlanetMan V2";
chips.names[241] = "PlanetMan V3";
chips.names[242] = "NapalmMan V1";
chips.names[243] = "NapalmMan V2";
chips.names[244] = "NapalmMan V3";
chips.names[245] = "PharaohMan V1";
chips.names[246] = "PharaohMan V2";
chips.names[247] = "PharaohMan V3";
chips.names[248] = "Bass V1";
chips.names[249] = "Bass V2";
chips.names[250] = "Bass V3";

chips.names[251] = "BgRedWav";
chips.names[252] = "FreezBom";
chips.names[253] = "Sparker";
chips.names[254] = "GaiaSwrd";
chips.names[255] = "BlkBomb";
chips.names[256] = "FtrSword";
chips.names[257] = "KngtSwrd";
chips.names[258] = "HeroSwrd";
chips.names[259] = "Meteors";
chips.names[260] = "Poltrgst";
chips.names[261] = "FireGspl";
chips.names[262] = "AquaGspl";
chips.names[263] = "ElecGspl";
chips.names[264] = "WoodGspl";
chips.names[265] = "GateSP";
chips.names[270] = "Snctuary";

chips.names[272] = "Z-Canon1";
chips.names[273] = "Z-Canon2";
chips.names[274] = "Z-Canon3";
chips.names[275] = "H-Burst";
chips.names[276] = "Z-Ball";
chips.names[277] = "Z-Raton1";
chips.names[278] = "Z-Raton2";
chips.names[279] = "Z-Raton3";
chips.names[280] = "O-Canon1";
chips.names[281] = "O-Canon2";
chips.names[282] = "O-Canon3";
chips.names[283] = "M-Burst";
chips.names[284] = "O-Ball";
chips.names[285] = "O-Ratton1";
chips.names[286] = "O-Ratton2";
chips.names[287] = "O-Ratton3";
chips.names[288] = "Arrows";
chips.names[289] = "UltraBmd";
chips.names[290] = "LifeSrd1";
chips.names[291] = "LifeSrd2";
chips.names[292] = "LifeSrd3";
chips.names[293] = "Punch";
chips.names[294] = "Curse";
chips.names[295] = "TimeBom+";
chips.names[296] = "HvyStamp";
chips.names[297] = "PoisPhar";
chips.names[298] = "Gater";
chips.names[299] = "GtsShoot";
chips.names[300] = "BigHeart";
chips.names[301] = "BodyGrd";
chips.names[302] = "2xHero";
chips.names[303] = "Darkness";

function chips.get_random_code()
    return math.random(0,25);
end

function chips.get_random_ID_standard()
    local ID = nil;
    while not chips.names[ID] do
        ID = math.random(1,193);
    end
    return ID;
end

function chips.get_random_ID_navi()
    local ID = nil;
    while not chips.names[ID] do
        ID = math.random(194,250);
    end
    return ID;
end

function chips.get_random_ID_Secret()
    local ID = nil;
    while not chips.names[ID] do
        ID = math.random(251,270);
    end
    return ID;
end

function chips.get_random_ID_PA()
    local ID = nil;
    while not chips.names[ID] do
        ID = math.random(272,303);
    end
    return ID;
end

function chips.get_random_ID_all_chips()
    local ID = nil;
    while not chips.names[ID] do
        ID = math.random(1,270);
    end
    return ID;
end

function chips.get_random_ID_all()
    local ID = nil;
    while not chips.names[ID] do
        ID = math.random(1,303);
    end
    return ID;
end

return chips;

