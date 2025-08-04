-- Trade Freeze GUI Script
-- Author: YOUR_NAME

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TradeFreezeGui"
ScreenGui.Parent = PlayerGui

-- Create draggable frame
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 250, 0, 150)
Frame.Position = UDim2.new(0.5, -125, 0.5, -75)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true -- Frame is movable
Frame.Parent = ScreenGui

-- Round the frame
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Frame

-- Title Label
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "🔒 Trade Freeze"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = Frame

-- Freeze Button
local FreezeButton = Instance.new("TextButton")
FreezeButton.Size = UDim2.new(0.8, 0, 0, 40)
FreezeButton.Position = UDim2.new(0.1, 0, 0.3, 0)
FreezeButton.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
FreezeButton.Text = "❄ Freeze Trade"
FreezeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FreezeButton.TextScaled = true
FreezeButton.Font = Enum.Font.GothamBold
FreezeButton.Parent = Frame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 8)
ButtonCorner.Parent = FreezeButton

-- Loading Bar
local LoadingBar = Instance.new("Frame")
LoadingBar.Size = UDim2.new(0, 0, 0, 10)
LoadingBar.Position = UDim2.new(0.1, 0, 0.65, 0)
LoadingBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
LoadingBar.BorderSizePixel = 0
LoadingBar.Visible = false
LoadingBar.Parent = Frame

local LoadingCorner = Instance.new("UICorner")
LoadingCorner.CornerRadius = UDim.new(0, 6)
LoadingCorner.Parent = LoadingBar

-- Animate loading bar
local function StartLoading()
    FreezeButton.Visible = false
    LoadingBar.Visible = true
    LoadingBar.Size = UDim2.new(0, 0, 0, 10)

    -- Animate for 10 seconds
    for i = 1, 100 do
        LoadingBar.Size = UDim2.new(i/100 * 0.8, 0, 0, 10) -- fills 80% width
        task.wait(0.1) -- 0.1 sec * 100 = 10 seconds
    end

    -- After loading
    LoadingBar.Visible = false
    FreezeButton.Visible = true
    FreezeButton.Text = "Trade Frozen!"
    FreezeButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    FreezeButton.AutoButtonColor = false -- disable hover effect
end

-- Button Click
FreezeButton.MouseButton1Click:Connect(function()
    if FreezeButton.Text == "❄ Freeze Trade" then
        StartLoading()
    end
end)