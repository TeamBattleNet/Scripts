# Draw Slot Window Finder for Mega Man Battle Network routing by Tterraj42

import rng

import itertools

do_print_parity = False

min_depth = 1
max_depth = 6

reg_slot  = 1

RNG_start = 115
RNG_end   = 500

min_window_size = 30

set_sizes = []
set_sizes.append(1)
#set_sizes.append(2)
#set_sizes.append(3)
#set_sizes.append(4)
#set_sizes.append(5)

any_slots = []
#any_slots.append("01")
#any_slots.append("02")
#any_slots.append("03")
#any_slots.append("04")
#any_slots.append("05")
#any_slots.append("06")
print("Requiring Any of Slots: ", any_slots)

all_slots = []
#all_slots.append("01")
#all_slots.append("02")
#all_slots.append("03")
#all_slots.append("04")
#all_slots.append("05")
#all_slots.append("06")
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

def find_windows(frames):
	windows  = {}
	
	for RNG_index in frames:
		slot_sets = get_slot_sets(frames[RNG_index])
		start_windows(windows, slot_sets, RNG_index)
		update_windows(windows, slot_sets, RNG_index)
		end_windows(windows, RNG_index)
	#for
	
	end_windows(windows, RNG_end+3)
	end_windows(windows, RNG_end+4)
#def

print("")
print("Processing No Reg ...")
find_windows(rng.get_draw_slots_bn3(RNG_start, RNG_end, 255, True))

print("")
print("Processing Reg Slot ...")
min_depth = max(2, min_depth) # skip reg slot
find_windows(rng.get_draw_slots_bn3(RNG_start, RNG_end, reg_slot, True))

