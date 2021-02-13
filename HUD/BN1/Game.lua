-- Functions for MMBN 1 scripting, enjoy.

local game = require("All/Game");

game.number = 1;

game.ram      = require("BN1/RAM"     );
game.areas    = require("BN1/Areas"   );
game.chips    = require("BN1/Chips"   );
game.enemies  = require("BN1/Enemies" );
game.progress = require("BN1/Progress");

game.fun_flags = {}; -- set in Commands, used in RAM

---------------------------------------- Game State ----------------------------------------

-- Game Mode

game.game_state_names[0x00] = "Title";         -- or BIOS
game.game_state_names[0x04] = "World";         -- real and digital
game.game_state_names[0x08] = "Battle";
game.game_state_names[0x0C] = "Player Change"; -- jack-in / out
game.game_state_names[0x10] = "Demo End";      -- what is this?
game.game_state_names[0x14] = "Capcom Logo";
game.game_state_names[0x18] = "Menu";
game.game_state_names[0x1C] = "Shop";
game.game_state_names[0x20] = "GAME OVER";
game.game_state_names[0x24] = "Chip Trader";
game.game_state_names[0x28] = "Credits";
game.game_state_names[0x2C] = "Ubisoft Logo";  -- PAL only
game.game_state_names[0x30] = "Unused?";
game.game_state_names[0x34] = "Unused?";

function game.in_title()
    return game.ram.get.game_state() == 0x00;
end

function game.in_world()
    return game.ram.get.game_state() == 0x04;
end

function game.in_battle()
    return game.ram.get.game_state() == 0x08;
end

function game.in_transition()
    return game.ram.get.game_state() == 0x0C;
end

function game.in_splash()
    return (game.ram.get.game_state() == 0x14 or game.ram.get.game_state() == 0x2C);
end

function game.in_menu()
    return game.ram.get.game_state() == 0x18;
end

function game.in_shop()
    return game.ram.get.game_state() == 0x1C;
end

function game.in_game_over()
    return game.ram.get.game_state() == 0x20;
end

function game.in_chip_trader()
    return game.ram.get.game_state() == 0x24;
end

function game.in_request_board()
    return false; -- Only BN 1 doesn't have a Request Board
end

function game.in_credits()
    return game.ram.get.game_state() == 0x28;
end

-- Battle Mode

game.battle_mode_names[0x00] = "Loading";
game.battle_mode_names[0x04] = "Chip Select";
game.battle_mode_names[0x08] = "Combat";
game.battle_mode_names[0x0C] = "Reward";

function game.in_chip_select()
    return game.ram.get.battle_mode() == 0x04;
end

function game.in_combat()
    return game.ram.get.battle_mode() == 0x08;
end

-- Battle State

game.battle_state_names[0x00] = "Loading";
game.battle_state_names[0x04] = "Busy";
game.battle_state_names[0x08] = "Transition";
game.battle_state_names[0x0C] = "Combat";
game.battle_state_names[0x10] = "PAUSE";
game.battle_state_names[0x14] = "Time Stop";
game.battle_state_names[0x18] = "Opening Custom";

-- Menu Mode

game.menu_mode_names[0x00] = "Folder";
--game.menu_mode_names[0x04] = "Sub Chips";
game.menu_mode_names[0x04] = "Library";
game.menu_mode_names[0x08] = "MegaMan";
game.menu_mode_names[0x0C] = "E-Mail";
game.menu_mode_names[0x10] = "Key Items";
game.menu_mode_names[0x14] = "Network";
game.menu_mode_names[0x18] = "Save";
game.menu_mode_names[0x20] = "Unused";

function game.in_menu_folder()
    return game.ram.get.menu_mode() == 0x00;
end

function game.in_menu_folder_select()
    return game.ram.get.menu_mode() == 0x00;
end

function game.in_menu_folder_edit()
    return game.ram.get.menu_mode() == 0x00;
end

function game.in_menu_subchips()
    return false; -- Only BN 1 doesn't have subchips
end

function game.in_menu_library()
    return game.ram.get.menu_mode() == 0x04;
end

function game.in_menu_megaman()
    return game.ram.get.menu_mode() == 0x08;
end

function game.in_menu_email()
    return game.ram.get.menu_mode() == 0x0C;
end

function game.in_menu_keyitems()
    return game.ram.get.menu_mode() == 0x10;
end

function game.in_menu_network()
    return game.ram.get.menu_mode() == 0x14;
end

function game.in_menu_save()
    return game.ram.get.menu_mode() == 0x18;
end

function game.get_shop_cursor_offset()
    return game.ram.get.shop_cursor_offset();
end

-- Menu State

game.menu_state_names[0x04] = "Editing";
game.menu_state_names[0x14] = "Sorting";
game.menu_state_names[0x10] = "To Pack";
game.menu_state_names[0x0C] = "To Folder";
game.menu_state_names[0x08] = "Exiting";

function game.in_folder()
    return game.ram.get.folder_to_pack() == 0x20;
end

function game.in_pack()
    return game.ram.get.folder_to_pack() == 0x02;
end

---------------------------------------- Inventory ----------------------------------------

function game.get_PowerUPs()
    return game.ram.get.PowerUP();
end

function game.set_PowerUPs(new_PowerUPs)
    if new_PowerUPs < 0 then
        new_PowerUPs = 0
    elseif new_PowerUPs > 50 then
        new_PowerUPs = 50;
    end
    game.ram.set.PowerUP(new_PowerUPs);
end

function game.add_PowerUPs(some_PowerUPs)
    game.set_PowerUPs(game.get_PowerUPs() + some_PowerUPs);
end

function game.get_IceBlocks()
    return game.ram.get.IceBlock();
end

function game.set_IceBlocks(new_IceBlocks)
    if new_IceBlocks < 0 then
        new_IceBlocks = 0
    elseif new_IceBlocks > 53 then
        new_IceBlocks = 53;
    end
    game.ram.set.IceBlock(new_IceBlocks);
end

function game.add_IceBlocks(some_IceBlocks)
    game.set_IceBlocks(game.get_IceBlocks() + some_IceBlocks);
end

---------------------------------------- Mega Modifications ----------------------------------------

function game.hub_buster_stats()
    game.set_buster_stats(5); -- super armor
end

function game.op_buster_stats()
    game.set_buster_stats(7); -- 327 buster shots
end

function game.give_armor()
    game.ram.set.armor_heat(1);
    game.ram.set.armor_aqua(1);
    game.ram.set.armor_wood(1);
end

function game.calculate_mega_level()
    level = 1; -- starting level
    level = level +     game.ram.get.HPMemory();
    level = level + 3 * game.ram.get.buster_attack();
    level = level + 3 * game.ram.get.buster_rapid();
    level = level + 3 * game.ram.get.buster_charge();
    level = level + 6 * game.ram.get.armor_heat();
    level = level + 6 * game.ram.get.armor_aqua();
    level = level + 6 * game.ram.get.armor_wood();
    return level;
end

---------------------------------------- Flags ----------------------------------------

function game.get_fire_flags()
    return game.ram.get.fire_flags();
end

function game.set_fire_flags(fire_flags)
    game.ram.set.fire_flags(fire_flags);
end

function game.ignite_oven_fires()
    game.ram.set.fire_flags     (0x00000000);
    game.ram.set.fire_flags_oven(0x00000000);
end

function game.extinguish_oven_fires()
    game.ram.set.fire_flags     (0xFFCFFFFF);
    game.ram.set.fire_flags_oven(0xFFCFFFFF);
end

function game.ignite_WWW_fires()
    game.ram.set.fire_flags    (0x00000000);
    game.ram.set.fire_flags_www(0x00000000);
end

function game.extinguish_WWW_fires()
    game.ram.set.fire_flags    (0x00FEFFFF);
    game.ram.set.fire_flags_www(0xFCFFFF01);
end

function game.get_star_byte()
    return game.ram.get.title_star_byte();
end

function game.set_star_byte(new_star_byte)
    game.ram.set.title_star_byte(new_star_byte);
end

function game.get_star_flag()
    return bit.rshift(bit.band(game.get_star_byte(), 0x04), 2);
end

function game.set_star_flag()
    game.set_star_byte(bit.set(game.get_star_byte(), 2));
end

function game.clear_star_flag()
    game.set_star_byte(bit.band(game.get_star_byte(), 0xFB));
end

function game.get_magic_byte()
    return game.ram.get.magic_byte();
end

function game.set_magic_byte(new_magic)
    game.ram.set.magic_byte(new_magic);
end

function game.is_magic_bit_set()
    return bit.band(game.get_magic_byte(), 0x18) == 0x10;
end

function game.is_go_mode()
    return game.is_magic_bit_set() and (game.get_progress() == 0x54);
end

function game.go_mode()
    game.set_progress(0x54);
    game.set_magic_byte(0x10);
end

---------------------------------------- Draw Slots ----------------------------------------

function game.shuffle_folder_simulate_from_battle(offset)
    local RNG_index = game.get_main_RNG_index();
    if RNG_index ~= nil then
        offset = offset or 0;
        return game.shuffle_folder_simulate_from_main_index(RNG_index-120+1+offset, 60);
    end
end

---------------------------------------- Battlechips ----------------------------------------

function game.count_library()
    local count = 0;
    for i=0,0x1F do -- 32 bytes (not all are real chips)
        count = count + game.bit_counter(game.ram.get.library(i));
    end
    return count;
end

function game.get_draw_slot_code_name(which_slot)
    local folder_slot = game.get_draw_slot(which_slot)-1;
    local draw_code = game.ram.get.folder_code(folder_slot);
    return game.get_chip_code(draw_code);
end

function game.is_chip_selected()
    return game.ram.get.chip_selected_flag() ~= 0x00;
end

function game.get_selected_chip_location_name()
    local selected_flag = game.ram.get.chip_selected_flag();
    if selected_flag == 0x01 then
        return "Folder";
    elseif selected_flag == 0x02 then
        return "Pack";
    end
    return "None";
end

function game.get_selected_ID()
    local selected_chip_location = game.get_selected_chip_location_name();
    if selected_chip_location == "Folder" then
        return game.ram.get.folder_ID(game.get_cursor_offset_selected()+game.get_cursor_position_selected());
    elseif selected_chip_location == "Pack" then
        return game.ram.get.pack_ID(game.get_cursor_offset_selected()+game.get_cursor_position_selected());
    end
    return -1;
end

function game.get_selected_code()
    local selected_chip_location = game.get_selected_chip_location_name();
    if selected_chip_location == "Folder" then
        return game.ram.get.folder_code(game.get_cursor_offset_selected()+game.get_cursor_position_selected());
    elseif selected_chip_location == "Pack" then
        return game.ram.get.pack_code(game.get_cursor_offset_selected()+game.get_cursor_position_selected());
    end
    return -1;
end

function game.overwrite_folder_dalus_special()
    game.overwrite_folder_to(1, {
        { ID= 34; code= 6 }; -- MetGuard G
        { ID= 34; code= 6 }; -- MetGuard G
        { ID= 34; code= 6 }; -- MetGuard G
        { ID= 34; code= 6 }; -- MetGuard G
        { ID= 34; code= 6 }; -- MetGuard G
        { ID= 34; code= 6 }; -- MetGuard G
        { ID= 34; code= 6 }; -- MetGuard G
        { ID= 34; code= 6 }; -- MetGuard G
        { ID= 34; code= 6 }; -- MetGuard G
        { ID= 34; code= 6 }; -- MetGuard G
        { ID= 31; code= 6 }; -- Dash G
        { ID= 31; code= 6 }; -- Dash G
        { ID= 31; code= 6 }; -- Dash G
        { ID= 31; code= 6 }; -- Dash G
        { ID= 31; code= 6 }; -- Dash G
        { ID= 31; code= 6 }; -- Dash G
        { ID= 31; code= 6 }; -- Dash G
        { ID= 31; code= 6 }; -- Dash G
        { ID= 31; code= 6 }; -- Dash G
        { ID= 31; code= 6 }; -- Dash G
        { ID=165; code= 6 }; -- GutsManV3 G
        { ID=165; code= 6 }; -- GutsManV3 G
        { ID=165; code= 6 }; -- GutsManV3 G
        { ID=165; code= 6 }; -- GutsManV3 G
        { ID=165; code= 6 }; -- GutsManV3 G
        { ID= 82; code= 5 }; -- Escape
        { ID= 82; code= 7 }; -- Escape
        { ID= 82; code= 9 }; -- Escape
        { ID= 82; code=11 }; -- Escape
        { ID= 82; code=13 }; -- Escape
    });
end

function game.overwrite_folder_smog_special()
    game.overwrite_folder_to(1, {
        { ID=16; code=2 }; -- ShokWave C
        { ID=16; code=2 }; -- ShokWave C
        { ID=16; code=2 }; -- ShokWave C
        { ID=16; code=2 }; -- ShokWave C
        { ID=16; code=2 }; -- ShokWave C
        { ID=16; code=2 }; -- ShokWave C
        { ID=16; code=2 }; -- ShokWave C
        { ID=16; code=2 }; -- ShokWave C
        { ID=16; code=2 }; -- ShokWave C
        { ID=16; code=2 }; -- ShokWave C
        { ID=17; code=2 }; -- SonicWav C
        { ID=17; code=2 }; -- SonicWav C
        { ID=17; code=2 }; -- SonicWav C
        { ID=17; code=2 }; -- SonicWav C
        { ID=17; code=2 }; -- SonicWav C
        { ID=17; code=2 }; -- SonicWav C
        { ID=17; code=2 }; -- SonicWav C
        { ID=17; code=2 }; -- SonicWav C
        { ID=17; code=2 }; -- SonicWav C
        { ID=17; code=2 }; -- SonicWav C
        { ID=17; code=2 }; -- SonicWav C
        { ID=18; code=2 }; -- DynaWave C
        { ID=18; code=2 }; -- DynaWave C
        { ID=18; code=2 }; -- DynaWave C
        { ID=18; code=2 }; -- DynaWave C
        { ID=18; code=2 }; -- DynaWave C
        { ID=18; code=2 }; -- DynaWave C
        { ID=18; code=2 }; -- DynaWave C
        { ID=18; code=2 }; -- DynaWave C
        { ID=18; code=2 }; -- DynaWave C
        { ID=18; code=2 }; -- DynaWave C
    });
end

function game.overwrite_folder_press_a()
    game.overwrite_folder_to(1, {
        { ID=119; code=0 }; -- FstGauge
        { ID= 76; code=0 }; -- Steal
        { ID= 76; code=0 }; -- Steal
        { ID= 76; code=0 }; -- Steal
        { ID= 76; code=0 }; -- Steal
        { ID=  9; code=0 }; -- BigBomb
        { ID=  9; code=0 }; -- BigBomb
        { ID=  9; code=0 }; -- BigBomb
        { ID=  9; code=0 }; -- BigBomb
        { ID=  9; code=0 }; -- BigBomb
        { ID= 24; code=0 }; -- Quake3
        { ID= 24; code=0 }; -- Quake3
        { ID= 24; code=0 }; -- Quake3
        { ID= 24; code=0 }; -- Quake3
        { ID= 24; code=0 }; -- Quake3
        { ID=129; code=0 }; -- Gaia3
        { ID=129; code=0 }; -- Gaia3
        { ID=129; code=0 }; -- Gaia3
        { ID=129; code=0 }; -- Gaia3
        { ID=129; code=0 }; -- Gaia3
        { ID=135; code=0 }; -- BigWave
        { ID=135; code=0 }; -- BigWave
        { ID=135; code=0 }; -- BigWave
        { ID=135; code=0 }; -- BigWave
        { ID=135; code=0 }; -- BigWave
        { ID=168; code=0 }; -- ProtoMan V3
        { ID=171; code=0 }; -- WoodMan V3
        { ID=180; code=0 }; -- StoneMan V3
        { ID=198; code=0 }; -- ElecMan V3
        { ID=199; code=0 }; -- Bass
    });
end

---------------------------------------- Miscellaneous ----------------------------------------

function game.get_door_code()
    return game.ram.get.door_code();
end

function game.set_door_code(new_door_code)
    game.ram.set.door_code(new_door_code);
end

function game.near_number_doors() -- NumberMan Scenario or WWW Comp 2
    return (0x12 <=  game.get_progress() and game.get_progress() <= 0x15)
        or (game.get_main_area() == 0x85 and game.get_sub_area() == 0x01);
end

function game.title_screen_A()
    if game.did_leave_title_screen() then
        print(string.format("\nPressed A on frame: %u", emu.framecount()-17));
    end
end

function game.randomize_color_palette()
    for offset=0,0x1FF do -- BN 1 uses 512 bytes
        game.ram.set.color_palette(offset, math.random(0x00, 0xFF));
    end
end

function game.use_fun_flags(fun_flags)
    if fun_flags.randomize_colors then
        if game.did_game_state_change() or game.did_menu_mode_change() or game.did_area_change() then game.doit_later[emu.framecount()+3] = game.randomize_color_palette; end
    end
end

---------------------------------------- Module Controls ----------------------------------------

local settings = require("All/Settings");

function game.initialize(options)
    settings.set_display_text("gui"); -- TODO: Remove when gui.text fully supported
    game.ram.initialize(options);
end

function game.pre_update(options)
    game.title_screen_A();
    options.fun_flags = game.fun_flags;
    game.ram.pre_update(options);
    game.use_fun_flags(game.fun_flags);
end

function game.post_update(options)
    game.track_game_state();
    game.ram.post_update(options);
end

return game;

