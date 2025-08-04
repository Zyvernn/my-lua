-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FreezeTradeGui"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create main frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Active = true
frame.Draggable = true -- Makes the frame draggable
frame.BackgroundTransparency = 1 -- Start transparent for fade in
frame.Parent = screenGui

-- Fade-in animation
task.spawn(function()
	for i = 1, 10 do
		frame.BackgroundTransparency = 1 - (i / 10)
		task.wait(0.03)
	end
end)

-- Title Text
local title = Instance.new("TextLabel")
title.Text = "❄️ Freeze Trade"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(30, 30, 30)
title.TextScaled = true
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 0, 40)
title.Parent = frame

-- Freeze Button
local button = Instance.new("TextButton")
button.Text = "Freeze Trade"
button.Font = Enum.Font.Gotham
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextScaled = true
button.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
button.Size = UDim2.new(0.8, 0, 0, 40)
button.Position = UDim2.new(0.1, 0, 0.3, 0)
button.BorderSizePixel = 0
button.AutoButtonColor = true
button.Parent = frame

-- Processing TextLabel (hidden initially)
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

-- Freeze logic
local frozen = false
local processing = false

button.MouseButton1Click:Connect(function()
	if frozen or processing then return end -- prevent spam

	processing = true
	button.AutoButtonColor = false
	button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
	button.Text = ""

	-- Start processing animation
	processingLabel.Visible = true
	local dots = ""
	local running = true

	task.spawn(function()
		while running do
			dots = (dots == "...") and "" or dots .. "."
			processingLabel.Text = "Processing" .. dots
			task.wait(0.5)
		end
	end)

	-- Wait 2 seconds then freeze
	task.delay(2, function()
		running = false
		processingLabel.Visible = false

		frozen = true
		button.Text = "Frozen ❄️"
		button.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
		button.AutoButtonColor = true
		processing = false
	end)
end)

-- Instructions
local instructions = Instance.new("TextLabel")
instructions.Text = "☑️ Freeze the trade.\n⏳ Wait for players to accept\n🕒 Stay 5 minutes in server."
instructions.Font = Enum.Font.Gotham
instructions.TextColor3 = Color3.fromRGB(50, 50, 50)
instructions.TextScaled = true
instructions.TextWrapped = true
instructions.BackgroundTransparency = 1
instructions.Position = UDim2.new(0.05, 0, 0.55, 0)
instructions.Size = UDim2.new(0.9, 0, 0.35, 0)
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
