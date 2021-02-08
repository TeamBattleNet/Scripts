-- Functions for MMBN 3 scripting, enjoy.

local game = require("All/Game");

game.number = 3;

game.ram      = require("BN3/RAM"     );
game.areas    = require("BN3/Areas"   );
game.chips    = require("BN3/Chips"   );
game.enemies  = require("BN3/Enemies" );
game.progress = require("BN3/Progress");

game.fun_flags = {}; -- set in Commands, used in RAM

---------------------------------------- RNG Wrapper ----------------------------------------

function game.get_main_RNG_value()
    return game.ram.get.main_RNG_value();
end

function game.set_main_RNG_value(new_value)
    game.ram.set.main_RNG_value(new_value);
end

function game.get_main_RNG_index()
    return game.ram.get.main_RNG_index();
end

function game.set_main_RNG_index(new_index)
    game.ram.set.main_RNG_index(new_index)
end

function game.get_main_RNG_delta()
    return game.ram.get.main_RNG_delta();
end

function game.adjust_main_RNG(steps)
    game.ram.adjust_main_RNG(steps);
end

function game.get_lazy_RNG_value()
    return game.ram.get.lazy_RNG_value();
end

function game.set_lazy_RNG_value(new_value)
    game.ram.set.lazy_RNG_value(new_value);
end

function game.get_lazy_RNG_index()
    return game.ram.get.lazy_RNG_index();
end

function game.set_lazy_RNG_index(new_index)
    game.ram.set.lazy_RNG_index(new_index)
end

function game.get_lazy_RNG_delta()
    return game.ram.get.lazy_RNG_delta();
end

function game.adjust_lazy_RNG(steps)
    game.ram.adjust_lazy_RNG(steps);
end

---------------------------------------- Game State ----------------------------------------

-- Game State

game.game_state_names = {};                    -- skip 2 bits, add 1
game.game_state_names[0x00] = "Title";         -- or BIOS
game.game_state_names[0x04] = "World";         -- real and digital
game.game_state_names[0x08] = "Battle";
game.game_state_names[0x0C] = "Player Change"; -- jack-in / out
game.game_state_names[0x10] = "Demo End";      -- what is this?
game.game_state_names[0x14] = "Capcom Logo";
game.game_state_names[0x18] = "Menu";
game.game_state_names[0x1C] = "Shop";
game.game_state_names[0x20] = "GAME OVER";
game.game_state_names[0x24] = "Chip Trader";
game.game_state_names[0x28] = "Request Board"; -- new
game.game_state_names[0x2C] = "Unused?";
game.game_state_names[0x30] = "Credits";
game.game_state_names[0x34] = "Unused?";

function game.get_game_state_name()
    return game.game_state_names[game.ram.get.game_state()] or "Unknown Game State";
end

function game.in_title()
    return game.ram.get.game_state() == 0x00;
end

function game.in_world()
    return game.ram.get.game_state() == 0x04;
end

function game.in_battle()
    return game.ram.get.game_state() == 0x08;
end

function game.in_transition()
    return game.ram.get.game_state() == 0x0C;
end

function game.in_splash()
    return game.ram.get.game_state() == 0x14;
end

function game.in_menu()
    return game.ram.get.game_state() == 0x18;
end

function game.in_shop()
    return game.ram.get.game_state() == 0x1C;
end

function game.in_game_over()
    return game.ram.get.game_state() == 0x20;
end

function game.in_chip_trader()
    return game.ram.get.game_state() == 0x24;
end

function game.in_request_board()
    return game.ram.get.game_state() == 0x28;
end

function game.in_credits()
    return game.ram.get.game_state() == 0x30;
end

-- Battle State

game.battle_state_names = {};
game.battle_state_names[0x00] = "TBD";
game.battle_state_names[0x04] = "TBD";
game.battle_state_names[0x08] = "TBD";
game.battle_state_names[0x0C] = "TBD";
game.battle_state_names[0x10] = "TBD";
game.battle_state_names[0x14] = "TBD";
game.battle_state_names[0x18] = "TBD";

function game.get_battle_state_name()
    return game.battle_state_names[game.ram.get.battle_state()] or "Unknown Battle State";
end

-- Menu State

game.folder_state_names = {};
game.folder_state_names[0x04] = "Editing Folder";
game.folder_state_names[0x08] = "Editing Pack";
game.folder_state_names[0x0C] = "Exiting";
game.folder_state_names[0x10] = "To Folder";
game.folder_state_names[0x14] = "To Pack";
game.folder_state_names[0x18] = "Sorting Folder";
game.folder_state_names[0x1C] = "Sorting Pack";

function game.get_folder_state_name()
    return game.game.folder_state_names[game.ram.get.menu_state()] or "Unknown Folder State";
end

function game.in_folder()
    return game.in_menu_folder_edit() and (game.ram.get.menu_state() == 0x04 or game.ram.get.menu_state() == 0x18);
end

function game.in_pack()
    return game.in_menu_folder_edit() and (game.ram.get.menu_state() == 0x08 or game.ram.get.menu_state() == 0x1C);
end

-- Style Info

game.elements = {"Elec", "Heat", "Aqua", "Wood"};
game.element_names = {}; -- FWEG but Elec is first
game.element_names[0x00] = "None";
game.element_names[0x01] = "Elec";
game.element_names[0x02] = "Heat";
game.element_names[0x03] = "Aqua";
game.element_names[0x04] = "Wood";
game.element_names[0x05] = "????";
game.element_names[0x06] = "????";
game.element_names[0x07] = "????";

game.styles = {"Guts", "Cust", "Team", "Shld", "Grnd", "Shdw", "Bug"};
game.style_names = {};
game.style_names[0x00] = "Norm";
game.style_names[0x01] = "Guts";
game.style_names[0x02] = "Cust";
game.style_names[0x03] = "Team";
game.style_names[0x04] = "Shld";
game.style_names[0x05] = "Grnd";
game.style_names[0x06] = "Shdw";
game.style_names[0x07] = "Bug";

---------------------------------------- Flags ----------------------------------------

function game.get_fire_flags()
    return game.ram.get.fire_flags();
end

function game.set_fire_flags(fire_flags)
    game.ram.set.fire_flags(fire_flags);
end

---------------------------------------- Battlechips ----------------------------------------

function game.count_library()
    local count = 0;
    for i=0,0x20 do -- TODO: 33 total bytes?
        local byte = game.ram.get.library(i);
        for i=0,7 do
            if bit.check(byte, i) then
                count = count + 1;
            end
        end
    end
    return count;
end

--[[ TODO
function game.is_chip_selected()
    return game.ram.get.chip_selected_flag() ~= 0x00;
end

function game.get_selected_chip_location_name()
    local selected_flag = game.ram.get.chip_selected_flag();
    if selected_flag == 0x01 then
        return "Folder";
    elseif selected_flag == 0x02 then
        return "Pack";
    end
    return "None";
end

function game.get_selected_ID()
    local selected_chip_location = game.get_selected_chip_location_name();
    if selected_chip_location == "Folder" then
        return game.ram.get.folder_ID(game.get_cursor_offset_selected()+game.get_cursor_position_selected());
    elseif selected_chip_location == "Pack" then
        return game.ram.get.pack_ID(game.get_cursor_offset_selected()+game.get_cursor_position_selected());
    end
    return -1;
end

function game.get_selected_code()
    local selected_chip_location = game.get_selected_chip_location_name();
    if selected_chip_location == "Folder" then
        return game.ram.get.folder_code(game.get_cursor_offset_selected()+game.get_cursor_position_selected());
    elseif selected_chip_location == "Pack" then
        return game.ram.get.pack_code(game.get_cursor_offset_selected()+game.get_cursor_position_selected());
    end
    return -1;
end
--]]

----------------------------------------Mega Modifications ----------------------------------------

function game.set_buster_stats(power_level)
    game.ram.set.buster_attack(power_level);
    game.ram.set.buster_rapid (power_level);
    game.ram.set.buster_charge(power_level);
end

function game.reset_buster_stats()
    game.set_buster_stats(0); -- 0 indexed
end

function game.max_buster_stats()
    game.set_buster_stats(4);
end

function game.hub_buster_stats()
    game.set_buster_stats(5); -- super armor
end

function game.op_buster_stats()
    game.set_buster_stats(7); -- 327 buster shots
end

function game.get_HPMemory_count()
    return game.ram.get.HPMemory();
end

function game.calculate_max_HP()
    return 100 + (20 * game.get_HPMemory_count());
end
---------------------------------------- Encounter Tracker ----------------------------------------

local last_encounter_check = 0;

function game.get_encounter_checks()
    return math.floor(last_encounter_check / 64); -- approximate
end

local function track_encounter_checks()
    if game.in_world() then
        if game.get_check() < last_encounter_check then
            last_encounter_check = 0;
        elseif game.get_check() > last_encounter_check then
            last_encounter_check = game.get_check();
        end
    end
end

function game.get_encounter_threshold()
    local curve_addr = game.ram.addr.encounter_curve;
    local curve_offset = (game.get_main_area() - 0x80) * 0x10 + game.get_sub_area();
    curve = memory.read_u8(curve_addr + curve_offset);
    local odds_addr = game.ram.addr.encounter_odds;
    local test_level = math.min(math.floor(game.get_steps() / 64), 16);
    return memory.read_u8(odds_addr + test_level * 8 + curve);
end

function game.get_encounter_chance()
    return (game.get_encounter_threshold() / 32) * 100;
end

function game.would_get_encounter()
    return game.get_encounter_threshold() > (game.get_main_RNG_value() % 0x20);
end

---------------------------------------- Miscellaneous ----------------------------------------

function game.get_max_HP()
    return memory.read_u16_le(world_HP_max);
end

function game.get_style_type()
    return bit.rshift(bit.band(memory.read_u8(style_stored), 0x38), 3);
end

function game.get_style_type_name()
    return style_names[ram.get_style_type()] or "????";
end

function game.get_current_element()
    return bit.band(memory.read_u8(style_stored), 0x07);
end

function game.get_current_element_name()
    return style_elements[ram.get_current_element()] or "????";
end

function game.get_style_name()
    return ram.get_current_element_name() .. ram.get_style_type_name();
end

function game.get_next_element()
    return memory.read_u8(next_element);
end

function game.get_next_element_name()
    return style_elements[ram.get_next_element()] or "????";
end

function game.set_next_element(new_next_element)
    return memory.write_u8(next_element, bit.band(new_next_element, 0x07));
end

function game.get_battle_count()
    return memory.read_u8(battle_count);
end

function game.set_battle_count(new_battle_count)
    return memory.write_u8(battleCount, new_battle_count);
end

function game.add_battle_count(some_battles)
    return ram.set_battle_count(ram.get_battle_count() + some_battles);
end

---------------------------------------- Miscellaneous ----------------------------------------

function game.get_GMD_RNG()
    return memory.read_u32_le(GMD_RNG);
end

function game.set_GMD_RNG(new_GMD_RNG)
    return memory.write_u32_le(GMD_RNG, new_GMD_RNG);
end

function game.randomize_GMD_RNG()
    return game.ram.set.GMD_RNG(game.get_main_RNG_value());
end

function game.get_GMD_value()
    return memory.read_u32_le(GMD_value);
end

function game.get_gamble_pick()
    return memory.read_u8(gamble_pick);
end

function game.get_gamble_win()
    return memory.read_u8(gamble_win);
end

function game.is_gambling()
    if game.ram.get.main_area() == 0x8C then -- Sub Comps
        if game.ram.get.sub_area() == 0x02 or game.ram.get.sub_area() == 0x08 or game.ram.get.sub_area() == 0x0C then
            return true; -- Vending Comp (SciLab) or TV Board Comp or Vending Comp (Hospital)
        end
    end
    return false;
end

function game.in_Secret_3()
    if game.ram.get.main_area() == 0x95 and game.ram.get.sub_area() == 0x02 then
        return true; -- Bug Frag Trader
    end
    return false;
end

---------------------------------------- Module Controls ----------------------------------------

function game.initialize(options)
    game.ram.initialize(options);
end

function game.update_pre(options)
    track_encounter_checks();
    options.fun_flags = game.fun_flags;
    game.ram.update_pre(options);
end

function game.update_post(options)
    game.update_state();
    game.ram.update_post(options);
end

return game;

