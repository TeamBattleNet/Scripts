-- HUD Script for Mega Man Battle Network 5, enjoy.

-- https://drive.google.com/drive/folders/1TWCr27-usF4kJqQ5pK-8BdQ8-ID21-Cy Did you check The Notes?

local hud = require("All/HUD");

hud.version = hud.version .. ".0.0";

hud.game = require("BN5/Game");

local ase_setups = require("BN5/ASE_Setups");
local curr_ase_setup = 1;

local total_fights = 0;

---------------------------------------- Display Functions ----------------------------------------

local function display_player_info()
    hud.to_screen(string.format("Zenny  : %6u", hud.game.get_zenny()));
    hud.to_screen(string.format("BugFrag: %6u", hud.game.get_bug_frags()));
    hud.to_screen(string.format("Max  HP: %6u", hud.game.calculate_max_HP()));
    hud.to_screen(string.format("Library: %6u", hud.game.count_library()));
end

local function display_edit_slots()
    if hud.game.in_folder() then
        for i=1,8 do
            hud.to_pixel( 97, 16+16*i, string.format("%2i", hud.game.get_cursor_offset_folder()+i));
        end
    elseif hud.game.in_pack() then
        for i=1,8 do
            hud.to_pixel(139, 16+16*i, string.format("%3i", hud.game.get_cursor_offset_pack()+i));
        end
    end
end

local function display_selected_chip()
    -- TODO: Selected Chip
end

local function display_gmd_table()
    hud.to_screen(string.format("Index: %8s", hud.game.ram.get.gmd_initial_seed_index()));
    hud.to_screen(string.format("Seed: %9x", hud.game.ram.get.gmd_initial_seed()));
    local gmd_table = hud.game.ram.get.gmd_table();
    local current_area = hud.game.get_area_name(hud.game.get_main_area(), hud.game.get_sub_area());
    if gmd_table[current_area] ~= nil then
        hud.to_screen("");
        hud.to_screen("GMD 1");
        hud.to_screen(string.format("Spawn: %d", gmd_table[current_area][1]["location"]));
        hud.to_screen(string.format("Reward: %s", gmd_table[current_area][1]["contents"]));
        hud.to_screen("");
        hud.to_screen("GMD 2");
        hud.to_screen(string.format("Spawn: %d", gmd_table[current_area][2]["location"]));
        hud.to_screen(string.format("Reward: %s", gmd_table[current_area][2]["contents"]));
    end
end

---------------------------------------- HUD Modes ----------------------------------------

local function HUD_speedrun()
    hud.to_screen(string.format("Progress: 0x%02X %s", hud.game.get_progress(), hud.game.get_progress_name_current()));
    display_player_info();
    hud.to_screen(string.format("EnCounter: %4u", total_fights));
    hud.to_screen("");
    hud.display_both_RNG(true, false);
    hud.display_area();
end

local function HUD_routing()
    hud.set_position(0, 8);
    hud.set_center_x(54);
    hud.to_screen("0180: " .. hud.game.get_string_hex(0x02000180, 4, true));
    hud.to_screen("60CC: " .. hud.game.get_string_hex(0x020060CC, 4, true));
    hud.to_screen("299C: " .. hud.game.get_string_hex(0x0200299C, 4, true));
end

local function HUD_battle()
    hud.set_position(1, 17);
    hud.set_offset( 0, 0);
    hud.display_draws(10,  1);
    hud.set_offset( 8, 0);
    hud.display_draws(10, 11);
    hud.set_offset(16, 0);
    hud.display_draws(10, 21);
    hud.set_offset(24, 0);
    hud.to_screen(string.format("Fight:  0x%04X", hud.game.get_battle_pointer()));
    hud.display_both_RNG(false, true);
    hud.to_screen("");
    hud.to_screen(string.format("Checks: %4u", hud.game.get_encounter_checks()));
    hud.to_screen(string.format("%%: %8.3f%%", 100-hud.game.get_current_percent()));
    --hud.to_screen(string.format("Drawfset: %2u", draw_offset));
    hud.display_enemies();
end

local function HUD_gmds()
    if hud.game.in_real_world() then
        hud.set_position(2, 23);
        hud.to_screen("Jack in to see GMD contents");
    else
        hud.set_position(2, 17);
        display_gmd_table();
    end
end

local log_data = true;
local init_message = true;
local swap_setups = true;
local function HUD_ACE()
    if init_message then
        print("Welcome to the ACE HUD! To change which setup you would like to practice, press the Spacebar.\n");
        init_message = false;
    end

    local keys = input.get();

    if keys.Space then
        if swap_setups then
            curr_ase_setup = curr_ase_setup + 1;
            if curr_ase_setup > table.getn(ase_setups) then
                curr_ase_setup = 1;
            end
            log_data = true;
            swap_setups = false;
        end
    else
        swap_setups = true;
    end

    local ase_setup = ase_setups[curr_ase_setup];

    if hud.game.did_leave_battle() then
        log_data = true;
    end

    local hand_buffer = false;
    local guardian_combo = false;
    local navi_stats = false;
    local payload = false;

    if hud.game.in_battle() or hud.game.in_game_over() then
        if hud.game.did_game_state_change() then
            hud.game.simulate_folder_shuffle()
        end
        if hud.game.in_combat() then
            hud.set_position(2, 17);
            hud.to_screen(string.format("Fight:  0x%04X", hud.game.get_battle_pointer()));
            hud.display_both_RNG();
        else
            hud.set_position(2, 25);
            hud.display_draws(9);
            hud.set_offset(8, 0);
            hud.display_both_RNG();
            hud.to_screen("");
            hud.to_screen(string.format("Run %%: %6.2f%%", hud.game.get_run_chance()));
            --hud.to_screen(string.format("M-Boomer: %4i", hud.game.find_first(138)));
            hud.to_screen(string.format("Checks: %6u", hud.game.get_encounter_checks()));
            hud.to_screen(string.format("%%: %10.3f%%", 100-hud.game.get_current_percent()));
        end
        hud.display_enemies();
    else
        hud.set_position(108, 126);
        if hud.game.check_hand_buffer(ase_setup.hand_buffer, log_data) then
            hud.to_screen("Hand Buffer:     Correct!");
            hand_buffer = true;
        else
            hud.to_screen("Hand Buffer:     Incorrect");
        end

        -- Check other Guardian combo, navi stats, and potentially payload if KnightMan hand buffer is required
        if ase_setup.hand_buffer == "KnightMan" then
            if hud.game.check_guardian_combo(log_data) then
                hud.to_screen("Guardian Combo:  Correct!");
                guardian_combo = true;
            else
                hud.to_screen("Guardian Combo:  Incorrect");
            end

            if hud.game.check_navi_stats(ase_setup.curr_hp, ase_setup.max_hp, ase_setup.karma, log_data) then
                hud.to_screen("Navi Stats:      Correct!");
                navi_stats = true;
            else
                hud.to_screen("Navi Stats:      Incorrect");
            end

            if ase_setup.type == "ACE" then
                if hud.game.check_crossover_data(ase_setup.payload, log_data) then
                    hud.to_screen("Payload:         Correct!");
                    payload = true;
                else
                    hud.to_screen("Payload:         Incorrect");
                end
            else
                payload = true;
            end
        else
            guardian_combo = true;
            navi_stats = true;
            payload = true;
        end

        hud.set_position(2, 126);
        hud.set_offset(0, 0);
        hud.to_screen(string.format("Karma: %9d", hud.game.ram.get.karma()))
        hud.to_screen(string.format("Current HP: %4d", hud.game.ram.get.curr_hp()))
        hud.to_screen(string.format("Max HP: %8d", hud.game.ram.get.max_hp()))

        hud.set_position(2, 0);
        hud.set_offset(0, 0);
        hud.to_screen("Currently verifying: " .. ase_setup.name);
        if hand_buffer and guardian_combo and navi_stats and payload then
            hud.to_screen("Expected Outcome: Success!");
        else
            hud.to_screen("Expected Outcome: Crash");
        end
    end

    log_data = false;
end

local function HUD_auto()
    if hud.game.in_title() or hud.game.in_splash() or hud.game.in_transition() then
        hud.display_game_info();
        hud.to_screen("");
        display_player_info();
        hud.display_area();
    elseif hud.game.in_liberation() then
        hud.set_position(2, 17);
        hud.display_steps();
        hud.display_area();
    elseif hud.game.in_world() or hud.game.in_liberation() then
        if hud.game.in_real_world() then
            hud.set_position(2, 23);
        else
            hud.set_position(2, 17);
        end
        hud.display_both_RNG();
        hud.display_steps(true);
        if hud.game.get_sneak() > 0 then
            hud.to_screen(string.format("Sneak: %5u", hud.game.get_sneak()));
        end
        hud.display_area();
    elseif hud.game.in_battle() or hud.game.in_game_over() then
        if hud.game.did_game_state_change() then
            hud.game.simulate_folder_shuffle()
        end
        if hud.game.in_combat() then
            hud.set_position(2, 17);
            hud.to_screen(string.format("Fight:  0x%04X", hud.game.get_battle_pointer()));
            hud.display_both_RNG();
        else
            hud.set_position(2, 25);
            hud.display_draws(9);
            hud.set_offset(8, 0);
            hud.display_both_RNG();
            hud.to_screen("");
            hud.to_screen(string.format("Run %%: %6.2f%%", hud.game.get_run_chance()));
            --hud.to_screen(string.format("M-Boomer: %4i", hud.game.find_first(138)));
            hud.to_screen(string.format("Checks: %6u", hud.game.get_encounter_checks()));
            hud.to_screen(string.format("%%: %10.3f%%", 100-hud.game.get_current_percent()));
        end
        hud.display_enemies();
    elseif hud.game.in_menu() then
        hud.display_both_RNG();
        if hud.game.in_menu_folder_edit() then
            display_edit_slots();
            display_selected_chip();
        end
    elseif hud.game.in_shop() then
        hud.set_position(168, 38);
        display_player_info();
    elseif hud.game.in_chip_trader() then
        hud.set_position(130, 1);
        hud.display_both_RNG(false, true);
    elseif hud.game.in_credits() then
        hud.display_game_info();
        gui.text(0, 0, "!blame SJH1UEKA", 0x80FFFFFF, "bottomleft");
    else
        hud.to_screen("Unknown Game State!");
    end
end

hud.HUDs = {}; -- in order
table.insert(hud.HUDs, HUD_auto);
table.insert(hud.HUDs, HUD_battle);
table.insert(hud.HUDs, HUD_routing);
table.insert(hud.HUDs, HUD_speedrun);
table.insert(hud.HUDs, HUD_gmds);
table.insert(hud.HUDs, HUD_ACE);

---------------------------------------- Module Controls ----------------------------------------

function hud.Up()
    print("\n" .. hud.game.get_folder_text(1));
end

function hud.Down()
    print("\n" .. hud.game.get_draw_slots_text_multi_line());
    print("\n" .. hud.game.get_draw_slots_text_one_line());
end

function hud.B()
    --hud.game.randomize_GMD_RNG();
end

function hud.update_local_state()
    if hud.game.did_game_state_change() and hud.game.in_battle() then
        total_fights = total_fights + 1;
    end
end

return hud;

