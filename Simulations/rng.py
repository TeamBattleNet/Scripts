# RNG Functions for MMBN scripting, enjoy.

def to_int(seed):
    return seed & 0x7FFFFFFF
#def

def simulate_RNG(seed):
    return ((to_int(seed) << 1) + (seed >> 31) + 1) ^ 0x873CA9E5
#def

def reverse_RNG(seed):
    seed = (seed ^ 0x873CA9E5) - 1
    seed = (seed >> 1) + ((seed & 1) << 31)
    return seed
#def

def iterate_RNG(seed, iterations):
    iterations = iterations or 0
    while iterations < 0:
        iterations += 1
        seed = reverse_RNG(seed)
    #while
    while iterations > 0:
        iterations -= 1
        seed = simulate_RNG(seed)
    #while
    return seed
#def

def calculate_RNG_delta(temp, goal):
    delta = 0
    while temp != goal and delta < 100000:
        delta += 1
        temp = simulate_RNG(temp)
    #while
    return delta
#def

def shuffle_folder_bn3(RNG_value=0x873CA9E4): # incorrect output
    slots = 30
    swaps = 30
    
    draw_slots = [n for n in range(slots)]
    
    #print(draw_slots)
    
    for i in range(swaps):
        RNG_value = simulate_RNG(RNG_value)
        slot_a = (RNG_value & 0x7FFFFFFF) % slots
        RNG_value = simulate_RNG(RNG_value)
        slot_b = (RNG_value & 0x7FFFFFFF) % slots
        #print(f'swapping {slot_a:02d} and {slot_b:02d}')
        draw_slots[slot_a], draw_slots[slot_b] = draw_slots[slot_b], draw_slots[slot_a]
    #for
    
    #print(draw_slots)
    
    return draw_slots
#def

def print_draw_slots_bn3(target_index, reg_slot=255):
    draw_slots = shuffle_folder_bn3(iterate_RNG(0x873CA9E4, target_index-60))
    draw_string = str(target_index) + ":"
    for draw_slot in draw_slots:
        draw_string += f' {draw_slot+1:02d}'
    #for
    print(draw_string)
#def

test_index = 120
print_draw_slots_bn3(test_index+0)
print_draw_slots_bn3(test_index+2)
print_draw_slots_bn3(test_index+4)
print_draw_slots_bn3(test_index+6)

def shuffle_folder_simulate_from_value(RNG_value, swaps, reg_slot):
    RNG_value = RNG_value or 0x873CA9E5
    swaps = swaps or 30 # 60 in BN1, 30 in the rest
    reg_slot = reg_slot or 255
    slots = 30
    
    draw_slots = [n for n in range(30)]
    
    if reg_slot != 255:
        swaps -= 1
        slots = 29
        for i in range(slots,reg_slot,-1):
            draw_slots[i] = draw_slots[i-1]
        #for
    #if
    
    for i in range(swaps):
        RNG_value = simulate_RNG(RNG_value)
        slot_a = (RNG_value & 0x7FFFFFFF) % slots
        RNG_value = simulate_RNG(RNG_value)
        slot_b = (RNG_value & 0x7FFFFFFF) % slots
        draw_slots[slot_a], draw_slots[slot_b] = draw_slots[slot_b], draw_slots[slot_a]
    #for
    
    if reg_slot != 255:
        for i in range(slots,0,-1):
            draw_slots[i+1] = draw_slots[i]
        #for
        draw_slots[0] = reg_slot
    #if
    
    return draw_slots
#def



""" Encounter Check
--[[
    Example Encounter Curves (BN 3):
    #: 00 01 02 03 04 05 06 07 - step
    ---------------------------------
    0: 00 00 00 00 00 00 00 00 -    0
    1: 00 00 00 00 00 00 00 00 -   64
    2: 01 00 00 00 00 00 00 00 -  128
    3: 02 01 00 00 00 00 00 00 -  192
    4: 03 02 01 00 00 00 00 00 -  256
    5: 04 03 02 01 00 00 00 00 -  320
    6: 05 04 03 02 01 00 00 00 -  384
    7: 06 05 04 03 02 00 00 00 -  448
    8: 08 06 05 04 03 01 00 00 -  512
    9: 0A 08 06 05 04 02 00 00 -  576
    A: 0C 0A 08 06 05 03 00 00 -  640
    B: 0E 0C 0A 08 06 04 00 00 -  704
    C: 10 0E 0C 0A 08 05 00 00 -  768
    D: 12 10 0E 0C 0A 06 00 00 -  832
    E: 14 12 10 0E 0C 08 02 00 -  896
    F: 1A 14 12 10 0E 0A 06 00 -  960
    G: 1C 1A 14 12 10 0C 0C 00 - 1024
    BugRun uses Curve 00
--]]

function ram.get_encounter_curve()
    return 0;
end

function ram.get_encounter_threshold()
    return 0x1C;
end

function ram.get_encounter_chance()
    return ram.get_encounter_threshold() / 32;
end

function ram.get_encounter_percent()
    return ram.get_encounter_chance() * 100;
end

function ram.would_get_encounter(check_RNG_value)
    return ram.get_encounter_threshold() > (check_RNG_value % 0x20); -- (1C is 87.5%)
end

-- ram.would_get_encounter(0x439E54F2); -- true
-- 0x439E54F2 01000011100111100101010011110010 input
-- 0x873CA9E4 10000111001111001010100111100100 lshift
-- 0x873CA9E5 10000111001111001010100111100101 add+1
-- 0x873CA9E5 10000111001111001010100111100101 xor
-- 0x00000000 00000000000000000000000000000000 yes encounter

-- ram.would_get_encounter(0xBC61AB0C); -- false
-- 0xBC61AB0C 10111100011000011010101100001100 input
-- 0x78C35619 01111000110000110101011000011001 lshift
-- 0x78C3561A 01111000110000110101011000011010 add+1
-- 0x873CA9E5 10000111001111001010100111100101 xor
-- 0xFFFFFFFF 11111111111111111111111111111111 no encounter

-- TODO: simulate threshold needed for each RNG value
-- TODO: steps needed to hit that threshold per curve
"""



""" BN 1 Folder Shuffling
swaps = 60
RNG_index = 1
RNG_value = 0xA338244F # 0x873CA9E4
target_RNG_index = 9999

log_file = io.open("logs/draws.txt", "w")

-- 376 4615
--  34  153 (120 + 33)
-- 410 4768

-- overworld fights perform 1 more RNG call than cutscene fights
-- this index is tuned to overworld fights, so cutscene draws will appear to be +1 (1564 maps to 1565)

function ram.simulate_draws()
    for i=1,calculations_per_frame do
        ram.shuffle_folder_simulate_from_value(RNG_value, swaps);
        local draw_slots = ram.get_draw_slots_text_one_line();
        log_file:write(string.format("%04i:%s\n", RNG_index+120, draw_slots));
        RNG_value = ram.simulate_RNG(RNG_value);
        RNG_index = RNG_index + 1;
    end
end

while RNG_index < target_RNG_index do
    ram.simulate_draws();
    emu.frameadvance();
end

log_file:close();

print("Simulations finished");

--local battle_index = 1564;
--local battle_value = ram.iterate_RNG(0xA338244F, battle_index-121);
--ram.shuffle_folder_simulate_from_value(battle_value, 60);
--print(string.format("%04i:%s\n", battle_index, ram.get_draw_slots_text_one_line()));
-- 1564: 01 09 18 12 13 30 24 21 06 26 07 03 14 25 28 29 15 19 11 16 04 08 02 20 22 17 10 27 05 23
"""
