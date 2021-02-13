-- Display Functions for MMBN scripting, enjoy.

local hud = { game={}; version="0.5"; };

local settings = require("All/Settings");

-- top left positioning
hud.x0 = 0;
hud.y0 = 0;

-- character offset
hud.x = 0;
hud.y = 0;

-- scaling multipliers
hud.ws = 1;
hud.xs = 0;
hud.ys = 0;

-- global display settings
settings.use_gui_text = true;
settings.pixel_background_color = 0x80000000;

---------------------------------------- Display Settings ----------------------------------------

function settings.set_text_background(new_background_color)
    gui.defaultTextBackground(new_background_color);
    settings.pixel_background_color = new_background_color;
end

function settings.set_display_text(font)
    if     font == "gui" then
        hud.xs = 10; ---- 5 10 15 20 25 xs = 5*ws
        hud.ys = 13+3; -- 8 16 24 32 40 ys = 8*ws
        hud.show_text = gui.text;
        settings.use_gui_text = true;
    elseif font == "gens" then
        hud.xs =  4; ---- 4  8 12 16 20
        hud.ys =  7; ---- 7 14 21 28 35
        hud.show_text = gui.pixelText;
        settings.use_gui_text = false;
        gui.defaultPixelFont("gens");
        gui.defaultTextBackground(settings.pixel_background_color);
    elseif font == "fceux" then
        hud.xs =  6; ---- 6 12 18 24 30
        hud.ys =  9; ---- 9 18 27 36 45
        hud.show_text = gui.pixelText;
        settings.use_gui_text = false;
        gui.defaultPixelFont("fceux");
        gui.defaultTextBackground(settings.pixel_background_color);
    end
end

function hud.set_ws()
    hud.ws = client.getwindowsize(); -- screen space is GBA * ws
end

function hud.reset_values()
    hud.x = 0;
    hud.y = 0;
    hud.x0 = 0;
    hud.y0 = 0;
    hud.xc = 0;
    hud.yc = 0;
    hud.set_ws();
end

function hud.set_position(x, y)
    hud.x0 = (x or 2) * hud.ws;
    hud.y0 = (y or 1) * hud.ws;
end

function hud.set_offset(x, y)
    hud.x = x or 0;
    hud.y = y or 0;
end

function hud.set_center_x(width) -- in characters
    local screen_width = 240 * (settings.use_gui_text and hud.ws or 1);
    hud.xc = (screen_width  - (width  * hud.xs)) / 2;
end

function hud.set_center_y(height) -- in characters
    local screen_height = 160 * (settings.use_gui_text and hud.ws or 1);
    hud.yc = (screen_height - (height * hud.ys)) / 2;
end

function hud.to_pixel(x, y, text)
    if settings.use_gui_text then
        x = x * hud.ws;
        y = y * hud.ws;
    end
    x = x - (hud.xs / 2) * string.len(text);
    y = y - (hud.ys / 2);
    hud.show_text(x, y, text);
end

function hud.to_screen(text)
    local x = hud.x * hud.xs + hud.xc;
    local y = hud.y * hud.ys;
    if settings.use_gui_text then -- don't center y for pixelText
        x = x + hud.x0;
        y = y + hud.y0 + hud.yc;
    end
    hud.show_text(x, y, text);
    hud.y = hud.y + 1;
end

function hud.to_bottom_right_gui(text)
    local x = 3;
    local y = 3 + hud.y * hud.ys;
    gui.text(x, y, text, 0xFFFFFFFF, "bottomright");
    hud.y = hud.y + 1;
end

function hud.to_bottom_right_pixel(text)
    local x = 239 - ( hud.xs * string.len(text) );
    local y = 160 - ( hud.ys * (hud.y + 1) );
    gui.pixelText(x, y, text); -- GBA is 240x160
    hud.y = hud.y + 1;
end

function hud.to_bottom_right(text)
    if settings.use_gui_text then
        hud.to_bottom_right_gui(text);
    else
        hud.to_bottom_right_pixel(text);
    end
end

function hud.display_strings(strings)
    for i,string in pairs(strings) do
        hud.to_screen(string);
    end
end

---------------------------------------- Display Functions ----------------------------------------

function hud.display_game_info()
    hud.to_screen(string.format("Progress: 0x%02X %s", hud.game.get_progress(), hud.game.get_progress_name_current()));
    hud.to_screen("HUD   Version: " .. hud.version);
    hud.to_screen("Game  Version: " .. hud.game.get_version_name());
end

function hud.display_RNG(and_value) -- for BN1 & BN2
    if and_value then
        hud.to_screen(string.format("RNG: %08X", hud.game.get_main_RNG_value()));
    end
    hud.to_screen(string.format("Index: %5s", (hud.game.get_main_RNG_index() or "?????")));
    hud.to_screen(string.format("Delta: %5s", (hud.game.get_main_RNG_delta() or     "?")));
end

function hud.display_main_RNG(and_value)
    if and_value then
        hud.to_screen(string.format("M RNG: %08X", hud.game.get_main_RNG_value()));
    end
    hud.to_screen(string.format("M Index: %6s", (hud.game.get_main_RNG_index() or "?????")));
    hud.to_screen(string.format("M Delta: %6s", (hud.game.get_main_RNG_delta() or     "?")));
end

function hud.display_lazy_RNG(and_value)
    if and_value then
        hud.to_screen(string.format("L RNG: %08X", hud.game.get_lazy_RNG_value()));
    end
    hud.to_screen(string.format("L Index: %6s", (hud.game.get_lazy_RNG_index() or "?????")));
    hud.to_screen(string.format("L Delta: %6s", (hud.game.get_lazy_RNG_delta() or     "?")));
end

function hud.display_both_RNG(with_space, and_value)
    if and_value then
        hud.to_screen(string.format("Main: %08X", hud.game.get_main_RNG_value()));
    end
    hud.to_screen(string.format("M Index: %5s", (hud.game.get_main_RNG_index() or "?????")));
    hud.to_screen(string.format("M Delta: %5s", (hud.game.get_main_RNG_delta() or     "?")));
    if with_space then
        hud.to_screen("");
    end
    if and_value then
        hud.to_screen(string.format("Lazy: %08X", hud.game.get_lazy_RNG_value()));
    end
    hud.to_screen(string.format("L Index: %5s", (hud.game.get_lazy_RNG_index() or "?????")));
    hud.to_screen(string.format("L Delta: %5s", (hud.game.get_lazy_RNG_delta() or     "?")));
end

function hud.display_steps(detailed)
    hud.to_screen(string.format("Steps: %5u" , hud.game.get_steps()));
    if hud.game.in_digital_world() then
        hud.to_screen(string.format("Check: %5u" , hud.game.get_check()));
        hud.to_screen(string.format("Checks: %4u", hud.game.get_encounter_checks()));
        if detailed then
            hud.to_screen(string.format("A%%: %7.3f%%", hud.game.get_area_percent()));
            hud.to_screen(string.format("C%%: %7.3f%%", hud.game.get_current_percent()));
        end
        hud.to_screen(string.format("E%%: %7.3f%%", hud.game.get_encounter_percent()));
        hud.to_screen(string.format("Next: %2i"  , hud.game.get_next_check()));
    end
    hud.to_screen(string.format("X: %5i", hud.game.get_X()));
    hud.to_screen(string.format("Y: %5i", hud.game.get_Y()));
end

function hud.display_area()
    hud.set_offset();
    hud.to_bottom_right(hud.game.get_area_name_current());
end

function hud.display_enemy(which_enemy)
    local enemy_name = hud.game.get_enemy_name(which_enemy);
    if enemy_name ~= "Unknown" and enemy_name ~= "Empty" and enemy_name ~= "MegaMan" then
        hud.to_bottom_right(enemy_name);
    end
end

function hud.display_enemies()
    hud.set_offset();
    hud.display_enemy(1);
    hud.display_enemy(2);
    hud.display_enemy(3);
end

function hud.display_draws(how_many, start_at)
    start_at = start_at or 1;
    for i=0,how_many-1 do
        hud.to_screen(string.format("%2i: %2i", i+start_at, hud.game.get_draw_slot(i+start_at)));
    end
end

return hud;

