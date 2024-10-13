local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local leftArm = character:FindFirstChild("Left Arm") or character:FindFirstChild("LeftUpperArm") -- R6 or R15
local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso") -- R6 or R15
local backpack = player.Backpack
local animateScript = character:WaitForChild("Animate")
local toolNoneAnimation = animateScript:WaitForChild("toolnone"):FindFirstChildOfClass("Animation")
toolNoneAnimation.AnimationId = "rbxassetid://1234567890"

-- Function to update the tool's grip position
local function updateToolGrip(tool)
    if not tool:IsA("Tool") or not tool:FindFirstChild("Handle") then
        return
    end

    -- Get the relative CFrame of the left arm to the torso
    local relativeLeftArmCFrame = torso.CFrame:inverse() * leftArm.CFrame

    -- Update the tool's grip to match the left arm's relative CFrame
    tool.Grip = relativeLeftArmCFrame

    -- Equip and unequip the tool to reflect changes
    humanoid:UnequipTools()
    humanoid:EquipTool(tool)
end

-- Function to handle updating all tools in the backpack
local function updateAllTools()
    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") then
            updateToolGrip(tool)
        end
    end
end

-- Continuously update the grip position based on the left arm
game:GetService("RunService").RenderStepped:Connect(function()
    updateAllTools()
end)

-- Handle when a new tool is added to the backpack
backpack.ChildAdded:Connect(function(child)
    if child:IsA("Tool") then
        updateToolGrip(child)
    end
end)
