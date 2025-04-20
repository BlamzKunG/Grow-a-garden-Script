local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- บันทึกตำแหน่งเดิม
local originalPos = humanoidRootPart.Position

-- วาร์ปไปยังจุดขาย (แก้ตำแหน่งตามที่เคยได้มา)
local sellPos = Vector3.new(61, 2, 0)
humanoidRootPart.CFrame = CFrame.new(sellPos + Vector3.new(0, 3, 0)) -- ลอยขึ้นเล็กน้อย

-- รอโหลดให้แน่ใจว่าใกล้พ่อค้าแล้ว
task.wait(0.4)

-- กดปุ่ม E เพื่อ Sell
local VirtualInputManager = game:GetService("VirtualInputManager")
VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)

-- กลับตำแหน่งเดิม
task.wait(0.3)
humanoidRootPart.CFrame = CFrame.new(originalPos)
