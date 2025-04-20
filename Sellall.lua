local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")

-- บันทึกตำแหน่งเดิม
local originalPos = root.Position

-- วาร์ปไปยังจุด Sell
local sellPos = Vector3.new(61, 2, 0)
root.CFrame = CFrame.new(sellPos + Vector3.new(0, 3, 0)) -- ขยับขึ้นเล็กน้อย

-- รอให้วาร์ปเสร็จ
task.wait(0.3)

-- ยิง RemoteEvent ขายของ
ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("Sell_Inventory"):FireServer()

-- กลับตำแหน่งเดิม
task.wait(0.3)
root.CFrame = CFrame.new(originalPos)
