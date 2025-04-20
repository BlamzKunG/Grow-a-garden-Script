-- ระบบเปิดปิด
getgenv().AutoCollect = true

-- ตั้งค่าระยะเวลาในการวนลูป
local collectDelay = 0.01

-- ฟังก์ชันจำลองการกด E
local VirtualInputManager = game:GetService("VirtualInputManager")

local function pressE()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.01)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end

-- ฟังก์ชันค้นหาและวาร์ปไปยังของที่สามารถเก็บได้
task.spawn(function()
    while getgenv().AutoCollect do
        pcall(function()
            local playerName = game.Players.LocalPlayer.Name
            local farms = workspace:WaitForChild("Farm"):GetChildren()

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
                                    local root = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                    if root and plant:IsA("BasePart") then
                                        local originalPos = root.Position
                                        root.CFrame = plant.CFrame + Vector3.new(0, 3, 0)
                                        task.wait(0.01)
                                        pressE()
                                        task.wait(collectDelay)
                                        root.CFrame = CFrame.new(originalPos)
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
