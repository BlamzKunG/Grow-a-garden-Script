loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/Gagg/refs/heads/main/Ulcmgl.lua"))()

local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()
local window = DrRayLibrary:Load("TikTok:Lxxuak", "Default")

local tab = DrRayLibrary.newTab("Main", "ImageIdHere")
local tab2 = DrRayLibrary.newTab("Auto Farm", "ImageIdHere")
local tab3 = DrRayLibrary.newTab("Other", "ImageIdHere")
--loadstring(game:HttpGet(""))()

tab.newButton("ขายทั้งหมด", "ขายของในตัวทั้งหมด", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/Gagg/refs/heads/main/Sellall.lua"))()
end)

--ต่อไปกันงง##########################

tab.newToggle("Auto เก็บของรอบตัว", "เก็บผัก/ผลไม้ทั้งหมดในสวนเร็วมาก", false, function(AutoCollect)
    getgenv().AutoCollect = AutoCollect
    if AutoCollect then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/Gagg/refs/heads/main/AutoCollect.lua"))()
    end
end)

tab.newDropdown("วาร์ป", "เลือกจุดวาร์ป", {"Quest", "Event"}, function(selectedOption)
    print(selectedOption)

    if selectedOption == "Quest" then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/Gagg/refs/heads/main/Tpq.lua"))()
    elseif selectedOption == "Easter" then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/Gagg/refs/heads/main/Tpe.lua"))()
    end
end)

--ต่อไปกันงง##########################

tab2.newToggle("Auto ฟาร์ม", "เก็บผัก/ผลไม้ทั้งหมดในสวน + ขายของทั้งหมด", false, function(FullAutoFarm)
    getgenv().FullAutoFarm = FullAutoFarm
    if FullAutoFarm then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/Gagg/refs/heads/main/Kak.lua"))()
    end
end)

--ต่อไปกันงง##########################

tab3.newSlider("Speed Hack", "ปรับความเร็วตัวละคร", 100, false, function(num)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = num
        print("ความเร็วที่ตั้งไว้:", num)
    end
end)
