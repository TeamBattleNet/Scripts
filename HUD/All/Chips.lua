-- Battlechip names for MMBN scripting, enjoy.

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

function chips.get_random_code()
    return math.random(0,25);
end

local function get_valid(first_ID, last_ID)
    local ID = nil;
    while not chips.names[ID] do
        ID = math.random(first_ID,last_ID);
    end
    return ID;
end

function chips.get_random_ID_standard()
    return get_valid(  1,   3);
end

function chips.get_random_ID_mega()
    return get_valid(  1,   3);
end

function chips.get_random_ID_all_chips()
    return get_valid(  1,   3);
end

function chips.get_random_ID_PA()
    return get_valid(  1,   3);
end

function chips.get_random_ID_all()
    return get_valid(  1,   3);
end

return chips;

