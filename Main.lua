loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Cr.lua"))()
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()
local window = DrRayLibrary:Load("TikTok:Lxxuak", "Default")

local tab = DrRayLibrary.newTab("Main", "ImageIdHere")

--loadstring(game:HttpGet(""))()

tab.newToggle("ขายทั้งหมด", "ขายของในตัวทั้งหมดทุก 10 วินาที", false, function(all)
    getgenv().all = all
    if all then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Ka1t.lua"))()
    end
end)

--ต่อไปกันงง############################

tab.newToggle("Auto เก็บ", "เก็บผัก/ผลไม้ทั้งหมดในสวน", false, function(AutoCollect)
    getgenv().AutoCollect = AutoCollect
    if AutoCollect then
        -- ระบบเปิดปิด
getgenv().AutoCollect = true

-- ตั้งค่าระยะเวลาในการวนลูป
local collectDelay = 0.2

-- ฟังก์ชันจำลองการกด E
local VirtualInputManager = game:GetService("VirtualInputManager")

local function pressE()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.05)
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
                                        task.wait(0.1)
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
        task.wait(1)
    end
end)
    end
end)

--ต่อไปกันงง##########################
