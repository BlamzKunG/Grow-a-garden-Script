local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()
local window = DrRayLibrary:Load("TikTok:Lxxuak", "Default")

local tab = DrRayLibrary.newTab("Main", "ImageIdHere")
--loadstring(game:HttpGet(""))()

tab.newToggle("Buy All", "Buy All", false, function(FullAutoFarm)
    getgenv().FullAutoFarm = FullAutoFarm
    if FullAutoFarm then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/Gagg/refs/heads/main/Kak.lua"))()
    end
end)
