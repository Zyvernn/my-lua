local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- UI Setup
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "FreezeTradeUI"

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 300, 0, 400)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.BackgroundTransparency = 0
Instance.new("UICorner", mainFrame)

-- Title
local title = Instance.new("TextLabel", mainFrame)
title.Text = "🔒 Trade Freeze"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 24
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(0, 0, 0)

-- Player List Label
local selectLabel = Instance.new("TextLabel", mainFrame)
selectLabel.Text = "Select Player:"
selectLabel.Font = Enum.Font.SourceSans
selectLabel.TextSize = 18
selectLabel.Position = UDim2.new(0, 10, 0, 50)
selectLabel.Size = UDim2.new(1, -20, 0, 30)
selectLabel.BackgroundTransparency = 1
selectLabel.TextColor3 = Color3.fromRGB(0, 0, 0)

-- Scrolling Player List
local playerList = Instance.new("ScrollingFrame", mainFrame)
playerList.Position = UDim2.new(0, 10, 0, 85)
playerList.Size = UDim2.new(1, -20, 0, 120)
playerList.CanvasSize = UDim2.new(0, 0, 0, 0)
playerList.ScrollBarThickness = 6
playerList.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
playerList.BorderSizePixel = 0

local listLayout = Instance.new("UIListLayout", playerList)
listLayout.Padding = UDim.new(0, 5)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Freeze Button
local freezeButton = Instance.new("TextButton", mainFrame)
freezeButton.Text = "❄️ Freeze Trade"
freezeButton.Font = Enum.Font.SourceSansBold
freezeButton.TextSize = 20
freezeButton.Size = UDim2.new(1, -20, 0, 40)
freezeButton.Position = UDim2.new(0, 10, 0, 215)
freezeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
freezeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", freezeButton)

-- Loading Bar Background
local loadingBack = Instance.new("Frame", mainFrame)
loadingBack.Size = UDim2.new(1, -20, 0, 20)
loadingBack.Position = UDim2.new(0, 10, 0, 265)
loadingBack.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
Instance.new("UICorner", loadingBack)

-- Loading Bar Fill
local loadingFill = Instance.new("Frame", loadingBack)
loadingFill.Size = UDim2.new(0, 0, 1, 0)
loadingFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
loadingFill.BorderSizePixel = 0
Instance.new("UICorner", loadingFill)

-- Status Label
local statusLabel = Instance.new("TextLabel", mainFrame)
statusLabel.Text = ""
statusLabel.Font = Enum.Font.SourceSansItalic
statusLabel.TextSize = 20
statusLabel.Position = UDim2.new(0, 10, 0, 295)
statusLabel.Size = UDim2.new(1, -20, 0, 30)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(0, 170, 0)
statusLabel.Visible = false

-- Attribution
local credit = Instance.new("TextLabel", mainFrame)
credit.Text = "👤 Made By KentNeedProfits"
credit.Font = Enum.Font.SourceSans
credit.TextSize = 14
credit.Position = UDim2.new(0, 10, 1, -30)
credit.Size = UDim2.new(1, -20, 0, 20)
credit.BackgroundTransparency = 1
credit.TextColor3 = Color3.fromRGB(100, 100, 100)

-- Script Logic
local selectedPlayer = nil

local function updatePlayerList()
	playerList:ClearAllChildren()
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= player then
			local btn = Instance.new("TextButton")
			btn.Size = UDim2.new(1, 0, 0, 30)
			btn.Text = p.Name
			btn.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
			btn.TextColor3 = Color3.fromRGB(0, 0, 0)
			btn.Font = Enum.Font.SourceSans
			btn.TextSize = 16
			btn.Parent = playerList

			btn.MouseButton1Click:Connect(function()
				selectedPlayer = p
				selectLabel.Text = "Selected: " .. p.Name
			end)
		end
	end
	playerList.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
end

updatePlayerList()
Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)

freezeButton.MouseButton1Click:Connect(function()
	if not selectedPlayer then
		statusLabel.Text = "⚠️ No player selected!"
		statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
		statusLabel.Visible = true
		return
	end

	statusLabel.Visible = false
	freezeButton.Active = false
	freezeButton.Text = "Freezing..."

	for i = 1, 10 do
		local percent = i / 10
		loadingFill:TweenSize(UDim2.new(percent, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 1, true)
		wait(1)
	end

	statusLabel.Text = "✅ Trade Frozen"
	statusLabel.TextColor3 = Color3.fromRGB(0, 170, 0)
	statusLabel.Visible = true
	freezeButton.Text = "❄️ Freeze Trade"
	loadingFill.Size = UDim2.new(0, 0, 1, 0)
	freezeButton.Active = true
end)