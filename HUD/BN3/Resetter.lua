-- Resets and pauses the game on a specific frame.

-- Note: When setting A in Lua, it happens before next_frame();
-- Note: When pressing A on Controller, it happens after next_frame();
-- Note: Game load (RNG freeze) happens 17 frames after Controller A, but 18 frames after Lua A

--[[
 67 ->  84: First Possible
100 -> 117: A 100
132 -> 149: Wind Star
133 -> 150: CopyMan
137 -> 154: US Gamble
170 -> 187: IceBall
173 -> 190: Bubble Beta
200 -> 217: A 200
--]]

local frame_stopper = {};

local function next_frame(message, ...)
    message = message or "";
    gui.text(3, 0, string.format(message, ...));
    emu.frameadvance();
end

local function wait_for(what, frames, buttons)
    buttons = buttons or {};
    for i=1,frames do
        joypad.set(buttons);
        next_frame("Waiting for %s: %3i", what, frames-i);
    end
end

function frame_stopper.reset(target_main_RNG, hard_reset)
    if hard_reset then
        joypad.set({Power=true});
        next_frame();
        wait_for("BIOS", 328, {Start=true});
    else
        joypad.set({A=true, B=true, Start=true, Select=true});
        next_frame();
    end
    
    wait_for("START", 82);
    
    joypad.set({Start=true});
    next_frame();
    
    wait_for("Main RNG", target_main_RNG-67);
    
    client.pause();
end

return frame_stopper;

--[[

Wind Star (Hard)
-A-    -L-    -1-
128 -> 145 -> no (bad)
129 -> 146 -> 252
130 -> 147 -> 188
131 -> 148 -> 188
132 -> 149 -> 220
133 -> 150 -> 252
134 -> 151 -> 220
135 -> 152 -> 220
136 -> 153 -> no (bad)

CopyMan Chain (Hard)
-A-    -L-    -2-
127 -> 144 -> 366 - 2xCrack (bad)
128 -> 145 -> 367 - Cracker
129 -> 146 -> 368 - Not
130 -> 147 -> 369 - Not
131 -> 148 -> 370 - Cracker
132 -> 149 -> 371 - Cracker
133 -> 150 -> 372 - Cracker
134 -> 151 -> 373 - Cracker
135 -> 152 -> 374 - Not
136 -> 153 -> 375 - Cracker
137 -> 154 -> 376 - Cracker
138 -> 155 -> 377 - 2xCrack (bad)

US Gamble (Soft)
-A-    -L-
134 -> 151 Top Right (bad)
135 -> 152 Bottom Left
136 -> 153 Bottom Left
137 -> 154 Bottom Left
138 -> 155 Bottom Left
139 -> 156 Bottom Left
140 -> 157 Bottom Right (bad)

IceBall M (Hard)
-A-    -L-
167 -> 184 none
168 -> 185 yes
169 -> 186 yes
170 -> 187 yes
171 -> 188 yes
172 -> 189 yes
173 -> 190 early

BubbleMan Beta (Hard)
-A-    -L-    -1- -2-
167 -> 184 -> 235 363 bad
168 -> 185 -> --- --- none
169 -> 186 -> 299 433 ok
170 -> 187 -> --- --- none
171 -> 188 -> 139 268 bad
172 -> 189 -> --- --- none
173 -> 190 -> 203 338 ok
174 -> 191 -> 203 339 ok
175 -> 192 -> 235 317 bad

--]]

