loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/Gagg/refs/heads/main/Ulcmgl.lua"))()

local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()
local window = DrRayLibrary:Load("TikTok:Lxxuak", "Default")

local tab = DrRayLibrary.newTab("Main", "ImageIdHere")
--loadstring(game:HttpGet(""))()

tab.newButton("Kill All", "Kill all players", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/KA_N.lua"))()
end)

tab.newToggle("Auto ฟาร์ม", "เก็บผัก/ผลไม้ทั้งหมดในสวน + ขายของทั้งหมด", false, function(FullAutoFarm)
    getgenv().FullAutoFarm = FullAutoFarm
    if FullAutoFarm then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/KA_N.lua"))()
    end
end)
