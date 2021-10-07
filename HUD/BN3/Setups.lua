-- Specific Sequences of Inputs for MMBN 3 scripting, enjoy.

local game   = require("BN3/Game");
local setups = require("All/Setups");

setups.delay_bios   = 282+ 5; -- BN 1 + 3
setups.delay_capcom =  31+11; -- BN 1 + 3
setups.delay_title  =  65+16; -- BN 1 + 3
setups.align_RNG    =  66   ; -- BN 3

setups.add_setup(setups.group_misc, "TEST BUTTONS", function()
    --setups.soft_reset();
    --setups.hard_reset();
    --setups.CONTINUE(0);
    setups.press_buttons(37+8, "Loading...."); -- area loading varies; fix with skip_lag_frames?
    setups.press_buttons( 1, "PRESS START", {Start=true});
end);

-- Title "PRESS START" flashes 25 on, 7 off (require Hard Reset?)
setups.add_setups(setups.create_group("Audio US"),
    { -- description, hard, pause, delay_start, target_index
        {" 66  ->   83 : First A",    false, false, 0,   0},
        {"104 (101-107):  1st Beat",  false, false, 0, 104},
      --{"104 (102-106): Wind Star",  false, false, 0, 104},
      --{"104 (102-106): GMD Jackin", false, false, 0, 104},
      --{"104 ( 99-108): Yort Yort",  false, false, 0, 104},
        {"119 (117-121):  2nd Beat",  false, false, 0, 119},
        {"129 (127-131):  3rd Beat",  false, false, 0, 129},
      --{"129 (127-130): ACDC Skip",  false, false, 0, 129},
        {"136 (134-138): Gamble US",  false, false, 0, 136},
        {"142 (139-145):  4th Beat",  false, false, 0, 142},
        {"153 (151-155):  5th Beat",  false, false, 0, 153},
      --{"158 (156-160): GMD Jackin", false, false, 0, 158},
      --{"162 (160-163): FastBall A", false, false, 0, 162},
        {"167 (165-169):  6th Beat",  false, false, 0, 167},
      --{"174 (172-176): FastBall B", false, false, 0, 174},
        {"174 (172-176):  7th Beat",  false, false, 0, 174},
        {"205 (203-207):  8th Beat",  false, false, 0, 205},
        {"220 (218-222):  9th Beat",  false, false, 0, 220},
      --{"220 (218-222): GMD Reroll", false, false, 0, 220},
        {"232 (230-234): 10th Beat",  false, false, 0, 232},
      --{"232 (229-234): SkeeBall",   false, false, 0, 232},
      --{"302 (300-304): FastBall C", false, false, 0, 302},
      --{"308 (306-310): FastBall D", false, false, 0, 308},
    }
);

setups.add_setups(setups.create_group("Test US"),
    { -- description, hard, pause, delay_start, target_index
        {" 66 ->  83: First  A  (Soft)",  false, false, 0,  66},
        {" 66 ->  83: First  A  (Hard)",   true, false, 0,  66},
        {" 66 ->  83: First  A  (Pause)",  true,  true, 0,  66},
        {" 83 -> 100: 100 Load",          false, false, 0,  83},
        {"100 -> 117: 100 On A",          false, false, 0, 100},
        {"200 -> 217: 200 On A",          false, false, 0, 200},
        {"300 -> 317: 300 On A",          false, false, 0, 300},
    }
);

setups.add_setups(setups.create_group("RNG US"),
    { -- description, hard, pause, delay_start, target_index
        {"102 -> 119: Wind Box 1",         true, false, 0, 102},
        {"104 -> 121: Wind Box 2",         true, false, 0, 104}, --  1st Beat
        {"106 -> 123: Wind Box 3",         true, false, 0, 106},
        {"128 -> 145: CopyMan (Pause)",    true,  true, 0, 128},
        {"132 -> 149: CopyMan",            true, false, 0, 132},
      --{"132 -> 149: Wind Star Old",      true, false, 0, 132},
        {"135 -> 152: Gamble  (Pause)",   false,  true, 0, 135},
        {"137 -> 154: Gamble",            false, false, 0, 137},
        {"162 -> 179: IceBall Fast A",     true, false, 0, 162},
        {"174 -> 191: IceBall Fast B",     true, false, 0, 174}, --  7th Beat
        {"220 -> 237: GMD Reroll",         true, false, 0, 220}, --  9th Beat
        {"232 -> 249: IceBall Slide",      true, false, 0, 232}, -- 10th Beat
        {"302 -> 319: IceBall Fast C",     true, false, 0, 302},
        {"308 -> 325: IceBall Fast D",    false, false, 0, 308},
      --{"170 -> 187: IceBall (Hard)",     true, false, 0, 170},
      --{"170 -> 187: IceBall (Soft)",    false, false, 0, 170},
    }
);

setups.add_setup(setups.group_folders, "Folder  1: Rock, Paper, FlashMan", function()
    setups.folder_edit_buttons({
        {A=true};
        {R=true};
        {R=true};
        {Down=true};
        {Down=true};
        {A=true};
        {L=true};
        {Up=true};
        {A=true};
        {L=true};
        {Down=true};
        {A=true};
        {A=true};
        {Up=true};
        {A=true};
        {A=true};
        {R=true};
        {R=true};
        {R=true};
        {Up=true};
        {Up=true};
        {Up=true};
        {A=true};
        {Down=true};
        {A=true};
        {Up=true};
        {Up=true};
        {A=true};
        {L=true};
        {A=true};
        {Down=true};
        {A=true};
        {L=true};
        {Down=true};
        {A=true};
        {R=true};
        {Down=true};
        {Down=true};
        {A=true};
        {A=true};
        {R=true};
        {A=true};
        {R=true};
        {Down=true};
        {A=true};
        {L=true};
        {A=true};
    });
end);

--require("BN3/Setups_GMD");
require("BN3/Setups_Gamble");

return setups.groups;

