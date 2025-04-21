getgenv().FullAutoFarm = true

local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Camera            = workspace.CurrentCamera
local LocalPlayer       = Players.LocalPlayer

local collectDelay      = 0.01
local collectLimit      = 50 -- วนเก็บ 200 ครั้งก่อนขาย
local sellPos           = Vector3.new(61, 2, 0) -- ตำแหน่งพ่อค้า

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
        if isSelling then return end -- หยุดทันทีถ้ากำลังขาย
        if isOwnedByPlayer(farm) then
            local phys = farm:FindFirstChild("Important") and farm.Important:FindFirstChild("Plants_Physical")
            if phys then
                for _, prompt in ipairs(phys:GetDescendants()) do
                    if isSelling then return end
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
    task.wait(0.5)
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local root = character:WaitForChild("HumanoidRootPart")
    local originalPos = root.Position

    -- วาร์ปไปขาย
    root.CFrame = CFrame.new(sellPos + Vector3.new(0, 3, 0))
    task.wait(0.5)

    -- ยิง Remote
    ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("Sell_Inventory"):FireServer()

    -- กลับ
    task.wait(2)
    root.CFrame = CFrame.new(originalPos)

    isSelling = false
end

-- เริ่มต้นล็อกกล้อง
lockCameraToFarm()

-- ลูปหลัก: วนเก็บ 200 ครั้งแล้วขาย
task.spawn(function()
    while getgenv().FullAutoFarm do
        for i = 1, collectLimit do
            if not getgenv().FullAutoFarm then break end
            if not isSelling then
                pcall(collectAvailablePlants)
            end
            task.wait(0.1)
        end

        if not getgenv().FullAutoFarm then break end

        pcall(sellAll)
        lockCameraToFarm() -- ล็อกกล้องกลับหลังขาย
        task.wait(3)
    end

    -- ปลดล็อกกล้องหลังหยุดทำงาน
    Camera.CameraType = Enum.CameraType.Custom
end)
