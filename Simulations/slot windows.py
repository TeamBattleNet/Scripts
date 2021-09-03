# Draw Slot Window Finder for routing RNG manipulation in Mega Man Battle Network, enjoy.

import rng

import itertools

min_depth = 1
max_depth = 6
reg_slot  = 1
RNG_start = 100
RNG_end   = 500
min_window_size = 30
do_print_parity = False

print("")
print("Running with settings:")
print(f"reg_slot={reg_slot:d}")
print(f"min_depth={min_depth:d}")
print(f"max_depth={max_depth:d}")
print(f"min_window_size={min_window_size:d}")
print("")

# TODO constraints
# limited copies of chip
# index offset to current frame
# gauntlets...

set_sizes = []
set_sizes.append(1)
#set_sizes.append(2)
#set_sizes.append(3)
#set_sizes.append(4)
#set_sizes.append(5)

any_slots = []
#any_slots.append(1)
#any_slots.append(2)
#any_slots.append(3)
#any_slots.append(4)
#any_slots.append(5)
#any_slots.append(6)
print("Requiring Any of Slots: ", any_slots)

all_slots = []
#all_slots.append(1)
#all_slots.append(2)
#all_slots.append(3)
#all_slots.append(4)
#all_slots.append(5)
#all_slots.append(6)
print("Requiring All of Slots: ", all_slots)

def has_any_slot(slot_set):
	for slot in any_slots:
		if slot in slot_set:
			return True
		#if
	#for
	return False
#def

def has_all_slots(slot_set):
	for slot in all_slots:
		if slot not in slot_set:
			return False
		#if
	#for
	return True
#def

if reg_slot and reg_slot != 255:
	min_depth = max(2, min_depth) # skip reg slot
#if

def get_slot_sets(frame):
	slot_sets = []
	# https://docs.python.org/3/library/itertools.html#itertools.combinations
	for set_size in set_sizes:
		for slot_set in itertools.combinations(sorted(frame[min_depth-1:max_depth]), set_size):
			if not any_slots or has_any_slot(slot_set):
				if not all_slots or has_all_slots(slot_set):
					slot_sets.append(slot_set)
				#if
			#if
		#for
	#for
	return slot_sets
#def

def start_windows(windows, slot_sets, RNG_index):
	parity = RNG_index % 2
	for slot_set in slot_sets:
		if slot_set not in windows:
			windows[slot_set] = {}
			windows[slot_set][0] = {} # even
			windows[slot_set][0]["first"] = None
			windows[slot_set][0]["last" ] = None
			windows[slot_set][1] = {} # odd
			windows[slot_set][1]["first"] = None
			windows[slot_set][1]["last" ] = None
		#if
		
		if  windows[slot_set][parity]["first"] == None:
			windows[slot_set][parity]["first"]  = RNG_index
			windows[slot_set][parity]["last" ]  = RNG_index
		#if
	#for
#def

def update_windows(windows, slot_sets, RNG_index):
	parity = RNG_index % 2
	for slot_set in slot_sets:
		if  windows[slot_set][parity]["first"] != None:
			windows[slot_set][parity]["last" ]  = RNG_index
		#if
	#for
#def

def end_windows(windows, RNG_index):
	parity = RNG_index % 2
	for slot_set in windows:
		if windows[slot_set][parity]["first"] != None:
			if RNG_index - windows[slot_set][parity]["last"] >= 2:
				
				# parity window
				window_start = windows[slot_set][parity]["first"]
				window_end   = windows[slot_set][parity]["last" ]
				window_size  = window_end - window_start + 1
				if do_print_parity and window_size >= min_window_size:
					print("Par ", slot_set, " from ", window_start, " to ", window_end, " size ", window_size)
				#if
				
				# all window
				if windows[slot_set][0]["first"] != None and windows[slot_set][1]["first"] != None:
					window_start = max(windows[slot_set][0]["first"], windows[slot_set][1]["first"]) - 1
					window_end   = min(windows[slot_set][0]["last" ], windows[slot_set][1]["last" ]) + 1
					window_size  = window_end - window_start + 1
					if window_size >= min_window_size:
						print("All ", slot_set, " from ", window_start, " to ", window_end, " size ", window_size)
					#if
				#if
				
				windows[slot_set][parity]["first"] = None
				windows[slot_set][parity]["last" ] = None
			#if
		#if
	#for
#def

def find_windows(index_start, index_end, reg=255):
	print(f"Searching for windows from {index_start:d} to {index_end:d}...")
	
	frames = rng.get_draw_slots_bn3(index_start, index_end, reg, True)
	
	windows  = {}
	
	for RNG_index in frames:
		slot_sets = get_slot_sets(frames[RNG_index])
		start_windows(windows, slot_sets, RNG_index)
		update_windows(windows, slot_sets, RNG_index)
		end_windows(windows, RNG_index)
	#for
	
	# end any active windows on both parity
	end_windows(windows, index_end+3)
	end_windows(windows, index_end+4)
#def

print("")

#find_windows(RNG_start, RNG_end, reg_slot)

#rng.print_draw_slots_log_bn3(-10, 120, 1)
#rng.print_draw_slots_gauntlet_bn3(313-68, 339-68, 5, 1)

print("")

