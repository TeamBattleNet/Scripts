-- Functions for MMBN 4 scripting, enjoy.

local game = require("Common/Game");

game.areas    = require("BN4/Areas"   );
game.chips    = require("BN4/Chips"   );
game.enemies  = require("BN4/Enemies" );
game.progress = require("BN4/Progress");
game.ram      = require("BN4/RAM"     );

game.game_state_names[0x00] = "world_init";
game.game_state_names[0x04] = "world";
game.game_state_names[0x08] = "battle";
game.game_state_names[0x0C] = "???";
game.game_state_names[0x10] = "player_change";
game.game_state_names[0x14] = "menu";
game.game_state_names[0x18] = "???";

game.battle_state_names[0x00] = "loading";
game.battle_state_names[0x04] = "busy";
game.battle_state_names[0x08] = "combat";
game.battle_state_names[0x1C] = "PAUSE";
game.battle_state_names[0x20] = "opening_custom";
game.battle_state_names[0x24] = "custom";

game.folder_state_names[0x04] = "editing";
game.folder_state_names[0x14] = "sorting";
game.folder_state_names[0x10] = "to_pack";
game.folder_state_names[0x0C] = "to_folder";
game.folder_state_names[0x08] = "exited";

function game.simulate_shuffle_folder()
    local seed = game.ram.get.lazy_RNG_value();

    game.ram.simulate_shuffle_folder(seed);
end

return game;

