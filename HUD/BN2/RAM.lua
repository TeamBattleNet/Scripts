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

ram.get.next_element = function() return memory.read_u8(ram.addr.element_next); end;
ram.set.next_element = function(next_element) memory.write_u8(ram.addr.element_next, next_element); end;

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

---------------------------------------- Styles ----------------------------------------

function ram.reset_styles()
    memory.write_u8(ram.addr.norm_styl_level, 1);
    for i=1,0x1F do
        memory.write_u8(ram.addr.norm_styl_level+i, 0);
    end
end

function ram.adjust_style_level(offset, some_level)
    local new_level = memory.read_u8(ram.addr.norm_styl_level+offset) + some_level;
    memory.write_u8(ram.addr.norm_styl_level+offset, new_level);
end

function ram.adjust_hub_style_level(some_level)
    ram.adjust_style_level(0x19, some_level);
end

function ram.set.active_style(level, style, element)
    local new_style = bit.bor(level, bit.bor(style, element)); -- 00 000 000
    memory.write_u8(ram.addr.style_active, new_style); -- level style element
end

function ram.change_active_level(new_level)
    local current_style = memory.read_u8(ram.addr.style_active);
    new_level     = bit.lshift(bit.band(new_level, 0x03), 6);
    local style   = bit.band(current_style, 0x38);
    local element = bit.band(current_style, 0x07);
    ram.set.active_style(new_level, style, element);
end

function ram.change_active_style(new_style)
    local current_style = memory.read_u8(ram.addr.style_active);
    local level   = bit.band(current_style, 0xC0);
    new_style     = bit.lshift(bit.band(new_style, 0x07), 3);
    local element = bit.band(current_style, 0x07);
    ram.set.active_style(level, new_style, element);
end

function ram.change_active_element(new_element)
    local current_style = memory.read_u8(ram.addr.style_active);
    local level   = bit.band(current_style, 0xC0);
    local style   = bit.band(current_style, 0x38);
    new_element   = bit.band(new_element  , 0x07);
    ram.set.active_style(level, style, new_element);
end

function ram.has_style()
    for i=0x06,0x19 do
        if memory.read_u8(ram.addr.norm_styl_level+i) > 0 then
            return true;
        end
    end
    return false;
end

---------------------------------------- RAMsacking ----------------------------------------

function ram.use_fun_flags(fun_flags)
    if fun_flags.always_fullcust then
        ram.set.custom_gauge(0x4000);
    end
    
    if fun_flags.no_chip_cooldown then
        --ram.set.chip_cooldown(0); -- TODO
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
    ram.lazy_RNG_table = ram.main_RNG_table; -- to support shared functions with later games
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

