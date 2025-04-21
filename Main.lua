loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/Gagg/refs/heads/main/Ulcmgl.lua"))()

local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()
local window = DrRayLibrary:Load("TikTok:Lxxuak", "Default")

local tab = DrRayLibrary.newTab("Main", "ImageIdHere")
local tab2 = DrRayLibrary.newTab("Auto Farm", "ImageIdHere")
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

tab.newToggle("Auto ขายเมื่อของเต็ม", "ขายเมื่อของเต็ม", false, function(AutoSell)
    getgenv().AutoSell = AutoSell
    if AutoSell then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/Gagg/refs/heads/main/AutoSell.lua"))()
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
