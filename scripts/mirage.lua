
local player = game:GetService("Players").LocalPlayer
local Character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = Character:WaitForChild("HumanoidRootPart")

local position = humanoidRootPart.CFrame
local offset = position * CFrame.new(0, 0, 3)

local function mirage()
    humanoidRootPart.CFrame = offset
    
end

mirage()