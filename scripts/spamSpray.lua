local Workspace = game:GetService("Workspace")
local Handle = Workspace:FindFirstChild('Handle')
local player = game:GetService('Players').LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

while true do
    local torso = char:FindFirstChild("Torso")
    if Handle and torso then
        firetouchinterest(torso, Handle, 0)
        firetouchinterest(torso, Handle, 1)
    else
        print("Handle or Torso not found")
    end

    local spray = char:WaitForChild('Spray') or player.Backpack:WaitForChild('Spray')

    if spray then
        spray.Parent = Workspace
    else
        print('Spray not found')
        break
    end
end