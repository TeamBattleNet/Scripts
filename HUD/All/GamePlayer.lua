-- Common Functions for MMBN scripting, enjoy.

local game = require("All/GameState");

game.ram      = {}; -- overridden later
game.areas    = {}; -- overridden later
game.chips    = {}; -- overridden later
game.enemies  = {}; -- overridden later
game.progress = {}; -- overridden later

---------------------------------------- Location ----------------------------------------

-- Area

function game.get_main_area()
    return game.ram.get.main_area();
end

function game.get_sub_area()
    return game.ram.get.sub_area();
end

function game.set_main_area(new_main_area)
    game.ram.set.main_area(new_main_area);
end

function game.set_sub_area(new_sub_area)
    game.ram.set.sub_area(new_sub_area);
end

function game.teleport(new_main_area, new_sub_area)
    game.set_main_area(new_main_area);
    game.set_sub_area(new_sub_area);
end

function game.get_area_name(main_area, sub_area)
    if game.areas.names[main_area] then
        if game.areas.names[main_area][sub_area] then
            return game.areas.names[main_area][sub_area];
        end
        return "Unknown Sub Area";
    end
    return "Unknown Main Area";
end

function game.get_area_name_current()
    return game.get_area_name(game.get_main_area(), game.get_sub_area());
end

function game.does_area_exist(main_area, sub_area)
    return game.areas.names[main_area] and game.areas.names[main_area][sub_area];
end

function game.get_area_groups_real()
    return game.areas.real_groups;
end

function game.get_area_groups_digital()
    return game.areas.digital_groups;
end

function game.get_area_group_name(main_area)
    if game.areas.names[main_area] and game.areas.names[main_area].group then
        return game.areas.names[main_area].group;
    end
    return "Unknown Main Area";
end

function game.in_real_world()
    if game.get_main_area() < 0x80 then
        return true;
    end
    return false;
end

function game.in_digital_world()
    return not game.in_real_world();
end

function game.in_the_internet()
    return (bit.band(game.get_main_area(), 0x90) == 0x90);
end

-- Position

function game.get_X()
    return game.ram.get.your_X();
end

function game.get_Y()
    return game.ram.get.your_Y();
end

function game.get_sneak()
    return game.ram.get.sneak();
end

function game.reset_sneak()
    game.ram.set.sneak(6000);
end

function game.get_steps()
    return game.ram.get.steps();
end

function game.set_steps(new_steps)
    if new_steps < 0 then
        new_steps = 0
    elseif new_steps > 0xFFF then
        new_steps = 0xFFF;
    end
    game.ram.set.steps(new_steps);
end

function game.add_steps(some_steps)
    game.set_steps(game.get_steps() + some_steps);
end

function game.get_check()
    return game.ram.get.check();
end

function game.set_check(new_check)
    if new_check < 0 then
        new_check = 0
    elseif new_check > 0xFFF then
        new_check = 0xFFF;
    end
    game.ram.set.check(new_check);
end

function game.add_check(some_check)
    game.set_check(game.get_check() + some_check);
end

function game.get_next_check()
    return 64 - (game.get_steps() - game.get_check());
end

---------------------------------------- Inventory ----------------------------------------

function game.get_zenny()
    return game.ram.get.zenny();
end

function game.set_zenny(new_zenny)
    if new_zenny < 0 then
        new_zenny = 0
    elseif new_zenny > 999999 then
        new_zenny = 999999;
    end
    game.ram.set.zenny(new_zenny);
end

function game.add_zenny(some_zenny)
    game.set_zenny(game.get_zenny() + some_zenny);
end

function game.get_bug_frags()
    return game.ram.get.bug_frags();
end

function game.set_bug_frags(new_bug_frags)
    if new_bug_frags < 0 then
        new_bug_frags = 0
    elseif new_bug_frags > 9999 then
        new_bug_frags = 9999;
    end
    game.ram.set.bug_frags(new_bug_frags);
end

function game.add_bug_frags(some_bug_frags)
    game.set_bug_frags(game.get_bug_frags() + some_bug_frags);
end

----------------------------------------Mega Modifications ----------------------------------------

function game.set_buster_stats(power_level)
    game.ram.set.buster_attack(power_level);
    game.ram.set.buster_rapid (power_level);
    game.ram.set.buster_charge(power_level);
end

function game.reset_buster_stats()
    game.set_buster_stats(0);
end

function game.max_buster_stats()
    game.set_buster_stats(4);
end

function game.op_buster_stats()
    game.set_buster_stats(7);
end

function game.get_HPMemory_count()
    return game.ram.get.HPMemory();
end

function game.calculate_max_HP()
    return 100 + (20 * game.get_HPMemory_count());
end

function game.calculate_mega_level()
    return 1; -- defined per game
end

---------------------------------------- Battlechips ----------------------------------------

function game.set_reg_capacity(reg_capacity)
    game.ram.set.reg_capacity(reg_capacity);
end

function game.max_reg_capacity()
    game.set_reg_capacity(99);
end

function game.get_chip_name(ID)
    return game.chips.names[ID] or "UnknwnID"; -- InvlidID ErrChpID
end

function game.get_chip_code(code)
    return game.chips.codes[code] or "?";
end

function game.get_folder_text(which_folder)
    local folder_text = "";
    for which_slot=0,29 do
        local ID   = game.ram.get.folder[which_folder].ID  (which_slot);
        local code = game.ram.get.folder[which_folder].code(which_slot);
        folder_text = string.format("%s%02u %8s %s\n", folder_text,
            which_slot+1, game.get_chip_name(ID), game.get_chip_code(code));
    end
    return folder_text;
end

function game.get_folder_text_lua(which_folder)
    local folder_text = "";
    for which_slot=0,29 do
        local ID   = game.ram.get.folder[which_folder].ID  (which_slot);
        local code = game.ram.get.folder[which_folder].code(which_slot);
        folder_text = string.format("%s{ ID=%3u; code=%2u }; -- %02u %8s %s\n", folder_text,
            ID, code, which_slot+1, game.get_chip_name(ID), game.get_chip_code(code));
    end
    return folder_text;
end

function game.overwrite_folder_to(which_folder, chips)
    for which_slot,chip in pairs(chips) do
        game.ram.set.folder[which_folder].ID  (which_slot-1, chip.ID  );
        game.ram.set.folder[which_folder].code(which_slot-1, chip.code);
    end
end

function game.set_all_folder_ID_to(which_folder, chip_ID)
    for which_slot=0,29 do
        game.ram.set.folder[which_folder].ID(which_slot, chip_ID);
    end
end

function game.randomize_folder_IDs_standard(which_folder)
    for which_slot=0,29 do
        game.ram.set.folder[which_folder].ID(which_slot, game.chips.get_random_ID_standard());
    end
end

function game.randomize_folder_IDs_mega(which_folder)
    for which_slot=0,29 do
        game.ram.set.folder[which_folder].ID(which_slot, game.chips.get_random_ID_mega());
    end
end

function game.randomize_folder_IDs_all_chips(which_folder)
    for which_slot=0,29 do
        game.ram.set.folder[which_folder].ID(which_slot, game.chips.get_random_ID_all_chips());
    end
end

function game.randomize_folder_IDs_PAs(which_folder)
    for which_slot=0,29 do
        game.ram.set.folder[which_folder].ID(which_slot, game.chips.get_random_ID_PA());
    end
end

function game.randomize_folder_IDs_anything(which_folder)
    for which_slot=0,29 do
        game.ram.set.folder[which_folder].ID(which_slot, game.chips.get_random_ID_all());
    end
end

function game.set_all_folder_code_to(which_folder, chip_code)
    for which_slot=0,29 do
        game.ram.set.folder[which_folder].code(which_slot, chip_code);
    end
end

function game.randomize_folder_codes(which_folder)
    for which_slot=0,29 do
        game.ram.set.folder[which_folder].code(which_slot, game.chips.get_random_code());
    end
end

function game.get_cursor_offset_folder()
    return game.ram.get.offset_folder();
end

function game.get_cursor_position_folder()
    return game.ram.get.cursor_folder();
end

function game.get_cursor_offset_pack()
    return game.ram.get.offset_pack();
end

function game.get_cursor_position_pack()
    return game.ram.get.cursor_pack();
end

function game.get_cursor_offset_selected()
    return game.ram.get.offset_selected();
end

function game.get_cursor_position_selected()
    return game.ram.get.cursor_selected();
end

---------------------------------------- Module Controls ----------------------------------------

return game;

