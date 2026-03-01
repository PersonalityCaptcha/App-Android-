-- ============================================================
--  ZHD Graphics Controller v1.0
--  By: Script Generator
--  Kompatibel: Roblox LocalScript (StarterPlayerScripts)
-- ============================================================

local Players         = game:GetService("Players")
local Lighting        = game:GetService("Lighting")
local RunService      = game:GetService("RunService")
local TweenService    = game:GetService("TweenService")
local UserInputService= game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

-- ============================================================
-- PRESET GRAFIK
-- ============================================================
local PRESETS = {
    ZHD  = {
        label        = "ZHD",
        desc         = "8K Ultra HD",
        quality      = Enum.RenderFidelity.Precise,
        shadowSoftness   = 0.200,
        shadowDistance   = 250,
        globalShadows    = true,
        brightness       = 4.0,
        ambientColor     = Color3.fromRGB(120,130,160),
        outDoorAmbient   = Color3.fromRGB(140,155,175),
        colorShift_Top   = Color3.fromRGB(255,245,200),
        colorShift_Bot   = Color3.fromRGB(20, 30, 80),
        fogEnd           = 10000,
        fogStart         = 9000,
        exposure         = 1.2,
        bloom            = { Intensity=1.2, Size=56, Threshold=0.95 },
        sunRays          = { Intensity=0.35, Spread=0.2 },
        depthOfField     = false,
        colorCorrection  = { Brightness=0.05, Contrast=0.15, Saturation=0.2, TintColor=Color3.new(1,1,1) },
        warning          = true,   -- tunjukkan dialog GPU
    },
    OHD  = {
        label        = "OHD",
        desc         = "4K HD",
        quality      = Enum.RenderFidelity.Precise,
        shadowSoftness   = 0.200,
        shadowDistance   = 150,
        globalShadows    = true,
        brightness       = 3.0,
        ambientColor     = Color3.fromRGB(100,110,140),
        outDoorAmbient   = Color3.fromRGB(120,135,155),
        colorShift_Top   = Color3.fromRGB(255,235,180),
        colorShift_Bot   = Color3.fromRGB(30, 40, 90),
        fogEnd           = 8000,
        fogStart         = 7000,
        exposure         = 1.0,
        bloom            = { Intensity=0.9, Size=40, Threshold=0.97 },
        sunRays          = { Intensity=0.20, Spread=0.15 },
        depthOfField     = false,
        colorCorrection  = { Brightness=0.03, Contrast=0.10, Saturation=0.15, TintColor=Color3.new(1,1,1) },
        warning          = false,
    },
    MHD  = {
        label        = "MHD",
        desc         = "2K HD",
        quality      = Enum.RenderFidelity.Performance,
        shadowSoftness   = 0.200,
        shadowDistance   = 100,
        globalShadows    = true,
        brightness       = 2.5,
        ambientColor     = Color3.fromRGB(90,100,120),
        outDoorAmbient   = Color3.fromRGB(100,115,135),
        colorShift_Top   = Color3.fromRGB(240,220,170),
        colorShift_Bot   = Color3.fromRGB(40, 50, 100),
        fogEnd           = 6000,
        fogStart         = 5500,
        exposure         = 0.9,
        bloom            = { Intensity=0.6, Size=28, Threshold=0.98 },
        sunRays          = { Intensity=0.10, Spread=0.10 },
        depthOfField     = false,
        colorCorrection  = { Brightness=0.02, Contrast=0.08, Saturation=0.10, TintColor=Color3.new(1,1,1) },
        warning          = false,
    },
    FHD  = {
        label        = "FHD",
        desc         = "1080P HD",
        quality      = Enum.RenderFidelity.Performance,
        shadowSoftness   = 0.200,
        shadowDistance   = 60,
        globalShadows    = true,
        brightness       = 2.0,
        ambientColor     = Color3.fromRGB(80,90,110),
        outDoorAmbient   = Color3.fromRGB(90,105,125),
        colorShift_Top   = Color3.fromRGB(230,210,160),
        colorShift_Bot   = Color3.fromRGB(50, 60, 110),
        fogEnd           = 4000,
        fogStart         = 3500,
        exposure         = 0.8,
        bloom            = { Intensity=0.3, Size=18, Threshold=0.99 },
        sunRays          = { Intensity=0.05, Spread=0.07 },
        depthOfField     = false,
        colorCorrection  = { Brightness=0.01, Contrast=0.05, Saturation=0.05, TintColor=Color3.new(1,1,1) },
        warning          = false,
    },
    ZLOW = {
        label        = "ZLOW",
        desc         = "720P",
        quality      = Enum.RenderFidelity.Performance,
        shadowSoftness   = 1,
        shadowDistance   = 0,
        globalShadows    = false,
        brightness       = 1.5,
        ambientColor     = Color3.fromRGB(70,80,100),
        outDoorAmbient   = Color3.fromRGB(80,95,115),
        colorShift_Top   = Color3.fromRGB(200,185,140),
        colorShift_Bot   = Color3.fromRGB(60, 70, 120),
        fogEnd           = 2000,
        fogStart         = 1800,
        exposure         = 0.7,
        bloom            = { Intensity=0.1, Size=10, Threshold=1.0 },
        sunRays          = { Intensity=0.0, Spread=0.0 },
        depthOfField     = false,
        waterReflect     = true,
        colorCorrection  = { Brightness=0, Contrast=0.02, Saturation=0.02, TintColor=Color3.new(1,1,1) },
        warning          = false,
    },
    OLOW = {
        label        = "OLOW",
        desc         = "540P",
        quality      = Enum.RenderFidelity.Performance,
        shadowSoftness   = 1,
        shadowDistance   = 0,
        globalShadows    = false,
        brightness       = 1.2,
        ambientColor     = Color3.fromRGB(60,70,90),
        outDoorAmbient   = Color3.fromRGB(70,85,105),
        colorShift_Top   = Color3.fromRGB(180,165,120),
        colorShift_Bot   = Color3.fromRGB(70, 80, 130),
        fogEnd           = 1200,
        fogStart         = 900,
        exposure         = 0.6,
        bloom            = { Intensity=0.0, Size=0, Threshold=1.0 },
        sunRays          = { Intensity=0.0, Spread=0.0 },
        depthOfField     = false,
        colorCorrection  = { Brightness=-0.02, Contrast=0, Saturation=-0.05, TintColor=Color3.new(1,1,1) },
        warning          = false,
    },
    MLOW = {
        label        = "MLOW",
        desc         = "320P",
        quality      = Enum.RenderFidelity.Performance,
        shadowSoftness   = 1,
        shadowDistance   = 0,
        globalShadows    = false,
        brightness       = 1.0,
        ambientColor     = Color3.fromRGB(50,55,70),
        outDoorAmbient   = Color3.fromRGB(55,65,80),
        colorShift_Top   = Color3.fromRGB(150,140,100),
        colorShift_Bot   = Color3.fromRGB(80, 90, 140),
        fogEnd           = 600,
        fogStart         = 400,
        exposure         = 0.5,
        bloom            = { Intensity=0.0, Size=0, Threshold=1.0 },
        sunRays          = { Intensity=0.0, Spread=0.0 },
        depthOfField     = false,
        colorCorrection  = { Brightness=-0.05, Contrast=-0.02, Saturation=-0.10, TintColor=Color3.new(1,1,1) },
        warning          = false,
    },
    FLOW = {
        label        = "FLOW",
        desc         = "100P",
        quality      = Enum.RenderFidelity.Performance,
        shadowSoftness   = 1,
        shadowDistance   = 0,
        globalShadows    = false,
        brightness       = 0.8,
        ambientColor     = Color3.fromRGB(40,40,55),
        outDoorAmbient   = Color3.fromRGB(45,50,65),
        colorShift_Top   = Color3.fromRGB(120,110,80),
        colorShift_Bot   = Color3.fromRGB(90,100,150),
        fogEnd           = 200,
        fogStart         = 100,
        exposure         = 0.4,
        bloom            = { Intensity=0.0, Size=0, Threshold=1.0 },
        sunRays          = { Intensity=0.0, Spread=0.0 },
        depthOfField     = false,
        colorCorrection  = { Brightness=-0.10, Contrast=-0.05, Saturation=-0.20, TintColor=Color3.new(1,1,1) },
        warning          = false,
    },
}

local PRESET_ORDER = { "ZHD","OHD","MHD","FHD","ZLOW","OLOW","MLOW","FLOW" }

local ICON = {
    ZHD  = "[Z8K]",
    OHD  = "[O4K]",
    MHD  = "[M2K]",
    FHD  = "[FHD]",
    ZLOW = "[72P]",
    OLOW = "[54P]",
    MLOW = "[32P]",
    FLOW = "[10P]",
    CLOSE    = "[X]",
    MINIMIZE = "[-]",
    TOGGLE   = "[*]",
    COPY     = "[CP]",
    YES      = "[YA]",
    NO       = "[TDK]",
}

-- ============================================================
-- APPLY PRESET
-- ============================================================
local function removeEffect(className)
    for _,v in ipairs(Lighting:GetChildren()) do
        if v:IsA(className) then v:Destroy() end
    end
end

local function ensureEffect(className, name)
    local existing = Lighting:FindFirstChildWhichIsA(className)
    if not existing then
        existing = Instance.new(className)
        existing.Parent = Lighting
    end
    return existing
end

local function applyPreset(key)
    local p = PRESETS[key]
    if not p then return end

    -- Lighting dasar
    Lighting.GlobalShadows     = p.globalShadows
    Lighting.ShadowSoftness    = p.shadowSoftness
    Lighting.Brightness        = p.brightness
    Lighting.Ambient           = p.ambientColor
    Lighting.OutdoorAmbient    = p.outDoorAmbient
    Lighting.ColorShift_Top    = p.colorShift_Top
    Lighting.ColorShift_Bottom = p.colorShift_Bot
    Lighting.FogEnd            = p.fogEnd
    Lighting.FogStart          = p.fogStart
    Lighting.ExposureCompensation = p.exposure

    -- Rendering quality (pcall karena tidak semua klien bisa)
    pcall(function()
        settings().Rendering.QualityLevel = p.quality == Enum.RenderFidelity.Precise
            and Enum.QualityLevel.Level21
            or  Enum.QualityLevel.Level01
    end)

    -- Bloom
    removeEffect("BloomEffect")
    if p.bloom and p.bloom.Intensity > 0 then
        local b = ensureEffect("BloomEffect","Bloom")
        b.Intensity = p.bloom.Intensity
        b.Size      = p.bloom.Size
        b.Threshold = p.bloom.Threshold
    end

    -- SunRays
    removeEffect("SunRaysEffect")
    if p.sunRays and p.sunRays.Intensity > 0 then
        local s = ensureEffect("SunRaysEffect","SunRays")
        s.Intensity = p.sunRays.Intensity
        s.Spread    = p.sunRays.Spread
    end

    -- ColorCorrection
    removeEffect("ColorCorrectionEffect")
    if p.colorCorrection then
        local c = ensureEffect("ColorCorrectionEffect","CC")
        c.Brightness = p.colorCorrection.Brightness
        c.Contrast   = p.colorCorrection.Contrast
        c.Saturation = p.colorCorrection.Saturation
        c.TintColor  = p.colorCorrection.TintColor
    end
end

-- ============================================================
-- BUAT GUI
-- ============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name            = "ZHD_GraphicsGUI"
ScreenGui.ResetOnSpawn    = false
ScreenGui.ZIndexBehavior  = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent          = PlayerGui

-- ---- WARNA TEMA ----
local C = {
    bg        = Color3.fromRGB(14, 16, 22),
    panel     = Color3.fromRGB(20, 24, 34),
    border    = Color3.fromRGB(45, 55, 80),
    accent    = Color3.fromRGB(0, 200, 255),
    accentDim = Color3.fromRGB(0, 130, 170),
    text      = Color3.fromRGB(220, 230, 255),
    textDim   = Color3.fromRGB(130, 145, 175),
    btnHD     = Color3.fromRGB(0, 80, 130),
    btnLOW    = Color3.fromRGB(80, 50, 10),
    danger    = Color3.fromRGB(200, 50, 50),
    success   = Color3.fromRGB(30, 160, 90),
    overlay   = Color3.fromRGB(5, 7, 12),
    titleBar  = Color3.fromRGB(10, 13, 20),
}

-- ---- FONT ----
local FONT_TITLE = Enum.Font.GothamBold
local FONT_BODY  = Enum.Font.Gotham
local FONT_MONO  = Enum.Font.Code

-- ---- HELPER UI ----
local function makeCorner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = parent
end

local function makeStroke(parent, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color     = color or C.border
    s.Thickness = thickness or 1
    s.Parent    = parent
end

local function makePad(parent, top, right, bottom, left)
    local p = Instance.new("UIPadding")
    p.PaddingTop    = UDim.new(0, top or 6)
    p.PaddingRight  = UDim.new(0, right or 6)
    p.PaddingBottom = UDim.new(0, bottom or 6)
    p.PaddingLeft   = UDim.new(0, left or 6)
    p.Parent = parent
end

local function newLabel(parent, text, size, color, font, xAlign)
    local l = Instance.new("TextLabel")
    l.Text              = text
    l.TextSize          = size or 14
    l.TextColor3        = color or C.text
    l.Font              = font or FONT_BODY
    l.BackgroundTransparency = 1
    l.TextXAlignment    = xAlign or Enum.TextXAlignment.Left
    l.Parent            = parent
    return l
end

local function tween(obj, info, props)
    TweenService:Create(obj, info, props):Play()
end

local T1 = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local T2 = TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

-- ============================================================
-- FRAME UTAMA
-- ============================================================
local MainFrame = Instance.new("Frame")
MainFrame.Name             = "MainFrame"
MainFrame.Size             = UDim2.new(0, 310, 0, 440)
MainFrame.Position         = UDim2.new(0.5, -155, 0.5, -220)
MainFrame.BackgroundColor3 = C.bg
MainFrame.ClipsDescendants = true
MainFrame.Parent           = ScreenGui
makeCorner(MainFrame, 12)
makeStroke(MainFrame, C.border, 1)

-- ---- SHADOW DEKORATIF ----
local Shadow = Instance.new("Frame")
Shadow.Name             = "Shadow"
Shadow.Size             = UDim2.new(1, 16, 1, 16)
Shadow.Position         = UDim2.new(0, -8, 0, 8)
Shadow.BackgroundColor3 = Color3.fromRGB(0,0,0)
Shadow.BackgroundTransparency = 0.55
Shadow.ZIndex           = MainFrame.ZIndex - 1
Shadow.Parent           = MainFrame
makeCorner(Shadow, 14)

-- ============================================================
-- TITLE BAR
-- ============================================================
local TitleBar = Instance.new("Frame")
TitleBar.Name             = "TitleBar"
TitleBar.Size             = UDim2.new(1, 0, 0, 42)
TitleBar.BackgroundColor3 = C.titleBar
TitleBar.Parent           = MainFrame
makeCorner(TitleBar, 12)

-- patch sudut bawah title bar agar rata
local TitlePatch = Instance.new("Frame")
TitlePatch.Size             = UDim2.new(1,0,0,10)
TitlePatch.Position         = UDim2.new(0,0,1,-10)
TitlePatch.BackgroundColor3 = C.titleBar
TitlePatch.BorderSizePixel  = 0
TitlePatch.Parent           = TitleBar

local TitleIcon = newLabel(TitleBar, ICON.TOGGLE, 15, C.accent, FONT_MONO)
TitleIcon.Size     = UDim2.new(0,30,1,0)
TitleIcon.Position = UDim2.new(0,10,0,0)
TitleIcon.TextXAlignment = Enum.TextXAlignment.Center

local TitleText = newLabel(TitleBar, "ZHD Graphics Controller", 13, C.text, FONT_TITLE)
TitleText.Size     = UDim2.new(1,-100,1,0)
TitleText.Position = UDim2.new(0,42,0,0)

-- Tombol MINIMIZE
local BtnMin = Instance.new("TextButton")
BtnMin.Name             = "BtnMin"
BtnMin.Text             = ICON.MINIMIZE
BtnMin.Size             = UDim2.new(0,30,0,26)
BtnMin.Position         = UDim2.new(1,-66,0,8)
BtnMin.BackgroundColor3 = C.panel
BtnMin.TextColor3       = C.text
BtnMin.Font             = FONT_MONO
BtnMin.TextSize         = 13
BtnMin.Parent           = TitleBar
makeCorner(BtnMin, 6)
makeStroke(BtnMin, C.border)

-- Tombol CLOSE
local BtnClose = Instance.new("TextButton")
BtnClose.Name             = "BtnClose"
BtnClose.Text             = ICON.CLOSE
BtnClose.Size             = UDim2.new(0,30,0,26)
BtnClose.Position         = UDim2.new(1,-32,0,8)
BtnClose.BackgroundColor3 = C.danger
BtnClose.TextColor3       = Color3.new(1,1,1)
BtnClose.Font             = FONT_MONO
BtnClose.TextSize         = 13
BtnClose.Parent           = TitleBar
makeCorner(BtnClose, 6)

-- ============================================================
-- KONTEN SCROLLABLE
-- ============================================================
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Name             = "ScrollFrame"
ScrollFrame.Size             = UDim2.new(1, -12, 1, -56)
ScrollFrame.Position         = UDim2.new(0, 6, 0, 48)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.ScrollBarImageColor3 = C.accent
ScrollFrame.CanvasSize       = UDim2.new(0, 0, 0, 0)
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollFrame.Parent           = MainFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding         = UDim.new(0, 6)
ListLayout.FillDirection   = Enum.FillDirection.Vertical
ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ListLayout.Parent          = ScrollFrame

makePad(ScrollFrame, 4, 4, 8, 4)

-- ============================================================
-- SECTION LABEL
-- ============================================================
local function makeSection(parent, label)
    local row = Instance.new("Frame")
    row.Size             = UDim2.new(1,-8,0,22)
    row.BackgroundTransparency = 1
    row.Parent           = parent

    local line = Instance.new("Frame")
    line.Size             = UDim2.new(1,0,0,1)
    line.Position         = UDim2.new(0,0,0.5,0)
    line.BackgroundColor3 = C.border
    line.Parent           = row

    local lbl = newLabel(row, "  "..label.."  ", 11, C.accentDim, FONT_MONO)
    lbl.Size             = UDim2.new(0, 120, 1, 0)
    lbl.Position         = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundColor3 = C.bg
    lbl.BackgroundTransparency = 0
    lbl.TextXAlignment   = Enum.TextXAlignment.Left

    return row
end

-- ============================================================
-- TOMBOL PRESET
-- ============================================================
local PRESET_COLORS = {
    ZHD  = Color3.fromRGB(0, 160, 255),
    OHD  = Color3.fromRGB(0, 130, 220),
    MHD  = Color3.fromRGB(0, 100, 190),
    FHD  = Color3.fromRGB(0, 75, 160),
    ZLOW = Color3.fromRGB(180, 120, 0),
    OLOW = Color3.fromRGB(150, 90, 0),
    MLOW = Color3.fromRGB(120, 65, 0),
    FLOW = Color3.fromRGB(90, 40, 0),
}

local activeKey = nil

-- ============================================================
-- DIALOG GENERIC (konfirmasi & peringatan)
-- ============================================================
local DialogOverlay = Instance.new("Frame")
DialogOverlay.Name             = "DialogOverlay"
DialogOverlay.Size             = UDim2.new(1,0,1,0)
DialogOverlay.BackgroundColor3 = C.overlay
DialogOverlay.BackgroundTransparency = 0.35
DialogOverlay.Visible          = false
DialogOverlay.ZIndex           = 10
DialogOverlay.Parent           = MainFrame

local DialogBox = Instance.new("Frame")
DialogBox.Name             = "DialogBox"
DialogBox.Size             = UDim2.new(0, 260, 0, 160)
DialogBox.Position         = UDim2.new(0.5,-130,0.5,-80)
DialogBox.BackgroundColor3 = C.panel
DialogBox.ZIndex           = 11
DialogBox.Parent           = DialogOverlay
makeCorner(DialogBox, 10)
makeStroke(DialogBox, C.border, 1)

local DialogIcon = newLabel(DialogBox, "[!]", 18, C.accent, FONT_MONO, Enum.TextXAlignment.Center)
DialogIcon.Size     = UDim2.new(1,0,0,30)
DialogIcon.Position = UDim2.new(0,0,0,12)
DialogIcon.ZIndex   = 12

local DialogTitle = newLabel(DialogBox, "", 13, C.text, FONT_TITLE, Enum.TextXAlignment.Center)
DialogTitle.Size     = UDim2.new(1,-20,0,20)
DialogTitle.Position = UDim2.new(0,10,0,44)
DialogTitle.ZIndex   = 12

local DialogMsg = newLabel(DialogBox, "", 11, C.textDim, FONT_BODY, Enum.TextXAlignment.Center)
DialogMsg.Size             = UDim2.new(1,-20,0,34)
DialogMsg.Position         = UDim2.new(0,10,0,66)
DialogMsg.TextWrapped      = true
DialogMsg.ZIndex           = 12

local DialogBtnRow = Instance.new("Frame")
DialogBtnRow.Size             = UDim2.new(1,-20,0,34)
DialogBtnRow.Position         = UDim2.new(0,10,0,118)
DialogBtnRow.BackgroundTransparency = 1
DialogBtnRow.ZIndex           = 12
DialogBtnRow.Parent           = DialogBox

local DialogBtnYes = Instance.new("TextButton")
DialogBtnYes.Size             = UDim2.new(0.47,0,1,0)
DialogBtnYes.Position         = UDim2.new(0.53,0,0,0)
DialogBtnYes.BackgroundColor3 = C.success
DialogBtnYes.TextColor3       = Color3.new(1,1,1)
DialogBtnYes.Text             = ICON.YES .. " IYA"
DialogBtnYes.Font             = FONT_TITLE
DialogBtnYes.TextSize         = 12
DialogBtnYes.ZIndex           = 13
DialogBtnYes.Parent           = DialogBtnRow
makeCorner(DialogBtnYes, 6)

local DialogBtnNo = Instance.new("TextButton")
DialogBtnNo.Size             = UDim2.new(0.47,0,1,0)
DialogBtnNo.Position         = UDim2.new(0,0,0,0)
DialogBtnNo.BackgroundColor3 = C.danger
DialogBtnNo.TextColor3       = Color3.new(1,1,1)
DialogBtnNo.Text             = ICON.NO .. " BATAL"
DialogBtnNo.Font             = FONT_TITLE
DialogBtnNo.TextSize         = 12
DialogBtnNo.ZIndex           = 13
DialogBtnNo.Parent           = DialogBtnRow
makeCorner(DialogBtnNo, 6)

-- ============================================================
-- DIALOG CLOSE (konfirmasi tutup)
-- ============================================================
local CloseDialogOverlay = Instance.new("Frame")
CloseDialogOverlay.Name             = "CloseDialogOverlay"
CloseDialogOverlay.Size             = UDim2.new(1,0,1,0)
CloseDialogOverlay.BackgroundColor3 = C.overlay
CloseDialogOverlay.BackgroundTransparency = 0.35
CloseDialogOverlay.Visible          = false
CloseDialogOverlay.ZIndex           = 10
CloseDialogOverlay.Parent           = MainFrame

local CloseBox = Instance.new("Frame")
CloseBox.Name             = "CloseBox"
CloseBox.Size             = UDim2.new(0, 260, 0, 160)
CloseBox.Position         = UDim2.new(0.5,-130,0.5,-80)
CloseBox.BackgroundColor3 = C.panel
CloseBox.ZIndex           = 11
CloseBox.Parent           = CloseDialogOverlay
makeCorner(CloseBox, 10)
makeStroke(CloseBox, C.danger, 1)

local CloseIcon = newLabel(CloseBox, "[X]", 18, C.danger, FONT_MONO, Enum.TextXAlignment.Center)
CloseIcon.Size     = UDim2.new(1,0,0,30)
CloseIcon.Position = UDim2.new(0,0,0,12)
CloseIcon.ZIndex   = 12

local CloseTitle = newLabel(CloseBox, "Hapus UI?", 13, C.text, FONT_TITLE, Enum.TextXAlignment.Center)
CloseTitle.Size     = UDim2.new(1,-20,0,20)
CloseTitle.Position = UDim2.new(0,10,0,44)
CloseTitle.ZIndex   = 12

local CloseMsg = newLabel(CloseBox, "Apakah Anda yakin ingin menghapus?\nTindakan ini tidak dapat diurungkan.", 11, C.textDim, FONT_BODY, Enum.TextXAlignment.Center)
CloseMsg.Size             = UDim2.new(1,-20,0,36)
CloseMsg.Position         = UDim2.new(0,10,0,64)
CloseMsg.TextWrapped      = true
CloseMsg.ZIndex           = 12

local CloseBtnRow = Instance.new("Frame")
CloseBtnRow.Size             = UDim2.new(1,-20,0,34)
CloseBtnRow.Position         = UDim2.new(0,10,0,118)
CloseBtnRow.BackgroundTransparency = 1
CloseBtnRow.ZIndex           = 12
CloseBtnRow.Parent           = CloseBox

local CloseBtnYes = Instance.new("TextButton")
CloseBtnYes.Size             = UDim2.new(0.47,0,1,0)
CloseBtnYes.Position         = UDim2.new(0.53,0,0,0)
CloseBtnYes.BackgroundColor3 = C.danger
CloseBtnYes.TextColor3       = Color3.new(1,1,1)
CloseBtnYes.Text             = ICON.YES .. " IYA, HAPUS"
CloseBtnYes.Font             = FONT_TITLE
CloseBtnYes.TextSize         = 11
CloseBtnYes.ZIndex           = 13
CloseBtnYes.Parent           = CloseBtnRow
makeCorner(CloseBtnYes, 6)

local CloseBtnNo = Instance.new("TextButton")
CloseBtnNo.Size             = UDim2.new(0.47,0,1,0)
CloseBtnNo.Position         = UDim2.new(0,0,0,0)
CloseBtnNo.BackgroundColor3 = C.success
CloseBtnNo.TextColor3       = Color3.new(1,1,1)
CloseBtnNo.Text             = ICON.NO .. " BATAL"
CloseBtnNo.Font             = FONT_TITLE
CloseBtnNo.TextSize         = 12
CloseBtnNo.ZIndex           = 13
CloseBtnNo.Parent           = CloseBtnRow
makeCorner(CloseBtnNo, 6)

-- ============================================================
-- TOGGLE BUTTON (muncul setelah minimize)
-- ============================================================
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name             = "ToggleBtn"
ToggleBtn.Text             = ICON.TOGGLE .. " ZHD"
ToggleBtn.Size             = UDim2.new(0, 90, 0, 30)
ToggleBtn.Position         = UDim2.new(0, 10, 1, -44)
ToggleBtn.BackgroundColor3 = C.panel
ToggleBtn.TextColor3       = C.accent
ToggleBtn.Font             = FONT_MONO
ToggleBtn.TextSize         = 12
ToggleBtn.Visible          = false
ToggleBtn.Parent           = ScreenGui
makeCorner(ToggleBtn, 8)
makeStroke(ToggleBtn, C.accent, 1)

-- ============================================================
-- DOKUMEN INFO
-- ============================================================
local function makeDocSection(parent)
    local docFrame = Instance.new("Frame")
    docFrame.Size             = UDim2.new(1,-8,0,90)
    docFrame.BackgroundColor3 = Color3.fromRGB(10,14,22)
    docFrame.Parent           = parent
    makeCorner(docFrame, 8)
    makeStroke(docFrame, C.border)

    local docScroll = Instance.new("ScrollingFrame")
    docScroll.Size             = UDim2.new(1,-8,1,-30)
    docScroll.Position         = UDim2.new(0,4,0,4)
    docScroll.BackgroundTransparency = 1
    docScroll.ScrollBarThickness = 3
    docScroll.ScrollBarImageColor3 = C.accentDim
    docScroll.CanvasSize       = UDim2.new(0,0,0,0)
    docScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    docScroll.Parent           = docFrame

    local docText = Instance.new("TextLabel")
    docText.Name             = "DocText"
    docText.Size             = UDim2.new(1,-6,0,0)
    docText.AutomaticSize    = Enum.AutomaticSize.Y
    docText.BackgroundTransparency = 1
    docText.TextColor3       = C.textDim
    docText.Font             = FONT_MONO
    docText.TextSize         = 10
    docText.TextWrapped      = true
    docText.TextXAlignment   = Enum.TextXAlignment.Left
    docText.Text             = "-- ZHD Graphics Controller\n"..
        "-- Preset Aktif: (belum dipilih)\n"..
        "-- ZHD=8K OHD=4K MHD=2K FHD=1080P\n"..
        "-- ZLOW=720P OLOW=540P MLOW=320P FLOW=100P\n"..
        "-- Ubah preset lalu salin info ini."
    docText.Parent           = docScroll

    -- Tombol Copy
    local BtnCopy = Instance.new("TextButton")
    BtnCopy.Text             = ICON.COPY .. " Salin Info"
    BtnCopy.Size             = UDim2.new(1,-8,0,22)
    BtnCopy.Position         = UDim2.new(0,4,1,-26)
    BtnCopy.BackgroundColor3 = C.btnHD
    BtnCopy.TextColor3       = C.text
    BtnCopy.Font             = FONT_BODY
    BtnCopy.TextSize         = 11
    BtnCopy.Parent           = docFrame
    makeCorner(BtnCopy, 6)

    BtnCopy.MouseButton1Click:Connect(function()
        local ok, err = pcall(function()
            setclipboard(docText.Text)
        end)
        if not ok then
            -- fallback
            warn("[ZHD] Clipboard: "..tostring(err).."\n"..docText.Text)
        end
        BtnCopy.Text      = "[OK] Tersalin!"
        BtnCopy.BackgroundColor3 = C.success
        task.delay(2, function()
            BtnCopy.Text      = ICON.COPY .. " Salin Info"
            BtnCopy.BackgroundColor3 = C.btnHD
        end)
    end)

    return docFrame, docText
end

-- ============================================================
-- BANGUN ISI SCROLL
-- ============================================================
makeSection(ScrollFrame, "-- GRAFIK HD --")

local presetButtons = {}

for _, key in ipairs(PRESET_ORDER) do
    local p = PRESETS[key]
    local isHD = (key == "ZHD" or key == "OHD" or key == "MHD" or key == "FHD")

    local row = Instance.new("Frame")
    row.Size             = UDim2.new(1,-8,0,46)
    row.BackgroundColor3 = C.panel
    row.Parent           = ScrollFrame
    makeCorner(row, 8)
    makeStroke(row, C.border)

    -- icon
    local ico = newLabel(row, ICON[key], 13, isHD and C.accent or C.accentDim, FONT_MONO)
    ico.Size     = UDim2.new(0,44,1,0)
    ico.Position = UDim2.new(0,4,0,0)
    ico.TextXAlignment = Enum.TextXAlignment.Center

    -- teks
    local lbl = newLabel(row, p.label, 13, C.text, FONT_TITLE)
    lbl.Size     = UDim2.new(0,50,0,20)
    lbl.Position = UDim2.new(0,50,0,4)

    local desc = newLabel(row, p.desc, 10, C.textDim, FONT_BODY)
    desc.Size     = UDim2.new(0,80,0,16)
    desc.Position = UDim2.new(0,50,0,24)

    -- indikator aktif
    local activeDot = Instance.new("Frame")
    activeDot.Size             = UDim2.new(0,6,0,6)
    activeDot.Position         = UDim2.new(0,140,0.5,-3)
    activeDot.BackgroundColor3 = PRESET_COLORS[key]
    activeDot.BackgroundTransparency = 1
    activeDot.Parent           = row
    makeCorner(activeDot, 3)

    -- tombol terapkan
    local btn = Instance.new("TextButton")
    btn.Text             = "Terapkan"
    btn.Size             = UDim2.new(0,72,0,28)
    btn.Position         = UDim2.new(1,-80,0.5,-14)
    btn.BackgroundColor3 = isHD and C.btnHD or C.btnLOW
    btn.TextColor3       = Color3.new(1,1,1)
    btn.Font             = FONT_BODY
    btn.TextSize         = 12
    btn.Parent           = row
    makeCorner(btn, 6)

    presetButtons[key] = { btn = btn, dot = activeDot, row = row }

    -- separator HD / LOW
    if key == "FHD" then
        makeSection(ScrollFrame, "-- GRAFIK LOW --")
    end

    btn.MouseEnter:Connect(function()
        if activeKey ~= key then
            tween(btn, T1, { BackgroundColor3 = C.accent })
            tween(btn, T1, { TextColor3 = C.bg })
        end
    end)
    btn.MouseLeave:Connect(function()
        if activeKey ~= key then
            tween(btn, T1, { BackgroundColor3 = isHD and C.btnHD or C.btnLOW })
            tween(btn, T1, { TextColor3 = Color3.new(1,1,1) })
        end
    end)
end

-- Dokumen
makeSection(ScrollFrame, "-- DOKUMEN INFO --")
local _docFrame, DocText = makeDocSection(ScrollFrame)

-- ============================================================
-- LOGIKA KONFIRMASI & APPLY
-- ============================================================
local pendingKey = nil

local function showDialog(title, msg, onYes)
    DialogTitle.Text = title
    DialogMsg.Text   = msg
    DialogOverlay.Visible = true
    tween(DialogBox, T2, { Size = UDim2.new(0,260,0,160) })

    local connYes, connNo
    connYes = DialogBtnYes.MouseButton1Click:Connect(function()
        DialogOverlay.Visible = false
        connYes:Disconnect()
        connNo:Disconnect()
        onYes()
    end)
    connNo = DialogBtnNo.MouseButton1Click:Connect(function()
        DialogOverlay.Visible = false
        connYes:Disconnect()
        connNo:Disconnect()
    end)
end

local function updateDocText(key)
    local p = PRESETS[key]
    DocText.Text =
        "-- ZHD Graphics Controller\n"..
        "-- Preset Aktif : "..p.label.." ("..p.desc..")\n"..
        "-- GlobalShadows: "..tostring(p.globalShadows).."\n"..
        "-- ShadowDist   : "..tostring(p.shadowDistance).."\n"..
        "-- Brightness   : "..tostring(p.brightness).."\n"..
        "-- Exposure     : "..tostring(p.exposure).."\n"..
        "-- Bloom Intens : "..tostring(p.bloom.Intensity).."\n"..
        "-- SunRays      : "..tostring(p.sunRays.Intensity).."\n"..
        "-- FogEnd       : "..tostring(p.fogEnd)
end

local function doApply(key)
    -- reset semua tombol
    for k, t in pairs(presetButtons) do
        local isHD = (k=="ZHD" or k=="OHD" or k=="MHD" or k=="FHD")
        tween(t.btn, T1, { BackgroundColor3 = isHD and C.btnHD or C.btnLOW })
        tween(t.btn, T1, { TextColor3 = Color3.new(1,1,1) })
        t.dot.BackgroundTransparency = 1
        t.btn.Text = "Terapkan"
    end

    activeKey = key
    local t = presetButtons[key]
    tween(t.btn, T1, { BackgroundColor3 = C.success })
    t.dot.BackgroundTransparency = 0
    t.btn.Text = "[ON]"

    applyPreset(key)
    updateDocText(key)
end

-- sambungkan tombol
for _, key in ipairs(PRESET_ORDER) do
    local p = PRESETS[key]
    local btn = presetButtons[key].btn

    btn.MouseButton1Click:Connect(function()
        pendingKey = key
        if p.warning then
            showDialog(
                "[!] Peringatan GPU",
                "Apakah Anda yakin ingin mengubah grafik ke "..p.label.."?\nHal ini membuat GPU bekerja sangat keras.",
                function() doApply(pendingKey) end
            )
        else
            showDialog(
                "[?] Konfirmasi Grafik",
                "Apakah Anda yakin ingin mengubah grafik ke "..p.label.." ("..p.desc..")?",
                function() doApply(pendingKey) end
            )
        end
    end)
end

-- ============================================================
-- DRAG & DROP
-- ============================================================
local dragging, dragStart, startPos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging  = true
        dragStart = input.Position
        startPos  = MainFrame.Position
    end
end)

TitleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement or
        input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- ============================================================
-- MINIMIZE
-- ============================================================
local minimized = false

BtnMin.MouseButton1Click:Connect(function()
    minimized = true
    tween(MainFrame, T1, { Size = UDim2.new(0,310,0,0) })
    task.delay(0.2, function()
        MainFrame.Visible = false
        ToggleBtn.Visible = true
        tween(ToggleBtn, T1, { BackgroundTransparency = 0 })
    end)
end)

ToggleBtn.MouseButton1Click:Connect(function()
    minimized = false
    ToggleBtn.Visible = false
    MainFrame.Visible = true
    MainFrame.Size    = UDim2.new(0,310,0,0)
    tween(MainFrame, T2, { Size = UDim2.new(0,310,0,440) })
end)

-- ============================================================
-- CLOSE
-- ============================================================
BtnClose.MouseButton1Click:Connect(function()
    CloseDialogOverlay.Visible = true
end)

CloseBtnNo.MouseButton1Click:Connect(function()
    CloseDialogOverlay.Visible = false
end)

CloseBtnYes.MouseButton1Click:Connect(function()
    tween(MainFrame, T1, { Size = UDim2.new(0,310,0,0) })
    tween(MainFrame, T1, { BackgroundTransparency = 1 })
    task.delay(0.22, function()
        ScreenGui:Destroy()
    end)
end)

-- ============================================================
-- ANIMASI MASUK
-- ============================================================
MainFrame.Size = UDim2.new(0,310,0,0)
tween(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    { Size = UDim2.new(0,310,0,440) })

-- ============================================================
-- SELESAI
-- ============================================================
print("[ZHD] Graphics Controller dimuat. Pilih preset dari GUI.")
