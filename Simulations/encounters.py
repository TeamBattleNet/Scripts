# mRNG Window Tool for MMBN routing, enjoy.

import rng

max_wiggles  = 0
A_offset     = 0
window_start = 1
window_end   = 1
area_curve   = 0
check_number = 1
constraints  = []

def all_false():
    for constraint in constraints:
        if constraint["got_encounter"]:
            return False
    return True
#def

def check_frame(mRNG):
    for constraint in constraints:
        mRNG_test = rng.iterate_RNG(mRNG, constraint["offset"])
        if rng.would_get_encounter(constraint["threshold"], mRNG_test):
            return constraint["got_encounter"]
        #if
    #for
    
    return all_false() # no True encounters, this might be what we want
#def

def find_windows():
    index_start = window_start + A_offset
    index_end   = window_end   + A_offset
    
    print(f"Searching for windows from mRNG index {index_start:d} to {index_end:d}...")
    
    mRNG = rng.iterate_RNG(0xA338244F, index_start-1) # lRNG Seed 0x873CA9E4
    
    for press_A_on in range(window_start, window_end+1):
        print(f"{press_A_on:03d} ({press_A_on+index_start-1:03d}): {check_frame(mRNG)}")
        mRNG = rng.simulate_RNG(mRNG)
    #for
#def

encounter_thresholds = [                              # BN 3
    [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00], #    0  0
    [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00], #   64  1
    [0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00], #  128  2
    [0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00], #  192  3
    [0x03, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00], #  256  4
    [0x04, 0x03, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00], #  320  5
    [0x05, 0x04, 0x03, 0x02, 0x01, 0x00, 0x00, 0x00], #  384  6
    [0x06, 0x05, 0x04, 0x03, 0x02, 0x00, 0x00, 0x00], #  448  7
    [0x08, 0x06, 0x05, 0x04, 0x03, 0x01, 0x00, 0x00], #  512  8
    [0x0A, 0x08, 0x06, 0x05, 0x04, 0x02, 0x00, 0x00], #  576  9
    [0x0C, 0x0A, 0x08, 0x06, 0x05, 0x03, 0x00, 0x00], #  640 10
    [0x0E, 0x0C, 0x0A, 0x08, 0x06, 0x04, 0x00, 0x00], #  704 11
    [0x10, 0x0E, 0x0C, 0x0A, 0x08, 0x05, 0x00, 0x00], #  768 12
    [0x12, 0x10, 0x0E, 0x0C, 0x0A, 0x06, 0x00, 0x00], #  832 13
    [0x14, 0x12, 0x10, 0x0E, 0x0C, 0x08, 0x02, 0x00], #  896 14
    [0x1A, 0x14, 0x12, 0x10, 0x0E, 0x0A, 0x06, 0x00], #  960 15
    [0x1C, 0x1A, 0x14, 0x12, 0x10, 0x0C, 0x0C, 0x00], # 1024 16
]
#encounter_thresholds[check_number][area_curve]
# BugRun uses Area Curve 0

""" Example Encounter Curves (BN 3):
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
BugRun uses Area Curve 00

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

========================= Encounter Check Logic
//encounter check every 64 steps
//table of encounterRate table at 0800D2F4
encounterRate = readByte(0800D2F4 + (area * 16) + subarea)
if sneakrun is bugged encounterRate = 0
encounterCheckNumber = steps / 64 //(capped out at 16)
//encounterCheckValue table at 0800D26C
encounterCheckValue = readByte(0800D26C + (encounterCheckNumber * 16) + encounterRate)
//rng1 is the one at 02009800
randomNum = rng1_get_uint() & 0x1F
if randomNum is >= encounterCheckValue there is no encounter
if locenemy is on
    if rng1_get_int() & 1 == 0
        do locenemybattle
Gets list of battles filtered by your navi cust (oil body, battery ect)
if that list is empty gets unfiltered list
//rng2 is the one at 02009730
randomNum = (rng2_get_int() >> 0x10) % sumBattleProbabilities
loops through list of battle list subtracting the probability of that battle from the random number
when that number if finally < 0 that battle is selected
if sneakrun is not active ends encounter routine
if hp is greater than battles threshold no encounter

========================= Drop Table Logic
Step 1 Picks which enemy to choose rewards for
    (rng2009800 number) % (number of enemy in the battle)

Step 2 Picks reward index:
    -Get reward list for enemy (80160AA8 + (enemy_index * 0x38))
    -If you are under half HP uses the first half of the list otherwise it uses the second half (+0 or +0x1C)

    -Gets another rng2009800 random number
    -Discards first 8 bits of the random number
    -With the next 8 bits of the random number:
        finalIndexAdd = (value & 1)*2
    -With the 8 bits after that:
        tableIndexAdd = (value & 0x0F)
    -Gets a reward index based on (busting level + tableIndexAdd)
    BustingLevel0?  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    BustingLevel1   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    BustingLevel2   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    BustingLevel3   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    BustingLevel4   00 00 00 00 00 00 00 00 04 04 04 04 04 04 04 04
    BustingLevel5   04 04 04 04 04 04 04 04 08 08 08 08 08 08 08 08
    BustingLevel6   08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08
    BustingLevel7   08 08 08 08 08 08 08 08 0C 0C 0C 0C 0C 0C 0C 0C
    BustingLevel8   0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C
    BustingLevel9   0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 10
    BustingLevel10  0C 0C 0C 0C 0C 0C 0C 0C 10 10 10 10 10 10 10 10
    BustingLevelS   10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10
    BustingLevelS+  14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14
    BustingLevelS++ 18 18 18 18 18 18 18 18 18 18 18 18 18 18 18 18
    
    -Adds finalIndexAdd to the value from the table
"""

def add_constraint(offset, got_encounter):
    global check_number
    constraints.append({
        "offset"       : offset,
        "threshold"    : encounter_thresholds[min(check_number,16)][(area_curve)%8],
        "got_encounter": got_encounter,
    })
    check_number = check_number + 1
#def

#print(f"0x{rng.reverse_RNG(0x02-1):08x}")
#print(f"0x{rng.reverse_RNG(0x06-1):08x}")
#print(f"0x{rng.reverse_RNG(0x0C-1):08x}")

print("")

# Single Threshold Check
A_offset     = 0
window_start =    1
window_end   = 2000
area_curve   = 5
check_number = 16
constraints  = []
add_constraint(0, True)
#find_windows()

# ACDC Area 3
max_wiggles  = 0
A_offset     = 505
window_start = 1
window_end   = 500
area_curve   = 6
check_number = 14
constraints  = []
add_constraint(33*0, False)
add_constraint(33*1, False)
add_constraint(33*2, False)
add_constraint(33*3 + 2, False)
add_constraint(33*4 + 3, False)
#find_windows()

# Tamako's HP - Wind Box
A_offset     = 151 # 24 steps to next check, 4 wiggles
window_start =   1
window_end   = 999
area_curve   = 5
check_number = 8
constraints  = []
add_constraint(33*0,  True) #  8
add_constraint(33*1,  True) #  9
add_constraint(33*2,  True) # 10
add_constraint(33*3,  True) # 11
add_constraint(33*4, False) # 12
add_constraint(33*5,  True) # 13
add_constraint(33*6,  True) # 14
#find_windows()

# Beach 1 - Double Yorts
A_offset     = 64 # 56 steps to next check
window_start =   1
window_end   = 999
area_curve   = 6
check_number = 14
constraints  = []
add_constraint(33*0,  True)
add_constraint(33*1,  True)
add_constraint(33*2,  True)
add_constraint(33*3, False)
add_constraint(33*4,  True)
add_constraint(33*5,  True)
add_constraint(33*6,  True)
#find_windows()

# IceBall M[anip] First Try (lRNG 1267)
#  896 0x02  2  6%
#  960 0x06  6 18%
# 1024 0x0C 12 38% 766 889 1240 1267
A_offset     = 1157
window_start =   1
window_end   = 999
area_curve   = 6
check_number = 14
constraints  = []
add_constraint(33*0, False)
add_constraint(33*1, False)
add_constraint(33*2,  True) # 107 if after conveyor
#find_windows()

# IceBall M[anip] Slider Backup (lRNG 766)
#  896 0x02  2  6% 190 313  664  691
#  960 0x06  6 18% 478 601  952  979
# 1024 0x0C 12 38% 766 889 1240 1267
A_offset     = 132
window_start =   1
window_end   = 999
area_curve   = 6
check_number = 14
constraints  = []
add_constraint(  0, False)
add_constraint(289, False)
add_constraint(578,  True)
#find_windows()

