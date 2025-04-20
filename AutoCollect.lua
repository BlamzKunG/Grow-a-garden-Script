getgenv().AutoCollect = true

local collectDelay = 0.01
local VirtualInputManager = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
-- c
-- จำลองการกด E
local function pressE()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.01)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end

-- ล็อกกล้องไปยัง Owner_Tag ของฟาร์มเรา
local function lockCameraToFarm()
    local farms = workspace:WaitForChild("Farm"):GetChildren()
    for _, farm in ipairs(farms) do
        local data = farm:FindFirstChild("Important") and farm.Important:FindFirstChild("Data")
        if data and data:FindFirstChild("Owner") and data.Owner.Value == LocalPlayer.Name then
            local ownerTag = farm:FindFirstChild("Owner_Tag")
            if ownerTag then
                Camera.CameraType = Enum.CameraType.Scriptable
                Camera.CFrame = CFrame.new(ownerTag.Position + Vector3.new(0, 10, 0), ownerTag.Position)
            end
        end
    end
end

-- ฟังก์ชันสลับลำดับแบบสุ่ม
local function shuffle(tbl)
    for i = #tbl, 2, -1 do
        local j = math.random(i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
    return tbl
end

-- เริ่มล็อกกล้องครั้งแรก
lockCameraToFarm()

-- ฟังก์ชันหลัก
task.spawn(function()
    while getgenv().AutoCollect do
        pcall(function()
            local playerName = LocalPlayer.Name
            local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local root = character:WaitForChild("HumanoidRootPart")
            local farms = workspace:WaitForChild("Farm"):GetChildren()

            for _, farm in ipairs(farms) do
                local success, owner = pcall(function()
                    return farm.Important.Data.Owner.Value
                end)

                if success and owner == playerName then
                    local physical = farm.Important:FindFirstChild("Plants_Physical")
                    if physical then
                        local allPlants = {}

                        for _, folder in ipairs(physical:GetChildren()) do
                            for _, plant in ipairs(folder:GetChildren()) do
                                if plant:IsA("BasePart") then
                                    table.insert(allPlants, plant)
                                end
                            end
                        end

                        -- สุ่มลำดับ
                        local randomized = shuffle(allPlants)

                        for _, plant in ipairs(randomized) do
                            if not getgenv().AutoCollect then break end
                            local prompt = plant:FindFirstChildOfClass("ProximityPrompt")
                            if prompt and prompt.Enabled then
                                local originalPos = root.Position
                                root.Anchored = true
                                root.CFrame = plant.CFrame + Vector3.new(0, 3, 0)
                                task.wait(0.01)
                                pressE()
                                task.wait(collectDelay)
                                root.CFrame = CFrame.new(originalPos)
                                root.Anchored = false
                            end
                        end
                    end
                end
            end
        end)

        -- ปลดล็อกกล้องในทุก ๆ รอบ
        Camera.CameraType = Enum.CameraType.Custom
        task.wait(0.01)
    end
end)
