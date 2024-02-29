expmultiplier = 5 -- Set this to your desired experience multiplier value

-- Print to screen and console
function print_everywhere(message)
    console.log("ExpMod: " .. message)
    gui.addmessage(message)
end

console.log("ExpMod: Starting")
-- console.log(memory.getmemorydomainlist())
-- console.log("Expecting: EWRAM")
memory.usememorydomain("EWRAM")
-- console.log("Got: " .. memory.getcurrentmemorydomain())
console.log("ExpMod: Loaded!")

while true do
	-- Get the values of the ram addresses for... 
    xpgain = memory.read_s16_le(tonumber("0x0241F0")) -- actual xp var
    xptext = memory.read_s16_le(tonumber("0x022F7C")) -- xp text as appears on screen

    -- If the two vars are the same, it means that a pokemon is about to get exp
    if xpgain == xptext then
        newxp = xpgain * expmultiplier
        -- Pokemon exp gain is a signed int for whatever reason
        -- We don't want to accidently have a negative number
        if newxp < 1 or newxp > 32767 then
            print_everywhere("Exp overflow, setting to max value")
            newxp = 32767
        end
        print_everywhere("Boosting XP to: " .. tostring(newxp))
        
        -- Write Both Addresses, I had a reason for this that I forgot, works fine
        memory.write_s16_le(tonumber("0x0241F0"),newxp)
        -- memory.write_s16_le(tonumber("0x022F7C"),newxp)
	-- memory.write_s16_le(tonumber("0x02309C"),newxp) -- Related to xp but cursed
	-- memory.write_s16_le(tonumber("0x000060"),newxp) -- Related to xp but cursed

    end
    
	emu.frameadvance();
end
