-- RAM Functions for BCC scripting, enjoy.

local ram = require("All/RAM"); -- BCC/RNG ?

ram.addr = require("BCC/Addresses");

ram.version_name = ram.addr.version_name;

------------------------------ Getters & Setters ------------------------------

function ram.get.main_RNG_value()
    return memory.read_u16_le(ram.addr.main_RNG);
end

function ram.set.main_RNG_value(new_main_RNG_value)
    memory.write_u16_le(ram.addr.main_RNG, new_main_RNG_value);
end

---------------------------------------- RAMsacking ----------------------------------------

function ram.use_fun_flags(fun_flags)
    -- TODO
end

---------------------------------------- Module Controls ----------------------------------------

function ram.initialize(options)
    ram.print_details();
    ram.main_RNG_table = ram.create_RNG_table(0x0B44, options.maximum_RNG_index); -- TODO: Verify Seed
end

function ram.pre_update(options)
    ram.use_fun_flags(options.fun_flags);
    --ram.use_fun_flags_common(options.fun_flags);
    ram.expand_RNG_table(ram.main_RNG_table);
end

function ram.post_update(options)
    ram.previous_main_RNG_value = ram.get.main_RNG_value();
end

return ram;

