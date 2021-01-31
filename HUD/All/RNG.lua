-- RNG Value Generator for MMBN Scripting, enjoy.

local rng = {};

-- Settings

local max_RNG_index = 5000; -- minimum value
local calculations_per_frame = 150; -- careful tweaking this

-- local variables

local address = nil;
local temp_RNG_index = 0;
local previous_RNG_index = 0;
local previous_RNG_value = 0;

-- RNG Functions

function rng.simulate_RNG(seed)
    -- seed = ((seed << 1) + (seed >> 31) + 1) ^ 0x873CA9E5;
    return bit.bxor((bit.lshift(seed,1) + bit.rshift(seed, 31) + 1), 0x873CA9E5);
end

function rng.calculate_RNG_delta(temp, goal)
    for delta=0,calculations_per_frame do
        if temp == goal then
            return delta;
        end
        temp = rng.simulate_RNG(temp);
    end
    return nil;
end

-- Validate arguments and create lookup table

local function initialize_table(RNG_address, RNG_seed, target_index)
    if     not RNG_address  or type(RNG_address)  ~= "number" then
        return false;
    elseif not RNG_seed     or type(RNG_seed)     ~= "number" then
        return false;
    elseif not target_index or type(target_index) ~= "number" then
        target_index = max_RNG_index;
    end
    
    address = RNG_address;
    
    rng.value = {};
    rng.index = {};
    rng.value[0] = 0;
    rng.index[0] = 0;
    rng.value[1] = RNG_seed;
    rng.index[RNG_seed] = 1;
    
    temp_RNG_index = 1;
    
    if  max_RNG_index < target_index then
        max_RNG_index = target_index;
    end
    
    return true; -- initialization successful
end

function rng.expand_table(by_this_many)
    for i=1, by_this_many do
        local RNG_next = rng.simulate_RNG(rng.value[temp_RNG_index]);
        
        temp_RNG_index = temp_RNG_index + 1;
        
        rng.value[temp_RNG_index] = RNG_next;
        rng.index[RNG_next] = temp_RNG_index;
    end
end

-- RAM Functions

function rng.get_RNG_value()
    return memory.read_u32_le(address);
end

function rng.set_RNG_value(new_rng)
    memory.write_u32_le(address, new_rng);
end

function rng.get_RNG_index()
    return rng.index[rng.get_RNG_value()]; -- will be nil for values above max_RNG_index
end

function rng.set_RNG_index(new_index)
    if 1 <= new_index and new_index <= max_RNG_index then
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
    
    if new_index > max_RNG_index then
        new_index = max_RNG_index;
    end
    
    rng.set_RNG_index(new_index);
end

-- Module Controls

function rng.initialize(address, seed, target_RNG_index)
    if initialize_table(address, seed, target_RNG_index) then
        print("Creating RNG Table with max index of: " .. max_RNG_index);
        print("Creating RNG Table with calculations per frame of: " .. calculations_per_frame);
    else
        print(string.format("Bad arguments to RNG: %s, %s, %s", address or "nil", seed or "nil", target_RNG_index or "nil"));
    end
end

function rng.update_pre()
    if temp_RNG_index < max_RNG_index then
        rng.expand_table(calculations_per_frame);
        if temp_RNG_index >= max_RNG_index then
            print("RNG Table Created.");
        end
    end
end

function rng.update_post()
    previous_RNG_index = rng.get_RNG_index();
    previous_RNG_value = rng.get_RNG_value();
end

return rng;

