-- Animated Trade Freeze GUI
-- Author: YOUR_NAME

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
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
Frame.Draggable = true
Frame.Parent = ScreenGui

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

-- Center Message
local CenterMessage = Instance.new("TextLabel")
CenterMessage.Size = UDim2.new(1, 0, 1, 0)
CenterMessage.BackgroundTransparency = 1
CenterMessage.TextColor3 = Color3.fromRGB(255, 255, 255)
CenterMessage.TextScaled = true
CenterMessage.Font = Enum.Font.GothamBold
CenterMessage.Text = ""
CenterMessage.Visible = false
CenterMessage.Parent = Frame

-- Function to animate loading
local function StartLoading()
    -- Hide button and show loading bar
    FreezeButton.Visible = false
    LoadingBar.Visible = true

    -- Show center text
    CenterMessage.Visible = true
    CenterMessage.Text = "Freezing Trade..."
    CenterMessage.TextTransparency = 1

    -- Fade in text
    TweenService:Create(CenterMessage, TweenInfo.new(0.5), {TextTransparency = 0}):Play()

    -- Animate loading bar to fill 80% over 10 seconds
    local Tween = TweenService:Create(
        LoadingBar,
        TweenInfo.new(10, Enum.EasingStyle.Linear),
        {Size = UDim2.new(0.8, 0, 0, 10)}
    )
    Tween:Play()
    Tween.Completed:Wait()

    -- After loading, show Trade Frozen!
    LoadingBar.Visible = false
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    CenterMessage.Text = "TRADE FROZEN!"
    CenterMessage.TextColor3 = Color3.fromRGB(0, 255, 0)
    
    -- Animate text pop effect
    CenterMessage.TextSize = 20
    TweenService:Create(CenterMessage, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextSize = 40}):Play()
end

-- Button Click
FreezeButton.MouseButton1Click:Connect(function()
    if FreezeButton.Text == "❄ Freeze Trade" then
        StartLoading()
    end
end)