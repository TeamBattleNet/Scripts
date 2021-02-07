-- Common RAM Functions for MMBN scripting, enjoy.

local ram  = {};

ram.addr = {}; -- overridden later

ram.calculations_per_frame = 200; -- careful tweaking this

---------------------------------------- Getters & Setters ----------------------------------------

ram.get = {};
ram.set = {};

ram.get.bytes_1 = function(addr) return memory.read_u8 (addr       )    ; end;
ram.set.bytes_1 = function(addr, value) memory.write_u8(addr, value)    ; end;
ram.get.bytes_2 = function(addr) return memory.read_u16_le (addr       ); end;
ram.set.bytes_2 = function(addr, value) memory.write_u16_le(addr, value); end;
ram.get.bytes_4 = function(addr) return memory.read_u32_le (addr       ); end;
ram.set.bytes_4 = function(addr, value) memory.write_u32_le(addr, value); end;

ram.get.main_area = function() return memory.read_u8(ram.addr.main_area); end;
ram.set.main_area = function(main_area) memory.write_u8(ram.addr.main_area, main_area); end;
ram.get.sub_area = function() return memory.read_u8(ram.addr.sub_area); end;
ram.set.sub_area = function(sub_area) memory.write_u8(ram.addr.sub_area, sub_area); end;

ram.get.battle_pointer = function() return memory.read_u16_le(ram.addr.battle_pointer); end;
ram.set.battle_pointer = function(battle_pointer) memory.write_u16_le(ram.addr.battle_pointer, battle_pointer); end;

ram.get.battle_state = function() return memory.read_u8(ram.addr.battle_state); end;
ram.set.battle_state = function(battle_state) memory.write_u8(ram.addr.battle_state, battle_state); end;

ram.get.bug_frags = function() return memory.read_u32_le(ram.addr.bug_frags); end;
ram.set.bug_frags = function(bug_frags) memory.write_u32_le(ram.addr.bug_frags, bug_frags); end;

ram.get.buster_attack = function() return memory.read_u8(ram.addr.buster_attack); end;
ram.set.buster_attack = function(buster_attack) memory.write_u8(ram.addr.buster_attack, buster_attack); end;
ram.get.buster_rapid = function() return memory.read_u8(ram.addr.buster_rapid); end;
ram.set.buster_rapid = function(buster_rapid) memory.write_u8(ram.addr.buster_rapid, buster_rapid); end;
ram.get.buster_charge = function() return memory.read_u8(ram.addr.buster_charge); end;
ram.set.buster_charge = function(buster_charge) memory.write_u8(ram.addr.buster_charge, buster_charge); end;

ram.get.check = function() return memory.read_u32_le(ram.addr.check); end;
ram.set.check = function(check) memory.write_u32_le(ram.addr.check, check); end;

ram.get.chip_cooldown = function() return memory.read_u8(ram.addr.chip_cooldown); end;
ram.set.chip_cooldown = function(chip_cooldown) memory.write_u8(ram.addr.chip_cooldown, chip_cooldown); end;

ram.get.cursor_ID = function() return memory.read_u16_le(ram.addr.cursor_ID); end;
ram.set.cursor_ID = function(cursor_ID) memory.write_u16_le(ram.addr.cursor_ID, cursor_ID); end;
ram.get.cursor_code = function() return memory.read_u16_le(ram.addr.cursor_code); end;
ram.set.cursor_code = function(cursor_code) memory.write_u16_le(ram.addr.cursor_code, cursor_code); end;

ram.get.cursor_folder = function() return memory.read_u16_le(ram.addr.cursor_folder); end;
ram.set.cursor_folder = function(cursor_folder) memory.write_u16_le(ram.addr.cursor_folder, cursor_folder); end;
ram.get.offset_folder = function() return memory.read_u16_le(ram.addr.offset_folder); end;
ram.set.offset_folder = function(offset_folder) memory.write_u16_le(ram.addr.offset_folder, offset_folder); end;

ram.get.cursor_pack = function() return memory.read_u16_le(ram.addr.cursor_pack); end;
ram.set.cursor_pack = function(cursor_pack) memory.write_u16_le(ram.addr.cursor_pack, cursor_pack); end;
ram.get.offset_pack = function() return memory.read_u16_le(ram.addr.offset_pack); end;
ram.set.offset_pack = function(offset_pack) memory.write_u16_le(ram.addr.offset_pack, offset_pack); end;

ram.get.cursor_selected = function() return memory.read_u16_le(ram.addr.cursor_selected); end;
ram.set.cursor_selected = function(cursor_selected) memory.write_u16_le(ram.addr.cursor_selected, cursor_selected); end;
ram.get.offset_selected = function() return memory.read_u16_le(ram.addr.offset_selected); end;
ram.set.offset_selected = function(offset_selected) memory.write_u16_le(ram.addr.offset_selected, offset_selected); end;

ram.get.custom_gauge = function() return memory.read_u16_le(ram.addr.battle_custom_gauge); end;
ram.set.custom_gauge = function(custom_gauge_fill) memory.write_u16_le(ram.addr.battle_custom_gauge, custom_gauge_fill); end;

ram.get.delete_timer = function() return memory.read_u16_le(ram.addr.battle_timer); end;
ram.set.delete_timer = function(battle_timer) memory.write_u16_le(ram.addr.battle_timer, battle_timer); end;

ram.get.enemy = {}
ram.set.enemy = {}

ram.get.enemy[1] = {}
ram.set.enemy[1] = {}
ram.get.enemy[1].ID = function() return memory.read_u8(ram.addr.enemy[1].ID); end;
ram.set.enemy[1].ID = function(enemy_ID) memory.write_u8(ram.addr.enemy[1].ID, enemy_ID); end;
ram.get.enemy[1].HP = function() return memory.read_u16_le(ram.addr.enemy[1].HP); end;
ram.set.enemy[1].HP = function(enemy_HP) memory.write_u16_le(ram.addr.enemy[1].HP, enemy_HP); end;

ram.get.enemy[2] = {}
ram.set.enemy[2] = {}
ram.get.enemy[2].ID = function() return memory.read_u8(ram.addr.enemy[2].ID); end;
ram.set.enemy[2].ID = function(enemy_ID) memory.write_u8(ram.addr.enemy[2].ID, enemy_ID); end;
ram.get.enemy[2].HP = function() return memory.read_u16_le(ram.addr.enemy[2].HP); end;
ram.set.enemy[2].HP = function(enemy_HP) memory.write_u16_le(ram.addr.enemy[2].HP, enemy_HP); end;

ram.get.enemy[3] = {}
ram.set.enemy[3] = {}
ram.get.enemy[3].ID = function() return memory.read_u8(ram.addr.enemy[3].ID); end;
ram.set.enemy[3].ID = function(enemy_ID) memory.write_u8(ram.addr.enemy[3].ID, enemy_ID); end;
ram.get.enemy[3].HP = function() return memory.read_u16_le(ram.addr.enemy[3].HP); end;
ram.set.enemy[3].HP = function(enemy_HP) memory.write_u16_le(ram.addr.enemy[3].HP, enemy_HP); end;

ram.get.folder = {};
ram.set.folder = {};

ram.get.folder[1] = {};
ram.set.folder[1] = {};
ram.get.folder[1].ID = function(which_slot) return memory.read_u16_le(ram.addr.folder[1].ID+(4*which_slot)); end;
ram.set.folder[1].ID = function(which_slot, chip_ID) memory.write_u16_le(ram.addr.folder[1].ID+(4*which_slot), chip_ID); end;
ram.get.folder[1].code = function(which_slot) return memory.read_u16_le(ram.addr.folder[1].code+(4*which_slot)); end;
ram.set.folder[1].code = function(which_slot, chip_code) memory.write_u16_le(ram.addr.folder[1].code+(4*which_slot), chip_code); end;

ram.get.folder[2] = {};
ram.set.folder[2] = {};
ram.get.folder[2].ID = function(which_slot) return memory.read_u16_le(ram.addr.folder[2].ID+(4*which_slot)); end;
ram.set.folder[2].ID = function(which_slot, chip_ID) memory.write_u16_le(ram.addr.folder[2].ID+(4*which_slot), chip_ID); end;
ram.get.folder[2].code = function(which_slot) return memory.read_u16_le(ram.addr.folder[2].code+(4*which_slot)); end;
ram.set.folder[2].code = function(which_slot, chip_code) memory.write_u16_le(ram.addr.folder[2].code+(4*which_slot), chip_code); end;

ram.get.folder[3] = {};
ram.set.folder[3] = {};
ram.get.folder[3].ID = function(which_slot) return memory.read_u16_le(ram.addr.folder[3].ID+(4*which_slot)); end;
ram.set.folder[3].ID = function(which_slot, chip_ID) memory.write_u16_le(ram.addr.folder[3].ID+(4*which_slot), chip_ID); end;
ram.get.folder[3].code = function(which_slot) return memory.read_u16_le(ram.addr.folder[3].code+(4*which_slot)); end;
ram.set.folder[3].code = function(which_slot, chip_code) memory.write_u16_le(ram.addr.folder[3].code+(4*which_slot), chip_code); end;

ram.get.game_state = function() return memory.read_u8(ram.addr.game_state); end;
ram.set.game_state = function(game_state) memory.write_u8(ram.addr.game_state, game_state); end;

ram.get.menu_mode = function() return memory.read_u8(ram.addr.menu_mode); end;
ram.set.menu_mode = function(menu_mode) memory.write_u8(ram.addr.menu_mode, menu_mode); end;

ram.get.menu_state = function() return memory.read_u8(ram.addr.menu_state); end;
ram.set.menu_state = function(menu_state) memory.write_u8(ram.addr.menu_state, menu_state); end;

ram.get.play_time = function() return memory.read_u32_le(ram.addr.play_time_frames); end;
ram.set.play_time = function(play_time_frames) memory.write_u32_le(ram.addr.play_time_frames, play_time_frames); end;

ram.get.progress = function() return memory.read_u8(ram.addr.progress); end;
ram.set.progress = function(progress) memory.write_u8(ram.addr.progress, progress); end;

ram.get.sneak = function() return memory.read_u32_le(ram.addr.sneak); end;
ram.set.sneak = function(sneak) memory.write_u32_le(ram.addr.sneak, sneak); end;

ram.get.steps = function() return memory.read_u32_le(ram.addr.steps); end;
ram.set.steps = function(steps) memory.write_u32_le(ram.addr.steps, steps); end;

ram.get.your_X = function() return memory.read_s16_le(ram.addr.your_X); end;
ram.set.your_X = function(your_X) memory.write_s16_le(ram.addr.your_X, your_X); end;
ram.get.your_Y = function() return memory.read_s16_le(ram.addr.your_Y); end;
ram.set.your_Y = function(your_Y) memory.write_s16_le(ram.addr.your_Y, your_Y); end;

ram.get.zenny = function() return memory.read_u32_le(ram.addr.zenny); end;
ram.set.zenny = function(zenny) memory.write_u32_le(ram.addr.zenny, zenny); end;

---------------------------------------- RNG Functions ----------------------------------------

function ram.to_int(seed)
    return bit.band(seed, 0x7FFFFFFF);
end

function ram.simulate_RNG(seed)
    -- seed = ((seed << 1) + (seed >> 31) + 1) ^ 0x873CA9E5;
    return bit.bxor((bit.lshift(seed,1) + bit.rshift(seed, 31) + 1), 0x873CA9E5);
end

function ram.iterate_RNG(seed, iterations)
    iterations = iterations or 1;
    for i=1,math.min(iterations,ram.calculations_per_frame) do
        seed = ram.simulate_RNG(seed);
    end
    return seed;
end

function ram.calculate_RNG_delta(temp, goal)
    for delta=0,ram.calculations_per_frame do
        if temp == goal then
            return delta;
        end
        temp = ram.simulate_RNG(temp);
    end
    return nil;
end

function ram.create_RNG_table(seed, max_index)
    print(string.format("\nCreating RNG Table with seed 0x%08X and max index of %u", seed, max_index));
    
    new_RNG_table = {};
    
    new_RNG_table.value = {};
    new_RNG_table.index = {};
    
    new_RNG_table.value[0] = 0;
    new_RNG_table.index[0] = 0;
    
    new_RNG_table.value[1] = seed;
    new_RNG_table.index[seed] = 1;
    
    new_RNG_table.current_RNG_index = 1;
    new_RNG_table.maximum_RNG_index = max_index;
    
    return new_RNG_table;
end

function ram.expand_RNG_table(RNG_table)
    if RNG_table.current_RNG_index < RNG_table.maximum_RNG_index then
        for i=1,math.min((RNG_table.maximum_RNG_index-RNG_table.current_RNG_index),ram.calculations_per_frame) do
            local RNG_next = ram.simulate_RNG(RNG_table.value[RNG_table.current_RNG_index]);
            
            RNG_table.current_RNG_index = RNG_table.current_RNG_index + 1;
            
            RNG_table.value[RNG_table.current_RNG_index] = RNG_next;
            RNG_table.index[RNG_next] = RNG_table.current_RNG_index;
        end
        if RNG_table.current_RNG_index >= RNG_table.maximum_RNG_index then
            print(string.format("\n%u: Created RNG Table for seed 0x%08X with final index of %i", emu.framecount(), RNG_table.value[1], RNG_table.current_RNG_index));
        end
    end
end

---------------------------------------- Folder Shuffling ----------------------------------------

ram.draw_slots = {};

function ram.shuffle_folder_simulate_from_value(RNG_value)
    RNG_value = RNG_value or 0x873CA9E5;
    for i=1,30 do
        ram.draw_slots[i] = i;
    end
    for i=1,60 do
        local slot_a = (ram.to_int(bit.rshift(RNG_value,1)) % 30) + 1;
        RNG_value = ram.get.RNG_value_at(RNG_value);
        local slot_b = (ram.to_int(bit.rshift(RNG_value,1)) % 30) + 1;
        RNG_value = ram.get.RNG_value_at(RNG_value);
        ram.draw_slots[slot_a], ram.draw_slots[slot_b] = ram.draw_slots[slot_b], ram.draw_slots[slot_a];
    end
    return ram.draw_slots;
end

function ram.shuffle_folder_simulate_from_index(RNG_index)
    return ram.shuffle_folder_simulate(ram.get.RNG_value_at(RNG_index));
end

---------------------------------------- Module Controls ----------------------------------------

return ram;

