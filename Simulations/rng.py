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

def calculate_RNG_delta(seed, goal):
    delta = 0
    while seed != goal: # possible infinite loop
        delta += 1
        seed = simulate_RNG(seed)
        if delta > 108000: # 30 minutes of frames
            return None
        #if
    #while
    return delta
#def

