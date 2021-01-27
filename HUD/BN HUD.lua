-- HUD Script by TeamBN for all Mega Man Battle Network games, enjoy.

-- Special thanks to Prof9, NMarkro, Risch, Tterraj42, TL_Plexa, Mountebank, and TREZ

-- To use: Hold L and R, then press:
-- Select to toggle display mode
-- Left/Right/Up/Down to navigate commands

function load_HUD()
    local code = bit.band(memory.read_u32_le(0x080000AC), 0xFFFFFF);
    if     (code == 0x455241) then
        return require("BN1/HUD");
    elseif (code == 0x324541) then
        return require("BN2/HUD");
    elseif (code == 0x423641 or code == 0x583341) then
        return require("BN3/HUD");
    elseif (code == 0x573442 or code == 0x423442) then
        --return require("BN4/HUD");
    elseif (code == 0x425242 or code == 0x4B5242) then
        --return require("BN5/HUD");
    elseif (code == 0x355242 or code == 0x365242) then
        --return require("BN6/HUD");
    end
end

local hud = load_HUD();

if hud then
    hud.initialize();
    while true do
        hud.update();
        emu.frameadvance();
    end
else
    print("Game not recognized.");
    while true do
        emu.frameadvance(); -- idle until new ROM is loaded
    end
end

