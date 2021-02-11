-- RAM Functions for MMBN 1 scripting, enjoy.

local ram = require("All/RAM");

ram.addr = require("BN1/Addresses");

ram.version_name = ram.addr.version_name;

------------------------------ Getters & Setters ------------------------------

ram.get.armor_heat = function() return memory.read_u8(ram.addr.armor_heat); end;
ram.set.armor_heat = function(armor_heat) memory.write_u8(ram.addr.armor_heat, armor_heat); end;
ram.get.armor_aqua = function() return memory.read_u8(ram.addr.armor_aqua); end;
ram.set.armor_aqua = function(armor_aqua) memory.write_u8(ram.addr.armor_aqua, armor_aqua); end;
ram.get.armor_wood = function() return memory.read_u8(ram.addr.armor_wood); end;
ram.set.armor_wood = function(armor_wood) memory.write_u8(ram.addr.armor_wood, armor_wood); end;

ram.get.battle_paused = function() return memory.read_u8(ram.addr.battle_paused); end;
ram.set.battle_paused = function(battle_paused) memory.write_u8(ram.addr.battle_paused, battle_paused); end;
ram.get.battle_paused_also = function() return memory.read_u8(ram.addr.battle_paused_also); end;
ram.set.battle_paused_also = function(battle_paused_also) memory.write_u8(ram.addr.battle_paused_also, battle_paused_also); end;

ram.get.chip_selected_flag = function() return memory.read_u8(ram.addr.chip_selected_flag); end;
ram.set.chip_selected_flag = function(chip_selected_flag) memory.write_u8(ram.addr.chip_selected_flag, chip_selected_flag); end;

ram.get.check = function() return memory.read_u32_le(ram.addr.check); end;
ram.set.check = function(check) memory.write_u32_le(ram.addr.check, check); end;

ram.get.cursor_ID = function() return memory.read_u8(ram.addr.cursor_ID); end;
ram.set.cursor_ID = function(cursor_ID) memory.write_u8(ram.addr.cursor_ID, cursor_ID); end;
ram.get.cursor_code = function() return memory.read_u8(ram.addr.cursor_code); end;
ram.set.cursor_code = function(cursor_code) memory.write_u8(ram.addr.cursor_code, cursor_code); end;

ram.get.door_code = function() return memory.read_u8(ram.addr.number_door_code); end;
ram.set.door_code = function(number_door_code) memory.write_u8(ram.addr.number_door_code, number_door_code); end;

ram.get.draw_slot = function(which_slot) return memory.read_u8(ram.addr.battle_draw_slots+which_slot); end;
ram.set.draw_slot = function(which_slot, folder_slot) memory.write_u8(ram.addr.battle_draw_slots+which_slot, folder_slot); end;

ram.get.folder_ID = function(which_slot) return memory.read_u8(ram.addr.folder_ID+(2*which_slot)); end;
ram.set.folder_ID = function(which_slot, chip_ID) memory.write_u8(ram.addr.folder_ID+(2*which_slot), chip_ID); end;
ram.get.folder_code = function(which_slot) return memory.read_u8(ram.addr.folder_code+(2*which_slot)); end;
ram.set.folder_code = function(which_slot, chip_code) memory.write_u8(ram.addr.folder_code+(2*which_slot), chip_code); end;
ram.get.folder[1].ID = function(which_slot) return memory.read_u8(ram.addr.folder_ID+(2*which_slot)); end;
ram.set.folder[1].ID = function(which_slot, chip_ID) memory.write_u8(ram.addr.folder_ID+(2*which_slot), chip_ID); end;
ram.get.folder[1].code = function(which_slot) return memory.read_u8(ram.addr.folder_code+(2*which_slot)); end;
ram.set.folder[1].code = function(which_slot, chip_code) memory.write_u8(ram.addr.folder_code+(2*which_slot), chip_code); end;

ram.get.folder_count = function() return memory.read_u8(ram.addr.folder_count); end;
ram.set.folder_count = function(folder_count) memory.write_u8(ram.addr.folder_count, folder_count); end;
ram.get.folder_to_pack = function() return memory.read_u8(ram.addr.folder_to_pack); end;
ram.set.folder_to_pack = function(folder_to_pack) memory.write_u8(ram.addr.folder_to_pack, folder_to_pack); end;

ram.get.fire_flags = function() return memory.read_u32_le(ram.addr.fire_flags); end;
ram.set.fire_flags = function(fire_flags) memory.write_u32_le(ram.addr.fire_flags, fire_flags); end;
ram.get.fire_flags_oven = function() return memory.read_u32_le(ram.addr.fire_flags_oven); end;
ram.set.fire_flags_oven = function(fire_flags_oven) memory.write_u32_le(ram.addr.fire_flags_oven, fire_flags_oven); end;
ram.get.fire_flags_www = function() return memory.read_u32_le(ram.addr.fire_flags_www); end;
ram.set.fire_flags_www = function(fire_flags_www) memory.write_u32_le(ram.addr.fire_flags_www, fire_flags_www); end;

ram.get.HPMemory = function() return memory.read_u8(ram.addr.HPMemory); end;
ram.set.HPMemory = function(HPMemory) memory.write_u8(ram.addr.HPMemory, HPMemory); end;

ram.get.IceBlock = function() return memory.read_u8(ram.addr.key_IceBlock_count); end;
ram.set.IceBlock = function(key_IceBlock_count) memory.write_u8(ram.addr.key_IceBlock_count, key_IceBlock_count); end;

ram.get.loading_state = function() return memory.read_u8(ram.addr.loading_state); end;
ram.set.loading_state = function(loading_state) memory.write_u8(ram.addr.loading_state, loading_state); end;

ram.get.magic_byte = function() return memory.read_u8(ram.addr.magic_byte); end;
ram.set.magic_byte = function(magic_byte) memory.write_u8(ram.addr.magic_byte, magic_byte); end;

ram.get.pack_ID = function(which_slot) return memory.read_u8(ram.addr.pack_ID+(0x20*which_slot)); end;
ram.set.pack_ID = function(which_slot, chip_ID) memory.write_u8(ram.addr.pack_ID+(0x20*which_slot), chip_ID); end;
ram.get.pack_code = function(which_slot) return memory.read_u8(ram.addr.pack_code+(0x20*which_slot)); end;
ram.set.pack_code = function(which_slot, chip_code) memory.write_u8(ram.addr.pack_code+(0x20*which_slot), chip_code); end;
ram.get.pack_quantity = function(which_slot) return memory.read_u8(ram.addr.pack_quantity+(0x20*which_slot)); end;
ram.set.pack_quantity = function(which_slot, chip_quantity) memory.write_u8(ram.addr.pack_quantity+(0x20*which_slot), chip_quantity); end;

ram.get.shop_cursor_offset = function() return memory.read_u8(ram.addr.shop_cursor_offset); end;
ram.set.shop_cursor_offset = function(shop_cursor_offset) memory.write_u8(ram.addr.shop_cursor_offset, shop_cursor_offset); end;

ram.get.title_star_byte = function() return memory.read_u8(ram.addr.title_star_byte); end;
ram.set.title_star_byte = function(title_star_byte) memory.write_u8(ram.addr.title_star_byte, title_star_byte); end;

---------------------------------------- RAMsacking ----------------------------------------

function ram.bit_blaster_WRAM_2AC()
    ram.bit_blaster_WRAM(0x02AC);
end

function ram.bit_blaster_WRAM_FFFF()
    ram.bit_blaster_WRAM(0xFFFF);
end

function ram.bit_blaster_library()
    ram.bit_blaster_WRAM(0x20, 0x20);
end

function ram.bit_blaster_folder()
    ram.bit_blaster_WRAM(0x3B, 0x1C0);
end

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
        ram.set.chip_window_size(15);
    elseif fun_flags.chip_selection_one then
        ram.set.chip_window_size( 1);
    end
end

---------------------------------------- Module Controls ----------------------------------------

function ram.initialize(options)
    ram.print_details();
    ram.main_RNG_table = ram.create_RNG_table(0xA338244F, options.maximum_RNG_index);
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

