-- RNG Value Generator for MMBN 2 Scripting by Tterraj42, enjoy.

local rng = {};

-- RAM Addresses

local RNG_Addr = 0x02009080; -- starts on title screen

-- local variables

local cur_index = 0;
local max_index = 0;
local previous_index = 0;
local values_per_frame = 10 * 60; -- 10 seconds of frames

-- Create RNG lookup table

function rng.simulate_RNG(seed)
	-- seed = ((seed << 1) + (seed >> 31) + 1) ^ 0x873CA9E5;
	return bit.bxor((bit.lshift(seed,1) + bit.rshift(seed, 31) + 1), 0x873CA9E5);
end

function rng.initialize_table()
	rng.value = {};
	rng.index = {};
	rng.value[0] = 0;
	rng.index[0] = 0;
	rng.value[1] = 0xC14CE145;
	rng.index[0xC14CE145] = 1;
	
	cur_index = 1
end

function rng.expand_table(by_this_many)
	for i=1, by_this_many do
		local RNG_next = rng.simulate_RNG(rng.value[cur_index]);
		rng.value[cur_index+1] = RNG_next;
		rng.index[RNG_next] = cur_index+1;
		
		cur_index = cur_index + 1
	end
end

-- Functions

function rng.get_RNG_value()
	return memory.read_u32_le(RNG_Addr);
end

function rng.set_RNG_value(new_rng)
	memory.write_u32_le(RNG_Addr, new_rng);
end

function rng.get_RNG_index()
	return rng.index[memory.read_u32_le(RNG_Addr)]; -- could be nil
end

function rng.set_RNG_index(new_index)
	if 0 < new_index and new_index <= cur_index then
		memory.write_u32_le(RNG_Addr, rng.value[new_index]);
	end
end

function rng.get_RNG_delta()
	local RNG_index = rng.get_RNG_index();
	if RNG_index and previous_index then
		return RNG_index - previous_index;
	end
	return nil;
end

function rng.adjust_RNG(steps)
	local RNG_index = rng.get_RNG_index();
	
	if not RNG_index then
		return
	end
	
	local new_index = RNG_index + steps; -- steps could be negative
	
	if new_index < 1 then
		new_index = 1;
	end
	
	if new_index > cur_index then
		new_index = cur_index;
	end
	
	rng.set_RNG_index(new_index);
end

-- Controls

function rng.initialize(target_RNG_index)
	if not target_RNG_index or target_RNG_index < values_per_frame then
		target_RNG_index = values_per_frame;
	end
	max_index = target_RNG_index;
	rng.initialize_table();
end

function rng.update_pre()
	if cur_index < max_index then
		rng.expand_table(values_per_frame);
	end
end

function rng.update_post()
	previous_index = rng.get_RNG_index();
end

return rng;

