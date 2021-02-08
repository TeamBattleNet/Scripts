-- Tests for RAM addresses for MMBN scripting.

local test_addresses = {}; -- mostly to prevent passing nil to memory.write()

local function assert_address_is_valid(address, description)
    if  address ~= nil
        and type(address) == "number"
        and address >= 0x00000000
        -- defaults to 0x02000000
        and address <= 0xFFFFFFFF
        then return true;
    end
    print(description .. " is " .. tostring(address));
    return false;
end

function test_addresses.enemies(addr)
    assert_address_is_valid(addr.enemy[1].ID, "addr.enemy[1].ID");
    assert_address_is_valid(addr.enemy[1].HP, "addr.enemy[1].HP");
    assert_address_is_valid(addr.enemy[2].ID, "addr.enemy[2].ID");
    assert_address_is_valid(addr.enemy[2].HP, "addr.enemy[2].HP");
    assert_address_is_valid(addr.enemy[3].ID, "addr.enemy[3].ID");
    assert_address_is_valid(addr.enemy[3].HP, "addr.enemy[3].HP");
end

function test_addresses.folders(addr)
    assert_address_is_valid(addr.folder[1].ID, "addr.folder[1].ID");
    assert_address_is_valid(addr.folder[1].code, "addr.folder[1].code");
    assert_address_is_valid(addr.folder[2].ID, "addr.folder[2].ID");
    assert_address_is_valid(addr.folder[2].code, "addr.folder[2].code");
    assert_address_is_valid(addr.folder[3].ID, "addr.folder[3].ID");
    assert_address_is_valid(addr.folder[3].code, "addr.folder[3].code");
end

function test_addresses.version(addr)
    assert_address_is_valid(addr.version_byte, "addr.version_byte");
    assert_address_is_valid(addr.encounter_odds, "addr.encounter_odds");
    assert_address_is_valid(addr.encounter_curve, "addr.encounter_curve");
    if  addr.version_name ~= nil and type(addr.version_name) == "string" then
        return true;
    end
    print("addr.version_name is " .. addr.version_name);
    return false;
end

function test_addresses.test_this(addr)
    print("\nTesting Addresses.lua...");
    test_addresses.enemies(addr);
    test_addresses.folders(addr);
    test_addresses.version(addr);
end

return test_addresses;

