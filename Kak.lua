getgenv().FullAutoFarm = true

local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Camera            = workspace.CurrentCamera
local LocalPlayer       = Players.LocalPlayer

local collectDelay       = 0.01
local autoFarmCycleTime  = 30
local sellPos            = Vector3.new(61, 2, 0) -- ตำแหน่งพ่อค้า

local isSelling = false

-- ตรวจว่าเป็นฟาร์มของเรา
local function isOwnedByPlayer(farm)
    local data = farm:FindFirstChild("Important") and farm.Important:FindFirstChild("Data")
    return data and data:FindFirstChild("Owner") and data.Owner.Value == LocalPlayer.Name
end

-- ล็อกกล้องไปที่ Owner_Tag
local function lockCameraToFarm()
    for _, farm in ipairs(workspace:WaitForChild("Farm"):GetChildren()) do
        if isOwnedByPlayer(farm) then
            local tag = farm:FindFirstChild("Owner_Tag")
            if tag then
                Camera.CameraType = Enum.CameraType.Scriptable
                Camera.CFrame = CFrame.new(tag.Position + Vector3.new(0,10,0), tag.Position)
                return
            end
        end
    end
end

-- เก็บของอัตโนมัติ (วาร์ปไปยิง prompt)
local function collectAvailablePlants()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")

    for _, farm in ipairs(workspace.Farm:GetChildren()) do
        if isOwnedByPlayer(farm) then
            local phys = farm:FindFirstChild("Important") and farm.Important:FindFirstChild("Plants_Physical")
            if phys then
                for _, prompt in ipairs(phys:GetDescendants()) do
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

-- ฟังก์ชันขายของ
local function sellAll()
    isSelling = true

    -- วาร์ปไปพ่อค้า
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    local orig = root.Position

    root.CFrame = CFrame.new(sellPos + Vector3.new(0,3,0))
    task.wait(0.3)

    -- ยิง RemoteEvent ขายของ
    ReplicatedStorage:WaitForChild("GameEvents")
                     :WaitForChild("Sell_Inventory")
                     :FireServer()

    -- กลับตำแหน่งเดิม
    task.wait(1)
    root.CFrame = CFrame.new(orig)

    -- ปลดล็อคกล้อง
    Camera.CameraType = Enum.CameraType.Custom

    isSelling = false
end

-- เริ่มต้น
lockCameraToFarm()

-- ลูปเก็บของ (หยุดชั่วคราวขณะขาย)
task.spawn(function()
    while true do
        if getgenv().FullAutoFarm and not isSelling then
            pcall(collectAvailablePlants)
        end
        task.wait(0.1)
    end
end)

-- ลูปขายของทุกรอบ
task.spawn(function()
    while true do
        task.wait(autoFarmCycleTime)
        if getgenv().FullAutoFarm then
            pcall(sellAll)
            -- หลังขายเสร็จ รี-Lock กล้องให้ลงฟาร์มต่อ
            lockCameraToFarm()
        end
    end
end)
