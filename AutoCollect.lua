getgenv().AutoCollect = true

local collectDelay = 0.01
local VirtualInputManager = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- จำลองการกด E
local function pressE()
    for i = 1, 2 do
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
        task.wait(0.01)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
        task.wait(0.01)
    end
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
                return true
            end
        end
    end
    return false
end

-- สลับลำดับสุ่ม
local function shuffle(tbl)
    for i = #tbl, 2, -1 do
        local j = math.random(i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
    return tbl
end

-- เริ่มล็อกกล้องครั้งแรก
lockCameraToFarm()

-- ตารางเก็บรายชื่อต้นไม้ที่ยังไม่เก็บ
local unvisitedPlants = {}

-- ฟังก์ชันรีเฟรชลิสต์ต้นไม้ใหม่
local function refreshPlants()
    local farms = workspace:WaitForChild("Farm"):GetChildren()
    for _, farm in ipairs(farms) do
        local success, owner = pcall(function()
            return farm.Important.Data.Owner.Value
        end)

        if success and owner == LocalPlayer.Name then
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

                unvisitedPlants = shuffle(allPlants)
            end
        end
    end
end

-- เรียกครั้งแรก
refreshPlants()

-- ฟังก์ชันหลัก
task.spawn(function()
    while getgenv().AutoCollect do
        pcall(function()
            local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local root = character:WaitForChild("HumanoidRootPart")

            if #unvisitedPlants == 0 then
                refreshPlants()
            end

            local currentPlant = table.remove(unvisitedPlants) -- ดึงต้นปัจจุบัน

            if currentPlant and currentPlant:IsDescendantOf(workspace) then
                local originalPos = root.Position
                root.CFrame = currentPlant.CFrame + Vector3.new(0, 0, 0)
                task.wait(0.01)
                pressE()
                task.wait(collectDelay)
                root.CFrame = CFrame.new(originalPos)
            end
        end)

        task.wait(0.01)
    end
    Camera.CameraType = Enum.CameraType.Custom
end)
