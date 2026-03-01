-- ============================================================
--  ZHD Graphics Settings GUI | by Script Generator
--  Features: Drag, Scroll, Minimize, Animate, Confirm Dialogs
-- ============================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ============================================================
-- GRAPHICS PRESETS
-- ============================================================
local Presets = {
    ZHD = {
        label = "ZHD — 8K Ultra HD",
        desc = "Efek Bayangan Penuh, Cahaya Matahari Sangat Intens",
        color = Color3.fromRGB(255, 215, 0),
        warn = true,
        apply = function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level21
            Lighting.GlobalShadows = true
            Lighting.Brightness = 4
            Lighting.Ambient = Color3.fromRGB(120, 120, 120)
            Lighting.OutdoorAmbient = Color3.fromRGB(160, 160, 160)
            Lighting.ShadowSoftness = 0.05
            Lighting.FogEnd = 100000
            Lighting.FogStart = 99000
            -- Atmosphere
            local atm = Lighting:FindFirstChildOfClass("Atmosphere") or Instance.new("Atmosphere", Lighting)
            atm.Density = 0.3
            atm.Offset = 0.25
            atm.Color = Color3.fromRGB(199, 199, 199)
            atm.Decay = Color3.fromRGB(106, 112, 125)
            atm.Glare = 1
            atm.Haze = 2
            -- Bloom
            local bloom = Lighting:FindFirstChildOfClass("BloomEffect") or Instance.new("BloomEffect", Lighting)
            bloom.Intensity = 1.5
            bloom.Size = 56
            bloom.Threshold = 0.9
            -- SunRays
            local sun = Lighting:FindFirstChildOfClass("SunRaysEffect") or Instance.new("SunRaysEffect", Lighting)
            sun.Intensity = 0.5
            sun.Spread = 1
            -- DepthOfField
            local dof = Lighting:FindFirstChildOfClass("DepthOfFieldEffect") or Instance.new("DepthOfFieldEffect", Lighting)
            dof.FarIntensity = 0.5
            dof.NearIntensity = 0.5
            dof.FocusDistance = 15
            dof.InFocusRadius = 10
            -- ColorCorrection
            local cc = Lighting:FindFirstChildOfClass("ColorCorrectionEffect") or Instance.new("ColorCorrectionEffect", Lighting)
            cc.Brightness = 0.1
            cc.Contrast = 0.2
            cc.Saturation = 0.2
            cc.TintColor = Color3.fromRGB(255, 245, 220)
        end
    },
    OHD = {
        label = "OHD — 4K HD",
        desc = "Bayangan Canggih, Cahaya Matahari Sedang",
        color = Color3.fromRGB(100, 220, 255),
        warn = false,
        apply = function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level17
            Lighting.GlobalShadows = true
            Lighting.Brightness = 3
            Lighting.Ambient = Color3.fromRGB(100, 100, 100)
            Lighting.OutdoorAmbient = Color3.fromRGB(140, 140, 140)
            Lighting.ShadowSoftness = 0.15
            Lighting.FogEnd = 80000
            Lighting.FogStart = 79000
            local atm = Lighting:FindFirstChildOfClass("Atmosphere") or Instance.new("Atmosphere", Lighting)
            atm.Density = 0.35
            atm.Offset = 0.2
            atm.Glare = 0.6
            atm.Haze = 3
            local bloom = Lighting:FindFirstChildOfClass("BloomEffect") or Instance.new("BloomEffect", Lighting)
            bloom.Intensity = 1
            bloom.Size = 40
            bloom.Threshold = 0.95
            local sun = Lighting:FindFirstChildOfClass("SunRaysEffect") or Instance.new("SunRaysEffect", Lighting)
            sun.Intensity = 0.3
            sun.Spread = 0.8
            local dof = Lighting:FindFirstChildOfClass("DepthOfFieldEffect")
            if dof then dof:Destroy() end
            local cc = Lighting:FindFirstChildOfClass("ColorCorrectionEffect") or Instance.new("ColorCorrectionEffect", Lighting)
            cc.Brightness = 0.05
            cc.Contrast = 0.1
            cc.Saturation = 0.1
            cc.TintColor = Color3.fromRGB(255, 250, 235)
        end
    },
    MHD = {
        label = "MHD — 2K HD",
        desc = "Bayangan Sedikit, Cahaya Matahari Sedikit",
        color = Color3.fromRGB(100, 255, 160),
        warn = false,
        apply = function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level13
            Lighting.GlobalShadows = true
            Lighting.Brightness = 2.5
            Lighting.Ambient = Color3.fromRGB(90, 90, 90)
            Lighting.OutdoorAmbient = Color3.fromRGB(120, 120, 120)
            Lighting.ShadowSoftness = 0.3
            Lighting.FogEnd = 60000
            Lighting.FogStart = 59000
            local atm = Lighting:FindFirstChildOfClass("Atmosphere") or Instance.new("Atmosphere", Lighting)
            atm.Density = 0.4
            atm.Glare = 0.2
            atm.Haze = 5
            local bloom = Lighting:FindFirstChildOfClass("BloomEffect") or Instance.new("BloomEffect", Lighting)
            bloom.Intensity = 0.6
            bloom.Size = 24
            bloom.Threshold = 1
            local sun = Lighting:FindFirstChildOfClass("SunRaysEffect") or Instance.new("SunRaysEffect", Lighting)
            sun.Intensity = 0.15
            sun.Spread = 0.5
            local dof = Lighting:FindFirstChildOfClass("DepthOfFieldEffect")
            if dof then dof:Destroy() end
            local cc = Lighting:FindFirstChildOfClass("ColorCorrectionEffect") or Instance.new("ColorCorrectionEffect", Lighting)
            cc.Brightness = 0
            cc.Contrast = 0.05
            cc.Saturation = 0.05
            cc.TintColor = Color3.new(1,1,1)
        end
    },
    FHD = {
        label = "FHD — 1080P",
        desc = "Bayangan Super Sedikit, Cahaya Minimal",
        color = Color3.fromRGB(180, 255, 100),
        warn = false,
        apply = function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level10
            Lighting.GlobalShadows = true
            Lighting.Brightness = 2
            Lighting.Ambient = Color3.fromRGB(80, 80, 80)
            Lighting.OutdoorAmbient = Color3.fromRGB(100, 100, 100)
            Lighting.ShadowSoftness = 0.5
            Lighting.FogEnd = 40000
            Lighting.FogStart = 39000
            local bloom = Lighting:FindFirstChildOfClass("BloomEffect") or Instance.new("BloomEffect", Lighting)
            bloom.Intensity = 0.3
            bloom.Size = 12
            bloom.Threshold = 1.1
            local sun = Lighting:FindFirstChildOfClass("SunRaysEffect")
            if sun then sun:Destroy() end
            local atm = Lighting:FindFirstChildOfClass("Atmosphere")
            if atm then atm:Destroy() end
            local dof = Lighting:FindFirstChildOfClass("DepthOfFieldEffect")
            if dof then dof:Destroy() end
            local cc = Lighting:FindFirstChildOfClass("ColorCorrectionEffect") or Instance.new("ColorCorrectionEffect", Lighting)
            cc.Brightness = 0
            cc.Contrast = 0
            cc.Saturation = 0
            cc.TintColor = Color3.new(1,1,1)
        end
    },
    ZLOW = {
        label = "ZLOW — 720P",
        desc = "Tanpa Bayangan, Air Memantul Cahaya",
        color = Color3.fromRGB(255, 200, 80),
        warn = false,
        apply = function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level07
            Lighting.GlobalShadows = false
            Lighting.Brightness = 1.5
            Lighting.Ambient = Color3.fromRGB(70, 70, 70)
            Lighting.OutdoorAmbient = Color3.fromRGB(80, 80, 80)
            Lighting.ShadowSoftness = 1
            Lighting.FogEnd = 20000
            Lighting.FogStart = 1000
            local bloom = Lighting:FindFirstChildOfClass("BloomEffect")
            if bloom then bloom:Destroy() end
            local sun = Lighting:FindFirstChildOfClass("SunRaysEffect")
            if sun then sun:Destroy() end
            local atm = Lighting:FindFirstChildOfClass("Atmosphere")
            if atm then atm:Destroy() end
            local dof = Lighting:FindFirstChildOfClass("DepthOfFieldEffect")
            if dof then dof:Destroy() end
            local cc = Lighting:FindFirstChildOfClass("ColorCorrectionEffect")
            if cc then cc:Destroy() end
        end
    },
    OLOW = {
        label = "OLOW — 540P",
        desc = "Tanpa Bayangan, Cahaya Burik",
        color = Color3.fromRGB(255, 160, 80),
        warn = false,
        apply = function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level05
            Lighting.GlobalShadows = false
            Lighting.Brightness = 1
            Lighting.Ambient = Color3.fromRGB(60, 60, 60)
            Lighting.OutdoorAmbient = Color3.fromRGB(60, 60, 60)
            Lighting.ShadowSoftness = 1
            Lighting.FogEnd = 10000
            Lighting.FogStart = 500
            local bloom = Lighting:FindFirstChildOfClass("BloomEffect")
            if bloom then bloom:Destroy() end
            local sun = Lighting:FindFirstChildOfClass("SunRaysEffect")
            if sun then sun:Destroy() end
            local atm = Lighting:FindFirstChildOfClass("Atmosphere")
            if atm then atm:Destroy() end
            local dof = Lighting:FindFirstChildOfClass("DepthOfFieldEffect")
            if dof then dof:Destroy() end
            local cc = Lighting:FindFirstChildOfClass("ColorCorrectionEffect")
            if cc then cc:Destroy() end
        end
    },
    MLOW = {
        label = "MLOW — 320P",
        desc = "Grafik Burik",
        color = Color3.fromRGB(200, 120, 80),
        warn = false,
        apply = function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level03
            Lighting.GlobalShadows = false
            Lighting.Brightness = 0.8
            Lighting.Ambient = Color3.fromRGB(50, 50, 50)
            Lighting.OutdoorAmbient = Color3.fromRGB(50, 50, 50)
            Lighting.FogEnd = 5000
            Lighting.FogStart = 200
            local bloom = Lighting:FindFirstChildOfClass("BloomEffect")
            if bloom then bloom:Destroy() end
            local sun = Lighting:FindFirstChildOfClass("SunRaysEffect")
            if sun then sun:Destroy() end
            local atm = Lighting:FindFirstChildOfClass("Atmosphere")
            if atm then atm:Destroy() end
            local dof = Lighting:FindFirstChildOfClass("DepthOfFieldEffect")
            if dof then dof:Destroy() end
            local cc = Lighting:FindFirstChildOfClass("ColorCorrectionEffect")
            if cc then cc:Destroy() end
        end
    },
    FLOW = {
        label = "FLOW — 100P",
        desc = "Grafik Paling Burik",
        color = Color3.fromRGB(180, 80, 80),
        warn = false,
        apply = function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            Lighting.GlobalShadows = false
            Lighting.Brightness = 0.5
            Lighting.Ambient = Color3.fromRGB(30, 30, 30)
            Lighting.OutdoorAmbient = Color3.fromRGB(30, 30, 30)
            Lighting.FogEnd = 2000
            Lighting.FogStart = 100
            local bloom = Lighting:FindFirstChildOfClass("BloomEffect")
            if bloom then bloom:Destroy() end
            local sun = Lighting:FindFirstChildOfClass("SunRaysEffect")
            if sun then sun:Destroy() end
            local atm = Lighting:FindFirstChildOfClass("Atmosphere")
            if atm then atm:Destroy() end
            local dof = Lighting:FindFirstChildOfClass("DepthOfFieldEffect")
            if dof then dof:Destroy() end
            local cc = Lighting:FindFirstChildOfClass("ColorCorrectionEffect")
            if cc then cc:Destroy() end
        end
    },
}

local PresetOrder = {"ZHD","OHD","MHD","FHD","ZLOW","OLOW","MLOW","FLOW"}

-- ============================================================
-- BUILD GUI
-- ============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ZHD_GraphicsGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = playerGui

-- ============================================================
-- TOGGLE BUTTON (always visible)
-- ============================================================
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Size = UDim2.new(0, 110, 0, 36)
ToggleBtn.Position = UDim2.new(0, 12, 0.5, -18)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Text = "🎮 Grafik"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
ToggleBtn.TextSize = 15
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.ZIndex = 10
ToggleBtn.Parent = ScreenGui

local tCorner = Instance.new("UICorner", ToggleBtn)
tCorner.CornerRadius = UDim.new(0, 10)
local tStroke = Instance.new("UIStroke", ToggleBtn)
tStroke.Color = Color3.fromRGB(255, 215, 0)
tStroke.Thickness = 1.5

-- ============================================================
-- MAIN FRAME
-- ============================================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 420)
MainFrame.Position = UDim2.new(0, 130, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 22)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.ZIndex = 5
MainFrame.Parent = ScreenGui

local mCorner = Instance.new("UICorner", MainFrame)
mCorner.CornerRadius = UDim.new(0, 14)
local mStroke = Instance.new("UIStroke", MainFrame)
mStroke.Color = Color3.fromRGB(60, 60, 100)
mStroke.Thickness = 1.5

-- Gradient Background
local grad = Instance.new("UIGradient", MainFrame)
grad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 18, 38)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 18)),
})
grad.Rotation = 135

-- ============================================================
-- TITLE BAR
-- ============================================================
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 46)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 6
TitleBar.Parent = MainFrame

local tbCorner = Instance.new("UICorner", TitleBar)
tbCorner.CornerRadius = UDim.new(0, 14)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -100, 1, 0)
TitleLabel.Position = UDim2.new(0, 14, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "⚙️ ZHD Grafik Settings"
TitleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
TitleLabel.TextSize = 14
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 7
TitleLabel.Parent = TitleBar

-- Minimize Button
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 28, 0, 28)
MinBtn.Position = UDim2.new(1, -66, 0.5, -14)
MinBtn.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
MinBtn.BorderSizePixel = 0
MinBtn.Text = "—"
MinBtn.TextColor3 = Color3.new(0,0,0)
MinBtn.TextSize = 14
MinBtn.Font = Enum.Font.GothamBold
MinBtn.ZIndex = 8
MinBtn.Parent = TitleBar
local mbCorner = Instance.new("UICorner", MinBtn)
mbCorner.CornerRadius = UDim.new(1, 0)

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -32, 0.5, -14)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.ZIndex = 8
CloseBtn.Parent = TitleBar
local cbCorner = Instance.new("UICorner", CloseBtn)
cbCorner.CornerRadius = UDim.new(1, 0)

-- Active preset label
local ActiveLabel = Instance.new("TextLabel")
ActiveLabel.Name = "ActiveLabel"
ActiveLabel.Size = UDim2.new(1, -20, 0, 22)
ActiveLabel.Position = UDim2.new(0, 10, 0, 50)
ActiveLabel.BackgroundTransparency = 1
ActiveLabel.Text = "Aktif: —"
ActiveLabel.TextColor3 = Color3.fromRGB(180, 180, 255)
ActiveLabel.TextSize = 12
ActiveLabel.Font = Enum.Font.Gotham
ActiveLabel.TextXAlignment = Enum.TextXAlignment.Left
ActiveLabel.ZIndex = 6
ActiveLabel.Parent = MainFrame

-- Divider
local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(1, -20, 0, 1)
Divider.Position = UDim2.new(0, 10, 0, 76)
Divider.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
Divider.BorderSizePixel = 0
Divider.ZIndex = 6
Divider.Parent = MainFrame

-- ============================================================
-- SCROLL FRAME
-- ============================================================
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Name = "ScrollFrame"
ScrollFrame.Size = UDim2.new(1, -10, 1, -90)
ScrollFrame.Position = UDim2.new(0, 5, 0, 82)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 215, 0)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollFrame.ZIndex = 6
ScrollFrame.Parent = MainFrame

local ListLayout = Instance.new("UIListLayout", ScrollFrame)
ListLayout.Padding = UDim.new(0, 8)
ListLayout.FillDirection = Enum.FillDirection.Vertical
ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local ListPad = Instance.new("UIPadding", ScrollFrame)
ListPad.PaddingTop = UDim.new(0, 6)
ListPad.PaddingBottom = UDim.new(0, 6)
ListPad.PaddingLeft = UDim.new(0, 4)
ListPad.PaddingRight = UDim.new(0, 4)

-- ============================================================
-- CREATE PRESET BUTTONS
-- ============================================================
local function createPresetButton(key)
    local preset = Presets[key]

    local Btn = Instance.new("TextButton")
    Btn.Name = key .. "Btn"
    Btn.Size = UDim2.new(1, -8, 0, 56)
    Btn.BackgroundColor3 = Color3.fromRGB(20, 22, 40)
    Btn.BorderSizePixel = 0
    Btn.Text = ""
    Btn.ZIndex = 7
    Btn.Parent = ScrollFrame

    local btnCorner = Instance.new("UICorner", Btn)
    btnCorner.CornerRadius = UDim.new(0, 10)
    local btnStroke = Instance.new("UIStroke", Btn)
    btnStroke.Color = preset.color
    btnStroke.Thickness = 1.2
    btnStroke.Transparency = 0.5

    -- Glow bar left
    local GlowBar = Instance.new("Frame")
    GlowBar.Size = UDim2.new(0, 4, 0.7, 0)
    GlowBar.Position = UDim2.new(0, 8, 0.15, 0)
    GlowBar.BackgroundColor3 = preset.color
    GlowBar.BorderSizePixel = 0
    GlowBar.ZIndex = 8
    GlowBar.Parent = Btn
    local gbCorner = Instance.new("UICorner", GlowBar)
    gbCorner.CornerRadius = UDim.new(1, 0)

    -- Label
    local NameLabel = Instance.new("TextLabel")
    NameLabel.Size = UDim2.new(1, -30, 0, 22)
    NameLabel.Position = UDim2.new(0, 22, 0, 6)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = preset.label
    NameLabel.TextColor3 = preset.color
    NameLabel.TextSize = 13
    NameLabel.Font = Enum.Font.GothamBold
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.ZIndex = 8
    NameLabel.Parent = Btn

    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(1, -30, 0, 18)
    DescLabel.Position = UDim2.new(0, 22, 0, 28)
    DescLabel.BackgroundTransparency = 1
    DescLabel.Text = preset.desc
    DescLabel.TextColor3 = Color3.fromRGB(160, 160, 200)
    DescLabel.TextSize = 10
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.ZIndex = 8
    DescLabel.Parent = Btn

    -- Hover / Click animation
    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(30, 32, 60)}):Play()
        TweenService:Create(btnStroke, TweenInfo.new(0.15), {Transparency = 0}):Play()
    end)
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(20, 22, 40)}):Play()
        TweenService:Create(btnStroke, TweenInfo.new(0.15), {Transparency = 0.5}):Play()
    end)

    return Btn, preset
end

-- ============================================================
-- CONFIRM DIALOG FACTORY
-- ============================================================
local function showConfirmDialog(title, body, onYes)
    -- Overlay
    local Overlay = Instance.new("Frame")
    Overlay.Size = UDim2.new(1, 0, 1, 0)
    Overlay.BackgroundColor3 = Color3.new(0, 0, 0)
    Overlay.BackgroundTransparency = 0.4
    Overlay.BorderSizePixel = 0
    Overlay.ZIndex = 20
    Overlay.Parent = ScreenGui

    local Dialog = Instance.new("Frame")
    Dialog.Size = UDim2.new(0, 280, 0, 160)
    Dialog.Position = UDim2.new(0.5, -140, 0.5, -80)
    Dialog.BackgroundColor3 = Color3.fromRGB(16, 16, 30)
    Dialog.BorderSizePixel = 0
    Dialog.ZIndex = 21
    Dialog.Parent = ScreenGui

    local dCorner = Instance.new("UICorner", Dialog)
    dCorner.CornerRadius = UDim.new(0, 14)
    local dStroke = Instance.new("UIStroke", Dialog)
    dStroke.Color = Color3.fromRGB(255, 200, 0)
    dStroke.Thickness = 1.5

    -- Animate in
    Dialog.Position = UDim2.new(0.5, -140, 0.6, -80)
    Dialog.BackgroundTransparency = 1
    TweenService:Create(Dialog, TweenInfo.new(0.25, Enum.EasingStyle.Back), {
        Position = UDim2.new(0.5, -140, 0.5, -80),
        BackgroundTransparency = 0
    }):Play()

    local TitleLbl = Instance.new("TextLabel")
    TitleLbl.Size = UDim2.new(1, -20, 0, 30)
    TitleLbl.Position = UDim2.new(0, 10, 0, 8)
    TitleLbl.BackgroundTransparency = 1
    TitleLbl.Text = title
    TitleLbl.TextColor3 = Color3.fromRGB(255, 215, 0)
    TitleLbl.TextSize = 14
    TitleLbl.Font = Enum.Font.GothamBold
    TitleLbl.ZIndex = 22
    TitleLbl.Parent = Dialog

    local BodyLbl = Instance.new("TextLabel")
    BodyLbl.Size = UDim2.new(1, -20, 0, 50)
    BodyLbl.Position = UDim2.new(0, 10, 0, 40)
    BodyLbl.BackgroundTransparency = 1
    BodyLbl.Text = body
    BodyLbl.TextColor3 = Color3.fromRGB(200, 200, 220)
    BodyLbl.TextSize = 11
    BodyLbl.Font = Enum.Font.Gotham
    BodyLbl.TextWrapped = true
    BodyLbl.ZIndex = 22
    BodyLbl.Parent = Dialog

    local function makeBtn(text, bgColor, xPos)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0, 110, 0, 34)
        b.Position = UDim2.new(0, xPos, 1, -46)
        b.BackgroundColor3 = bgColor
        b.BorderSizePixel = 0
        b.Text = text
        b.TextColor3 = Color3.new(1,1,1)
        b.TextSize = 13
        b.Font = Enum.Font.GothamBold
        b.ZIndex = 22
        b.Parent = Dialog
        local bc = Instance.new("UICorner", b)
        bc.CornerRadius = UDim.new(0, 8)
        return b
    end

    local BatalBtn = makeBtn("✕ Batal", Color3.fromRGB(80, 30, 30), 14)
    local IyaBtn   = makeBtn("✔ Iya", Color3.fromRGB(30, 100, 50), 156)

    local function closeDialog()
        TweenService:Create(Dialog, TweenInfo.new(0.2), {
            Position = UDim2.new(0.5, -140, 0.6, -80),
            BackgroundTransparency = 1
        }):Play()
        TweenService:Create(Overlay, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        task.delay(0.25, function()
            Dialog:Destroy()
            Overlay:Destroy()
        end)
    end

    BatalBtn.MouseButton1Click:Connect(closeDialog)
    IyaBtn.MouseButton1Click:Connect(function()
        closeDialog()
        onYes()
    end)
end

-- ============================================================
-- WIRE UP BUTTONS
-- ============================================================
for _, key in ipairs(PresetOrder) do
    local Btn, preset = createPresetButton(key)

    Btn.MouseButton1Click:Connect(function()
        -- Click animation
        TweenService:Create(Btn, TweenInfo.new(0.08), {Size = UDim2.new(1, -16, 0, 52)}):Play()
        task.delay(0.08, function()
            TweenService:Create(Btn, TweenInfo.new(0.12), {Size = UDim2.new(1, -8, 0, 56)}):Play()
        end)

        if preset.warn then
            showConfirmDialog(
                "⚠️ Peringatan Grafik Tinggi",
                "Apakah Anda yakin ingin mengubah ke grafik " .. preset.label .. "?\nHal ini membuat GPU bekerja sangat keras!",
                function()
                    preset.apply()
                    ActiveLabel.Text = "Aktif: " .. preset.label
                    TweenService:Create(ActiveLabel, TweenInfo.new(0.3), {TextColor3 = preset.color}):Play()
                end
            )
        else
            showConfirmDialog(
                "🔧 Ubah Grafik",
                "Apakah Anda yakin ingin grafik diubah ke " .. preset.label .. "?",
                function()
                    preset.apply()
                    ActiveLabel.Text = "Aktif: " .. preset.label
                    TweenService:Create(ActiveLabel, TweenInfo.new(0.3), {TextColor3 = preset.color}):Play()
                end
            )
        end
    end)
end

-- ============================================================
-- DRAG & DROP
-- ============================================================
local dragging, dragInput, dragStart, startPos = false, nil, nil, nil

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

-- ============================================================
-- MINIMIZE
-- ============================================================
local minimized = false
local fullHeight = 420
local miniHeight = 46

MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
            Size = UDim2.new(0, 300, 0, miniHeight)
        }):Play()
        MinBtn.Text = "+"
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
            Size = UDim2.new(0, 300, 0, fullHeight)
        }):Play()
        MinBtn.Text = "—"
    end
end)

-- ============================================================
-- CLOSE (with confirm)
-- ============================================================
CloseBtn.MouseButton1Click:Connect(function()
    showConfirmDialog(
        "🗑️ Hapus UI",
        "Apakah Anda yakin ingin menghapus UI ini?\nTindakan ini tidak dapat diurungkan!",
        function()
            TweenService:Create(MainFrame, TweenInfo.new(0.3), {
                Size = UDim2.new(0, 0, 0, 0),
                BackgroundTransparency = 1
            }):Play()
            TweenService:Create(ToggleBtn, TweenInfo.new(0.3), {
                Size = UDim2.new(0, 0, 0, 0)
            }):Play()
            task.delay(0.35, function()
                ScreenGui:Destroy()
            end)
        end
    )
end)

-- ============================================================
-- TOGGLE OPEN/CLOSE
-- ============================================================
local guiOpen = true

ToggleBtn.MouseButton1Click:Connect(function()
    guiOpen = not guiOpen
    if guiOpen then
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
            Size = UDim2.new(0, 300, 0, minimized and miniHeight or fullHeight)
        }):Play()
        ToggleBtn.Text = "🎮 Grafik"
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.25), {
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
        task.delay(0.28, function()
            MainFrame.Visible = false
        end)
        ToggleBtn.Text = "🎮 Buka"
    end
end)

-- ============================================================
-- ENTRANCE ANIMATION
-- ============================================================
MainFrame.Size = UDim2.new(0, 0, 0, 0)
task.defer(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 300, 0, fullHeight)
    }):Play()
end)

print("[ZHD Graphics] GUI Loaded! Gunakan tombol 🎮 Grafik untuk membuka/tutup.")
