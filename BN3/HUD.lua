-- HUD Script for Mega Man Battle Network 3 Scripting by Tterraj42, enjoy.

-- To Use: Hold L and R, then press:
--  Start: Toggle HUD Display
-- Select: Toggle Settings Mode

-- https://docs.google.com/spreadsheets/d/1MILb--rcdUO4iVRPpAM9B4qUvD0XDJodoHaqWnozXeM/pubhtml Did you check the notes?

local hud = {};

local ram = require("BN3/RAM");

local display = true;
local option_changed = false;

local x = 2; -- puts text one pixel from edge
local y = 0; -- puts text one pixel from edge

-- font is positioned as if 10 pixels by 13 pixels
-- letters can be as wide as 14, or as tall as 17

local function toScreen(text, color, anchor)
	color = color or 0xFFFFFFFF;
	anchor = anchor or "topleft";
	gui.text(x, y, text, color, anchor);
	y = y + 15;
end

local function DisplayRNG()
	toScreen("M RNG: "   .. string.format("%08X", ram.rng.get_main_RNG_value()));
	toScreen("M Index: " .. (ram.rng.get_main_RNG_index() or "?"));
	toScreen("M Delta: " .. (ram.rng.get_main_RNG_delta() or "?"));
	toScreen("S RNG: "   .. string.format("%08X", ram.rng.get_sub_RNG_value()));
	toScreen("S Index: " .. (ram.rng.get_sub_RNG_index() or "?"));
	toScreen("S Delta: " .. (ram.rng.get_sub_RNG_delta() or "?"));
end

local function displayHUD()
	x = 2;
	y = 0;
	DisplayRNG();
end

function hud.initialize()
	print("Initializing HUD for MMBN 3...");
	ram.initialize();
	print("HUD for MMBN 3 Initialized.");
end

function hud.update()
	ram.update_pre();
	
	local keys = joypad.get();
	
	if keys.R and keys.L then
		if     keys.Start then
			if not option_changed then
				option_changed = true;
				display = not display;
			end
		elseif keys.Select then
			if not option_changed then
				option_changed = true;
				-- TODO: Settings Menu
			end
		else
			option_changed = false;
		end
	end
	
	if display then
		displayHUD();
	end
	
	ram.update_post();
end

return hud;

