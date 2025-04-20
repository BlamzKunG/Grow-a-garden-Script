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

tab.newToggle("Auto เก็บ", "เก็บผัก/ผลไม้ทั้งหมดในสวน", false, function(all)
    getgenv().all = all
    if all then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Ka1t.lua"))()
    end
end)
