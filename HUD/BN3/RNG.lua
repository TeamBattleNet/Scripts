-- RNG Value Generator for MMBN 3 Scripting, enjoy.

local rng = {};

-- RAM Addresses

local  sub_RNG = 0x02009730; -- controls encounter ID and chip draws
local main_RNG = 0x02009800; -- controls everything else

-- 0x02009800 is rng1 and 0x02009730 is rng2 - GreigaMaster
-- I labeled them this way because 0x02009800 comes first in the code.

-- local variables

local cur_RNG_index = 0;
local max_RNG_index = 0;
local previous_main_RNG_index = 0;
local previous_sub_RNG_index = 0;
local values_per_frame = 10 * 60; -- 10 seconds of frames

-- Create RNG lookup table

function rng.simulate_RNG(seed) -- this magic voodoo from Prof9
    -- seed = ((seed << 1) + (seed >> 31) + 1) ^ 0x873CA9E5;
    return bit.bxor((bit.lshift(seed,1) + bit.rshift(seed, 31) + 1), 0x873CA9E5);
end

function rng.initialize_table()
    rng.main_value = {};
    rng.main_index = {};
    rng.main_value[0] = 0;
    rng.main_index[0] = 0;
    rng.main_value[1] = 0xA338244F;
    rng.main_index[0xA338244F] = 1;
    
    rng.sub_value = {};
    rng.sub_index = {};
    rng.sub_value[0] = 0;
    rng.sub_index[0] = 0;
    rng.sub_value[1] = 0x873CA9E4;
    rng.sub_index[0x873CA9E4] = 1;
    
    cur_RNG_index = 1
end

function rng.expand_table(by_this_many)
    for i=1, by_this_many do
        local main_RNG_next = rng.simulate_RNG(rng.main_value[cur_RNG_index]);
        rng.main_value[cur_RNG_index+1] = main_RNG_next;
        rng.main_index[main_RNG_next] = cur_RNG_index+1;
        
        local sub_RNG_next = rng.simulate_RNG(rng.sub_value[cur_RNG_index]);
        rng.sub_value[cur_RNG_index+1] = sub_RNG_next;
        rng.sub_index[sub_RNG_next] = cur_RNG_index+1;
        
        cur_RNG_index = cur_RNG_index + 1
    end
end

-- Functions

function rng.get_main_RNG_value()
    return memory.read_u32_le(main_RNG);
end

function rng.set_main_RNG_value(new_rng)
    memory.write_u32_le(main_RNG, new_rng);
end

function rng.get_main_RNG_index()
    return rng.main_index[memory.read_u32_le(main_RNG)]; -- could be nil
end

function rng.set_main_RNG_index(new_index)
    if 0 < new_index and new_index <= cur_RNG_index then
        memory.write_u32_le(main_RNG, rng.main_value[new_index]);
    end
end

function rng.get_main_RNG_delta()
    local main_RNG_index = rng.get_main_RNG_index();
    if main_RNG_index and previous_main_RNG_index then
        return main_RNG_index - previous_main_RNG_index;
    end
    return nil;
end

function rng.adjust_main_RNG(steps)
    local main_RNG_index = rng.get_main_RNG_index();
    
    if not main_RNG_index then
        return
    end
    
    local new_index = main_RNG_index + steps; -- steps could be negative
    
    if new_index < 1 then
        new_index = 1;
    end
    
    if new_index > cur_RNG_index then
        new_index = cur_RNG_index;
    end
    
    rng.set_main_RNG_index(new_index);
end

function rng.get_sub_RNG_value()
    return memory.read_u32_le(sub_RNG);
end

function rng.set_sub_RNG_value(new_rng)
    memory.write_u32_le(sub_RNG, new_rng);
end

function rng.get_sub_RNG_index()
    return rng.sub_index[memory.read_u32_le(sub_RNG)]; -- could be nil
end

function rng.set_sub_RNG_index(new_index)
    if 0 < new_index and new_index <= cur_RNG_index then
        memory.write_u32_le(sub_RNG, rng.sub_value[new_index]);
    end
end

function rng.get_sub_RNG_delta()
    local sub_RNG_index = rng.get_sub_RNG_index();
    if sub_RNG_index and previous_sub_RNG_index then
        return sub_RNG_index - previous_sub_RNG_index;
    end
    return nil;
end

function rng.adjust_sub_RNG(steps)
    local sub_RNG_index = rng.get_sub_RNG_index();
    
    if not sub_RNG_index then
        return
    end
    
    local new_index = sub_RNG_index + steps; -- steps could be negative
    
    if new_index < 1 then
        new_index = 1;
    end
    
    if new_index > cur_RNG_index then
        new_index = cur_RNG_index;
    end
    
    rng.set_sub_RNG_index(new_index);
end

-- Controls

function rng.initialize(target_RNG_index)
    if not target_RNG_index or target_RNG_index < values_per_frame then
        target_RNG_index = values_per_frame;
    end
    max_RNG_index = target_RNG_index;
    rng.initialize_table();
end

function rng.update_pre()
    if cur_RNG_index < max_RNG_index then
        rng.expand_table(values_per_frame);
    end
end

function rng.update_post()
    previous_main_RNG_index = rng.get_main_RNG_index();
    previous_sub_RNG_index = rng.get_sub_RNG_index();
end

return rng;

