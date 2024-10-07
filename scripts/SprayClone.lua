local player = game:GetService("Players").LocalPlayer
local character = player.Character
local humanoid = character:FindFirstChild("Humanoid")
local backpack = player.Backpack
local tools = backpack:GetChildren()
local cloneScale = 1
local convertedPos
local convertedRotation

local bodyParts = {
    Head = character:FindFirstChild("Head"),
    Torso = character:FindFirstChild("Torso"), -- or "UpperTorso" and "LowerTorso" for R6
    LeftArm = character:FindFirstChild("Left Arm"),
    RightArm = character:FindFirstChild("Right Arm"),
    LeftLeg = character:FindFirstChild("Left Leg"),
    RightLeg = character:FindFirstChild("Right Leg"),
}
-- Disable & ReEnable Animation Script & Apply updates
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local animateScript = character:WaitForChild("Animate")
local toolNoneAnimation = animateScript:WaitForChild("toolnone"):FindFirstChildOfClass("Animation")
toolNoneAnimation.AnimationId = "rbxassetid://1234567890"