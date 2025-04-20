getgenv().FullAutoFarm = true

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- ตั้งค่า
local collectDelay = 0.01
local autoFarmCycleTime = 30
 

-- กด E 3 ครั้ง
local function pressE()
	for i = 1, 3 do
		VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
		task.wait(0.01)
		VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
		task.wait(0.01)
	end
end

-- กล้องล็อกไปฟาร์มเรา
local function lockCameraToFarm()
	local farms = workspace:WaitForChild("Farm"):GetChildren()
	for _, farm in ipairs(farms) do
		local data = farm:FindFirstChild("Important") and farm.Important:FindFirstChild("Data")
		if data and data:FindFirstChild("Owner") and data.Owner.Value == LocalPlayer.Name then
			local ownerTag = farm:FindFirstChild("Owner_Tag")
			if ownerTag then
				Camera.CameraType = Enum.CameraType.Scriptable
				Camera.CFrame = CFrame.new(ownerTag.Position + Vector3.new(0, 10, 0), ownerTag.Position)
				return true
			end
		end
	end
	return false
end

-- สลับลำดับ
local function shuffle(tbl)
	for i = #tbl, 2, -1 do
		local j = math.random(i)
		tbl[i], tbl[j] = tbl[j], tbl[i]
	end
	return tbl
end

-- Sell All
local function sellAll()
	local player = Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local root = character:WaitForChild("HumanoidRootPart")
	local originalPos = root.Position

	-- วาร์ปไปขาย
	local sellPos = Vector3.new(61, 2, 0)
	root.CFrame = CFrame.new(sellPos + Vector3.new(0, 3, 0))
	task.wait(0.3)

	-- ยิง Remote
	ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("Sell_Inventory"):FireServer()

	-- กลับ
	task.wait(0.3)
	root.CFrame = CFrame.new(originalPos)
end

-- เก็บพืช
local unvisitedPlants = {}

local function refreshPlants()
	local farms = workspace:WaitForChild("Farm"):GetChildren()
	for _, farm in ipairs(farms) do
		local success, owner = pcall(function()
			return farm.Important.Data.Owner.Value
		end)

		if success and owner == LocalPlayer.Name then
			local physical = farm.Important:FindFirstChild("Plants_Physical")
			if physical then
				local allPlants = {}
				for _, folder in ipairs(physical:GetChildren()) do
					for _, plant in ipairs(folder:GetChildren()) do
						if plant:IsA("BasePart") then
							table.insert(allPlants, plant)
						end
					end
				end
				unvisitedPlants = shuffle(allPlants)
			end
		end
	end
end

-- เริ่มล็อกกล้อง
lockCameraToFarm()

-- Full AutoFarm Loop
task.spawn(function()
	while getgenv().FullAutoFarm do
		 
		local start = tick()

		while tick() - start < autoFarmCycleTime and getgenv().FullAutoFarm do
			pcall(function()
				local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
				local root = character:WaitForChild("HumanoidRootPart")

				if #unvisitedPlants == 0 then
					refreshPlants()
				end

				local currentPlant = table.remove(unvisitedPlants)
				if currentPlant and currentPlant:IsDescendantOf(workspace) then
					local originalPos = root.Position
					root.CFrame = currentPlant.CFrame
					task.wait(0.01)
					pressE()
					task.wait(collectDelay)
					root.CFrame = CFrame.new(originalPos)
				end
			end)
			task.wait(0.01)
		end

		getgenv().FullAutoFarm = false
		sellAll()
		task.wait(1)
	end
end)
