# RNG Functions for MMBN scripting, enjoy.

def to_int(seed):
    return seed & 0x7FFFFFFF
#def

def simulate_RNG(seed):
    seed = (to_int(seed) << 1) + (seed >> 31)
    seed = (seed + 1) ^ 0x873CA9E5
    return seed
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

def would_get_encounter(encounter_threshold, mRNG):
    return encounter_threshold > (mRNG % 0x20)
#def

max_delta = 100000
def calculate_RNG_delta(seed, goal):
    delta = 0
    while seed != goal:
        delta += 1
        seed = simulate_RNG(seed)
        if delta > max_delta:
            return None
        #if
    #while
    return delta
#def

def shuffle_folder_bn3(RNG_value=0x873CA9E4, reg_slot=255, swaps=30): # matches L Delta of 61
    slots = 30
    
    draw_slots = [n for n in range(slots)]
    
    if reg_slot != 255:
        slots -= 1
        reg_slot -= 1 # 0 index
        draw_slots[reg_slot] = 0
        draw_slots.pop(0)
    #if
    
    for i in range(swaps):
        slot_a = to_int(RNG_value) % slots
        RNG_value = simulate_RNG(RNG_value)
        slot_b = to_int(RNG_value) % slots
        RNG_value = simulate_RNG(RNG_value)
        draw_slots[slot_a], draw_slots[slot_b] = draw_slots[slot_b], draw_slots[slot_a]
    #for
    
    if reg_slot != 255:
        draw_slots.insert(0, reg_slot)
    #if
    
    return draw_slots
#def

# note from BN 1 testing:
# overworld fights perform 1 more RNG call than cutscene fights
# this index is tuned to overworld fights, so cutscene draws will appear to be +1 (420 maps to 421)

def get_draw_slots_bn3(start_index, end_index, reg_slot=255, one_index=False):
    draw_slots = {}
    RNG_value = iterate_RNG(0x873CA9E4, start_index-61)
    for index in range(start_index, end_index+1):
        draw_slots[index] = shuffle_folder_bn3(RNG_value, reg_slot)
        if one_index:
            draw_slots[index] = [slot+1 for slot in draw_slots[index]]
        #if
        RNG_value = simulate_RNG(RNG_value)
    #for
    return draw_slots
#def

def print_draw_slots_bn3(start_index, end_index, reg_slot=255, zero_pad=False):
    draw_frames = get_draw_slots_bn3(start_index, end_index, reg_slot, True)
    for draw_frame in draw_frames:
        draw_string = f'{draw_frame:d}'
        for draw_slot in draw_frames[draw_frame]:
            if zero_pad:
                draw_string += f' {draw_slot:02d}'
            else:
                draw_string += f' {draw_slot:d}'
            #if
        #for
        print(draw_string)
    #for
#def

def log_draw_slots_bn3(start_index, end_index, reg_slot=255):
    f = open('Simulations/logs/bn3_slots.txt', 'a')
    f.write("####: 01 02 03 04 05 | 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30\n")
    f.write("---------------------+---------------------------------------------------------------------------\n")
    draw_frames = get_draw_slots_bn3(start_index, end_index, reg_slot, True)
    for draw_frame in draw_frames:
        draw_string = f'{draw_frame:04d}:'
        for draw_slot in draw_frames[draw_frame]:
            draw_string += f' {draw_slot:02d}'
        #for
        f.write(draw_string[:21] + "|" + draw_string[20:] + "\n")
    #for
    f.write("\n")
    f.close()
#def

def log_draw_chips_bn3(start_index, end_index, reg_slot=255, draw_depth=5, folder=None):
    f = open('Simulations/logs/bn3_chips.txt', 'a')
    f.write("\n")
    draw_frames = get_draw_slots_bn3(start_index, end_index, reg_slot, True)
    for draw_frame in draw_frames:
        draw_string = f'{draw_frame:04d}:'
        for slot in range(draw_depth):
            draw_string += f' {folder[draw_frames[draw_frame][slot]]:10s}'
        #for
        f.write(draw_string + "\n")
    #for
    f.write("\n")
    f.close()
#def

def log_draw_slots_gauntlet_bn3(start_index, end_index, reg_slot=255, draw_depth=5, folder=None, fights=3, gauntlet_offset=68):
    for fight in range(fights):
        start = start_index + gauntlet_offset * fight
        end   =   end_index + gauntlet_offset * fight
        if folder:
            log_draw_chips_bn3(start, end, reg_slot, draw_depth, folder)
        else:
            log_draw_slots_bn3(start, end, reg_slot)
        #if
    #for
#def

