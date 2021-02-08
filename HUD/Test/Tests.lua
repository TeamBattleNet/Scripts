-- Tests for the MMBN HUD.

local tests = {};

-- print(type(nil))       --> nil
-- print(type(true))      --> boolean
-- print(type(print))     --> function
-- print(type(0x00))      --> number
-- print(type("MMBN"))    --> string
-- print(type(type(nil))) --> string
-- https://www.tutorialspoint.com/lua/lua_data_types.htm

function tests.test_this(hud)
    require("Test/Addresses").test_this(hud.game.ram.addr);
end

return tests;

