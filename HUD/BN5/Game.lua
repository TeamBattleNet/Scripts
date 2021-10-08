-- Functions for MMBN 5 scripting, enjoy.

local game = require("All/Game");

game.number = 5;
game.name = "BN5";

game.ram      = require("BN5/RAM"     );
game.areas    = require("BN5/Areas"   );
game.chips    = require("BN5/Chips"   );
game.enemies  = require("BN5/Enemies" );
game.progress = require("BN5/Progress");

game.fun_flags = {}; -- set in Commands, used in RAM

---------------------------------------- Game State ----------------------------------------

game.state.splash        = 0x00; -- or BIOS or loading
game.state.world_init    = 0x00; -- real and digital
game.state.world         = 0x04; -- real and digital
game.state.battle_init   = 0x08;
game.state.battle        = 0x0C;
game.state.transition    = 0x14; -- jack-in / out
game.state.title         = 0x1C;
game.state.menu          = 0x1C;
game.state.liberation    = 0x18;
game.state.shop          = 0x28;

game.game_state_names[0x00] = "World Init";
game.game_state_names[0x04] = "World";
game.game_state_names[0x08] = "Battle Init";
game.game_state_names[0x0C] = "Battle";
game.game_state_names[0x10] = "Map Change";
game.game_state_names[0x14] = "Player Change";
game.game_state_names[0x18] = "Liberation";
game.game_state_names[0x1C] = "Menu";
game.game_state_names[0x20] = "BBS";
game.game_state_names[0x28] = "Shop";
game.game_state_names[0x2C] = "Liberation Init";
game.game_state_names[0x30] = "Chip Trader";

function game.did_leave_battle()
    return (game.did_game_state_change() and game.previous_game_state == 0x0C);
end

function game.in_liberation()
    return game.ram.get.game_state() == game.state.liberation;
end

--game.state.game_over     = 0xFF;
--game.state.chip_trader   = 0xFF;
--game.state.request_board = 0xFF;
--game.state.load_navicust = 0xFF;
--game.state.credits       = 0xFF;

-- Battle Mode

function game.in_chip_select()
    return (true);
end

function game.in_combat()
    return (false);
end

-- Battle State

-- Menu Mode

game.menu.folder_select = 0x00;
game.menu.subchips      = 0x04;
game.menu.library       = 0x08;
game.menu.megaman       = 0x0C;
game.menu.email         = 0x10;
game.menu.key_items     = 0x14;
game.menu.network       = 0x18;
game.menu.save          = 0x1C;
game.menu.navicust      = 0x20;
game.menu.folder_edit   = 0x24;

-- Menu State

function game.in_folder()
    return game.in_menu_folder_edit() and (true);
end

function game.in_pack()
    return game.in_menu_folder_edit() and (false);
end

---------------------------------------- Battle Chips ----------------------------------------

function game.count_library()
    local count = 0;
    for i=0,0x1F do -- TODO: determine total bytes
        count = count + game.bit_counter(game.ram.get.library(i));
    end
    return count;
end

function game.simulate_folder_shuffle()
    local seed = game.ram.get.lazy_RNG_value();

    -- TODO: Determine actual number of seeds to advance.
    for i=0,247 do
        seed = game.ram.simulate_RNG(seed);
    end

    local draw_slots = game.ram.shuffle_folder_simulate_from_value(seed, 30);
end

---------------------------------------- Fun Flags  ----------------------------------------

function game.title_screen_A()
    if game.did_leave_title_screen() then
        print("");
        local lazy_RNG_index = game.get_lazy_RNG_index();
        local main_RNG_index = game.get_main_RNG_index();
        local on_A_RNG_index = (main_RNG_index and main_RNG_index - 17);
        game.broadcast(string.format("%u: Pressed A on M RNG Index %s", emu.framecount(), on_A_RNG_index or "?????"));
        game.broadcast(string.format("%u: Loaded in on M RNG Index %s", emu.framecount(), main_RNG_index or "?????"));
        game.broadcast(string.format("%u: Loaded in on L RNG Index %s", emu.framecount(), lazy_RNG_index or "?????"));
    end
end

function game.use_fun_flags(fun_flags) -- TODO: Rename
    --game.title_screen_A();
    
    if fun_flags.randomize_colors then
        if game.did_game_state_change() or game.did_menu_mode_change() or game.did_area_change() then game.doit_later[emu.framecount()+5] = game.randomize_color_palette; end
    end
    
    if fun_flags.is_routing and not game.in_title() then
        if game.did_progress_change() then
            game.broadcast(game.get_progress_change());
        end
        
        if game.did_magic_byte_change() then
            game.broadcast_magic_byte();
        end
    end
end

---------------------------------------- GMD Generation ----------------------------------------

function game.on_spawn_gmds()
    local r14 = emu.getregister("R14");
    if r14 ~= 0x8004b01 then
        local RNG_value = game.ram.get.main_RNG_value();

        game.ram.generate_gmds_simulate_from_value(RNG_value);
    end
end

if game.on_spawn_gmds and game.ram.addr.gmd_function then
    event.onmemoryexecute(game.on_spawn_gmds, game.ram.addr.gmd_function);
end

---------------------------------------- ACE Shenanigans ----------------------------------------

function game.check_crossover_data(payload, log_data)
    local name = game.ram.get.crossover_name();
    local desc1 = game.ram.get.crossover_desc_1();
    local desc2 = game.ram.get.crossover_desc_2();
    local desc3 = game.ram.get.crossover_desc_3();

    if name == payload.name and desc1 == payload.desc1 and desc2 == payload.desc2 and desc3 == payload.desc3 then
        return true;
    else
        if log_data then
            if name ~= payload.name then
                if name == 0 then
                    print("Payload name is all 0s. This likely means you have not loaded the payload. Enter the Crossover Battle menu from the title screen, enter the first menu, then back out.");
                else
                    print(string.format("Payload name data is incorrect. Expected: %08x, Actual: %08x", payload.name, name));
                end
            end

            if desc1 ~= payload.desc1 or desc2 ~= payload.desc2 or desc3 ~= payload.desc3 then
                if desc1 == 0 and desc2 == 0 and desc3 == 0 then
                    print("Payload description is all 0s. This likely means you have not loaded the payload. Enter the Crossover Battle menu from the title screen, enter the first menu, then back out.");
                else
                    print(string.format("Payload description data is incorrect. Expected: %08x%08x%08x, Actual: %08x%08x%08x", payload.desc1, payload.desc2, payload.desc3, desc1, desc2, desc3));
                end
            end
        end
    end

    if log_data then
        print("");
    end

    return false;
end

function game.is_safe_chip(chip_id)
    if chip_id < 0x00E6 or chip_id > 0x00FF then
        return true;
    end

    return false;
end

function game.is_safe_damage(chip_damage)
    if chip_damage < 0x00E6 or chip_damage > 0x00FF then
        return true;
    end

    return false;
end

function game.check_knightman_hand_buffer(log_data)
    local chip_id_1 = game.ram.get.hand_buffer_chip_id_1();
    local chip_id_2 = game.ram.get.hand_buffer_chip_id_2();
    local chip_id_3 = game.ram.get.hand_buffer_chip_id_3();
    local chip_id_4 = game.ram.get.hand_buffer_chip_id_4();
    local chip_id_5 = game.ram.get.hand_buffer_chip_id_5();

    local chip_damage_1 = game.ram.get.hand_buffer_chip_damage_1();
    local chip_damage_2 = game.ram.get.hand_buffer_chip_damage_2();
    local chip_damage_3 = game.ram.get.hand_buffer_chip_damage_3();
    local chip_damage_4 = game.ram.get.hand_buffer_chip_damage_4();
    local chip_damage_5 = game.ram.get.hand_buffer_chip_damage_5();

    -- First, check chip IDs are correct for KnightManSP 240 setup.
    if game.is_safe_chip(chip_id_1) and chip_id_2 == 0x00FF and chip_id_3 == 0x0100 and game.is_safe_chip(chip_id_4) and chip_id_5 == 0x00FE then
        -- Verify the damage values are correct
        if chip_damage_1 == 0x0000 and chip_damage_2 == 0x00F0 and chip_damage_3 == 0x00DC and game.is_safe_damage(chip_damage_4) and chip_damage_5 == 0x00AA then
            return true;
        else
            if log_data then
                print("Hand Buffer is wrong: Damage values are wrong. Expected damage values below (Note: XXXX can be any chip damage less than 230 or greater than 255).");
                print("0000 00F0 00DC XXXX 00AA");
                print("Actual Chip Damage.");
                print(string.format("%04x %04x %04x %04x %04x", chip_damage_1, chip_damage_2, chip_damage_3, chip_damage_4, chip_damage_5));
            end
        end
    -- If KnightManSP 240 damage setup isn't correct, check chip IDs are correct for KnightManSP 220 setup.
    elseif game.is_safe_chip(chip_id_1) and chip_id_2 == 0x0100 and chip_id_3 == 0x00FF and chip_id_4 == 0x0001 and chip_id_5 == 0x00FE then
        -- If KnightManSP 240 damage setup isn't correct, check chip IDs are correct for KnightManSP 220 setup.
        -- Verify the damage values are correct
        if chip_damage_1 == 0x0000 and chip_damage_2 == 0x00F0 and chip_damage_3 == 0x00DC and game.is_safe_damage(chip_damage_4) and chip_damage_5 == 0x00AA then
            return true;
        else
            if log_data then
                print("Hand Buffer is wrong: Damage values are wrong. Expected damage values below (Note: XXXX can be any chip damage less than 230 or greater than 255).");
                print("0000 00F0 00DC XXXX 00AA");
                print("Actual Chip Damage.");
                print(string.format("%04x %04x %04x %04x %04x", chip_damage_1, chip_damage_2, chip_damage_3, chip_damage_4, chip_damage_5));
            end
        end
    else
        if log_data then
            print("Hand Buffer is wrong: Chips were not selected in the right order. Expected order listed below (Note: XXXX can be any chip ID less than 230 or greater than 255).");
            print("Chip ID order for KnightMan SP 240 damage.");
            print("XXXX 00FF 0100 XXXX 00FE");
            print("Chip ID order for KnightMan SP 240 damage.");
            print("XXXX 0100 00FF 0001 00FE");
            print("Actual Chip ID order.");
            print(string.format("%04x %04x %04x %04x %04x", chip_id_1, chip_id_2, chip_id_3, chip_id_4, chip_id_5));
        end
    end

    if log_data then
        print("");
    end

    -- If both cases are incorrect, the hand buffer setup is bad. Return false
    return false;
end

function game.check_hand_buffer(type, log_data)
    if type == "KnightMan" then
        return game.check_knightman_hand_buffer(log_data)
    end
end

function game.check_guardian_combo(log_data)
    local dark_mega_ai_combo = game.ram.get.dark_mega_ai_combo_1();

    if dark_mega_ai_combo == 0x00CB00FC then
        return true;
    else
        if log_data then
            -- Check if Guardian is the first chip. If it is, then verify the X Y coordinates.
            if game.ram.get.dark_mega_ai_combo_1_chip_id_1() ~= 0x00CB then
                print("Guardian Combo is wrong: Chip 1 in the top combo is not Guardian.");

                -- If Guardian is not the first chip, check other combos to see if the Guardian combo is not the top combo.
                if game.ram.get.dark_mega_ai_combo_2_chip_id_1() == 0x00CB then
                    print("Noticed that Guardian combo is in the list, but not the top combo. Either another combo has been done more often, or a different combo has been done more recently. Try doing the combo again.");
                end

                if game.ram.get.dark_mega_ai_combo_3_chip_id_1() == 0x00CB then
                    print("Noticed that Guardian combo is in the list, but not the top combo. Either another combo has been done more often, or a different combo has been done more recently. Try doing the combo again.");
                end

                if game.ram.get.dark_mega_ai_combo_4_chip_id_1() == 0x00CB then
                    print("Noticed that Guardian combo is in the list, but not the top combo. Either another combo has been done more often, or a different combo has been done more recently. Try doing the combo again.");
                end

                if game.ram.get.dark_mega_ai_combo_5_chip_id_1() == 0x00CB then
                    print("Noticed that Guardian combo is in the list, but not the top combo. Either another combo has been done more often, or a different combo has been done more recently. Try doing the combo again.");
                end
            else
                if game.ram.get.dark_mega_ai_combo_1_x() ~= -4 then
                    print("Guardian Combo is wrong: X position is wrong. Expected: " .. -4 .. ", Actual: " .. game.ram.get.dark_mega_ai_combo_1_x());
                end

                if game.ram.get.dark_mega_ai_combo_1_y() ~= 0 then
                    print("Guardian Combo is wrong: Y position is wrong. Expected: " .. 0 .. ", Actual: " .. game.ram.get.dark_mega_ai_combo_1_y());
                end
            end

            print("");
        end
    end

    return false;
end

function game.check_navi_stats(expected_curr_hp, expected_max_hp, expected_karma, log_data)
    local curr_hp = game.ram.get.navi_stats_buffer_curr_hp();
    local max_hp = game.ram.get.navi_stats_buffer_max_hp();
    local karma = game.ram.get.navi_stats_buffer_karma();

    if curr_hp == expected_curr_hp and max_hp == expected_max_hp and karma == expected_karma then
        return true;
    else
        if log_data then
            if curr_hp ~= expected_curr_hp then
                print("Current HP in buffer is wrong. Expected: " .. expected_curr_hp .. ", Actual: " .. curr_hp);
            end
            if max_hp ~= expected_max_hp then
                print("Max HP in buffer is wrong. Expected: " .. expected_max_hp .. ", Actual: " .. max_hp);
            end
            if karma ~= expected_karma then
                print("Karma in buffer is wrong. Expected: " .. expected_karma .. ", Actual: " .. karma);
            end

            print("");
        end
    end

    return false;
end

---------------------------------------- State Tracking ----------------------------------------

function game.track_game_state_bn5()
end

---------------------------------------- Module Controls ----------------------------------------

function game.initialize(options)
    game.ram.initialize(options);
    require("All/Settings").set_display_text("gui"); -- TODO: Remove when gui.text fully supported
end

function game.pre_update(options)
    options.fun_flags = game.fun_flags;
    game.ram.pre_update(options);
    game.use_fun_flags(game.fun_flags);
end

function game.post_update(options)
    game.track_game_state_bn5();
    game.ram.post_update(options);
end

return game;

