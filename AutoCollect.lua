getgenv().AutoCollect = true

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local collectDelay = 0.01

-- ตรวจว่าเป็นฟาร์มของเรา
local function isOwnedByPlayer(farm)
    local data = farm:FindFirstChild("Important") and farm.Important:FindFirstChild("Data")
    return data and data:FindFirstChild("Owner") and data.Owner.Value == LocalPlayer.Name
end

-- เก็บของอัตโนมัติ (วาร์ปไปยิง prompt)
local function collectAvailablePlants()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")

    for _, farm in ipairs(workspace:WaitForChild("Farm"):GetChildren()) do
        if isOwnedByPlayer(farm) then
            local phys = farm:FindFirstChild("Important") and farm.Important:FindFirstChild("Plants_Physical")
            if phys then
                for _, prompt in ipairs(phys:GetDescendants()) do
                    if not getgenv().AutoCollect then return end
                    if prompt:IsA("ProximityPrompt") and prompt.Enabled then
                        local orig = root.Position
                        root.CFrame = prompt.Parent.CFrame
                        task.wait(0.05)
                        fireproximityprompt(prompt)
                        task.wait(collectDelay)
                        root.CFrame = CFrame.new(orig)
                    end
                end
            end
        end
    end
end

-- เรียกใช้ใน loop ของคุณเอง
task.spawn(function()
    while true do
        if not getgenv().AutoCollect then break end
        pcall(collectAvailablePlants)
        task.wait(0.1)
    end
end)
