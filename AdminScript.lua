-- AdminScript LocalScript
-- Place inside StarterPlayerScripts or StarterCharacterScripts

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- ============================================================
-- STATE
-- ============================================================
local States = {
	Fly = false,
	SuperSpeed = false,
	SuperJump = false,
	Immortal = false,
	NoRagdoll = false,
	Rejoin = false,
	Float = false,
	Emote = false,
}

-- ============================================================
-- FLY SYSTEM
-- ============================================================
local flyConnection = nil
local flyBodyVelocity = nil
local flyBodyGyro = nil
local flySpeed = 80

local function enableFly()
	local camera = workspace.CurrentCamera
	flyBodyVelocity = Instance.new("BodyVelocity")
	flyBodyVelocity.Velocity = Vector3.zero
	flyBodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
	flyBodyVelocity.Parent = HumanoidRootPart

	flyBodyGyro = Instance.new("BodyGyro")
	flyBodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
	flyBodyGyro.D = 50
	flyBodyGyro.Parent = HumanoidRootPart

	Humanoid.PlatformStand = true

	flyConnection = RunService.Heartbeat:Connect(function()
		if not States.Fly then return end
		local moveDir = Vector3.zero
		local cf = camera.CFrame

		if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cf.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cf.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cf.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cf.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0,1,0) end
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir = moveDir - Vector3.new(0,1,0) end

		if moveDir.Magnitude > 0 then
			flyBodyVelocity.Velocity = moveDir.Unit * flySpeed
		else
			flyBodyVelocity.Velocity = Vector3.zero
		end
		flyBodyGyro.CFrame = cf
	end)
end

local function disableFly()
	if flyConnection then flyConnection:Disconnect() flyConnection = nil end
	if flyBodyVelocity then flyBodyVelocity:Destroy() flyBodyVelocity = nil end
	if flyBodyGyro then flyBodyGyro:Destroy() flyBodyGyro = nil end
	Humanoid.PlatformStand = false
end

-- ============================================================
-- FLOAT SYSTEM (walk in air)
-- ============================================================
local floatConnection = nil
local floatPart = nil

local function enableFloat()
	floatPart = Instance.new("Part")
	floatPart.Size = Vector3.new(4, 0.2, 4)
	floatPart.Anchored = false
	floatPart.CanCollide = true
	floatPart.Transparency = 1
	floatPart.Parent = workspace

	local weld = Instance.new("WeldConstraint")
	weld.Part0 = HumanoidRootPart
	weld.Part1 = floatPart
	weld.Parent = floatPart

	floatPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0)

	floatConnection = RunService.Heartbeat:Connect(function()
		if floatPart then
			floatPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3.1, 0)
		end
	end)
end

local function disableFloat()
	if floatConnection then floatConnection:Disconnect() floatConnection = nil end
	if floatPart then floatPart:Destroy() floatPart = nil end
end

-- ============================================================
-- IMMORTAL SYSTEM
-- ============================================================
local immortalConnection = nil

local function enableImmortal()
	Humanoid.MaxHealth = math.huge
	Humanoid.Health = math.huge
	immortalConnection = Humanoid.HealthChanged:Connect(function()
		if States.Immortal then
			Humanoid.MaxHealth = math.huge
			Humanoid.Health = math.huge
		end
	end)
end

local function disableImmortal()
	if immortalConnection then immortalConnection:Disconnect() immortalConnection = nil end
	Humanoid.MaxHealth = 100
	Humanoid.Health = 100
end

-- ============================================================
-- NO RAGDOLL SYSTEM
-- ============================================================
local ragdollConnection = nil

local function enableNoRagdoll()
	ragdollConnection = Humanoid.StateChanged:Connect(function(_, new)
		if States.NoRagdoll then
			if new == Enum.HumanoidStateType.Ragdoll or new == Enum.HumanoidStateType.FallingDown then
				Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
			end
		end
	end)
end

local function disableNoRagdoll()
	if ragdollConnection then ragdollConnection:Disconnect() ragdollConnection = nil end
end

-- ============================================================
-- CREATE GUI
-- ============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AdminPanel"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 540)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -270)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Glow Border
local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(0, 200, 255)
Stroke.Thickness = 1.5
Stroke.Transparency = 0.3
Stroke.Parent = MainFrame

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

local HeaderFix = Instance.new("Frame")
HeaderFix.Size = UDim2.new(1, 0, 0.5, 0)
HeaderFix.Position = UDim2.new(0, 0, 0.5, 0)
HeaderFix.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
HeaderFix.BorderSizePixel = 0
HeaderFix.Parent = Header

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -80, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "⚡ Administrator"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = Header

-- Minimize Button
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -68, 0.5, -15)
MinBtn.BackgroundColor3 = Color3.fromRGB(255, 180, 0)
MinBtn.Text = "—"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 14
MinBtn.Font = Enum.Font.GothamBold
MinBtn.BorderSizePixel = 0
MinBtn.Parent = Header

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinBtn

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -33, 0.5, -15)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

-- Scroll Frame for buttons
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -10, 1, -60)
ScrollFrame.Position = UDim2.new(0, 5, 0, 55)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 3
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 255)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollFrame.Parent = MainFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 6)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Parent = ScrollFrame

local Padding = Instance.new("UIPadding")
Padding.PaddingLeft = UDim.new(0, 5)
Padding.PaddingRight = UDim.new(0, 5)
Padding.PaddingTop = UDim.new(0, 5)
Padding.Parent = ScrollFrame

-- ============================================================
-- TOGGLE SWITCH FACTORY
-- ============================================================
local toggleConnections = {}

local function createToggle(name, labelText, order)
	local Row = Instance.new("Frame")
	Row.Name = name .. "Row"
	Row.Size = UDim2.new(1, 0, 0, 50)
	Row.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
	Row.BorderSizePixel = 0
	Row.LayoutOrder = order
	Row.Parent = ScrollFrame

	local RowCorner = Instance.new("UICorner")
	RowCorner.CornerRadius = UDim.new(0, 8)
	RowCorner.Parent = Row

	local RowStroke = Instance.new("UIStroke")
	RowStroke.Color = Color3.fromRGB(40, 40, 70)
	RowStroke.Thickness = 1
	RowStroke.Parent = Row

	local Label = Instance.new("TextLabel")
	Label.Size = UDim2.new(1, -70, 1, 0)
	Label.Position = UDim2.new(0, 12, 0, 0)
	Label.BackgroundTransparency = 1
	Label.Text = labelText
	Label.TextColor3 = Color3.fromRGB(200, 210, 255)
	Label.TextSize = 14
	Label.Font = Enum.Font.Gotham
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.Parent = Row

	-- Switch Track
	local Track = Instance.new("Frame")
	Track.Size = UDim2.new(0, 46, 0, 24)
	Track.Position = UDim2.new(1, -58, 0.5, -12)
	Track.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
	Track.BorderSizePixel = 0
	Track.Parent = Row

	local TrackCorner = Instance.new("UICorner")
	TrackCorner.CornerRadius = UDim.new(1, 0)
	TrackCorner.Parent = Track

	-- Switch Thumb
	local Thumb = Instance.new("Frame")
	Thumb.Size = UDim2.new(0, 18, 0, 18)
	Thumb.Position = UDim2.new(0, 3, 0.5, -9)
	Thumb.BackgroundColor3 = Color3.fromRGB(180, 180, 200)
	Thumb.BorderSizePixel = 0
	Thumb.Parent = Track

	local ThumbCorner = Instance.new("UICorner")
	ThumbCorner.CornerRadius = UDim.new(1, 0)
	ThumbCorner.Parent = Thumb

	-- Clickable overlay
	local ClickBtn = Instance.new("TextButton")
	ClickBtn.Size = UDim2.new(1, 0, 1, 0)
	ClickBtn.BackgroundTransparency = 1
	ClickBtn.Text = ""
	ClickBtn.Parent = Track

	local function updateSwitch(state)
		local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad)
		if state then
			TweenService:Create(Track, tweenInfo, {BackgroundColor3 = Color3.fromRGB(0, 200, 100)}):Play()
			TweenService:Create(Thumb, tweenInfo, {Position = UDim2.new(0, 25, 0.5, -9), BackgroundColor3 = Color3.fromRGB(255,255,255)}):Play()
		else
			TweenService:Create(Track, tweenInfo, {BackgroundColor3 = Color3.fromRGB(60, 60, 80)}):Play()
			TweenService:Create(Thumb, tweenInfo, {Position = UDim2.new(0, 3, 0.5, -9), BackgroundColor3 = Color3.fromRGB(180, 180, 200)}):Play()
		end
	end

	toggleConnections[name] = {updateSwitch = updateSwitch}

	return ClickBtn, updateSwitch, Row
end

-- ============================================================
-- BUTTON CALLBACKS
-- ============================================================

-- FLY
local flyBtn, flyUpdate = createToggle("Fly", "✈  Fly  —  Terbang bebas di udara", 1)
flyBtn.MouseButton1Click:Connect(function()
	States.Fly = not States.Fly
	flyUpdate(States.Fly)
	if States.Fly then
		enableFly()
	else
		disableFly()
	end
end)

-- SUPER SPEED
local speedBtn, speedUpdate = createToggle("Speed", "⚡ Super Speed  —  Kecepatan 700", 2)
speedBtn.MouseButton1Click:Connect(function()
	States.SuperSpeed = not States.SuperSpeed
	speedUpdate(States.SuperSpeed)
	Humanoid.WalkSpeed = States.SuperSpeed and 700 or 16
end)

-- SUPER JUMP
local jumpBtn, jumpUpdate = createToggle("Jump", "🚀 Super Jump  —  Lompat sangat tinggi", 3)
jumpBtn.MouseButton1Click:Connect(function()
	States.SuperJump = not States.SuperJump
	jumpUpdate(States.SuperJump)
	Humanoid.JumpPower = States.SuperJump and 200 or 50
end)

-- IMMORTAL
local immortalBtn, immortalUpdate = createToggle("Immortal", "🛡  Immortal  —  Tidak bisa mati", 4)
immortalBtn.MouseButton1Click:Connect(function()
	States.Immortal = not States.Immortal
	immortalUpdate(States.Immortal)
	if States.Immortal then
		enableImmortal()
	else
		disableImmortal()
	end
end)

-- NO RAGDOLL
local ragdollBtn, ragdollUpdate = createToggle("NoRagdoll", "🤸 No Ragdoll  —  Tahan ragdoll", 5)
ragdollBtn.MouseButton1Click:Connect(function()
	States.NoRagdoll = not States.NoRagdoll
	ragdollUpdate(States.NoRagdoll)
	if States.NoRagdoll then
		enableNoRagdoll()
	else
		disableNoRagdoll()
	end
end)

-- REJOIN
local rejoinBtn, rejoinUpdate = createToggle("Rejoin", "🔄 Rejoin  —  Join server yang sama", 6)
rejoinBtn.MouseButton1Click:Connect(function()
	States.Rejoin = not States.Rejoin
	rejoinUpdate(States.Rejoin)
	if States.Rejoin then
		local TeleportService = game:GetService("TeleportService")
		TeleportService:TeleportToPlaceInstance(game.PlaceId, game:GetService("Players").LocalPlayer:GetAttribute("ServerId") or game.JobId, Player)
	end
end)

-- FLOAT
local floatBtn, floatUpdate = createToggle("Float", "🌊 Float  —  Jalan bebas di udara", 7)
floatBtn.MouseButton1Click:Connect(function()
	States.Float = not States.Float
	floatUpdate(States.Float)
	if States.Float then
		enableFloat()
	else
		disableFloat()
	end
end)

-- EMOTE BUTTON (opens sub-panel)
local emoteBtn, emoteUpdate, emoteRow = createToggle("Emote", "💃 Emote  —  Buka panel emote", 8)

-- ============================================================
-- EMOTE PANEL
-- ============================================================
local EmotePanel = Instance.new("Frame")
EmotePanel.Name = "EmotePanel"
EmotePanel.Size = UDim2.new(0, 290, 0, 480)
EmotePanel.Position = UDim2.new(0.5, 170, 0.5, -240)
EmotePanel.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
EmotePanel.BorderSizePixel = 0
EmotePanel.Visible = false
EmotePanel.Parent = ScreenGui

local EPCorner = Instance.new("UICorner")
EPCorner.CornerRadius = UDim.new(0, 12)
EPCorner.Parent = EmotePanel

local EPStroke = Instance.new("UIStroke")
EPStroke.Color = Color3.fromRGB(200, 0, 255)
EPStroke.Thickness = 1.5
EPStroke.Transparency = 0.3
EPStroke.Parent = EmotePanel

-- Emote Header
local EHeader = Instance.new("Frame")
EHeader.Size = UDim2.new(1, 0, 0, 50)
EHeader.BackgroundColor3 = Color3.fromRGB(150, 0, 200)
EHeader.BorderSizePixel = 0
EHeader.Parent = EmotePanel

local EHeaderCorner = Instance.new("UICorner")
EHeaderCorner.CornerRadius = UDim.new(0, 12)
EHeaderCorner.Parent = EHeader

local EHeaderFix = Instance.new("Frame")
EHeaderFix.Size = UDim2.new(1, 0, 0.5, 0)
EHeaderFix.Position = UDim2.new(0, 0, 0.5, 0)
EHeaderFix.BackgroundColor3 = Color3.fromRGB(150, 0, 200)
EHeaderFix.BorderSizePixel = 0
EHeaderFix.Parent = EHeader

local ETitleLabel = Instance.new("TextLabel")
ETitleLabel.Size = UDim2.new(1, -80, 1, 0)
ETitleLabel.Position = UDim2.new(0, 15, 0, 0)
ETitleLabel.BackgroundTransparency = 1
ETitleLabel.Text = "💃 Emote Panel"
ETitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ETitleLabel.TextSize = 16
ETitleLabel.Font = Enum.Font.GothamBold
ETitleLabel.TextXAlignment = Enum.TextXAlignment.Left
ETitleLabel.Parent = EHeader

-- Emote Minimize
local EMinBtn = Instance.new("TextButton")
EMinBtn.Size = UDim2.new(0, 30, 0, 30)
EMinBtn.Position = UDim2.new(1, -68, 0.5, -15)
EMinBtn.BackgroundColor3 = Color3.fromRGB(255, 180, 0)
EMinBtn.Text = "—"
EMinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EMinBtn.TextSize = 14
EMinBtn.Font = Enum.Font.GothamBold
EMinBtn.BorderSizePixel = 0
EMinBtn.Parent = EHeader

local EMinCorner = Instance.new("UICorner")
EMinCorner.CornerRadius = UDim.new(0, 6)
EMinCorner.Parent = EMinBtn

-- Emote Close
local ECloseBtn = Instance.new("TextButton")
ECloseBtn.Size = UDim2.new(0, 30, 0, 30)
ECloseBtn.Position = UDim2.new(1, -33, 0.5, -15)
ECloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
ECloseBtn.Text = "✕"
ECloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ECloseBtn.TextSize = 14
ECloseBtn.Font = Enum.Font.GothamBold
ECloseBtn.BorderSizePixel = 0
ECloseBtn.Parent = EHeader

local ECloseCorner = Instance.new("UICorner")
ECloseCorner.CornerRadius = UDim.new(0, 6)
ECloseCorner.Parent = ECloseBtn

-- Emote TextBox
local ETextBox = Instance.new("TextBox")
ETextBox.Size = UDim2.new(1, -20, 0, 36)
ETextBox.Position = UDim2.new(0, 10, 0, 58)
ETextBox.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
ETextBox.Text = ""
ETextBox.PlaceholderText = "/E Dance2"
ETextBox.TextColor3 = Color3.fromRGB(200, 210, 255)
ETextBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 140)
ETextBox.TextSize = 13
ETextBox.Font = Enum.Font.Gotham
ETextBox.BorderSizePixel = 0
ETextBox.ClearTextOnFocus = false
ETextBox.Parent = EmotePanel

local ETBCorner = Instance.new("UICorner")
ETBCorner.CornerRadius = UDim.new(0, 8)
ETBCorner.Parent = ETextBox

local ETBStroke = Instance.new("UIStroke")
ETBStroke.Color = Color3.fromRGB(150, 0, 200)
ETBStroke.Thickness = 1
ETBStroke.Parent = ETextBox

-- Emote Send Button
local ESendBtn = Instance.new("TextButton")
ESendBtn.Size = UDim2.new(1, -20, 0, 36)
ESendBtn.Position = UDim2.new(0, 10, 0, 100)
ESendBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 200)
ESendBtn.Text = "▶  Jalankan Emote"
ESendBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ESendBtn.TextSize = 13
ESendBtn.Font = Enum.Font.GothamBold
ESendBtn.BorderSizePixel = 0
ESendBtn.Parent = EmotePanel

local ESendCorner = Instance.new("UICorner")
ESendCorner.CornerRadius = UDim.new(0, 8)
ESendCorner.Parent = ESendBtn

-- Emote list scroll
local EScroll = Instance.new("ScrollingFrame")
EScroll.Size = UDim2.new(1, -10, 1, -145)
EScroll.Position = UDim2.new(0, 5, 0, 143)
EScroll.BackgroundTransparency = 1
EScroll.BorderSizePixel = 0
EScroll.ScrollBarThickness = 3
EScroll.ScrollBarImageColor3 = Color3.fromRGB(200, 0, 255)
EScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
EScroll.CanvasSize = UDim2.new(0,0,0,0)
EScroll.Parent = EmotePanel

local EListLayout = Instance.new("UIListLayout")
EListLayout.Padding = UDim.new(0, 4)
EListLayout.Parent = EScroll

local EPad = Instance.new("UIPadding")
EPad.PaddingLeft = UDim.new(0, 5)
EPad.PaddingRight = UDim.new(0, 5)
EPad.PaddingTop = UDim.new(0, 4)
EPad.Parent = EScroll

local emoteList = {
	{name = "Dance 2",       cmd = "/e dance2"},
	{name = "Dance 3",       cmd = "/e dance3"},
	{name = "Dance 4",       cmd = "/e dance4"},
	{name = "Dance 5",       cmd = "/e dance5"},
	{name = "Head Hand",     cmd = "/e headhand"},
	{name = "Open Head",     cmd = "/e openhead"},
	{name = "Clap",          cmd = "/e clap"},
	{name = "Laughter",      cmd = "/e laughter"},
	{name = "LOL",           cmd = "/e lol"},
	{name = "Angry",         cmd = "/e angry"},
	{name = "Point",         cmd = "/e point"},
	{name = "Loop Step Foot",cmd = "/e loopstepfoot"},
	{name = "Sad",           cmd = "/e sad"},
	{name = "Walk",          cmd = "/e walk"},
	{name = "Run",           cmd = "/e run"},
	{name = "Touch",         cmd = "/e touch"},
}

local function sendChat(msg)
	-- Use StarterGui chat bar method
	local success, err = pcall(function()
		game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
			and game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents
			:FindFirstChild("SayMessageRequest"):FireServer(msg, "All")
	end)
	if not success then
		-- fallback TextChat
		local TextChatService = game:GetService("TextChatService")
		if TextChatService then
			local channels = TextChatService:FindFirstChild("TextChannels")
			if channels then
				local all = channels:FindFirstChild("RBXGeneral")
				if all then all:SendAsync(msg) end
			end
		end
	end
end

for _, emote in ipairs(emoteList) do
	local EBtn = Instance.new("TextButton")
	EBtn.Size = UDim2.new(1, 0, 0, 36)
	EBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 40)
	EBtn.Text = "  " .. emote.name .. "   (" .. emote.cmd .. ")"
	EBtn.TextColor3 = Color3.fromRGB(200, 210, 255)
	EBtn.TextSize = 12
	EBtn.Font = Enum.Font.Gotham
	EBtn.TextXAlignment = Enum.TextXAlignment.Left
	EBtn.BorderSizePixel = 0
	EBtn.Parent = EScroll

	local EBtnCorner = Instance.new("UICorner")
	EBtnCorner.CornerRadius = UDim.new(0, 6)
	EBtnCorner.Parent = EBtn

	EBtn.MouseButton1Click:Connect(function()
		ETextBox.Text = emote.cmd
		sendChat(emote.cmd)
	end)

	EBtn.MouseEnter:Connect(function()
		TweenService:Create(EBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(90, 0, 130)}):Play()
	end)
	EBtn.MouseLeave:Connect(function()
		TweenService:Create(EBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(22, 22, 40)}):Play()
	end)
end

ESendBtn.MouseButton1Click:Connect(function()
	local txt = ETextBox.Text
	if txt ~= "" then
		sendChat(txt)
	end
end)

-- ============================================================
-- EMOTE TOGGLE BUTTON
-- ============================================================
local emoteBodyVisible = true

emoteBtn.MouseButton1Click:Connect(function()
	States.Emote = not States.Emote
	emoteUpdate(States.Emote)
	EmotePanel.Visible = States.Emote
end)

-- Emote panel minimize/close
local emoteBodyPanel = EScroll

EMinBtn.MouseButton1Click:Connect(function()
	emoteBodyVisible = not emoteBodyVisible
	EScroll.Visible = emoteBodyVisible
	ETextBox.Visible = emoteBodyVisible
	ESendBtn.Visible = emoteBodyVisible
	local newH = emoteBodyVisible and 480 or 50
	TweenService:Create(EmotePanel, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = UDim2.new(0, 290, 0, newH)}):Play()
end)

ECloseBtn.MouseButton1Click:Connect(function()
	States.Emote = false
	emoteUpdate(false)
	EmotePanel.Visible = false
end)

-- ============================================================
-- DRAGGABLE MAIN FRAME
-- ============================================================
local function makeDraggable(frame, dragHandle)
	local dragging = false
	local dragInput, mousePos, framePos

	dragHandle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			mousePos = input.Position
			framePos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	dragHandle.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and input == dragInput then
			local delta = input.Position - mousePos
			frame.Position = UDim2.new(
				framePos.X.Scale, framePos.X.Offset + delta.X,
				framePos.Y.Scale, framePos.Y.Offset + delta.Y
			)
		end
	end)
end

makeDraggable(MainFrame, Header)
makeDraggable(EmotePanel, EHeader)

-- ============================================================
-- MINIMIZE MAIN
-- ============================================================
local bodyVisible = true
MinBtn.MouseButton1Click:Connect(function()
	bodyVisible = not bodyVisible
	ScrollFrame.Visible = bodyVisible
	local newH = bodyVisible and 540 or 50
	TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = UDim2.new(0, 320, 0, newH)}):Play()
end)

CloseBtn.MouseButton1Click:Connect(function()
	TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = UDim2.new(0, 0, 0, 0)}):Play()
	task.wait(0.35)
	ScreenGui:Destroy()
end)

-- ============================================================
-- INTRO ANIMATION
-- ============================================================
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Visible = true

task.spawn(function()
	TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		Size = UDim2.new(0, 320, 0, 540)
	}):Play()
end)

-- ============================================================
-- Character Respawn handler
-- ============================================================
Player.CharacterAdded:Connect(function(newChar)
	Character = newChar
	Humanoid = newChar:WaitForChild("Humanoid")
	HumanoidRootPart = newChar:WaitForChild("HumanoidRootPart")

	-- Reapply active states
	if States.SuperSpeed then Humanoid.WalkSpeed = 700 end
	if States.SuperJump then Humanoid.JumpPower = 200 end
	if States.Immortal then enableImmortal() end
	if States.NoRagdoll then enableNoRagdoll() end
end)

print("[AdminScript] Loaded ✓")
