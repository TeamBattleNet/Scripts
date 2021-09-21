# Scratch file for calling various simulation functions for MMBN routing, enjoy.

import rng
import slot_windows

# note: working directory is at the HUD/ Simulations/ level

print("")

folder     = {}
folder[ 1] = " Wood+30 *"
folder[ 2] = " VarSwrd B"
folder[ 3] = " VarSwrd B"
folder[ 4] = "StepCros R"
folder[ 5] = " VarSwrd D"
folder[ 6] = "StepCros R"
folder[ 7] = "  Atk+10 *"
folder[ 8] = " VarSwrd B"
folder[ 9] = "StepSwrd P"
folder[10] = " CopyDmg *"
folder[11] = "RockCube *"
folder[12] = "   Invis *"
folder[13] = "   Invis *"
folder[14] = "   Invis *"
folder[15] = "   Invis *"
folder[16] = "HeroSwrd P"
folder[17] = "AirShot1 *"
folder[18] = "GutStrgt O"
folder[19] = "GutStrgt O"
folder[20] = " CopyDmg *"
folder[21] = "  Shake1 R"
folder[22] = " CopyDmg *"
folder[23] = "BambSwrd P"
folder[24] = " Slasher D"
folder[25] = "  Atk+10 *"
folder[26] = "  Atk+10 *"
folder[27] = "AirShot1 *"
folder[28] = "AirShot1 *"
folder[29] = "AirShot1 *"
folder[30] = "GutStrgt O"
#folder    = None

start_index = 100 # 178
end_index   = 500 # 199
reg_slot    = 27
fights      = 4
draw_depth  = 5

print("Folder: " + str(folder))

# Question: Which 4 slots are you most likely to top deck *at least one of* in the first N RNG values?
#  10800 is  3 minutes (of overworld movement)
# 108000 is 30 minutes
# 324000 is 90 minutes
# 648000 is 3    hours
# 972000 is 4.5  hours
# rng.get_draw_slots_bn3(1, 648000, reg_slot=1)
# for each combination of 4 slots, count how many top 5 draws had at least 1 of those slots; sort.

#rng.print_draw_slots_bn3(start_index, end_index, reg_slot, zero_pad=True)
#rng.log_draw_slots_bn3(start_index, end_index, reg_slot)
#rng.log_draw_chips_bn3(start_index, end_index, reg_slot, draw_depth, folder)
#rng.log_draw_slots_gauntlet_bn3(start_index, end_index, reg_slot, draw_depth, folder, fights, gauntlet_offset=68)

#slot_windows.find_windows_bn3(100, 1000, reg_slot)

print("\ndone!\n")

