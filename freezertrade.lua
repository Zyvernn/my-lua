local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- ScreenGui Setup
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "FreezeTradeMiniUI"
gui.ResetOnSpawn = false

-- Main Small Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 180, 0, 220)
frame.Position = UDim2.new(1, -190, 1, -230)
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui
local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)

-- Title Label
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 25)
title.Text = "🔒 Freeze Trade"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(0, 0, 0)
title.BackgroundTransparency = 1

-- Refresh Button
local refresh = Instance.new("TextButton", frame)
refresh.Size = UDim2.new(0.4, 0, 0, 20)
refresh.Position = UDim2.new(0.55, 0, 0, 30)
refresh.Text = "🔁"
refresh.Font = Enum.Font.SourceSansBold
refresh.TextSize = 14
refresh.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
refresh.TextColor3 = Color3.fromRGB(0, 0, 0)
Instance.new("UICorner", refresh)

-- Player List Label
local label = Instance.new("TextLabel", frame)
label.Text = "Pick Player:"
label.Position = UDim2.new(0, 10, 0, 30)
label.Size = UDim2.new(0.5, 0, 0, 20)
label.Font = Enum.Font.SourceSans
label.TextSize = 14
label.TextColor3 = Color3.fromRGB(0, 0, 0)
label.BackgroundTransparency = 1

-- Player List (ScrollingFrame)
local list = Instance.new("ScrollingFrame", frame)
list.Size = UDim2.new(1, -20, 0, 80)
list.Position = UDim2.new(0, 10, 0, 55)
list.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
list.BorderSizePixel = 0
list.ScrollBarThickness = 4
Instance.new("UICorner", list)
local layout = Instance.new("UIListLayout", list)
layout.Padding = UDim.new(0, 3)
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- Freeze Button
local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(1, -20, 0, 30)
button.Position = UDim2.new(0, 10, 0, 140)
button.Text = "❄️ Freeze"
button.Font = Enum.Font.SourceSansBold
button.TextSize = 16
button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", button)

-- Loading Bar Background
local barBg = Instance.new("Frame", frame)
barBg.Size = UDim2.new(1, -20, 0, 12)
barBg.Position = UDim2.new(0, 10, 0, 175)
barBg.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
Instance.new("UICorner", barBg)

local barFill = Instance.new("Frame", barBg)
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
barFill.BorderSizePixel = 0
Instance.new("UICorner", barFill)

-- Status Label
local status = Instance.new("TextLabel", frame)
status.Size = UDim2.new(1, -20, 0, 20)
status.Position = UDim2.new(0, 10, 0, 190)
status.Font = Enum.Font.SourceSansItalic
status.TextSize = 14
status.Text = ""
status.TextColor3 = Color3.fromRGB(0, 170, 0)
status.BackgroundTransparency = 1
status.Visible = false

-- Script Logic
local selectedPlayer = nil

local function refreshList()
	list:ClearAllChildren()
	selectedPlayer = nil
	label.Text = "Pick Player:"
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= player then
			local btn = Instance.new("TextButton")
			btn.Size = UDim2.new(1, 0, 0, 25)
			btn.Text = p.Name
			btn.Font = Enum.Font.SourceSans
			btn.TextSize = 14
			btn.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
			btn.TextColor3 = Color3.fromRGB(0, 0, 0)
			Instance.new("UICorner", btn)
			btn.Parent = list

			btn.MouseButton1Click:Connect(function()
				selectedPlayer = p
				label.Text = "Selected: " .. p.Name
			end)
		end
	end
	list.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y)
end

refresh.MouseButton1Click:Connect(refreshList)
Players.PlayerAdded:Connect(refreshList)
Players.PlayerRemoving:Connect(refreshList)

button.MouseButton1Click:Connect(function()
	if not selectedPlayer then
		status.Text = "⚠ No player selected"
		status.TextColor3 = Color3.fromRGB(255, 0, 0)
		status.Visible = true
		return
	end

	status.Visible = false
	button.Active = false
	button.Text = "Freezing..."
	barFill.Size = UDim2.new(0, 0, 1, 0)

	for i = 1, 10 do
		barFill:TweenSize(UDim2.new(i/10, 0, 1, 0), "Out", "Linear", 1, true)
		wait(1)
	end

	status.Text = "✅ Trade Frozen"
	status.TextColor3 = Color3.fromRGB(0, 170, 0)
	status.Visible = true
	button.Text = "❄️ Freeze"
	button.Active = true
end)

-- Initial player load
refreshList()