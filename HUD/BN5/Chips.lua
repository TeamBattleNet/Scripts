-- Battlechip names for MMBN 5 scripting, enjoy.

-- https://docs.google.com/spreadsheets/d/18qUmXQP_w6g7Guy_fpzaCCWph17cxSetR29n5WOxXKI/pubhtml

local chips = {};

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

