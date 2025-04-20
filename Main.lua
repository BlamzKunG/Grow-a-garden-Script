loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Cr.lua"))()
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()
local window = DrRayLibrary:Load("TikTok:Lxxuak", "Default")

local tab = DrRayLibrary.newTab("Main", "ImageIdHere")

--loadstring(game:HttpGet(""))()

tab.newButton("ขายทั้งหมด", "ขายของในตัวทั้งหมดทุก 10 วินาที", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/Gagg/refs/heads/main/Sellall.lua"))()
end)

--ต่อไปกันงง############################

tab.newToggle("Auto เก็บ", "เก็บผัก/ผลไม้ทั้งหมดในสวน", false, function(AutoCollect)
    getgenv().AutoCollect = AutoCollect
    if AutoCollect then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/Gagg/refs/heads/main/AutoCollect.lua"))()
    end
end)

--ต่อไปกันงง##########################
