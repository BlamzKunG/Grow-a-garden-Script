-- 🥕 Auto Buy Seeds
getgenv().AutoBuySeeds = true
local seeds = {
    "Carrot", "Strawberry", "Blueberry", "Orange Tulip", "Tomato", "Corn",
    "Daffodil", "Watermelon", "Pumpkin", "Apple", "Bamboo", "Coconut",
    "Cactus", "Dragon Fruit", "Mango", "Mushroom", "Grape", "Pepper",
    "Cacao", "Beanstalk", "Ember Lily"
}
local buySeed = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuySeedStock")
spawn(function()
    while getgenv().AutoBuySeeds do
        for _, seed in ipairs(seeds) do
            buySeed:FireServer(seed)
            wait(0.3)
        end
    end
end)

-- 🛠️ Auto Buy Gear
getgenv().AutoBuyGear = true
local gears = {
    "Watering Can", "Trowel", "Recall Wrench", "Basic Sprinkler",
    "Advanced Sprinkler", "Godly Sprinkler", "Master Sprinkler", "Harvest Tool", "Lightning Rod"
}
local buyGear = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyGearStock")
spawn(function()
    while getgenv().AutoBuyGear do
        for _, gear in ipairs(gears) do
            buyGear:FireServer(gear)
            wait(0.3)
        end
    end
end)

-- 🐝 Auto Buy Event Shop Items
getgenv().AutoBuyEventItems = true
local eventItems = { "Flower Seed Pack", "Honey Sprinkler", "Bee Egg" }
local buyEvent = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyEventShopStock")
spawn(function()
    while getgenv().AutoBuyEventItems do
        for _, item in ipairs(eventItems) do
            buyEvent:FireServer(item)
            wait(0.3)
        end
    end
end)
