-- UniversalCameraUnlocker.lua
local Camera = workspace.CurrentCamera
local heartbeat = game:GetService("RunService").Heartbeat

-- รายชื่อ flag ที่เกี่ยวกับงานออโต้
local flagsToCheck = {
    "FullAutoFarm",
    "AutoSell",
    "AutoClick",
    "AutoCollect",
    "AutoLoop",
    "AutoAttack",
    "AnyOtherFlagYouUse"
}

local function areAllFlagsFalse()
    for _, flagName in ipairs(flagsToCheck) do
        local flagValue = rawget(getgenv(), flagName)
        if flagValue == true then
            return false
        end
    end
    return true
end

-- ทำงานตลอดเวลา
task.spawn(function()
    while true do
        if areAllFlagsFalse() then
            if Camera.CameraType ~= Enum.CameraType.Custom then
                Camera.CameraType = Enum.CameraType.Custom
                print("[UniversalCameraUnlocker] Camera unlocked.")
            end
        end
        heartbeat:Wait()
    end
end)
