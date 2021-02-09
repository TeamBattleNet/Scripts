-- Functions for MMBN 3 scripting, enjoy.

local game = require("All/Game");

game.number = 3;

game.ram      = require("BN3/RAM"     );
game.areas    = require("BN3/Areas"   );
game.chips    = require("BN3/Chips"   );
game.enemies  = require("BN3/Enemies" );
game.progress = require("BN3/Progress");

game.fun_flags = {}; -- set in Commands, used in RAM

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
game.game_state_names[0x28] = "Request Board";
game.game_state_names[0x2C] = "Loading NaviCust?"; -- new?
game.game_state_names[0x30] = "Credits";
game.game_state_names[0x34] = "Unused?";

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

-- Menu State

game.folder_state_names = {};
game.folder_state_names[0x04] = "Editing Folder";
game.folder_state_names[0x08] = "Editing Pack";
game.folder_state_names[0x0C] = "Exiting";
game.folder_state_names[0x10] = "To Folder";
game.folder_state_names[0x14] = "To Pack";
game.folder_state_names[0x18] = "Sorting Folder";
game.folder_state_names[0x1C] = "Sorting Pack";

function game.in_folder()
    return game.in_menu_folder_edit() and (game.ram.get.menu_state() == 0x04 or game.ram.get.menu_state() == 0x18);
end

function game.in_pack()
    return game.in_menu_folder_edit() and (game.ram.get.menu_state() == 0x08 or game.ram.get.menu_state() == 0x1C);
end

---------------------------------------- Flags ----------------------------------------

function game.get_fire_flags()
    return game.ram.get.fire_flags();
end

function game.set_fire_flags(fire_flags)
    game.ram.set.fire_flags(fire_flags);
end

---------------------------------------- Draw Slots ----------------------------------------

function game.shuffle_folder_simulate_from_battle(offset)
    local RNG_index = game.get_main_RNG_index();
    if RNG_index ~= nil then
        offset = offset or 0;
        return game.ram.shuffle_folder_simulate_from_main_index(RNG_index-60+1+offset, 30);
    end
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
    options.fun_flags = game.fun_flags;
    game.ram.update_pre(options);
end

function game.update_post(options)
    game.track_game_state();
    game.ram.update_post(options);
end

return game;

