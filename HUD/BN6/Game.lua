-- Functions for MMBN 1 scripting, enjoy.

local game = require("Common/Game");

game.areas    = require("BN6/Areas"   );
game.chips    = require("BN6/Chips"   );
game.enemies  = require("BN6/Enemies" );
game.progress = require("BN6/Progress");
game.ram      = require("BN6/RAM"     );

game.game_state_names[0x00] = "world_init";
game.game_state_names[0x04] = "world";
game.game_state_names[0x08] = "battle_init";
game.game_state_names[0x0C] = "battle";
game.game_state_names[0x10] = "map_change";
game.game_state_names[0x14] = "player_change";
game.game_state_names[0x18] = "menu";
game.game_state_names[0x1C] = "bbs";
game.game_state_names[0x20] = "shop";
game.game_state_names[0x24] = "trader";
game.game_state_names[0x30] = "request_bbs";
game.game_state_names[0x34] = "mailbox";
game.game_state_names[0x38] = "chargeman_minigame";

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

return game;

