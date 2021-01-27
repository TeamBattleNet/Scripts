-- HUD Script for Mega Man Battle Network 2 Scripting by Tterraj42, enjoy.

-- To Use: Hold L and R, then press:
--  Start: Toggle HUD Display
-- Select: Toggle Settings Mode

-- https://docs.google.com/spreadsheets/d/e/2PACX-1vS1-XuptqnclG6GOlXjKIwuQWdM5HLPMh5KM6yAUrfaTva6uvfoBV98Sgm4flMnC07HNYXMR4HsEGbe/pubhtml Did you check the notes?

local hud = {};

local ram = require("BN2/RAM");

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
	toScreen("RNG: "   .. string.format("%08X", ram.rng.get_RNG_value()));
	toScreen("Index: " .. (ram.rng.get_RNG_index() or "?"));
	toScreen("Delta: " .. (ram.rng.get_RNG_delta() or "?"));
end

local function displayHUD()
	x = 2;
	y = 0;
	DisplayRNG();
end

function hud.initialize()
	print("Initializing HUD for MMBN 2...");
	ram.initialize();
	print("HUD for MMBN 2 Initialized.");
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

