-- HUD Script for the Mega Man Battle Network series, enjoy.

-- In HUD Mode   -  Hold L and R then press:
-- Start         -  to toggle HUD on/off
-- Select        -  to turn Command Mode on
-- Left / Right  -  to change display mode
-- Up / Down     -  to change mode specific values
-- A             -  to print inputs from the last folder edit
-- B             -  to print game specific information

-- Command Mode  -  On Controller Press:
-- Select        -  to turn Command Mode off
-- Left / Right  -  to change Command
-- Up / Down     -  to change Options
-- A / B         -  to activate the Command Option

-- Command Mode  -  On Keyboard Press:
-- KeypadPeriod  -  to toggle Command Mode off
-- Left / Right  -  to change Command
-- Up / Down     -  to change Options
-- Tab / Keypad0 -  to activate the Command Option

-- Special thanks to Prof9, NMarkro, Risch, TL_Plexa, Mountebank, Tterraj42, TREZ, and TeamBN

-- https://drive.google.com/drive/folders/1NjYy8mXjc-B06gpng1D2WzWJT4waQAFV "The Notes"

console.clear();

print("ROM Hash: " .. gameinfo.getromhash());
print("ROM Name: " .. gameinfo.getromname());

function load_HUD()
    local code = bit.band(memory.read_u32_le(0x080000AC), 0xFFFFFF);
    if     (code == 0x455241) then
        return require("BN1/HUD");
    elseif (code == 0x324541 or code == 0x324D41) then
        return require("BN2/HUD");
    elseif (code == 0x423641 or code == 0x583341) then
        return require("BN3/HUD");
    elseif (code == 0x573442 or code == 0x423442) then
        return require("BN4/HUD");
    elseif (code == 0x425242 or code == 0x4B5242) then
        --return require("BN5/HUD");
    elseif (code == 0x355242 or code == 0x365242) then
        return require("BN6/HUD");
    elseif (code == 0x393841) then
        return require("BCC/HUD");
    end
    return nil;
end

local hud = load_HUD();

if hud then
    hud.initialize({major_version = "0.3"});
    while true do
        hud.update();
        emu.frameadvance();
    end
else
    print("\nGame not recognized!\n");
    while true do
        emu.frameadvance(); -- idle until a new ROM is loaded
    end
end

