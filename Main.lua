loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Cr.lua"))()
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()
local window = DrRayLibrary:Load("TikTok:Lxxuak", "Default")

local tab = DrRayLibrary.newTab("Main", "ImageIdHere")

--loadstring(game:HttpGet(""))()

tab.newButton("ขายทั้งหมด", "ขายของในตัวทั้งหมดทุก 10 วินาที", false, function(AutoSell)
    getgenv().AutoSell = AutoSell
    if AutoSell then
        getgenv().AutoSell = true

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SellRemote = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("Sell_Inventory")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- ตำแหน่งพ่อค้า Sell
local sellPosition = Vector3.new(61, 2, 0)

-- เวลาหน่วงก่อนกลับจุดเดิม (ไว้ให้ Remote ทำงาน)
local sellDelay = 1

-- ระยะห่างที่ใช้เทเลพอร์ต
local function teleportTo(position)
    hrp.CFrame = CFrame.new(position + Vector3.new(0, 3, 0)) -- ลอยขึ้นนิดหน่อย ป้องกันตกพื้น
end

task.spawn(function()
    while getgenv().AutoSell do
        pcall(function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                -- เก็บตำแหน่งเดิมไว้
                local originalPosition = hrp.Position

                -- เทเลพอร์ตไปตำแหน่งขายของ
                teleportTo(sellPosition)

                -- รอให้โหลดและให้เกมตรวจว่ามาอยู่ใกล้พ่อค้าแล้ว
                task.wait(0.5)

                -- ส่งคำสั่งขายของ
                SellRemote:FireServer()

                -- หน่วงให้ปลอดภัยก่อนวาร์ปกลับ
                task.wait(sellDelay)

                -- วาร์ปกลับตำแหน่งเดิม
                teleportTo(originalPosition)
            end
        end)
        task.wait(10) -- ความถี่ในการขายของ (ปรับได้)
    end
end)
    end
end)

--ต่อไปกันงง############################

tab.newToggle("Auto เก็บ", "เก็บผัก/ผลไม้ทั้งหมดในสวน", false, function(AutoCollect)
    getgenv().AutoCollect = AutoCollect
    if AutoCollect then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/Gagg/refs/heads/main/AutoCollect.lua"))()
    end
end)

--ต่อไปกันงง##########################
