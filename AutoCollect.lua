getgenv().AutoCollect = true

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local collectDelay = 0
local repeatTimes = 3
local parallelDelay = 0.002

-- ตรวจว่าเป็นฟาร์มของเรา
local function isOwnedByPlayer(farm)
    local data = farm:FindFirstChild("Important") and farm.Important:FindFirstChild("Data")
    return data and data:FindFirstChild("Owner") and data.Owner.Value == LocalPlayer.Name
end

-- เก็บของแบบไม่วาร์ป (ยิงจากที่ยืนอยู่)
local function collectAvailablePlants()
    for _, farm in ipairs(workspace:WaitForChild("Farm"):GetChildren()) do
        if isOwnedByPlayer(farm) then
            local phys = farm:FindFirstChild("Important") and farm.Important:FindFirstChild("Plants_Physical")
            if phys then
                for _, prompt in ipairs(phys:GetDescendants()) do
                    if not getgenv().AutoCollect then return end
                    if prompt:IsA("ProximityPrompt") and prompt.Enabled then
                        task.spawn(function()
                            for i = 1, repeatTimes do
                                if not getgenv().AutoCollect or not prompt.Enabled then break end
                                pcall(function()
                                    fireproximityprompt(prompt)
                                end)
                                task.wait(collectDelay)
                            end
                        end)
                        task.wait(parallelDelay)
                    end
                end
            end
        end
    end
end

-- ลูปทำงานตลอดเวลา
task.spawn(function()
    while getgenv().AutoCollect do
        pcall(collectAvailablePlants)
        task.wait(0.05)
    end
end)
