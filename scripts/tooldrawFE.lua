--AFFEXTER BABY


local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FEDraw By Affexter"
screenGui.ResetOnSpawn = true
screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 600, 0, 450)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -225)
mainFrame.BackgroundColor3 = Color3.new(1, 1, 1)
mainFrame.BorderSizePixel = 2
mainFrame.Parent = screenGui

local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
titleBar.Parent = mainFrame

local titleText = Instance.new("TextLabel")
titleText.Name = "TitleText"
titleText.Size = UDim2.new(1, -60, 1, 0)
titleText.Position = UDim2.new(0, 10, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "ToolDraw FE By Affexter"
titleText.Font = Enum.Font.SourceSansBold
titleText.TextColor3 = Color3.new(1, 1, 1)
titleText.TextSize = 18
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
closeButton.Text = "X"
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.TextSize = 18
closeButton.Parent = titleBar

local drawingArea = Instance.new("Frame")
drawingArea.Name = "DrawingArea"
drawingArea.Size = UDim2.new(1, -20, 1, -70)
drawingArea.Position = UDim2.new(0, 10, 0, 40)
drawingArea.BackgroundColor3 = Color3.new(0.95, 0.95, 0.95)
drawingArea.BorderSizePixel = 1
drawingArea.ClipsDescendants = true
drawingArea.Parent = mainFrame

local resetButton = Instance.new("TextButton")
resetButton.Name = "ResetButton"
resetButton.Size = UDim2.new(0, 80, 0, 25)
resetButton.Position = UDim2.new(1, -90, 1, -35)
resetButton.BackgroundColor3 = Color3.new(0.2, 0.6, 1)
resetButton.Text = "Reset"
resetButton.Font = Enum.Font.SourceSansBold
resetButton.TextColor3 = Color3.new(1, 1, 1)
resetButton.TextSize = 14
resetButton.Parent = mainFrame

local Character = Players.LocalPlayer.Character
local animate = Character:FindFirstChild('Animate')
if animate then
    animate:Destroy()
end

local function createPixel(position)
    local pixel = Instance.new("Frame")
    pixel.Size = UDim2.new(0, 5, 0, 5)
    pixel.Position = UDim2.new(0, position.X - 2, 0, position.Y - 2)
    pixel.BackgroundColor3 = Color3.new(0, 0, 0)
    pixel.BorderSizePixel = 0
    pixel.Parent = drawingArea
    return position
end

local player = game:GetService('Players').LocalPlayer
local char = player.Character

local function treeDraw(pos)
    local tools = player.Backpack:GetChildren()

    if #tools > 0 then
        local tool = tools[1]

        if tool:FindFirstChild("Handle") then
            local ls = tool:WaitForChild('LocalScript')

            if ls then
                ls:Destroy()
            end

            tool.Parent = char

            local gripOffset = Vector3.new(pos.X / 10, 0, pos.Y / 10)

            tool.Grip = CFrame.new(gripOffset)

            local rotation = CFrame.Angles(math.rad(90), 0, 0)
            tool.Grip = tool.Grip * rotation
        end
    else
        warn("No tools found in backpack.")
    end
end




local function handleDrawing(input)
    local position = Vector2.new(
        input.Position.X - drawingArea.AbsolutePosition.X,
        input.Position.Y - drawingArea.AbsolutePosition.Y
    )
    if position.X >= 0 and position.X <= drawingArea.AbsoluteSize.X and
       position.Y >= 0 and position.Y <= drawingArea.AbsoluteSize.Y then
        createPixel(position)
        treeDraw(position)
    end
end


local drawing = false

drawingArea.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or
       input.UserInputType == Enum.UserInputType.Touch then
        drawing = true
        handleDrawing(input)
    end
end)

drawingArea.InputChanged:Connect(function(input)
    if drawing and (input.UserInputType == Enum.UserInputType.MouseMovement or
                    input.UserInputType == Enum.UserInputType.Touch) then
        handleDrawing(input)
    end
end)

drawingArea.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or
       input.UserInputType == Enum.UserInputType.Touch then
        drawing = false
    end
end)

local dragging
local dragStart
local startPos

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or
       input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or
                     input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or
       input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

resetButton.MouseButton1Click:Connect(function()
    for _, child in pairs(drawingArea:GetChildren()) do
        child:Destroy()
    end
end)