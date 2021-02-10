-- RAM Functions for MMBN 2 scripting, enjoy.

local ram = require("All/RAM");

ram.addr = require("BN2/Addresses");

ram.version_name = ram.addr.version_name;

------------------------------ Getters & Setters ------------------------------

ram.get.battle_paused = function() return memory.read_u8(ram.addr.battle_paused); end;
ram.set.battle_paused = function(battle_paused) memory.write_u8(ram.addr.battle_paused, battle_paused); end;

ram.get.bug_frags = function() return memory.read_u8(ram.addr.bug_frags); end;
ram.set.bug_frags = function(bug_frags) memory.write_u8(ram.addr.bug_frags, bug_frags); end;

ram.get.draw_slot = function(which_slot) return memory.read_u8(ram.addr.battle_draw_slots+which_slot); end;
ram.set.draw_slot = function(which_slot, folder_slot) memory.write_u8(ram.addr.battle_draw_slots+which_slot, folder_slot); end;

ram.get.folder_count = function() return memory.read_u8(ram.addr.folder_count); end;
ram.set.folder_count = function(folder_count) memory.write_u8(ram.addr.folder_count, folder_count); end;

ram.get.ice_flags = function() return memory.read_u32_le(ram.addr.ice_flags); end;
ram.set.ice_flags = function(ice_flags) memory.write_u32_le(ram.addr.ice_flags, ice_flags); end;

ram.get.HPMemory = function() return memory.read_u8(ram.addr.HPMemory); end;
ram.set.HPMemory = function(HPMemory) memory.write_u8(ram.addr.HPMemory, HPMemory); end;

ram.get.pack_ID = function(which_slot) return memory.read_u8(ram.addr.pack_ID+(0x20*which_slot)); end;
ram.set.pack_ID = function(which_slot, chip_ID) memory.write_u8(ram.addr.pack_ID+(0x20*which_slot), chip_ID); end;
ram.get.pack_code = function(which_slot) return memory.read_u8(ram.addr.pack_code+(0x20*which_slot)); end;
ram.set.pack_code = function(which_slot, chip_code) memory.write_u8(ram.addr.pack_code+(0x20*which_slot), chip_code); end;
ram.get.pack_quantity = function(which_slot) return memory.read_u8(ram.addr.pack_quantity+(0x20*which_slot)); end;
ram.set.pack_quantity = function(which_slot, chip_quantity) memory.write_u8(ram.addr.pack_quantity+(0x20*which_slot), chip_quantity); end;

ram.get.title_star_byte = function() return memory.read_u8(ram.addr.title_star_byte); end;
ram.set.title_star_byte = function(title_star_byte) memory.write_u8(ram.addr.title_star_byte, title_star_byte); end;

---------------------------------------- RAMsacking ----------------------------------------

function ram.use_fun_flags(fun_flags)
    if fun_flags.always_fullcust then
        ram.set.custom_gauge(0x4000);
    end
    
    if fun_flags.no_chip_cooldown then
        ram.set.chip_cooldown(0);
    end
    
    if fun_flags.delete_time_zero then
        ram.set.delete_timer(0);
    end
    
    if fun_flags.chip_selection_max then
        ram.set.chip_window_size(10);
    elseif fun_flags.chip_selection_one then
        ram.set.chip_window_size( 1);
    end
end

---------------------------------------- Module Controls ----------------------------------------

function ram.initialize(options)
    ram.print_details();
    ram.main_RNG_table = ram.create_RNG_table(0xC14CE145, options.maximum_RNG_index);
end

function ram.pre_update(options)
    ram.use_fun_flags(options.fun_flags);
    ram.use_fun_flags_common(options.fun_flags);
    ram.expand_RNG_table(ram.main_RNG_table);
end

function ram.post_update(options)
    ram.previous_main_RNG_value = ram.get.main_RNG_value();
end

return ram;

