-- RNG Value Generator for MMBN 3 Scripting, enjoy.

local rng = {};

-- RAM Addresses

local lazy_RNG = 0x02001120; -- controls encounter ID and folder shuffling
local main_RNG = 0x020013F0; -- controls everything else

-- local variables

local current_RNG_index = 0;
local maximum_RNG_index = 60 * 300; -- minimum value
local previous_main_RNG_index = 0;
local previous_main_RNG_value = 0;
local previous_lazy_RNG_index = 0;
local previous_lazy_RNG_value = 0;
local maximum_calculations_per_frame = 5 * 60; -- large values will run slowly on older PCs

-- RNG Functions

function rng.simulate_RNG(seed)
    -- seed = ((seed << 1) + (seed >> 31) + 1) ^ 0x873CA9E5;
    return bit.bxor((bit.lshift(seed,1) + bit.rshift(seed, 31) + 1), 0x873CA9E5);
end

function rng.calculate_RNG_delta(temp, goal)
    for delta=0,maximum_calculations_per_frame do
        if temp == goal then
            return delta;
        end
        temp = rng.simulate_RNG(temp);
    end
    return nil;
end

-- Create lookup table

function rng.initialize_table()
    rng.main_value = {};
    rng.main_index = {};
    rng.main_value[0] = 0;
    rng.main_index[0] = 0;
    rng.main_value[1] = 0xA338244F;
    rng.main_index[0xA338244F] = 1;
    
    rng.lazy_value = {};
    rng.lazy_index = {};
    rng.lazy_value[0] = 0;
    rng.lazy_index[0] = 0;
    rng.lazy_value[1] = 0x873CA9E4;
    rng.lazy_index[0x873CA9E4] = 1;
    
    current_RNG_index = 1;
end

function rng.expand_table(by_this_many)
    for i=1, by_this_many do
        local main_RNG_next = rng.simulate_RNG(rng.main_value[current_RNG_index]);
        local lazy_RNG_next = rng.simulate_RNG(rng.lazy_value[current_RNG_index]);
        
        current_RNG_index = current_RNG_index + 1;
        
        rng.main_value[current_RNG_index] = main_RNG_next;
        rng.main_index[main_RNG_next] = current_RNG_index;
        
        rng.lazy_value[current_RNG_index] = lazy_RNG_next;
        rng.lazy_index[lazy_RNG_next] = current_RNG_index;
    end
end

-- RAM Functions

function rng.get_main_RNG_value()
    return memory.read_u32_le(main_RNG);
end

function rng.set_main_RNG_value(new_rng)
    memory.write_u32_le(main_RNG, new_rng);
end

function rng.get_main_RNG_index()
    return rng.main_index[rng.get_main_RNG_value()]; -- will be nil for values above maximum_RNG_index
end

function rng.set_main_RNG_index(new_index)
    if 1 <= new_index and new_index <= current_RNG_index then
        rng.set_main_RNG_value(rng.main_value[new_index]);
    end
end

function rng.get_main_RNG_delta()
    return rng.calculate_RNG_delta(previous_main_RNG_value, rng.get_main_RNG_value());
end

function rng.get_main_RNG_delta_from_index()
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
    
    local new_index = main_RNG_index + steps;
    
    if new_index < 1 then -- steps could be negative
        new_index = 1;
    end
    
    if new_index > current_RNG_index then
        new_index = current_RNG_index;
    end
    
    rng.set_main_RNG_index(new_index);
end

function rng.get_lazy_RNG_value()
    return memory.read_u32_le(lazy_RNG);
end

function rng.set_lazy_RNG_value(new_rng)
    memory.write_u32_le(lazy_RNG, new_rng);
end

function rng.get_lazy_RNG_index()
    return rng.lazy_index[rng.get_lazy_RNG_value()]; -- will be nil for values above maximum_RNG_index
end

function rng.set_lazy_RNG_index(new_index)
    if 1 <= new_index and new_index <= current_RNG_index then
        rng.set_lazy_RNG_value(rng.lazy_value[new_index]);
    end
end

function rng.get_lazy_RNG_delta()
    return rng.calculate_RNG_delta(previous_lazy_RNG_value, rng.get_lazy_RNG_value());
end

function rng.get_lazy_RNG_delta_from_index()
    local lazy_RNG_index = rng.get_lazy_RNG_index();
    if lazy_RNG_index and previous_lazy_RNG_index then
        return lazy_RNG_index - previous_lazy_RNG_index;
    end
    return nil;
end

function rng.adjust_lazy_RNG(steps)
    local lazy_RNG_index = rng.get_lazy_RNG_index();
    
    if not lazy_RNG_index then
        return
    end
    
    local new_index = lazy_RNG_index + steps;
    
    if new_index < 1 then -- steps could be negative
        new_index = 1;
    end
    
    if new_index > current_RNG_index then
        new_index = current_RNG_index;
    end
    
    rng.set_lazy_RNG_index(new_index);
end

-- Module Controls

function rng.initialize(target_RNG_index)
    if target_RNG_index and target_RNG_index > maximum_RNG_index then
        maximum_RNG_index = target_RNG_index;
    end
    rng.initialize_table();
    print("Creating RNG Tables with max index of: " .. maximum_RNG_index);
end

function rng.update_pre()
    if current_RNG_index < maximum_RNG_index then
        rng.expand_table(maximum_calculations_per_frame);
        if current_RNG_index >= maximum_RNG_index then
            print("RNG Table Created.");
        end
    end
end

function rng.update_post()
    previous_main_RNG_index = rng.get_main_RNG_index();
    previous_main_RNG_value = rng.get_main_RNG_value();
    previous_lazy_RNG_index = rng.get_lazy_RNG_index();
    previous_lazy_RNG_value = rng.get_lazy_RNG_value();
end

return rng;

