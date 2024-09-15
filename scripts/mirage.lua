-- LocalScript

-- Variables
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")

-- Create the part
local function createPart()
    local part = Instance.new("Part")
    part.Size = Vector3.new(2, 2, 2)  -- Size of the part
    part.Position = humanoidRootPart.Position + Vector3.new(5, 0, 0)  -- Position to the right of the player
    part.Anchored = true
    part.CanCollide = false
    part.BrickColor = BrickColor.new("Bright red")  -- Set color to easily identify the part
    part.Parent = workspace
    return part
end

-- Update the part's position relative to the player
local function updatePartPosition(part)
    local offset = Vector3.new(5, 0, 0)  -- Offset from the player's position
    part.Position = humanoidRootPart.Position + offset
end

-- Update the camera every frame
local function updateCamera(part)
    -- Calculate the new camera CFrame
    local partPosition = part.Position
    local cameraOffset = Vector3.new(0, 5, -10)  -- Adjust camera position relative to the part
    local newCameraCFrame = CFrame.new(partPosition + cameraOffset, partPosition)
    
    -- Update the camera CFrame but allow manual control
    camera.CameraType = Enum.CameraType.Scriptable
    camera.CFrame = newCameraCFrame
end

-- Main function
local function main()
    local part = createPart()

    -- Update the part position and camera every frame
    RunService.RenderStepped:Connect(function()
        updatePartPosition(part)
        updateCamera(part)
    end)
end

main()
