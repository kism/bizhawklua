-- Auto Savestate to a file

function main()
    -- Settings
    local saveinterval = 7200
    local path = "C:\\Temp\\"

    -- Dont touch
    local frame = 0
    local filename = ""
    local gamename = gameinfo.getromname()
    console.log("Starting auto savestate script")
    console.log("Saving to: " .. path)
    console.log("Saving every: " .. saveinterval .. " frames")
    console.log("This should be every: " .. tostring(saveinterval / 3600) .. " minutes")

    while true do
        frame = frame + 1
        if frame > saveinterval then
            filename = path .. gamename .. os.date(" %Y-%m-%d %H-%M-%S") .. ".state"
            console.log(filename)
            savestate.save(filename)
            frame = 0
        end
        emu.frameadvance()
    end
end

main()
