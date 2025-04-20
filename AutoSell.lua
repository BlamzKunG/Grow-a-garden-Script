getgenv().AutoSell = true -- เปลี่ยนเป็น false เพื่อหยุดระบบ

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

-- กำหนดจำนวนสูงสุด
local MAX_ITEMS = 200

-- ฟังก์ชันเช็คจำนวนไอเทม
local function getTotalItems()
	local total = 0

	local invFolder = LocalPlayer:FindFirstChild("Inventory")
	if invFolder then
		total += #invFolder:GetChildren()
	end

	local hotbarFolder = LocalPlayer:FindFirstChild("Hotbar")
	if hotbarFolder then
		total += #hotbarFolder:GetChildren()
	end

	return total
end

-- ฟังก์ชันขายไอเทม
local function sellAllItems()
	local sellEvent = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("Sell_Inventory")
	sellEvent:FireServer()
	print("[AutoSell] Inventory เต็ม - ทำการขายเรียบร้อย")
end

-- Loop ตรวจสอบ
task.spawn(function()
	while getgenv().AutoSell do
		pcall(function()
			local count = getTotalItems()
			if count >= MAX_ITEMS then
				sellAllItems()
			end
		end)
		task.wait(2)
	end
end)
