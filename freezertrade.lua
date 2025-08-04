local Players = game:GetService("Players")
local player = Players.LocalPlayer
local userId = player.UserId

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FreezeTradeGui"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 320, 0, 230)
frame.Position = UDim2.new(0.5, -160, 0.5, -115)
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Active = true
frame.Draggable = true
frame.BackgroundTransparency = 1
frame.ClipsDescendants = true
frame.Parent = screenGui

-- Rounded corners
local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 20)

-- Fade in
task.spawn(function()
	for i = 1, 10 do
		frame.BackgroundTransparency = 1 - (i / 10)
		task.wait(0.03)
	end
end)

-- Avatar Image
local avatar = Instance.new("ImageLabel")
avatar.Size = UDim2.new(0, 60, 0, 60)
avatar.Position = UDim2.new(0.05, 0, 0.05, 0)
avatar.BackgroundTransparency = 1
avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. userId .. "&width=420&height=420&format=png"
avatar.Parent = frame

-- Title
local title = Instance.new("TextLabel")
title.Text = "❄️ Freeze Trade"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(30, 30, 30)
title.TextScaled = true
title.BackgroundTransparency = 1
title.Position = UDim2.new(0.28, 0, 0.05, 0)
title.Size = UDim2.new(0.65, 0, 0.15, 0)
title.Parent = frame

-- Freeze Button
local button = Instance.new("TextButton")
button.Text = "Freeze Trade"
button.Font = Enum.Font.Gotham
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextScaled = true
button.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
button.Size = UDim2.new(0.8, 0, 0, 45)
button.Position = UDim2.new(0.1, 0, 0.35, 0)
button.BorderSizePixel = 0
button.AutoButtonColor = true
button.Parent = frame

local btnCorner = Instance.new("UICorner", button)
btnCorner.CornerRadius = UDim.new(0, 10)

-- Instruction
local instructions = Instance.new("TextLabel")
instructions.Text = "☑️ Freeze the trade.\n⏳ Wait for players to accept\n🕒 Stay 5 minutes in server."
instructions.Font = Enum.Font.Gotham
instructions.TextColor3 = Color3.fromRGB(50, 50, 50)
instructions.TextScaled = true
instructions.TextWrapped = true
instructions.BackgroundTransparency = 1
instructions.Position = UDim2.new(0.05, 0, 0.6, 0)
instructions.Size = UDim2.new(0.9, 0, 0.3, 0)
instructions.Parent = frame

-- Footer
local footer = Instance.new("TextLabel")
footer.Text = "🛠️ Made By YourNameHere"
footer.Font = Enum.Font.GothamItalic
footer.TextColor3 = Color3.fromRGB(120, 120, 120)
footer.TextScaled = true
footer.BackgroundTransparency = 1
footer.Position = UDim2.new(0, 0, 0.92, 0)
footer.Size = UDim2.new(1, 0, 0.08, 0)
footer.Parent = frame

-- Popup Message
local popup = Instance.new("TextLabel")
popup.Size = UDim2.new(0, 200, 0, 50)
popup.Position = UDim2.new(0.5, -100, 0.1, -60)
popup.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
popup.TextColor3 = Color3.new(1, 1, 1)
popup.Text = "❄️ Trade Frozen!"
popup.TextScaled = true
popup.Font = Enum.Font.GothamBold
popup.BackgroundTransparency = 1
popup.Visible = false
popup.Parent = screenGui

local popupCorner = Instance.new("UICorner", popup)
popupCorner.CornerRadius = UDim.new(0, 12)

-- Processing Text
local processingLabel = Instance.new("TextLabel")
processingLabel.Text = ""
processingLabel.Font = Enum.Font.Gotham
processingLabel.TextColor3 = Color3.fromRGB(90, 90, 90)
processingLabel.TextScaled = true
processingLabel.BackgroundTransparency = 1
processingLabel.Position = UDim2.new(0, 0, 0.85, 0)
processingLabel.Size = UDim2.new(1, 0, 0.1, 0)
processingLabel.Visible = false
processingLabel.Parent = frame

-- Animation + Logic
local frozen = false
local processing = false

button.MouseButton1Click:Connect(function()
	if frozen or processing then return end

	processing = true
	button.AutoButtonColor = false
	button.Text = ""
	button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
	processingLabel.Visible = true

	-- Animate "Processing..."
	local running = true
	task.spawn(function()
		local dots = ""
		while running do
			dots = (dots == "...") and "" or dots .. "."
			processingLabel.Text = "Processing" .. dots
			task.wait(0.4)
		end
	end)

	-- Color pulse animation during "freezing"
	local originalColor = Color3.fromRGB(100, 100, 100)
	local pulse = true
	task.spawn(function()
		while pulse do
			button.BackgroundColor3 = Color3.fromRGB(120, 180, 255)
			task.wait(0.3)
			button.BackgroundColor3 = originalColor
			task.wait(0.3)
		end
	end)

	-- Finish freeze after delay
	task.delay(2.2, function()
		running = false
		pulse = false
		processingLabel.Visible = false
		button.Text = "Frozen ❄️"
		button.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
		button.AutoButtonColor = true
		frozen = true
		processing = false

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