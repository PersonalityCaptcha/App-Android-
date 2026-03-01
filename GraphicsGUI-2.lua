-- ============================================================
--  ZHD Graphics Controller  |  by Script Generator
--  Roblox LocalScript  (place inside StarterPlayerScripts)
-- ============================================================

local Players        = game:GetService("Players")
local Lighting       = game:GetService("Lighting")
local RunService     = game:GetService("RunService")
local TweenService   = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer  = Players.LocalPlayer
local PlayerGui    = LocalPlayer:WaitForChild("PlayerGui")

-- ============================================================
--  PRESET DATA
-- ============================================================
local PRESETS = {
    {
        id   = "ZHD",
        label= "ZHD",
        sub  = "8K Ultra HD",
        desc = "Grafik 8K canggih dengan efek bayangan penuh, HDR ekstrem,\ndan efek cahaya matahari terang maksimum.\n\nSalin teks ini untuk referensi preset Anda.",
        icon = "[8K]",
        warn = true,
        -- Lighting values
        brightness       = 3,
        ambient          = Color3.fromRGB(110,110,130),
        colorShift_Top   = Color3.fromRGB(255,220,150),
        colorShift_Bottom= Color3.fromRGB(80,90,120),
        shadowSoftness   = 0,
        -- Post FX
        bloom_intensity  = 1.2,
        bloom_size       = 56,
        bloom_threshold  = 0.95,
        blur_size        = 0,
        sunRays_intensity= 0.25,
        sunRays_spread   = 1,
        colorCorrection  = {brightness=0.05, contrast=0.15, saturation=0.3, tintColor=Color3.fromRGB(255,250,240)},
        depthOfField     = {farIntensity=0, focusDistance=50, inFocusRadius=40, nearIntensity=0},
        technology       = Enum.Technology.Future,
        globalShadows    = true,
    },
    {
        id   = "OHD",
        label= "OHD",
        sub  = "4K High Definition",
        desc = "Grafik 4K dengan efek bayangan sedikit lebih ringan,\ncahaya matahari yang masih terasa nyata.\n\nSalin teks ini untuk referensi preset Anda.",
        icon = "[4K]",
        warn = false,
        brightness       = 2.2,
        ambient          = Color3.fromRGB(100,100,115),
        colorShift_Top   = Color3.fromRGB(240,210,150),
        colorShift_Bottom= Color3.fromRGB(70,80,100),
        shadowSoftness   = 0.2,
        bloom_intensity  = 0.85,
        bloom_size       = 40,
        bloom_threshold  = 0.97,
        blur_size        = 0,
        sunRays_intensity= 0.15,
        sunRays_spread   = 0.8,
        colorCorrection  = {brightness=0.02, contrast=0.1, saturation=0.2, tintColor=Color3.fromRGB(255,252,245)},
        depthOfField     = {farIntensity=0, focusDistance=80, inFocusRadius=60, nearIntensity=0},
        technology       = Enum.Technology.Future,
        globalShadows    = true,
    },
    {
        id   = "MHD",
        label= "MHD",
        sub  = "2K High Definition",
        desc = "Grafik 2K, bayangan sedikit, efek cahaya lebih subtle.\n\nSalin teks ini untuk referensi preset Anda.",
        icon = "[2K]",
        warn = false,
        brightness       = 1.8,
        ambient          = Color3.fromRGB(120,120,130),
        colorShift_Top   = Color3.fromRGB(220,200,160),
        colorShift_Bottom= Color3.fromRGB(90,90,105),
        shadowSoftness   = 0.35,
        bloom_intensity  = 0.5,
        bloom_size       = 24,
        bloom_threshold  = 0.99,
        blur_size        = 0,
        sunRays_intensity= 0.07,
        sunRays_spread   = 0.5,
        colorCorrection  = {brightness=0, contrast=0.05, saturation=0.1, tintColor=Color3.fromRGB(255,255,255)},
        depthOfField     = {farIntensity=0, focusDistance=100, inFocusRadius=80, nearIntensity=0},
        technology       = Enum.Technology.Future,
        globalShadows    = true,
    },
    {
        id   = "FHD",
        label= "FHD",
        sub  = "1080P Full HD",
        desc = "Grafik 1080P, bayangan super tipis, sedikit efek cahaya.\n\nSalin teks ini untuk referensi preset Anda.",
        icon = "[FHD]",
        warn = false,
        brightness       = 1.5,
        ambient          = Color3.fromRGB(130,130,135),
        colorShift_Top   = Color3.fromRGB(210,205,185),
        colorShift_Bottom= Color3.fromRGB(100,100,105),
        shadowSoftness   = 0.5,
        bloom_intensity  = 0.25,
        bloom_size       = 12,
        bloom_threshold  = 1,
        blur_size        = 0,
        sunRays_intensity= 0.03,
        sunRays_spread   = 0.3,
        colorCorrection  = {brightness=0, contrast=0, saturation=0.05, tintColor=Color3.fromRGB(255,255,255)},
        depthOfField     = {farIntensity=0, focusDistance=150, inFocusRadius=120, nearIntensity=0},
        technology       = Enum.Technology.ShadowMap,
        globalShadows    = true,
    },
    {
        id   = "ZLOW",
        label= "ZLOW",
        sub  = "720P Standard",
        desc = "Grafik 720P, tanpa bayangan, tanpa cahaya matahari.\nAir masih memantulkan cahaya sedikit.\n\nSalin teks ini untuk referensi preset Anda.",
        icon = "[720]",
        warn = false,
        brightness       = 1.2,
        ambient          = Color3.fromRGB(140,140,140),
        colorShift_Top   = Color3.fromRGB(200,200,200),
        colorShift_Bottom= Color3.fromRGB(115,115,115),
        shadowSoftness   = 1,
        bloom_intensity  = 0.1,
        bloom_size       = 5,
        bloom_threshold  = 1,
        blur_size        = 0,
        sunRays_intensity= 0,
        sunRays_spread   = 0,
        colorCorrection  = {brightness=0, contrast=0, saturation=0, tintColor=Color3.fromRGB(255,255,255)},
        depthOfField     = {farIntensity=0, focusDistance=200, inFocusRadius=150, nearIntensity=0},
        technology       = Enum.Technology.Compatibility,
        globalShadows    = false,
    },
    {
        id   = "OLOW",
        label= "OLOW",
        sub  = "540P Low",
        desc = "Grafik 540P, tanpa bayangan, cahaya burik.\n\nSalin teks ini untuk referensi preset Anda.",
        icon = "[540]",
        warn = false,
        brightness       = 1.0,
        ambient          = Color3.fromRGB(150,150,150),
        colorShift_Top   = Color3.fromRGB(185,185,185),
        colorShift_Bottom= Color3.fromRGB(130,130,130),
        shadowSoftness   = 1,
        bloom_intensity  = 0,
        bloom_size       = 0,
        bloom_threshold  = 1,
        blur_size        = 0,
        sunRays_intensity= 0,
        sunRays_spread   = 0,
        colorCorrection  = {brightness=-0.05, contrast=-0.05, saturation=-0.2, tintColor=Color3.fromRGB(240,240,240)},
        depthOfField     = {farIntensity=0, focusDistance=200, inFocusRadius=200, nearIntensity=0},
        technology       = Enum.Technology.Compatibility,
        globalShadows    = false,
    },
    {
        id   = "MLOW",
        label= "MLOW",
        sub  = "320P Very Low",
        desc = "Grafik 320P sangat burik, performa maksimum.\n\nSalin teks ini untuk referensi preset Anda.",
        icon = "[320]",
        warn = false,
        brightness       = 0.8,
        ambient          = Color3.fromRGB(160,160,160),
        colorShift_Top   = Color3.fromRGB(170,170,170),
        colorShift_Bottom= Color3.fromRGB(145,145,145),
        shadowSoftness   = 1,
        bloom_intensity  = 0,
        bloom_size       = 0,
        bloom_threshold  = 1,
        blur_size        = 2,
        sunRays_intensity= 0,
        sunRays_spread   = 0,
        colorCorrection  = {brightness=-0.1, contrast=-0.1, saturation=-0.4, tintColor=Color3.fromRGB(230,230,230)},
        depthOfField     = {farIntensity=0, focusDistance=200, inFocusRadius=200, nearIntensity=0},
        technology       = Enum.Technology.Compatibility,
        globalShadows    = false,
    },
    {
        id   = "FLOW",
        label= "FLOW",
        sub  = "100P Minimum",
        desc = "Grafik 100P paling burik, grafik terendah mungkin.\n\nSalin teks ini untuk referensi preset Anda.",
        icon = "[100]",
        warn = false,
        brightness       = 0.5,
        ambient          = Color3.fromRGB(175,175,175),
        colorShift_Top   = Color3.fromRGB(155,155,155),
        colorShift_Bottom= Color3.fromRGB(160,160,160),
        shadowSoftness   = 1,
        bloom_intensity  = 0,
        bloom_size       = 0,
        bloom_threshold  = 1,
        blur_size        = 8,
        sunRays_intensity= 0,
        sunRays_spread   = 0,
        colorCorrection  = {brightness=-0.15, contrast=-0.15, saturation=-0.8, tintColor=Color3.fromRGB(210,210,210)},
        depthOfField     = {farIntensity=0.5, focusDistance=10, inFocusRadius=5, nearIntensity=0.5},
        technology       = Enum.Technology.Compatibility,
        globalShadows    = false,
    },
}

-- Time of Day Presets
local TIME_PRESETS = {
    {id="Sun",     label="Siang",    icon="[O]",  clockTime=14,  fogColor=Color3.fromRGB(200,220,255), fogEnd=1800},
    {id="Sunrise", label="Fajar",   icon="[/]",  clockTime=6.5, fogColor=Color3.fromRGB(255,190,130), fogEnd=1200},
    {id="Sunset",  label="Senja",   icon="[\\]", clockTime=17.5,fogColor=Color3.fromRGB(255,140,80),  fogEnd=1000},
    {id="Night",   label="Malam",   icon="[*]",  clockTime=23,  fogColor=Color3.fromRGB(20,20,60),    fogEnd=2000},
    {id="Moonrise",label="Bulan Naik",icon="[(]", clockTime=20,  fogColor=Color3.fromRGB(30,30,80),    fogEnd=1500},
    {id="Crescent",label="Sabit",   icon="[C]",  clockTime=2,   fogColor=Color3.fromRGB(15,15,40),    fogEnd=2500},
}

-- ============================================================
--  HELPER: Apply Lighting Preset
-- ============================================================
local function ensureFX()
    local bloom = Lighting:FindFirstChildOfClass("BloomEffect") or Instance.new("BloomEffect", Lighting)
    local blur  = Lighting:FindFirstChildOfClass("BlurEffect")  or Instance.new("BlurEffect",  Lighting)
    local sun   = Lighting:FindFirstChildOfClass("SunRaysEffect") or Instance.new("SunRaysEffect", Lighting)
    local cc    = Lighting:FindFirstChildOfClass("ColorCorrectionEffect") or Instance.new("ColorCorrectionEffect", Lighting)
    local dof   = Lighting:FindFirstChildOfClass("DepthOfFieldEffect") or Instance.new("DepthOfFieldEffect", Lighting)
    return bloom, blur, sun, cc, dof
end

local function applyPreset(p)
    local bloom, blur, sun, cc, dof = ensureFX()
    local tweenInfo = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

    -- Lighting
    TweenService:Create(Lighting, tweenInfo, {
        Brightness       = p.brightness,
        Ambient          = p.ambient,
        ColorShift_Top   = p.colorShift_Top,
        ColorShift_Bottom= p.colorShift_Bottom,
        ShadowSoftness   = p.shadowSoftness,
    }):Play()
    Lighting.Technology   = p.technology
    Lighting.GlobalShadows= p.globalShadows

    -- Bloom
    TweenService:Create(bloom, tweenInfo, {
        Intensity = p.bloom_intensity,
        Size      = p.bloom_size,
        Threshold = p.bloom_threshold,
    }):Play()

    -- Blur
    TweenService:Create(blur, tweenInfo, {Size = p.blur_size}):Play()

    -- Sun Rays
    TweenService:Create(sun, tweenInfo, {
        Intensity = p.sunRays_intensity,
        Spread    = p.sunRays_spread,
    }):Play()

    -- Color Correction
    local c = p.colorCorrection
    TweenService:Create(cc, tweenInfo, {
        Brightness = c.brightness,
        Contrast   = c.contrast,
        Saturation = c.saturation,
        TintColor  = c.tintColor,
    }):Play()

    -- Depth of Field
    local d = p.depthOfField
    TweenService:Create(dof, tweenInfo, {
        FarIntensity  = d.farIntensity,
        FocusDistance = d.focusDistance,
        InFocusRadius = d.inFocusRadius,
        NearIntensity = d.nearIntensity,
    }):Play()
end

local function applyTimePreset(t)
    local tweenInfo = TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    TweenService:Create(Lighting, tweenInfo, {
        ClockTime = t.clockTime,
        FogColor  = t.fogColor,
        FogEnd    = t.fogEnd,
    }):Play()
end

-- ============================================================
--  BUILD GUI
-- ============================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name            = "ZHDGraphicsGUI"
screenGui.ResetOnSpawn    = false
screenGui.ZIndexBehavior  = Enum.ZIndexBehavior.Sibling
screenGui.IgnoreGuiInset  = true
screenGui.Parent          = PlayerGui

-- ── colour palette ──────────────────────────────────────────
local C = {
    bg        = Color3.fromRGB(12,14,20),
    panel     = Color3.fromRGB(18,21,30),
    border    = Color3.fromRGB(40,45,65),
    accent    = Color3.fromRGB(80,200,255),
    accentDim = Color3.fromRGB(40,100,140),
    text      = Color3.fromRGB(220,230,255),
    textDim   = Color3.fromRGB(120,130,160),
    btnBg     = Color3.fromRGB(25,30,45),
    btnHov    = Color3.fromRGB(35,42,65),
    warn      = Color3.fromRGB(255,190,50),
    danger    = Color3.fromRGB(230,70,70),
    green     = Color3.fromRGB(60,200,120),
    red       = Color3.fromRGB(220,60,60),
}

-- ── sizes ────────────────────────────────────────────────────
local WIN_W, WIN_H = 340, 480
local HEADER_H     = 36
local MIN_H        = HEADER_H

-- ============================================================
--  TOGGLE BUTTON (always visible)
-- ============================================================
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size            = UDim2.new(0, 90, 0, 30)
toggleBtn.Position        = UDim2.new(0, 16, 0.5, -15)
toggleBtn.BackgroundColor3= C.accent
toggleBtn.TextColor3      = C.bg
toggleBtn.Font            = Enum.Font.GothamBold
toggleBtn.TextSize        = 12
toggleBtn.Text            = "GRAFIK"
toggleBtn.ZIndex          = 200
toggleBtn.Parent          = screenGui
Instance.new("UICorner",toggleBtn).CornerRadius = UDim.new(0,6)

-- ============================================================
--  MAIN WINDOW
-- ============================================================
local mainFrame = Instance.new("Frame")
mainFrame.Name            = "MainWindow"
mainFrame.Size            = UDim2.new(0, WIN_W, 0, WIN_H)
mainFrame.Position        = UDim2.new(0.5, -WIN_W/2, 0.5, -WIN_H/2)
mainFrame.BackgroundColor3= C.bg
mainFrame.BorderSizePixel = 0
mainFrame.Active          = true
mainFrame.ZIndex          = 10
mainFrame.Parent          = screenGui
Instance.new("UICorner",mainFrame).CornerRadius = UDim.new(0,10)

-- border stroke
local stroke = Instance.new("UIStroke",mainFrame)
stroke.Color     = C.border
stroke.Thickness = 1.5

-- ── HEADER ──────────────────────────────────────────────────
local header = Instance.new("Frame",mainFrame)
header.Name            = "Header"
header.Size            = UDim2.new(1,0,0,HEADER_H)
header.BackgroundColor3= C.panel
header.BorderSizePixel = 0
header.ZIndex          = 11
Instance.new("UICorner",header).CornerRadius = UDim.new(0,10)

-- patch bottom corners of header (visual)
local headerPatch = Instance.new("Frame",header)
headerPatch.Size            = UDim2.new(1,0,0.5,0)
headerPatch.Position        = UDim2.new(0,0,0.5,0)
headerPatch.BackgroundColor3= C.panel
headerPatch.BorderSizePixel = 0
headerPatch.ZIndex          = 11

local titleLbl = Instance.new("TextLabel",header)
titleLbl.Size            = UDim2.new(1,-80,1,0)
titleLbl.Position        = UDim2.new(0,12,0,0)
titleLbl.BackgroundTransparency = 1
titleLbl.TextColor3      = C.accent
titleLbl.Font            = Enum.Font.GothamBold
titleLbl.TextSize        = 14
titleLbl.Text            = "ZHD Graphics Controller"
titleLbl.TextXAlignment  = Enum.TextXAlignment.Left
titleLbl.ZIndex          = 12

-- Minimize button
local minBtn = Instance.new("TextButton",header)
minBtn.Size            = UDim2.new(0,26,0,22)
minBtn.Position        = UDim2.new(1,-58,0,7)
minBtn.BackgroundColor3= C.btnBg
minBtn.TextColor3      = C.text
minBtn.Font            = Enum.Font.GothamBold
minBtn.TextSize        = 13
minBtn.Text            = "-"
minBtn.ZIndex          = 12
Instance.new("UICorner",minBtn).CornerRadius = UDim.new(0,5)

-- Close button
local closeBtn = Instance.new("TextButton",header)
closeBtn.Size            = UDim2.new(0,26,0,22)
closeBtn.Position        = UDim2.new(1,-28,0,7)
closeBtn.BackgroundColor3= C.danger
closeBtn.TextColor3      = Color3.new(1,1,1)
closeBtn.Font            = Enum.Font.GothamBold
closeBtn.TextSize        = 13
closeBtn.Text            = "x"
closeBtn.ZIndex          = 12
Instance.new("UICorner",closeBtn).CornerRadius = UDim.new(0,5)

-- ── BODY (ScrollingFrame) ────────────────────────────────────
local body = Instance.new("ScrollingFrame",mainFrame)
body.Name                  = "Body"
body.Size                  = UDim2.new(1,0,1,-HEADER_H)
body.Position              = UDim2.new(0,0,0,HEADER_H)
body.BackgroundTransparency= 1
body.BorderSizePixel       = 0
body.ScrollBarThickness    = 4
body.ScrollBarImageColor3  = C.accentDim
body.CanvasSize            = UDim2.new(0,0,0,0)  -- set later
body.ZIndex                = 11

local bodyLayout = Instance.new("UIListLayout",body)
bodyLayout.SortOrder      = Enum.SortOrder.LayoutOrder
bodyLayout.Padding        = UDim.new(0,6)

local bodyPad = Instance.new("UIPadding",body)
bodyPad.PaddingLeft   = UDim.new(0,10)
bodyPad.PaddingRight  = UDim.new(0,10)
bodyPad.PaddingTop    = UDim.new(0,10)
bodyPad.PaddingBottom = UDim.new(0,10)

-- auto-resize canvas
bodyLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    body.CanvasSize = UDim2.new(0,0,0, bodyLayout.AbsoluteContentSize.Y + 20)
end)

-- ── SECTION LABEL helper ─────────────────────────────────────
local function makeSection(parent, text, order)
    local lbl = Instance.new("TextLabel", parent)
    lbl.Size            = UDim2.new(1,0,0,20)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3      = C.accentDim
    lbl.Font            = Enum.Font.GothamBold
    lbl.TextSize        = 10
    lbl.Text            = text
    lbl.TextXAlignment  = Enum.TextXAlignment.Left
    lbl.LayoutOrder     = order
    lbl.ZIndex          = 12
    return lbl
end

-- ── GRAPHIC BUTTONS ──────────────────────────────────────────
makeSection(body, "-- KUALITAS GRAFIK --", 0)

local currentPresetId = nil

local function makePresetBtn(preset, order)
    local btn = Instance.new("TextButton", body)
    btn.Name            = preset.id
    btn.Size            = UDim2.new(1,0,0,52)
    btn.BackgroundColor3= C.btnBg
    btn.BorderSizePixel = 0
    btn.Text            = ""
    btn.LayoutOrder     = order
    btn.ZIndex          = 12
    Instance.new("UICorner",btn).CornerRadius = UDim.new(0,8)

    -- Icon badge
    local badge = Instance.new("TextLabel",btn)
    badge.Size            = UDim2.new(0,50,0,36)
    badge.Position        = UDim2.new(0,8,0.5,-18)
    badge.BackgroundColor3= C.accentDim
    badge.TextColor3      = C.accent
    badge.Font            = Enum.Font.GothamBold
    badge.TextSize        = 9
    badge.Text            = preset.icon
    badge.ZIndex          = 13
    Instance.new("UICorner",badge).CornerRadius = UDim.new(0,6)

    local lblName = Instance.new("TextLabel",btn)
    lblName.Size            = UDim2.new(1,-72,0,20)
    lblName.Position        = UDim2.new(0,66,0,7)
    lblName.BackgroundTransparency= 1
    lblName.TextColor3      = C.text
    lblName.Font            = Enum.Font.GothamBold
    lblName.TextSize        = 13
    lblName.Text            = preset.label .. "  —  " .. preset.sub
    lblName.TextXAlignment  = Enum.TextXAlignment.Left
    lblName.ZIndex          = 13

    local lblSub = Instance.new("TextLabel",btn)
    lblSub.Size            = UDim2.new(1,-72,0,16)
    lblSub.Position        = UDim2.new(0,66,0,28)
    lblSub.BackgroundTransparency= 1
    lblSub.TextColor3      = C.textDim
    lblSub.Font            = Enum.Font.Gotham
    lblSub.TextSize        = 10
    lblSub.Text            = preset.id == currentPresetId and "[AKTIF]" or ""
    lblSub.TextXAlignment  = Enum.TextXAlignment.Left
    lblSub.ZIndex          = 13

    -- hover
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3=C.btnHov}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = currentPresetId == preset.id and C.accentDim or C.btnBg
        }):Play()
    end)

    return btn, lblSub
end

local presetSubLabels = {}
local presetBtns      = {}

for i, preset in ipairs(PRESETS) do
    local btn, subLbl = makePresetBtn(preset, i)
    presetSubLabels[preset.id] = subLbl
    presetBtns[preset.id]      = btn
end

-- ── TIME MODE SECTION ────────────────────────────────────────
makeSection(body, "-- MODE WAKTU --", 100)

local timeGrid = Instance.new("Frame", body)
timeGrid.Name            = "TimeGrid"
timeGrid.Size            = UDim2.new(1,0,0,110)
timeGrid.BackgroundTransparency = 1
timeGrid.LayoutOrder     = 101
timeGrid.ZIndex          = 12

local timeLayout = Instance.new("UIGridLayout", timeGrid)
timeLayout.CellSize       = UDim2.new(0.5,-4,0,46)
timeLayout.CellPaddingX   = UDim.new(0,4)
timeLayout.CellPaddingY   = UDim.new(0,4)
timeLayout.SortOrder      = Enum.SortOrder.LayoutOrder

for i, tp in ipairs(TIME_PRESETS) do
    local tb = Instance.new("TextButton", timeGrid)
    tb.Size            = UDim2.new(1,0,0,46)
    tb.BackgroundColor3= C.btnBg
    tb.BorderSizePixel = 0
    tb.Text            = ""
    tb.LayoutOrder     = i
    tb.ZIndex          = 12
    Instance.new("UICorner",tb).CornerRadius = UDim.new(0,8)

    local lic = Instance.new("TextLabel",tb)
    lic.Size            = UDim2.new(0,30,1,0)
    lic.Position        = UDim2.new(0,6,0,0)
    lic.BackgroundTransparency = 1
    lic.TextColor3      = C.warn
    lic.Font            = Enum.Font.GothamBold
    lic.TextSize        = 10
    lic.Text            = tp.icon
    lic.ZIndex          = 13

    local lname = Instance.new("TextLabel",tb)
    lname.Size            = UDim2.new(1,-40,1,0)
    lname.Position        = UDim2.new(0,38,0,0)
    lname.BackgroundTransparency = 1
    lname.TextColor3      = C.text
    lname.Font            = Enum.Font.GothamBold
    lname.TextSize        = 11
    lname.Text            = tp.label
    lname.TextXAlignment  = Enum.TextXAlignment.Left
    lname.ZIndex          = 13

    tb.MouseEnter:Connect(function() TweenService:Create(tb,TweenInfo.new(0.12),{BackgroundColor3=C.btnHov}):Play() end)
    tb.MouseLeave:Connect(function() TweenService:Create(tb,TweenInfo.new(0.12),{BackgroundColor3=C.btnBg}):Play() end)

    tb.MouseButton1Click:Connect(function()
        applyTimePreset(tp)
    end)
end

-- Update canvas after layout
task.defer(function()
    body.CanvasSize = UDim2.new(0,0,0, bodyLayout.AbsoluteContentSize.Y + 20)
end)

-- ============================================================
--  MODAL SYSTEM
-- ============================================================
local function makeModal(title, message, onConfirm)
    local overlay = Instance.new("Frame", screenGui)
    overlay.Size            = UDim2.new(1,0,1,0)
    overlay.BackgroundColor3= Color3.new(0,0,0)
    overlay.BackgroundTransparency = 0.45
    overlay.ZIndex          = 50
    overlay.BorderSizePixel = 0

    local box = Instance.new("Frame", overlay)
    box.Size            = UDim2.new(0,300,0,190)
    box.Position        = UDim2.new(0.5,-150,0.5,-95)
    box.BackgroundColor3= C.panel
    box.BorderSizePixel = 0
    box.ZIndex          = 51
    Instance.new("UICorner",box).CornerRadius = UDim.new(0,10)
    local bs = Instance.new("UIStroke",box)
    bs.Color = C.warn; bs.Thickness = 1.5

    local ttl = Instance.new("TextLabel",box)
    ttl.Size            = UDim2.new(1,-20,0,30)
    ttl.Position        = UDim2.new(0,10,0,10)
    ttl.BackgroundTransparency = 1
    ttl.TextColor3      = C.warn
    ttl.Font            = Enum.Font.GothamBold
    ttl.TextSize        = 14
    ttl.Text            = title
    ttl.TextXAlignment  = Enum.TextXAlignment.Left
    ttl.ZIndex          = 52

    local msg = Instance.new("TextLabel",box)
    msg.Size            = UDim2.new(1,-20,0,90)
    msg.Position        = UDim2.new(0,10,0,44)
    msg.BackgroundTransparency = 1
    msg.TextColor3      = C.text
    msg.Font            = Enum.Font.Gotham
    msg.TextSize        = 11
    msg.Text            = message
    msg.TextWrapped     = true
    msg.TextXAlignment  = Enum.TextXAlignment.Left
    msg.ZIndex          = 52

    local function makeModalBtn(label, color, posX, cb)
        local b = Instance.new("TextButton",box)
        b.Size            = UDim2.new(0,118,0,32)
        b.Position        = UDim2.new(0,posX,1,-44)
        b.BackgroundColor3= color
        b.TextColor3      = Color3.new(1,1,1)
        b.Font            = Enum.Font.GothamBold
        b.TextSize        = 12
        b.Text            = label
        b.ZIndex          = 52
        Instance.new("UICorner",b).CornerRadius = UDim.new(0,7)
        b.MouseButton1Click:Connect(function()
            overlay:Destroy()
            if cb then cb() end
        end)
    end

    makeModalBtn("Batal", C.btnBg, 10, nil)
    makeModalBtn("Iya",   C.green, 172, onConfirm)
end

-- ============================================================
--  CLOSE CONFIRM MODAL
-- ============================================================
local function showCloseConfirm()
    makeModal(
        "[!] Hapus UI",
        "Apakah Anda yakin ingin menghapus UI ini?\nTindakan ini tidak dapat diurungkan.",
        function()
            screenGui:Destroy()
        end
    )
end

-- ============================================================
--  CONNECT PRESET BUTTONS
-- ============================================================
local function activatePreset(preset)
    -- update visuals
    for id, btn in pairs(presetBtns) do
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = id == preset.id and C.accentDim or C.btnBg
        }):Play()
        presetSubLabels[id].Text = id == preset.id and "[AKTIF]" or ""
    end
    currentPresetId = preset.id
    applyPreset(preset)
end

for _, preset in ipairs(PRESETS) do
    local btn = presetBtns[preset.id]
    btn.MouseButton1Click:Connect(function()
        if preset.warn then
            makeModal(
                "[!] Konfirmasi Grafik",
                "Apakah Anda yakin ingin mengubah ke " .. preset.label .. " (" .. preset.sub .. ")?\n\nHal ini membuat GPU bekerja keras dan dapat menyebabkan lag pada perangkat rendah.",
                function()
                    activatePreset(preset)
                end
            )
        else
            -- non-8K still confirm but simpler
            makeModal(
                "[?] Ubah Grafik",
                "Apakah Anda yakin ingin grafik diubah ke " .. preset.label .. " - " .. preset.sub .. "?",
                function()
                    activatePreset(preset)
                end
            )
        end
    end)
end

-- ============================================================
--  MINIMIZE / CLOSE
-- ============================================================
local isMinimized = false

minBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    local targetH = isMinimized and MIN_H or WIN_H
    TweenService:Create(mainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, WIN_W, 0, targetH)
    }):Play()
    body.Visible = not isMinimized
    minBtn.Text  = isMinimized and "+" or "-"
end)

closeBtn.MouseButton1Click:Connect(function()
    showCloseConfirm()
end)

-- ============================================================
--  TOGGLE BUTTON
-- ============================================================
toggleBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

-- ============================================================
--  DRAG & DROP
-- ============================================================
do
    local dragging, dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end

    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            dragging  = true
            dragStart = input.Position
            startPos  = mainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    header.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or
           input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- ============================================================
--  ENTRANCE ANIMATION
-- ============================================================
mainFrame.Size     = UDim2.new(0, WIN_W, 0, 0)
mainFrame.Position = UDim2.new(0.5, -WIN_W/2, 0.5, 0)
TweenService:Create(mainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size     = UDim2.new(0, WIN_W, 0, WIN_H),
    Position = UDim2.new(0.5, -WIN_W/2, 0.5, -WIN_H/2),
}):Play()

print("[ZHD Graphics] GUI loaded. Select a preset to begin.")
