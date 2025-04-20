getgenv().AutoCollect = true

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- กดปุ่ม E
local function pressE()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end

-- ฟังก์ชันหลัก
task.spawn(function()
    while getgenv().AutoCollect do
        pcall(function()
            character = player.Character or player.CharacterAdded:Wait()
            humanoidRootPart = character:WaitForChild("HumanoidRootPart")
            local originalPos = humanoidRootPart.Position

            local farms = workspace:WaitForChild("Farm"):GetChildren()
            for _, farm in ipairs(farms) do
                local data = farm:FindFirstChild("Important") and farm.Important:FindFirstChild("Data")
                if data and data:FindFirstChild("Owner") and data.Owner.Value == player.Name then
                    local physical = farm.Important:FindFirstChild("Plants_Physical")
                    if physical then
                        for _, folder in ipairs(physical:GetChildren()) do
                            for _, plant in ipairs(folder:GetChildren()) do
                                if not getgenv().AutoCollect then return end
                                if plant:IsA("BasePart") and plant:IsDescendantOf(workspace) then
                                    humanoidRootPart.Anchored = true -- ล็อกตัวไว้ไม่ให้กระเด้ง
                                    humanoidRootPart.CFrame = plant.CFrame + Vector3.new(0, 3, 0)
                                    task.wait(0.05)
                                    pressE()
                                    task.wait(0.05)
                                end
                            end
                        end
                    end
                end
            end

            humanoidRootPart.CFrame = CFrame.new(originalPos)
            humanoidRootPart.Anchored = true -- ปลดล็อกตัว
        end)
        task.wait(0.1)
    end
end)
