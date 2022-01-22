# Scratch file for calling various simulation functions for MMBN routing, enjoy.

import slots
import slot_windows

import os
if  os.path.exists("Simulations/ignore/bn3_slots.txt"):
    os.remove(     "Simulations/ignore/bn3_slots.txt")
if  os.path.exists("Simulations/ignore/bn3_chips.txt"):
    os.remove(     "Simulations/ignore/bn3_chips.txt")
# working directory is at the HUD/ Simulations/ level

print("")

start_index = 100
end_index   = 2000

fights      = 5
draw_depth  = 5

reg_slot   = 27
folder     = {}
folder[ 1] = " Wood+30 *"
folder[ 2] = " VarSwrd B"
folder[ 3] = " VarSwrd B"
folder[ 4] = "StepCros R"
folder[ 5] = " VarSwrd D"
folder[ 6] = "StepCros R"
folder[ 7] = "RockCube *"
folder[ 8] = " VarSwrd B"
folder[ 9] = "StepSwrd P"
folder[10] = "Jealousy J"
folder[11] = " CopyDmg *"
folder[12] = "   Invis *"
folder[13] = "   Invis *"
folder[14] = "   Invis *"
folder[15] = "   Invis *"
folder[16] = "HeroSwrd P"
folder[17] = "AirShot1 *"
folder[18] = "GutStrgt O"
folder[19] = "GutStrgt O"
folder[20] = "BambSwrd P"
folder[21] = "  Shake1 R"
folder[22] = " CopyDmg *"
folder[23] = "  Atk+10 *"
folder[24] = "  Atk+10 *"
folder[25] = "  Atk+10 *"
folder[26] = "  Atk+10 *"
folder[27] = "AirShot1 *"
folder[28] = "AirShot1 *"
folder[29] = "AirShot1 *"
folder[30] = "GutStrgt O"

print("Folder: " + str(folder))

# RNG loop  781,480,823  frames,
# which is  13,024,680   seconds,
# which is  217,078      minutes
# which is  3,618        hours,
# which is ~1,000        runs.

# Question: Which 1 slot is, on average, closest to the top?
#  10800 is  3 minutes (of overworld movement)
# 108000 is 30 minutes
# 324000 is 90 minutes
# 648000 is 3    hours
# 972000 is 4.5  hours
# slots.get_draw_slots_bn2(     1, 324000, reg_slot=1)
# slots.get_draw_slots_bn2(324000, 648000, reg_slot=1)

# Question: Which 4 slots are you most likely to top deck *at least one of* in a given RNG range?
#  10800 is  3 minutes (of overworld movement)
# 108000 is 30 minutes
# 324000 is 90 minutes
# 648000 is 3    hours
# 972000 is 4.5  hours
# slots.get_draw_slots_bn3(     1, 648000, reg_slot=1) # full  game
# slots.get_draw_slots_bn3(     1, 324000, reg_slot=1) # early game
# slots.get_draw_slots_bn3(324000, 648000, reg_slot=1) # late  game
# for each combination of 4 slots, count how many top 5 draws had at least 1 of those slots; sort.

#slots.log_draw_slots_bn3(start_index, end_index, reg_slot, draw_depth)
#slots.log_draw_chips_bn3(start_index, end_index, reg_slot, draw_depth, folder)
#slots.log_draw_slots_gauntlet_bn3(start_index, end_index, reg_slot, draw_depth,   None, fights, gauntlet_offset=68)
#slots.log_draw_slots_gauntlet_bn3(start_index, end_index, reg_slot, draw_depth, folder, fights, gauntlet_offset=68)

#slot_windows.find_windows_bn3(100, 1000, reg_slot)

print("\ndone!\n")

