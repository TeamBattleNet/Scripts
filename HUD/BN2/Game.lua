-- Functions for MMBN 2 scripting, enjoy.

local game = require("All/Game");

game.number = 2;

game.ram      = require("BN2/RAM"     );
game.areas    = require("BN2/Areas"   );
game.chips    = require("BN2/Chips"   );
game.enemies  = require("BN2/Enemies" );
game.progress = require("BN2/Progress");

game.fun_flags = {}; -- set in Commands, used in RAM

---------------------------------------- Game State ----------------------------------------

-- Game Mode

game.state.title         = 0x00; -- or BIOS
game.state.world         = 0x04; -- real and digital
game.state.battle        = 0x08;
game.state.transition    = 0x0C; -- jack-in / out
game.state.demo_end      = 0x10; -- what is this?
game.state.splash        = 0x14;
game.state.menu          = 0x18;
game.state.shop          = 0x1C;
game.state.game_over     = 0x20;
game.state.chip_trader   = 0x24;
game.state.request_board = 0x28; -- new
game.state.credits       = 0x2C;
game.state.splash_pal    = 0x34; -- Ubisoft Logo (PAL only)

game.game_state_names[0x00] = "Title";
game.game_state_names[0x04] = "World";
game.game_state_names[0x08] = "Battle";
game.game_state_names[0x0C] = "Player Change";
game.game_state_names[0x10] = "Demo End";
game.game_state_names[0x14] = "Capcom Logo";
game.game_state_names[0x18] = "Menu";
game.game_state_names[0x1C] = "Shop";
game.game_state_names[0x20] = "GAME OVER";
game.game_state_names[0x24] = "Chip Trader";
game.game_state_names[0x28] = "Request Board";
game.game_state_names[0x2C] = "Credits";
game.game_state_names[0x30] = "Unused?";
game.game_state_names[0x34] = "Ubisoft Logo";

-- Battle Mode

game.battle_mode_names[0x00] = "Loading & Reward";
game.battle_mode_names[0x04] = "Chip Select";
game.battle_mode_names[0x08] = "Combat";

function game.in_chip_select()
    return game.ram.get.battle_mode() == 0x04;
end

function game.in_combat()
    return game.ram.get.battle_mode() == 0x08;
end

-- Battle State

game.battle_state_names[0x00] = "Loading";
game.battle_state_names[0x04] = "Waiting";
game.battle_state_names[0x08] = "PAUSE";
game.battle_state_names[0x0C] = "Reward & Time Stop";

-- Menu Mode

game.menu.folder_select = 0x00;
game.menu.subchips      = 0x04;
game.menu.library       = 0x08;
game.menu.megaman       = 0x0C;
game.menu.email         = 0x10;
game.menu.key_items     = 0x14;
game.menu.network       = 0x18;
game.menu.save          = 0x1C;
game.menu.folder_edit   = 0x20;

game.menu_mode_names[0x00] = "Folder Select";
game.menu_mode_names[0x04] = "Sub Chips";
game.menu_mode_names[0x08] = "Library";
game.menu_mode_names[0x0C] = "MegaMan";
game.menu_mode_names[0x10] = "E-Mail";
game.menu_mode_names[0x14] = "Key Items";
game.menu_mode_names[0x18] = "Network";
game.menu_mode_names[0x1C] = "Save";
game.menu_mode_names[0x20] = "Folder Edit";
game.menu_mode_names[0x24] = "Unused";

-- Menu State

game.menu_state_names[0x04] = "Editing Folder";
game.menu_state_names[0x08] = "Editing Pack";
game.menu_state_names[0x0C] = "Exiting";
game.menu_state_names[0x10] = "To Folder";
game.menu_state_names[0x14] = "To Pack";
game.menu_state_names[0x18] = "Sorting Folder";
game.menu_state_names[0x1C] = "Sorting Pack";

function game.in_folder()
    return game.in_menu_folder_edit() and (game.ram.get.menu_state() == 0x04 or game.ram.get.menu_state() == 0x18);
end

function game.in_pack()
    return game.in_menu_folder_edit() and (game.ram.get.menu_state() == 0x08 or game.ram.get.menu_state() == 0x1C);
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

function game.set_bug_frags(new_bug_frags)
    if new_bug_frags < 0 then
        new_bug_frags = 0
    elseif new_bug_frags > 0xFF then
        new_bug_frags = 0xFF; -- only 1 byte
    end
    game.ram.set.bug_frags(new_bug_frags);
end

----------------------------------------Mega Modifications ----------------------------------------

function game.reset_styles()
    game.ram.reset_styles();
end

function game.hub_style_level_up()
    game.ram.adjust_hub_style_level(1);
end

function game.hub_style_level_down()
    game.ram.adjust_hub_style_level(-1);
end

function game.set_style_guts()
    game.ram.change_active_style(1);
end

function game.set_style_cust()
    game.ram.change_active_style(2);
end

function game.set_style_team()
    game.ram.change_active_style(3);
end

function game.set_style_shld()
    game.ram.change_active_style(4);
end

function game.set_style_elec()
    game.ram.change_active_element(1);
end

function game.set_style_heat()
    game.ram.change_active_element(2);
end

function game.set_style_aqua()
    game.ram.change_active_element(3);
end

function game.set_style_wood()
    game.ram.change_active_element(4);
end

function game.calculate_mega_level()
    level = 1; -- starting level
    level = level +     game.ram.get.HPMemory();
    level = level + 4 * game.ram.get.buster_attack();
    level = level + 4 * game.ram.get.buster_rapid();
    level = level + 4 * game.ram.get.buster_charge();
    if game.ram.has_style() then
        level = level + 6;
    end
    return level;
end

---------------------------------------- Flags ----------------------------------------

function game.get_ice_flags()
    return game.ram.get.ice_flags();
end

function game.set_ice_flags(ice_flags)
    game.ram.set.ice_flags(ice_flags);
end

function game.is_magic_bit_set()
    return bit.band(game.get_magic_byte(), 0x04) == 0x04;
end

function game.is_go_mode()
    return (game.is_magic_bit_set() and game.get_progress() >= 0x42);
end

function game.go_mode()
    game.set_progress(0x47);
    game.set_magic_byte(0x04);
end

---------------------------------------- Draw Slots ----------------------------------------

function game.shuffle_folder_simulate_from_battle(offset)
    local RNG_index = game.get_main_RNG_index();
    if RNG_index ~= nil then
        offset = offset or 0;
        return game.shuffle_folder_simulate_from_main_index(RNG_index-60+1+offset, 30);
    end
end

---------------------------------------- Battlechips ----------------------------------------

function game.count_library()
    local count = 0;
    for i=0,0x20 do -- 33 bytes? (not all are real chips)
        count = count + game.bit_counter(game.ram.get.library(i));
    end
    return count;
end

function game.overwrite_folder_press_a()
    game.overwrite_folder_to(1, {
        { ID= 19; code=0 }; -- BigBomb
        { ID= 19; code=0 }; -- BigBomb
        { ID= 19; code=0 }; -- BigBomb
        { ID= 19; code=0 }; -- BigBomb
        { ID= 19; code=0 }; -- BigBomb
        { ID= 44; code=0 }; -- Quake3
        { ID= 44; code=0 }; -- Quake3
        { ID= 44; code=0 }; -- Quake3
        { ID= 44; code=0 }; -- Quake3
        { ID= 44; code=0 }; -- Quake3
        { ID= 59; code=0 }; -- Ratton3
        { ID= 59; code=0 }; -- Ratton3
        { ID= 59; code=0 }; -- Ratton3
        { ID= 59; code=0 }; -- Ratton3
        { ID= 59; code=0 }; -- Ratton3
        { ID= 73; code=0 }; -- Satelit3
        { ID= 73; code=0 }; -- Satelit3
        { ID= 73; code=0 }; -- Satelit3
        { ID= 73; code=0 }; -- Satelit3
        { ID= 73; code=0 }; -- Satelit3
        { ID=152; code=0 }; -- FullCust
        { ID=152; code=0 }; -- FullCust
        { ID=152; code=0 }; -- FullCust
        { ID=152; code=0 }; -- FullCust
        { ID=152; code=0 }; -- FullCust
        { ID=202; code=0 }; -- Protoman V3
        { ID=202; code=0 }; -- Protoman V3
        { ID=202; code=0 }; -- Protoman V3
        { ID=202; code=0 }; -- Protoman V3
        { ID=202; code=0 }; -- Protoman V3
    });
end

function game.overwrite_folder_dalus_special()
    game.overwrite_folder_to(1, {
        { ID=111; code=26 }; -- Guard *
        { ID=111; code=26 }; -- Guard *
        { ID=111; code=26 }; -- Guard *
        { ID=111; code=26 }; -- Guard *
        { ID=111; code=26 }; -- Guard *
        { ID= 50; code= 6 }; -- DashAtk G
        { ID= 50; code= 6 }; -- DashAtk G
        { ID= 50; code= 6 }; -- DashAtk G
        { ID= 50; code= 6 }; -- DashAtk G
        { ID= 50; code= 6 }; -- DashAtk G
        { ID=199; code= 6 }; -- GutsMan V3 G
        { ID=199; code= 6 }; -- GutsMan V3 G
        { ID=199; code= 6 }; -- GutsMan V3 G
        { ID=199; code= 6 }; -- GutsMan V3 G
        { ID=199; code= 6 }; -- GutsMan V3 G
        { ID=152; code=26 }; -- FullCust *
        { ID=152; code=26 }; -- FullCust *
        { ID=152; code=26 }; -- FullCust *
        { ID=152; code=26 }; -- FullCust *
        { ID=152; code=26 }; -- FullCust *
        { ID=188; code=26 }; -- Atk+10 *
        { ID=188; code=26 }; -- Atk+10 *
        { ID=188; code=26 }; -- Atk+10 *
        { ID=188; code=26 }; -- Atk+10 *
        { ID=188; code=26 }; -- Atk+10 *
        { ID=138; code= 5 }; -- Escape F
        { ID=138; code= 7 }; -- Escape H
        { ID=138; code= 9 }; -- Escape J
        { ID=138; code=11 }; -- Escape L
        { ID=138; code=13 }; -- Escape N
    });
end

function game.overwrite_folder_gater()
    game.overwrite_folder_to(1, {
        { ID=147; code=26 }; -- Wind *
        { ID=147; code=26 }; -- Wind *
        { ID=147; code=26 }; -- Wind *
        { ID=147; code=26 }; -- Wind *
        { ID=147; code=26 }; -- Wind *
        { ID=148; code=26 }; -- Fan *
        { ID=148; code=26 }; -- Fan *
        { ID=148; code=26 }; -- Fan *
        { ID=148; code=26 }; -- Fan *
        { ID=148; code=26 }; -- Fan *
        { ID=152; code=26 }; -- FullCust *
        { ID=152; code=26 }; -- FullCust *
        { ID=152; code=26 }; -- FullCust *
        { ID=152; code=26 }; -- FullCust *
        { ID=152; code=26 }; -- FullCust *
        { ID=188; code=26 }; -- Atk+10 *
        { ID=188; code=26 }; -- Atk+10 *
        { ID=188; code=26 }; -- Atk+10 *
        { ID=188; code=26 }; -- Atk+10 *
        { ID=188; code=26 }; -- Atk+10 *
        { ID=188; code=26 }; -- Atk+10 *
        { ID= 48; code=26 }; -- Atk+30 *
        { ID= 48; code=26 }; -- Atk+30 *
        { ID= 48; code=26 }; -- Atk+30 *
        { ID= 48; code=26 }; -- Atk+30 *
        { ID= 48; code=26 }; -- Atk+30 *
        { ID=238; code= 6 }; -- GateMan V3 G
        { ID=238; code= 6 }; -- GateMan V3 G
        { ID=238; code= 6 }; -- GateMan V3 G
        { ID=238; code= 6 }; -- GateMan V3 G
        { ID=238; code= 6 }; -- GateMan V3 G
    });
end

function game.overwrite_folder_last_special()
    game.overwrite_folder_to(1, {
        { ID=151; code= 0 }; -- FstGauge *
        { ID=177; code=14 }; -- IceStage *
        { ID=146; code=14 }; -- Guardian *
        { ID=171; code=25 }; -- LifeAur3 *
        { ID=117; code=25 }; -- ZeusHamr *
        { ID= 29; code=26 }; -- FireBlde *
        { ID= 29; code=26 }; -- FireBlde *
        { ID= 29; code=26 }; -- FireBlde *
        { ID= 29; code=26 }; -- FireBlde *
        { ID= 29; code=26 }; -- FireBlde *
        { ID= 30; code=26 }; -- AquaBlde *
        { ID= 30; code=26 }; -- AquaBlde *
        { ID= 30; code=26 }; -- AquaBlde *
        { ID= 30; code=26 }; -- AquaBlde *
        { ID= 30; code=26 }; -- AquaBlde *
        { ID= 31; code=26 }; -- ElecBlde *
        { ID= 31; code=26 }; -- ElecBlde *
        { ID= 31; code=26 }; -- ElecBlde *
        { ID= 31; code=26 }; -- ElecBlde *
        { ID= 31; code=26 }; -- ElecBlde *
        { ID=131; code=26 }; -- AreaGrab *
        { ID=131; code=26 }; -- AreaGrab *
        { ID=131; code=26 }; -- AreaGrab *
        { ID=131; code=26 }; -- AreaGrab *
        { ID=131; code=26 }; -- AreaGrab *
        { ID=152; code=26 }; -- FullCust *
        { ID=152; code=26 }; -- FullCust *
        { ID=152; code=26 }; -- FullCust *
        { ID=152; code=26 }; -- FullCust *
        { ID=152; code=26 }; -- FullCust *
    });
end

---------------------------------------- Miscellaneous ----------------------------------------

-- None yet

---------------------------------------- Fun Flags  ----------------------------------------

function game.title_screen_A()
    if game.did_leave_title_screen() then
        print("");
        local main_RNG_index = game.get_main_RNG_index();
        local on_A_RNG_index = (main_RNG_index and main_RNG_index - 17);
        game.broadcast(string.format("%u: Pressed A on M RNG Index %s", emu.framecount(), on_A_RNG_index or "?????"));
        game.broadcast(string.format("%u: Loaded in on M RNG Index %s", emu.framecount(), main_RNG_index or "?????"));
    end
end

function game.use_fun_flags(fun_flags) -- TODO: Rename
    game.title_screen_A();
    
    if fun_flags.randomize_colors then
        if game.did_game_state_change() or game.did_menu_mode_change() or game.did_area_change() then game.doit_later[emu.framecount()+5] = game.randomize_color_palette; end
    end
    
    if fun_flags.is_routing and not game.in_title() then
        if game.did_progress_change() then
            game.broadcast(game.get_progress_change());
        end
        
        if game.did_magic_byte_change() then
            game.broadcast_magic_byte();
        end
    end
end

---------------------------------------- Module Controls ----------------------------------------

local settings = require("All/Settings");

function game.initialize(options)
    settings.set_display_text("gui"); -- TODO: Remove when gui.text fully supported
    game.ram.initialize(options);
end

function game.pre_update(options)
    options.fun_flags = game.fun_flags;
    game.ram.pre_update(options);
    game.use_fun_flags(game.fun_flags);
end

function game.post_update(options)
    game.track_game_state();
    game.ram.post_update(options);
end

return game;

