-- RAM Functions for MMBN 3 scripting, enjoy.

local ram = require("All/RAM");

ram.addr = require("BN3/Addresses");

ram.version_name = ram.addr.version_name;

------------------------------ Getters & Setters ------------------------------

ram.get.draw_slot = function(which_slot) return memory.read_u8(ram.addr.battle_draw_slots+which_slot); end;
ram.set.draw_slot = function(which_slot, folder_slot) memory.write_u8(ram.addr.battle_draw_slots+which_slot, folder_slot); end;

ram.get.fire_flags = function() return memory.read_u32_le(ram.addr.fire_flags); end;
ram.set.fire_flags = function(fire_flags) memory.write_u32_le(ram.addr.fire_flags, fire_flags); end;

ram.get.gamble_pick = function() return memory.read_u8(ram.addr.gamble_pick); end;
ram.set.gamble_pick = function(gamble_pick) memory.write_u8(ram.addr.gamble_pick, gamble_pick); end;
ram.get.gamble_win = function() return memory.read_u8(ram.addr.gamble_win); end;
ram.set.gamble_win = function(gamble_win) memory.write_u8(ram.addr.gamble_win, gamble_win); end;

ram.get.pack_ID = function(which_slot) return memory.read_u8(ram.addr.pack_ID+(0x20*which_slot)); end;
ram.set.pack_ID = function(which_slot, chip_ID) memory.write_u8(ram.addr.pack_ID+(0x20*which_slot), chip_ID); end;
ram.get.pack_code = function(which_slot) return memory.read_u8(ram.addr.pack_code+(0x20*which_slot)); end;
ram.set.pack_code = function(which_slot, chip_code) memory.write_u8(ram.addr.pack_code+(0x20*which_slot), chip_code); end;
ram.get.pack_quantity = function(which_slot) return memory.read_u8(ram.addr.pack_quantity+(0x20*which_slot)); end;
ram.set.pack_quantity = function(which_slot, chip_quantity) memory.write_u8(ram.addr.pack_quantity+(0x20*which_slot), chip_quantity); end;

ram.get.GMD_RNG = function() return memory.read_u32_le(ram.addr.GMD_RNG); end;
ram.set.GMD_RNG = function(GMD_RNG) memory.write_u32_le(ram.addr.GMD_RNG, GMD_RNG); end;
ram.get.GMD_value = function() return memory.read_u16_le(ram.addr.GMD_value); end;
ram.set.GMD_value = function(GMD_value) memory.write_u16_le(ram.addr.GMD_value, GMD_value); end;

ram.get.GMD_1_xy = function() return memory.read_u16_le(ram.addr.GMD_1_xy); end;
ram.set.GMD_1_xy = function(GMD_xy) memory.write_u16_le(ram.addr.GMD_1_xy, GMD_xy); end;
ram.get.GMD_1_yx = function() return memory.read_u16_le(ram.addr.GMD_1_yx); end;
ram.set.GMD_1_yx = function(GMD_xy) memory.write_u16_le(ram.addr.GMD_1_yx, GMD_xy); end;
ram.get.GMD_2_xy = function() return memory.read_u16_le(ram.addr.GMD_2_xy); end;
ram.set.GMD_2_xy = function(GMD_xy) memory.write_u16_le(ram.addr.GMD_2_xy, GMD_xy); end;
ram.get.GMD_2_yx = function() return memory.read_u16_le(ram.addr.GMD_2_yx); end;
ram.set.GMD_2_yx = function(GMD_xy) memory.write_u16_le(ram.addr.GMD_2_yx, GMD_xy); end;

ram.get.style_active = function () return memory.read_u16_le(ram.addr.style_active); end;
ram.set.style_active = function (style) return memory.write_u16_le(ram.addr.style_active, style); end;
ram.set.style_stored = function () return memory.read_u16_le(ram.addr.style_stored); end;
ram.set.style_stored = function (style) return memory.write_u16_le(ram.addr.style_stored, style); end;
---------------------------------------- RAMsacking ----------------------------------------

function ram.use_fun_flags(fun_flags)
    if fun_flags.always_fullcust then
        ram.set.custom_gauge(0x4000);
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
    ram.main_RNG_table = ram.create_RNG_table(0xA338244F, options.maximum_RNG_index);
    ram.lazy_RNG_table = ram.create_RNG_table(0x873CA9E4, options.maximum_RNG_index);
end

function ram.pre_update(options)
    ram.use_fun_flags(options.fun_flags);
    ram.use_fun_flags_common(options.fun_flags);
    ram.expand_RNG_table(ram.main_RNG_table);
    ram.expand_RNG_table(ram.lazy_RNG_table);
end

function ram.post_update(options)
    ram.previous_main_RNG_value = ram.get.main_RNG_value();
    ram.previous_lazy_RNG_value = ram.get.lazy_RNG_value();
end

return ram;

