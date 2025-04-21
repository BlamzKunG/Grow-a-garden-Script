local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function teleportToPosition(pos)
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    root.CFrame = CFrame.new(pos)
end

teleportToPosition(Vector3.new(-99.49, 3.40, -4.48))
