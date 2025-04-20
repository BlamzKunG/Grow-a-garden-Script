-- ระบบเปิดปิด
getgenv().AutoCollect = true

-- ตั้งค่าระยะเวลาในการวนลูป
local collectDelay = 0.01

-- ฟังก์ชันจำลองการกด E
local VirtualInputManager = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

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
            local cam = workspace.CurrentCamera
            local ownerTag = farm:FindFirstChild("Owner_Tag")
            if ownerTag then
                cam.CameraType = Enum.CameraType.Scriptable
                cam.CFrame = CFrame.new(ownerTag.Position + Vector3.new(0, 10, 0), ownerTag.Position)
            end
        end
    end
end

-- เรียกตอนเริ่มต้นเพื่อกล้องล็อกที่ฟาร์มเรา
lockCameraToFarm()

-- ฟังก์ชันหลักในการเก็บ
task.spawn(function()
    while getgenv().AutoCollect do
        pcall(function()
            local playerName = LocalPlayer.Name
            local farms = workspace:WaitForChild("Farm"):GetChildren()
            local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local root = character:WaitForChild("HumanoidRootPart")

            for _, farm in ipairs(farms) do
                local success, owner = pcall(function()
                    return farm.Important.Data.Owner.Value
                end)

                if success and owner == playerName then
                    local physical = farm.Important:FindFirstChild("Plants_Physical")
                    if physical then
                        for _, folder in ipairs(physical:GetChildren()) do
                            for _, plant in ipairs(folder:GetChildren()) do
                                if getgenv().AutoCollect then
                                    -- เช็คว่ามี ProximityPrompt = เก็บได้
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
                                else
                                    return
                                end
                            end
                        end
                    end
                end
            end
        end)
        task.wait(0.01)
    end
end)
