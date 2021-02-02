-- RNG Value Generator for MMBN 1 Scripting, enjoy.

local rng = {};

local RNG_address = nil;
local current_RNG_index = 0;
local maximum_RNG_index = 60 * 60; -- minimum value
local previous_RNG_index = 0;
local previous_RNG_value = 0;
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

-- RNG Index Table

function rng.initialize_table()
    rng.value = {};
    rng.index = {};
    rng.value[0] = 0;
    rng.index[0] = 0;
    rng.value[1] = 0xA338244F;
    rng.index[0xA338244F] = 1;
    
    current_RNG_index = 1;
end

function rng.expand_table(by_this_many)
    for i=1, by_this_many do
        local RNG_next = rng.simulate_RNG(rng.value[current_RNG_index]);
        
        current_RNG_index = current_RNG_index + 1;
        
        rng.value[current_RNG_index] = RNG_next;
        rng.index[RNG_next] = current_RNG_index;
    end
end

-- RAM Functions

function rng.get_RNG_value()
    return memory.read_u32_le(RNG_address);
end

function rng.set_RNG_value(new_rng)
    memory.write_u32_le(RNG_address, new_rng);
end

function rng.get_RNG_index()
    return rng.index[rng.get_RNG_value()]; -- will be nil for values above maximum_RNG_index
end

function rng.set_RNG_index(new_index)
    if 1 <= new_index and new_index <= current_RNG_index then
        rng.set_RNG_value(rng.value[new_index]);
    end
end

function rng.get_RNG_delta()
    return rng.calculate_RNG_delta(previous_RNG_value, rng.get_RNG_value());
end

function rng.get_RNG_delta_from_index()
    local RNG_index = rng.get_RNG_index();
    if RNG_index and previous_RNG_index then
        return RNG_index - previous_RNG_index;
    end
    return nil;
end

function rng.adjust_RNG(steps)
    local RNG_index = rng.get_RNG_index();
    
    if not RNG_index then
        return
    end
    
    local new_index = RNG_index + steps;
    
    if new_index < 1 then -- steps could be negative
        new_index = 1;
    end
    
    if new_index > current_RNG_index then
        new_index = current_RNG_index;
    end
    
    rng.set_RNG_index(new_index);
end

-- Module Controls

function rng.initialize(options)
    RNG_address = options.RNG_address;
    if options.maximum_RNG_index > maximum_RNG_index then
        maximum_RNG_index = options.maximum_RNG_index;
    end
    rng.initialize_table();
    print("Creating RNG Table with max index of: " .. maximum_RNG_index);
    print("Calculating RNG with max calculations per frame of: " .. maximum_calculations_per_frame);
end

function rng.update_pre(options)
    if current_RNG_index < maximum_RNG_index then
        rng.expand_table(maximum_calculations_per_frame);
        if current_RNG_index >= maximum_RNG_index then
            print("RNG Table Created.");
        end
    end
end

function rng.update_post(options)
    previous_RNG_index = rng.get_RNG_index();
    previous_RNG_value = rng.get_RNG_value();
end

return rng;

