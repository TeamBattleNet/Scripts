-- RAM functions for MMBN 1 scripting, enjoy.

local ram  = {};

ram.addr = require("BN6/Addresses");

ram.version_name = ram.addr.version_name;

------------------------------ Getters & Setters ------------------------------

local slots = {};

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

ram.get.battle_paused = function() return memory.read_u8(ram.addr.battle_paused); end;
ram.set.battle_paused = function(battle_paused) memory.write_u8(ram.addr.battle_paused, battle_paused); end;
ram.get.battle_paused_also = function() return memory.read_u8(ram.addr.battle_paused_also); end;
ram.set.battle_paused_also = function(battle_paused_also) memory.write_u8(ram.addr.battle_paused_also, battle_paused_also); end;
ram.get.battle_pointer = function() return memory.read_u16_le(ram.addr.battle_pointer); end;
ram.set.battle_pointer = function(battle_pointer) memory.write_u16_le(ram.addr.battle_pointer, battle_pointer); end;
ram.get.battle_state = function() return memory.read_u8(ram.addr.battle_state); end;
ram.set.battle_state = function(battle_state) memory.write_u8(ram.addr.battle_state, battle_state); end;

ram.get.buster_attack = function() return memory.read_u8(ram.addr.buster_attack); end;
ram.set.buster_attack = function(buster_attack) memory.write_u8(ram.addr.buster_attack, buster_attack); end;
ram.get.buster_rapid = function() return memory.read_u8(ram.addr.buster_rapid); end;
ram.set.buster_rapid = function(buster_rapid) memory.write_u8(ram.addr.buster_rapid, buster_rapid); end;
ram.get.buster_charge = function() return memory.read_u8(ram.addr.buster_charge); end;
ram.set.buster_charge = function(buster_charge) memory.write_u8(ram.addr.buster_charge, buster_charge); end;

ram.get.chip_cooldown = function() return memory.read_u8(ram.addr.chip_cooldown); end;
ram.set.chip_cooldown = function(chip_cooldown) memory.write_u8(ram.addr.chip_cooldown, chip_cooldown); end;

ram.get.chip_window_count = function() return memory.read_u8(ram.addr.chip_window_count); end;
ram.set.chip_window_count = function(chip_window_count) memory.write_u8(ram.addr.chip_window_count, chip_window_count); end;

ram.get.check = function() return memory.read_u32_le(ram.addr.check); end;
ram.set.check = function(check) memory.write_u32_le(ram.addr.check, check); end;

ram.get.cursor_ID = function() return memory.read_u8(ram.addr.cursor_ID); end;
ram.set.cursor_ID = function(cursor_ID) memory.write_u8(ram.addr.cursor_ID, cursor_ID); end;
ram.get.cursor_code = function() return memory.read_u8(ram.addr.cursor_code); end;
ram.set.cursor_code = function(cursor_code) memory.write_u8(ram.addr.cursor_code, cursor_code); end;

ram.get.cursor_folder = function() return memory.read_u16_le(ram.addr.cursor_folder); end;
ram.set.cursor_folder = function(cursor_folder) memory.write_u16_le(ram.addr.cursor_folder, cursor_folder); end;
ram.get.cursor_pack = function() return memory.read_u16_le(ram.addr.cursor_pack); end;
ram.set.cursor_pack = function(cursor_pack) memory.write_u16_le(ram.addr.cursor_pack, cursor_pack); end;
ram.get.cursor_selected = function() return memory.read_u16_le(ram.addr.cursor_selected); end;
ram.set.cursor_selected = function(cursor_selected) memory.write_u16_le(ram.addr.cursor_selected, cursor_selected); end;

ram.get.offset_folder = function() return memory.read_u16_le(ram.addr.offset_folder); end;
ram.set.offset_folder = function(offset_folder) memory.write_u16_le(ram.addr.offset_folder, offset_folder); end;
ram.get.offset_pack = function() return memory.read_u16_le(ram.addr.offset_pack); end;
ram.set.offset_pack = function(offset_pack) memory.write_u16_le(ram.addr.offset_pack, offset_pack); end;
ram.get.offset_selected = function() return memory.read_u16_le(ram.addr.offset_selected); end;
ram.set.offset_selected = function(offset_selected) memory.write_u16_le(ram.addr.offset_selected, offset_selected); end;

ram.get.custom_gauge = function() return memory.read_u16_le(ram.addr.battle_custom_gauge); end;
ram.set.custom_gauge = function(battle_custom_gauge) memory.write_u16_le(ram.addr.battle_custom_gauge, battle_custom_gauge); end;

ram.get.delete_timer = function() return memory.read_u16_le(ram.addr.battle_timer); end;
ram.set.delete_timer = function(battle_timer) memory.write_u16_le(ram.addr.battle_timer, battle_timer); end;

ram.get.draw_slot = function(which_slot) return slots[which_slot]; end;

ram.get.enemy_ID = function(which_enemy) return memory.read_u16_le(ram.addr.enemy_ID+(which_enemy * 2)); end;
ram.set.enemy_ID = function(which_enemy, enemy_ID) memory.write_u16_le(ram.addr.enemy_ID+which_enemy, enemy_ID); end;
ram.get.enemy_HP = function(which_enemy) return memory.read_u16_le(ram.addr.enemy_HP+(0xD8*which_enemy)); end;
ram.set.enemy_HP = function(which_enemy, enemy_HP) memory.write_u16_le(ram.addr.enemy_HP+(0xD8*which_enemy), enemy_HP); end;

ram.get.folder_ID = function(which_slot) return memory.read_u8(ram.addr.folder_ID+(2*which_slot)); end;
ram.set.folder_ID = function(which_slot, chip_ID) memory.write_u8(ram.addr.folder_ID+(2*which_slot), chip_ID); end;
ram.get.folder_code = function(which_slot) return memory.read_u8(ram.addr.folder_code+(2*which_slot)); end;
ram.set.folder_code = function(which_slot, chip_code) memory.write_u8(ram.addr.folder_code+(2*which_slot), chip_code); end;
ram.get.folder_count = function() return memory.read_u8(ram.addr.folder_count); end;
ram.set.folder_count = function(folder_count) memory.write_u8(ram.addr.folder_count, folder_count); end;
ram.get.folder_menu_state = function() return memory.read_u8(ram.addr.folder_menu_state); end;
ram.set.folder_menu_state = function(folder_menu_state) memory.write_u8(ram.addr.folder_menu_state, folder_menu_state); end;
ram.get.folder_to_pack = function() return memory.read_u8(ram.addr.folder_to_pack); end;
ram.set.folder_to_pack = function(folder_to_pack) memory.write_u8(ram.addr.folder_to_pack, folder_to_pack); end;

ram.get.reg_slot = function() return memory.readbyte(ram.addr.reg_slot); end;

ram.get.game_state = function() return memory.read_u8(ram.addr.game_state); end;
ram.set.game_state = function(game_state) memory.write_u8(ram.addr.game_state, game_state); end;

ram.get.HPMemory = function() return memory.read_u8(ram.addr.HPMemory); end;
ram.set.HPMemory = function(HPMemory) memory.write_u8(ram.addr.HPMemory, HPMemory); end;

ram.get.library = function(offset) return memory.read_u8(ram.addr.library+offset); end;
ram.set.library = function(offset, bit_flags) memory.write_u8(ram.addr.library+offset, bit_flags); end;

ram.get.magic_byte = function() return memory.read_u8(ram.addr.magic_byte); end;
ram.set.magic_byte = function(magic_byte) memory.write_u8(ram.addr.magic_byte, magic_byte); end;

ram.get.play_time = function() return memory.read_u32_le(ram.addr.play_time_frames); end;
ram.set.play_time = function(play_time_frames) memory.write_u32_le(ram.addr.play_time_frames, play_time_frames); end;

ram.get.progress = function() return memory.read_u8(ram.addr.progress); end;
ram.set.progress = function(progress) memory.write_u8(ram.addr.progress, progress); end;

ram.get.steps = function() return memory.read_u16_le(ram.addr.steps); end;
ram.set.steps = function(steps) memory.write_u16_le(ram.addr.steps, steps); end;

ram.get.title_star_byte = function() return memory.read_u8(ram.addr.title_star_byte); end;
ram.set.title_star_byte = function(title_star_byte) memory.write_u8(ram.addr.title_star_byte, title_star_byte); end;

ram.get.your_X = function() return memory.read_s16_le(ram.addr.your_X); end;
ram.set.your_X = function(your_X) memory.write_s16_le(ram.addr.your_X, your_X); end;
ram.get.your_Y = function() return memory.read_s16_le(ram.addr.your_Y); end;
ram.set.your_Y = function(your_Y) memory.write_s16_le(ram.addr.your_Y, your_Y); end;

ram.get.zenny = function() return memory.read_u32_le(ram.addr.zenny); end;
ram.set.zenny = function(zenny) memory.write_u32_le(ram.addr.zenny, zenny); end;

ram.get.bugfrags = function() return memory.read_u32_le(ram.addr.bugfrags); end;
ram.set.bugfrags = function(bugfrags) memory.write_u32_le(ram.addr.bugfrags, bugfrags); end;

---------------------------------------- RNG Functions ----------------------------------------

local main_rng_table = nil;
local lazy_rng_table = nil;
local previous_main_RNG_value = 0;
local previous_lazy_RNG_value = 0;
local calculations_per_frame = 200; -- careful tweaking this

function ram.simulate_RNG(seed) -- 0x8000000C 0x72 (run twice?)
    -- seed = ((seed << 1) + (seed >> 31) + 1) ^ 0x873CA9E5;
    return bit.bxor((bit.lshift(seed,1) + bit.rshift(seed, 31) + 1), 0x873CA9E5);
end

function ram.iterate_RNG(seed, iterations)
    iterations = iterations or 1;
    for i=1,math.min(iterations,calculations_per_frame) do
        seed = ram.simulate_RNG(seed);
    end
    return seed;
end

function ram.calculate_RNG_delta(temp, goal)
    for delta=0,calculations_per_frame do
        if temp == goal then
            return delta;
        end
        temp = ram.simulate_RNG(temp);
    end
    return nil;
end

local function create_RNG_table(seed, max_index)
    print(string.format("Creating RNG Table with seed 0x%08X and max index %u", seed, max_index));
    
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

local function expand_RNG_table(RNG_table)
    if RNG_table.current_RNG_index < RNG_table.maximum_RNG_index then
        for i=1, calculations_per_frame do
            local RNG_next = ram.simulate_RNG(RNG_table.value[RNG_table.current_RNG_index]);
            
            RNG_table.current_RNG_index = RNG_table.current_RNG_index + 1;
            
            RNG_table.value[RNG_table.current_RNG_index] = RNG_next;
            RNG_table.index[RNG_next] = RNG_table.current_RNG_index;
        end
        if RNG_table.current_RNG_index >= RNG_table.maximum_RNG_index then
            print("");
            print(string.format("%u: RNG Table Created for seed: 0x%08X", emu.framecount(), RNG_table.value[1]));
            print("");
        end
    end
end

function ram.get.lazy_RNG_value()
    return memory.read_u32_le(ram.addr.lazy_RNG);
end

function ram.get.lazy_RNG_value_at(new_RNG_index)
    return lazy_rng_table.value[new_lazy_RNG_index];
end

function ram.set.lazy_RNG_value(new_RNG_value)
    memory.write_u32_le(ram.addr.lazy_RNG, new_RNG_value);
end

function ram.get.lazy_RNG_index_of(new_RNG_value)
    return lazy_rng_table.index[new_RNG_value];
end

function ram.get.lazy_RNG_index()
    return ram.get.lazy_RNG_index_of(ram.get.lazy_RNG_value());
end

function ram.set.lazy_RNG_index(new_RNG_index)
    new_RNG_value = ram.get.lazy_RNG_value_at(new_RNG_index);
    if new_RNG_value then
        ram.set.lazy_RNG_value(new_RNG_value);
    end
end

function ram.get.lazy_RNG_delta()
    return ram.calculate_RNG_delta(previous_lazy_RNG_value, ram.get.lazy_RNG_value());
end

function ram.adjust_lazy_RNG(steps)
    local lazy_RNG_index = ram.get.lazy_RNG_index();
    
    if not lazy_RNG_index then
        return;
    end
    
    local new_index = lazy_RNG_index + steps;
    
    if new_index < 1 then -- steps could be negative
        new_index = 1;
    end
    
    if new_index > rng_table.current_lazy_RNG_index then
        new_index = rng_table.current_lazy_RNG_index;
    end
    
    ram.set.RNG_index(new_index);
end

function ram.get.main_RNG_value()
    return memory.read_u32_le(ram.addr.main_RNG);
end

function ram.get.main_RNG_value_at(new_RNG_index)
    return main_rng_table.value[new_RNG_index];
end

function ram.set.main_RNG_value(new_RNG_value)
    memory.write_u32_le(ram.addr.main_RNG, new_RNG_value);
end

function ram.get.main_RNG_index_of(new_RNG_value)
    return main_rng_table.index[new_RNG_value];
end

function ram.get.main_RNG_index()
    return ram.get.main_RNG_index_of(ram.get.main_RNG_value());
end

function ram.set.main_RNG_index(new_RNG_index)
    new_RNG_value = ram.get.main_RNG_value_at(new_RNG_index);
    if new_RNG_value then
        ram.set.main_RNG_value(new_RNG_value);
    end
end

function ram.get.main_RNG_delta()
    return ram.calculate_RNG_delta(previous_main_RNG_value, ram.get.main_RNG_value());
end

function ram.adjust_main_RNG(steps)
    local main_RNG_index = ram.get.main_RNG_index();
    
    if not main_RNG_index then
        return;
    end
    
    local new_index = main_RNG_index + steps;
    
    if new_index < 1 then -- steps could be negative
        new_index = 1;
    end
    
    if new_index > main_rng_table.current_RNG_index then
        new_index = main_rng_table.current_RNG_index;
    end
    
    ram.set.main_RNG_index(new_index);
end

---------------------------------------- Draw Simulation ----------------------------------------

function ram.to_int(seed)
	return bit.band(seed, 0x7FFFFFFF)
end

function ram.simulate_shuffle_folder(seed)
    for i=0,29 do
		slots[i] = i;
	end
	
	regSlot = ram.get.reg_slot();
	
	if regSlot == 255 then
		for i=1,30 do
			seed = ram.simulate_RNG(seed);
			slot1 = ram.to_int(seed) % 30;
			seed = ram.simulate_RNG(seed);
			slot2 = ram.to_int(seed) % 30;

			slots[slot1], slots[slot2] = slots[slot2], slots[slot1];
		end
	else
		for i=1,29 do
			seed = ram.simulate_RNG(seed);
			slot1 = ram.to_int(seed) % 29;
			if slot1 >= regSlot then
				slot1 = slot1 + 1
			end
			
			seed = ram.simulate_RNG(seed);
			slot2 = ram.to_int(seed) % 29;
			if slot2 >= regSlot then
				slot2 = slot2 + 1
			end

			slots[slot1], slots[slot2] = slots[slot2], slots[slot1];
		end
		
		-- In BN6, place reg chip at top and move other chips down.
		-- In other games, swap the reg slot with the top chip.
		for i=regSlot,0,-1 do
			slots[i] = slots[i - 1];
		end
		
		slots[0] = regSlot;
	end
end

---------------------------------------- RAMsacking ----------------------------------------

local function fun_flags(options)
    if options.no_encounters then
        ram.set.RNG_value(0x8000000C);
    elseif options.yes_encounters then
        ram.set.RNG_value(0x72      );
    end
    
    if options.no_chip_cooldown then
        ram.set.chip_cooldown(0);
    end
end

---------------------------------------- Module Controls ----------------------------------------

function ram.initialize(options)
    print("");
    lazy_rng_table = create_RNG_table(0x873CA9E4, options.maximum_RNG_index);
	main_rng_table = create_RNG_table(0xA338244F, options.maximum_RNG_index);
    print("Calculating RNG with max calculations per frame of: " .. calculations_per_frame);
    print("");
end

function ram.update_pre(options)
    fun_flags(options);
    expand_RNG_table(lazy_rng_table);
	expand_RNG_table(main_rng_table);
end

function ram.update_post(options)
    previous_lazy_RNG_value = ram.get.lazy_RNG_value();
	previous_main_RNG_value = ram.get.main_RNG_value();
end

return ram;

