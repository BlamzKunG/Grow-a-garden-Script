local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()
local window = DrRayLibrary:Load("TikTok:Lxxuak", "Default")

local tab = DrRayLibrary.newTab("Main", "ImageIdHere")
--loadstring(game:HttpGet(""))()

tab.newToggle("Kill All", "Kill All Players", false, function(KillAllEnabled)
    getgenv().KillAllEnabled = KillAllEnabled
    if KillAllEnabled then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/KA_N.lua"))()
    end
end)
