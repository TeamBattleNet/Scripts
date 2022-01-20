local addresses = require("BN4/Addresses");

local tournaments = {};

tournaments.boards = {};
tournaments.seeds = {};

local function parseBoards(file)
    local pattern = "frame%s+(%d+)%s+seed (%x+)%s+(%a+)%s+(%a+)%s+(%a+)%s+(%a+)%s+(%a+)%s+(%a+)%s+(%a+)%s+(%a+)%s+(%a+)";
    for line in file:lines() do
        frame, seed, navi1, navi2, navi3, navi4, navi5, navi6, navi7, navi8, navi9 = string.match(line, pattern);
        tournaments.boards[tonumber(frame, 10)] = {navi1, navi2, navi3, navi4, navi5, navi6, navi7, navi8, navi9};
        tournaments.seeds[tonumber(seed, 16)] = tonumber(frame, 10);
    end
end

local version_byte = memory.read_u32_le(addresses.version_byte);

if version_byte == 0x45423442 or version_byte == 0x4A423442 then
    -- Read Blue Moon tournaments
    local file = io.open("BN4/Scenarios_BlueMoon.txt", "r");
    parseBoards(file);
elseif version_byte == 0x45573442 or version_byte == 0x4A573442 then
    -- Read Red Sun tournaments
    local file = io.open("BN4/Scenarios_RedSun.txt", "r");
    parseBoards(file);
end

io.close();

return tournaments;