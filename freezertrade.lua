local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ScreenGui setup
local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "FreezeTradeUI"
gui.ResetOnSpawn = false

-- Main Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 340, 0, 270)
frame.Position = UDim2.new(0.5, -170, 0.5, -135)
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Active = true
frame.Draggable = true

-- Rounded corners
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 20)

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 10)
title.Text = "❄️ Freeze Trade"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(40, 40, 40)
title.TextScaled = true
title.BackgroundTransparency = 1

-- Dropdown player list
local playerDropdown = Instance.new("TextButton", frame)
playerDropdown.Size = UDim2.new(0.8, 0, 0, 35)
playerDropdown.Position = UDim2.new(0.1, 0, 0.25, 0)
playerDropdown.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
playerDropdown.TextColor3 = Color3.fromRGB(30, 30, 30)
playerDropdown.Font = Enum.Font.Gotham
playerDropdown.TextScaled = true
playerDropdown.Text = "Select Target"
Instance.new("UICorner", playerDropdown).CornerRadius = UDim.new(0, 8)

-- Avatar display
local avatarImage = Instance.new("ImageLabel", frame)
avatarImage.Size = UDim2.new(0, 60, 0, 60)
avatarImage.Position = UDim2.new(0.1, 0, 0.45, 0)
avatarImage.BackgroundTransparency = 1
avatarImage.Visible = false

-- Freeze Button
local freezeButton = Instance.new("TextButton", frame)
freezeButton.Size = UDim2.new(0.8, 0, 0, 40)
freezeButton.Position = UDim2.new(0.1, 0, 0.7, 0)
freezeButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
freezeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
freezeButton.Font = Enum.Font.Gotham
freezeButton.TextScaled = true
freezeButton.Text = "Freeze Trade"
Instance.new("UICorner", freezeButton).CornerRadius = UDim.new(0, 10)

-- Popup
local popup = Instance.new("TextLabel", gui)
popup.Size = UDim2.new(0, 220, 0, 50)
popup.Position = UDim2.new(0.5, -110, 0.15, -20)
popup.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
popup.TextColor3 = Color3.new(1, 1, 1)
popup.Text = "❄️ Trade Frozen"
popup.Font = Enum.Font.GothamBold
popup.TextScaled = true
popup.Visible = false
popup.BackgroundTransparency = 1
Instance.new("UICorner", popup).CornerRadius = UDim.new(0, 12)

-- Scroll list of players (popup list)
local dropdownFrame = Instance.new("Frame", frame)
dropdownFrame.Size = UDim2.new(0.8, 0, 0, 100)
dropdownFrame.Position = UDim2.new(0.1, 0, 0.35, 0)
dropdownFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
dropdownFrame.BorderSizePixel = 0
dropdownFrame.Visible = false
Instance.new("UICorner", dropdownFrame).CornerRadius = UDim.new(0, 8)

local uiList = Instance.new("UIListLayout", dropdownFrame)
uiList.SortOrder = Enum.SortOrder.LayoutOrder
uiList.Padding = UDim.new(0, 5)

-- Create list buttons
local selectedPlayer = nil

local function refreshDropdown()
	dropdownFrame:ClearAllChildren()
	uiList.Parent = dropdownFrame

	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer then
			local option = Instance.new("TextButton", dropdownFrame)
			option.Size = UDim2.new(1, 0, 0, 25)
			option.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
			option.Text = p.DisplayName
			option.TextScaled = true
			option.TextColor3 = Color3.fromRGB(30, 30, 30)
			option.Font = Enum.Font.Gotham
			Instance.new("UICorner", option).CornerRadius = UDim.new(0, 6)

			option.MouseButton1Click:Connect(function()
				selectedPlayer = p
				playerDropdown.Text = "Target: " .. p.DisplayName
				avatarImage.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. p.UserId .. "&width=420&height=420&format=png"
				avatarImage.Visible = true
				dropdownFrame.Visible = false
			end)
		end
	end
end

-- Toggle dropdown
playerDropdown.MouseButton1Click:Connect(function()
	refreshDropdown()
	dropdownFrame.Visible = not dropdownFrame.Visible
end)

-- Freeze logic
local isFrozen = false
freezeButton.MouseButton1Click:Connect(function()
	if not selectedPlayer or isFrozen then return end

	isFrozen = true
	freezeButton.Text = "Freezing Trade…"
	freezeButton.AutoButtonColor = false

	-- Animation pulse
	local pulse = true
	task.spawn(function()
		while pulse do
			freezeButton.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
			task.wait(0.3)
			freezeButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
			task.wait(0.3)
		end
	end)

	-- Delay, then show frozen popup
	task.delay(2.2, function()
		pulse = false
		freezeButton.Text = "Frozen ❄️"
		freezeButton.BackgroundColor3 = Color3.fromRGB(0, 180, 255)

		-- Show popup
		popup.Visible = true
		for i = 1, 10 do
			popup.BackgroundTransparency = 1 - (i / 10)
			task.wait(0.02)
		end
		task.wait(2)
		for i = 1, 10 do
			popup.BackgroundTransparency = i / 10
			task.wait(0.02)
		end
		popup.Visible = false
	end)
end)