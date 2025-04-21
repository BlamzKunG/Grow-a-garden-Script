getgenv().AutoCollect = true

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local collectDelay = 0 -- ลดให้ต่ำสุด
local repeatTimes = 3 -- ยิงซ้ำ 3 รอบ
local parallelDelay = 0.002 -- ดีเลย์ระหว่าง task.spawn ป้องกัน lag

-- ตรวจว่าเป็นฟาร์มของเรา
local function isOwnedByPlayer(farm)
    local data = farm:FindFirstChild("Important") and farm.Important:FindFirstChild("Data")
    return data and data:FindFirstChild("Owner") and data.Owner.Value == LocalPlayer.Name
end

-- ยิง prompt แบบยิงรัว ยิงซ้ำ ยิงพร้อมกัน
local function collectAvailablePlants()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    local origPos = root.Position

    for _, farm in ipairs(workspace:WaitForChild("Farm"):GetChildren()) do
        if isOwnedByPlayer(farm) then
            local phys = farm:FindFirstChild("Important") and farm.Important:FindFirstChild("Plants_Physical")
            if phys then
                for _, prompt in ipairs(phys:GetDescendants()) do
                    if not getgenv().AutoCollect then return end
                    if prompt:IsA("ProximityPrompt") and prompt.Enabled then
                        task.spawn(function()
                            -- ยิงซ้ำหลายรอบ เผื่อ prompt ไม่ติด
                            for i = 1, repeatTimes do
                                if not getgenv().AutoCollect or not prompt.Enabled then break end
                                pcall(function()
                                    root.CFrame = prompt.Parent.CFrame
                                    task.wait(0.01)
                                    fireproximityprompt(prompt)
                                end)
                                task.wait(collectDelay)
                            end
                            root.CFrame = CFrame.new(origPos)
                        end)
                        task.wait(parallelDelay)
                    end
                end
            end
        end
    end
end

-- ลูปทำงานถี่ ๆ ตลอดเวลา
task.spawn(function()
    while getgenv().AutoCollect do
        pcall(collectAvailablePlants)
        task.wait(0.05) -- ถี่กว่าปกติ
    end
end)
