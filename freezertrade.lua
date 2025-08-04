local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- 🖼️ UI Setup
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "MiniFreezeTradeUI"
gui.ResetOnSpawn = false

-- 🎯 Main Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 240, 0, 280)
frame.Position = UDim2.new(1, -250, 1, -290)
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui
Instance.new("UICorner", frame)

-- 🏷️ Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🔒 Freeze Trade"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(0, 0, 0)
title.BackgroundTransparency = 1

-- 🔁 Refresh Button
local refreshButton = Instance.new("TextButton", frame)
refreshButton.Size = UDim2.new(0, 80, 0, 25)
refreshButton.Position = UDim2.new(1, -90, 0, 35)
refreshButton.Text = "🔁 Refresh"
refreshButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
refreshButton.TextColor3 = Color3.fromRGB(0, 0, 0)
refreshButton.Font = Enum.Font.SourceSans
refreshButton.TextSize = 16
Instance.new("UICorner", refreshButton)

-- 📜 Player List Label
local playerListLabel = Instance.new("TextLabel", frame)
playerListLabel.Text = "Select Player:"
playerListLabel.Position = UDim2.new(0, 10, 0, 35)
playerListLabel.Size = UDim2.new(0.5, 0, 0, 25)
playerListLabel.Font = Enum.Font.SourceSans
playerListLabel.TextSize = 16
playerListLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
playerListLabel.BackgroundTransparency = 1

-- 👤 Player List Frame
local scroll = Instance.new("ScrollingFrame", frame)
scroll.Position = UDim2.new(0, 10, 0, 65)
scroll.Size = UDim2.new(1, -20, 0, 100)
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ScrollBarThickness = 5
scroll.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
scroll.BorderSizePixel = 0
Instance.new("UICorner", scroll)

local listLayout = Instance.new("UIListLayout", scroll)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 5)

-- ❄️ Freeze Button
local freezeButton = Instance.new("TextButton", frame)
freezeButton.Size = UDim2.new(1, -20, 0, 40)
freezeButton.Position = UDim2.new(0, 10, 0, 175)
freezeButton.Text = "❄️ Freeze Trade"
freezeButton.Font = Enum.Font.SourceSansBold
freezeButton.TextSize = 18
freezeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
freezeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", freezeButton)

-- 🔵 Loading Bar Background
local loadingBack = Instance.new("Frame", frame)
loadingBack.Size = UDim2.new(1, -20, 0, 15)
loadingBack.Position = UDim2.new(0, 10, 0, 225)
loadingBack.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
Instance.new("UICorner", loadingBack)

-- 🔵 Loading Fill
local loadingFill = Instance.new("Frame", loadingBack)
loadingFill.Size = UDim2.new(0, 0, 1, 0)
loadingFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
loadingFill.BorderSizePixel = 0
Instance.new("UICorner", loadingFill)

-- ✅ Status Label
local statusLabel = Instance.new("TextLabel", frame)
statusLabel.Size = UDim2.new(1, -20, 0, 25)
statusLabel.Position = UDim2.new(0, 10, 0, 245)
statusLabel.Font = Enum.Font.SourceSansItalic
statusLabel.TextSize = 18
statusLabel.Text = ""
statusLabel.TextColor3 = Color3.fromRGB(0, 170, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Visible = false

-- 🧠 Logic
local selectedPlayer = nil

local function refreshPlayerList()
	scroll:ClearAllChildren()
	selectedPlayer = nil
	playerListLabel.Text = "Select Player:"
	
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player then
			local btn = Instance.new("TextButton")
			btn.Size = UDim2.new(1, 0, 0, 30)
			btn.Text = p.Name
			btn.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
			btn.TextColor3 = Color3.fromRGB(0, 0, 0)
			btn.Font = Enum.Font.SourceSans
			btn.TextSize = 16
			Instance.new("UICorner", btn)
			btn.Parent = scroll

			btn.MouseButton1Click:Connect(function()
				selectedPlayer = p
				playerListLabel.Text = "Selected: " .. p.Name
			end)
		end
	end

	scroll.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
end

-- Initial Load + Refresh
refreshPlayerList()
refreshButton.MouseButton1Click:Connect(refreshPlayerList)
Players.PlayerAdded:Connect(refreshPlayerList)
Players.PlayerRemoving:Connect(refreshPlayerList)

-- Freeze Trade Logic
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
	loadingFill.Size = UDim2.new(0, 0, 1, 0)

	for i = 1, 10 do
		local percent = i / 10
		loadingFill:TweenSize(UDim2.new(percent, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 1, true)
		wait(1)
	end

	statusLabel.Text = "✅ Trade Frozen"
	statusLabel.TextColor3 = Color3.fromRGB(0, 170, 0)
	statusLabel.Visible = true
	freezeButton.Text = "❄️ Freeze Trade"
	freezeButton.Active = true
end)