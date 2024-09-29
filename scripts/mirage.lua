local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")

local isMirageActive = false
local mirageDistance = 2
local mirageSpeed = 0.05

local direction = 1

local function startSpeedMirage()
    if isMirageActive then return end
    isMirageActive = true

    local mirageConnection
    mirageConnection = runService.RenderStepped:Connect(function(deltaTime)
        if not isMirageActive then
            mirageConnection:Disconnect()
            return
        end

        humanoidRootPart.CFrame = humanoidRootPart.CFrame * CFrame.new(mirageDistance * direction, 0, 0)
        direction = direction * -1
        wait(mirageSpeed)
    end)
end

local function stopSpeedMirage()
    isMirageActive = false
end

userInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.M then
        if isMirageActive then
            stopSpeedMirage()
        else
            startSpeedMirage()
        end
    end
end)
