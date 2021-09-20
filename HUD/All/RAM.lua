-- RAM Functions for MMBN scripting, enjoy.

local ram = require("All/RNG");

--ram.addr = {}; -- defined in All/RNG
--ram.get  = {}; -- defined in All/RNG
--ram.set  = {}; -- defined in All/RNG

---------------------------------------- Data ----------------------------------------

ram.encounter_thresholds     = {};                                               -- BN 3
ram.encounter_thresholds[ 0] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}; --    0
ram.encounter_thresholds[ 1] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}; --   64
ram.encounter_thresholds[ 2] = {0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}; --  128
ram.encounter_thresholds[ 3] = {0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}; --  192
ram.encounter_thresholds[ 4] = {0x03, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00}; --  256
ram.encounter_thresholds[ 5] = {0x04, 0x03, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00}; --  320
ram.encounter_thresholds[ 6] = {0x05, 0x04, 0x03, 0x02, 0x01, 0x00, 0x00, 0x00}; --  384
ram.encounter_thresholds[ 7] = {0x06, 0x05, 0x04, 0x03, 0x02, 0x00, 0x00, 0x00}; --  448
ram.encounter_thresholds[ 8] = {0x08, 0x06, 0x05, 0x04, 0x03, 0x01, 0x00, 0x00}; --  512
ram.encounter_thresholds[ 9] = {0x0A, 0x08, 0x06, 0x05, 0x04, 0x02, 0x00, 0x00}; --  576
ram.encounter_thresholds[10] = {0x0C, 0x0A, 0x08, 0x06, 0x05, 0x03, 0x00, 0x00}; --  640
ram.encounter_thresholds[11] = {0x0E, 0x0C, 0x0A, 0x08, 0x06, 0x04, 0x00, 0x00}; --  704
ram.encounter_thresholds[12] = {0x10, 0x0E, 0x0C, 0x0A, 0x08, 0x05, 0x00, 0x00}; --  768
ram.encounter_thresholds[13] = {0x12, 0x10, 0x0E, 0x0C, 0x0A, 0x06, 0x00, 0x00}; --  832
ram.encounter_thresholds[14] = {0x14, 0x12, 0x10, 0x0E, 0x0C, 0x08, 0x02, 0x00}; --  896
ram.encounter_thresholds[15] = {0x1A, 0x14, 0x12, 0x10, 0x0E, 0x0A, 0x06, 0x00}; --  960
ram.encounter_thresholds[16] = {0x1C, 0x1A, 0x14, 0x12, 0x10, 0x0C, 0x0C, 0x00}; -- 1024
-- BugRun uses Area Curve 0

function ram.get_threshold(check_number, area_curve)
    area_curve = area_curve % 8;
    check_number = min(check_number, 15);
    return encounter_thresholds[check_number][area_curve];
end

---------------------------------------- Getters & Setters ----------------------------------------

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
ram.get.battle_mode = function() return memory.read_u8(ram.addr.battle_mode); end;
ram.set.battle_mode = function(battle_mode) memory.write_u8(ram.addr.battle_mode, battle_mode); end;
ram.get.battle_state = function() return memory.read_u8(ram.addr.battle_state); end;
ram.set.battle_state = function(battle_state) memory.write_u8(ram.addr.battle_state, battle_state); end;

ram.get.bug_frags = function() return memory.read_u32_le(ram.addr.bug_frags); end;
ram.set.bug_frags = function(bug_frags) memory.write_u32_le(ram.addr.bug_frags, bug_frags); end;

ram.get.bug_run = function() return memory.read_u8(ram.addr.bug_run); end;
ram.set.bug_run = function(bug_run) memory.write_u8(ram.addr.bug_run, bug_run); end;

ram.get.buster_attack = function() return memory.read_u8(ram.addr.buster_attack); end;
ram.set.buster_attack = function(buster_attack) memory.write_u8(ram.addr.buster_attack, buster_attack); end;
ram.get.buster_rapid = function() return memory.read_u8(ram.addr.buster_rapid); end;
ram.set.buster_rapid = function(buster_rapid) memory.write_u8(ram.addr.buster_rapid, buster_rapid); end;
ram.get.buster_charge = function() return memory.read_u8(ram.addr.buster_charge); end;
ram.set.buster_charge = function(buster_charge) memory.write_u8(ram.addr.buster_charge, buster_charge); end;

ram.get.check = function() return memory.read_u16_le(ram.addr.check); end;
ram.set.check = function(check) memory.write_u16_le(ram.addr.check, check); end;

ram.get.chip_cooldown = function() return memory.read_u8(ram.addr.chip_cooldown); end;
ram.set.chip_cooldown = function(chip_cooldown) memory.write_u8(ram.addr.chip_cooldown, chip_cooldown); end;

ram.get.chip_window_size = function() return memory.read_u8(ram.addr.chip_window_size); end;
ram.set.chip_window_size = function(chip_window_size) memory.write_u8(ram.addr.chip_window_size, chip_window_size); end;

ram.get.color_palette = function(offset) return memory.read_u8(ram.addr.color_palette+offset); end;
ram.set.color_palette = function(offset, color_palette) memory.write_u8(ram.addr.color_palette+offset, color_palette); end;

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

ram.get.delete_timer = function() return memory.read_u16_le(ram.addr.delete_timer); end;
ram.set.delete_timer = function(delete_timer) memory.write_u16_le(ram.addr.delete_timer, delete_timer); end;

ram.get.base_HP = function() return memory.read_u16_le(ram.addr.base_HP); end;
ram.set.base_HP = function(base_HP) memory.write_u16_le(ram.addr.base_HP, base_HP); end;

ram.get.run_count = function() return memory.read_u32_le(ram.addr.run_count); end;
ram.set.run_count = function(run_count) memory.write_u32_le(ram.addr.run_count, run_count); end;

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

ram.get.game_mode = function() return memory.read_u8(ram.addr.game_mode); end;
ram.set.game_mode = function(game_mode) memory.write_u8(ram.addr.game_mode, game_mode); end;

ram.get.reg_slot = function() return memory.read_u8(ram.addr.reg_slot) or 255; end

ram.get.game_state = function() return memory.read_u8(ram.addr.game_state); end;
ram.set.game_state = function(game_state) memory.write_u8(ram.addr.game_state, game_state); end;

ram.get.HPMemory = function() return memory.read_u8(ram.addr.HPMemory); end;
ram.set.HPMemory = function(HPMemory) memory.write_u8(ram.addr.HPMemory, HPMemory); end;

ram.get.library = function(offset) return memory.read_u8(ram.addr.library+offset); end;
ram.set.library = function(offset, bit_flags) memory.write_u8(ram.addr.library+offset, bit_flags); end;

ram.get.magic_byte = function() return memory.read_u8(ram.addr.magic_byte); end;
ram.set.magic_byte = function(magic_byte) memory.write_u8(ram.addr.magic_byte, magic_byte); end;

ram.get.menu_mode = function() return memory.read_u8(ram.addr.menu_mode); end;
ram.set.menu_mode = function(menu_mode) memory.write_u8(ram.addr.menu_mode, menu_mode); end;
ram.get.menu_state = function() return memory.read_u8(ram.addr.menu_state); end;
ram.set.menu_state = function(menu_state) memory.write_u8(ram.addr.menu_state, menu_state); end;

ram.get.play_time = function() return memory.read_u32_le(ram.addr.play_time_frames); end;
ram.set.play_time = function(play_time_frames) memory.write_u32_le(ram.addr.play_time_frames, play_time_frames); end;

ram.get.power_on_frames = function() return memory.read_u16_le(ram.addr.power_on_frames); end;
ram.set.power_on_frames = function(power_on_frames) memory.write_u16_le(ram.addr.power_on_frames, power_on_frames); end;

ram.get.PowerUP = function() return memory.read_u8(ram.addr.PowerUP); end;
ram.set.PowerUP = function(PowerUP) memory.write_u8(ram.addr.PowerUP, PowerUP); end;

ram.get.progress = function() return memory.read_u8(ram.addr.progress); end;
ram.set.progress = function(progress) memory.write_u8(ram.addr.progress, progress); end;
ram.get.music_progress = function() return memory.read_u8(ram.addr.music_progress); end;
ram.set.music_progress = function(music_progress) memory.write_u8(ram.addr.music_progress, music_progress); end;

ram.get.reg_capacity = function() return memory.read_u8(ram.addr.reg_capacity); end;
ram.set.reg_capacity = function(reg_capacity) memory.write_u8(ram.addr.reg_capacity, reg_capacity); end;

ram.get.sneak = function() return memory.read_u16_le(ram.addr.sneak); end;
ram.set.sneak = function(sneak) memory.write_u16_le(ram.addr.sneak, sneak); end;

ram.get.steps = function() return memory.read_u16_le(ram.addr.steps); end;
ram.set.steps = function(steps) memory.write_u16_le(ram.addr.steps, steps); end;

ram.get.your_X = function() return memory.read_s16_le(ram.addr.your_X); end;
ram.set.your_X = function(your_X) memory.write_s16_le(ram.addr.your_X, your_X); end;
ram.get.your_Y = function() return memory.read_s16_le(ram.addr.your_Y); end;
ram.set.your_Y = function(your_Y) memory.write_s16_le(ram.addr.your_Y, your_Y); end;

ram.get.zenny = function() return memory.read_u32_le(ram.addr.zenny); end;
ram.set.zenny = function(zenny) memory.write_u32_le(ram.addr.zenny, zenny); end;

---------------------------------------- RAMsacking ----------------------------------------

function ram.set_bits(val, addr)
    memory.write_u8(addr, bit.bor(memory.read_u8(addr), val))
end

function ram.write_bytes(val, addr, len)
    for i=0,len do
        memory.write_u8(addr+i, val)
    end
end

function ram.bit_blast(addr, value)
    print(string.format("Changing 0x%08X from 0x%02X to 0x%02X!", addr, memory.read_u8(addr), value));
    memory.write_u8(addr, value);
end

function ram.bit_adder(addr, some_value)
    some_value = some_value or 1;
    local value = memory.read_u8(addr);
    print(string.format("Changing 0x%08X from 0x%02X to 0x%02X!", addr, value, value+some_value));
    memory.write_u8(addr, value+some_value);
end

function ram.bit_blaster(addr_range, offset)
    local addr = (math.random(0x00, 0xFFFFFF) % addr_range) + offset;
    local value = math.random(0x00, 0xFF);
    ram.bit_blast(addr, value);
end

function ram.bit_blaster_WRAM(addr_range, offset)
    addr_range = addr_range or 0x048000;
    offset = 0x02000000 + (offset or 0);
    ram.bit_blaster(addr_range, offset);
end

function ram.bit_blaster_ROM(start_at, upper_bound)
    addr_range = addr_range or 0x7BCFFF;
    offset = 0x08000000 + (offset or 0);
    ram.bit_blaster(addr_range, offset);
end

function ram.use_fun_flags_common(fun_flags)
    if fun_flags.no_encounters then
        ram.set.main_RNG_value(0xBC61AB0C);
    elseif fun_flags.maybe_encounters then
        ram.set.main_RNG_value(ram.reverse_RNG(fun_flags.encounter_threshold-1));
    elseif fun_flags.yes_encounters then
        ram.set.main_RNG_value(0x439E54F2);
    end
    
    if fun_flags.modulate_steps then
        if ram.get.steps() > 64 then
            ram.set.steps(ram.get.steps() % 64);
            ram.set.check(ram.get.check() % 64);
        end
    end
end

---------------------------------------- Module Controls ----------------------------------------

return ram;

