-- [[ CUSTOM DOORS HUB V1 - CORE FRAMEWORK ]] --
-- ЧАСТЬ 1: Настройка и экран загрузки

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local guiName = "DoorsCustomHub_V1"
if CoreGui:FindFirstChild(guiName) then
    CoreGui[guiName]:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = guiName
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local LoadingFrame = Instance.new("Frame")
LoadingFrame.Name = "LoadingFrame"
LoadingFrame.Size = UDim2.new(0, 400, 0, 250)
LoadingFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
LoadingFrame.BorderSizePixel = 0
LoadingFrame.Parent = ScreenGui

local UICorner_Load = Instance.new("UICorner")
UICorner_Load.CornerRadius = UDim.new(0, 15)
UICorner_Load.Parent = LoadingFrame

local LoadTitle = Instance.new("TextLabel")
LoadTitle.Size = UDim2.new(1, -40, 0, 50)
LoadTitle.Position = UDim2.new(0, 20, 0, 30)
LoadTitle.BackgroundTransparency = 1
LoadTitle.Text = "Custom Doors Hub (Beta)"
LoadTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadTitle.TextSize = 24
LoadTitle.Font = Enum.Font.GothamBold
LoadTitle.TextXAlignment = Enum.TextXAlignment.Left
LoadTitle.Parent = LoadingFrame

local LoadSub = Instance.new("TextLabel")
LoadSub.Size = UDim2.new(1, -40, 0, 20)
LoadSub.Position = UDim2.new(0, 20, 0, 70)
LoadSub.BackgroundTransparency = 1
LoadSub.Text = "Cool Premium Script Suite v2.0"
LoadSub.TextColor3 = Color3.fromRGB(150, 150, 150)
LoadSub.TextSize = 14
LoadSub.Font = Enum.Font.Gotham
LoadSub.TextXAlignment = Enum.TextXAlignment.Left
LoadSub.Parent = LoadingFrame

local FetchingText = Instance.new("TextLabel")
FetchingText.Size = UDim2.new(0.8, 0, 0, 20)
FetchingText.Position = UDim2.new(0, 20, 0.6, 0)
FetchingText.BackgroundTransparency = 1
FetchingText.Text = "Fetching hub modules..."
FetchingText.TextColor3 = Color3.fromRGB(180, 180, 180)
FetchingText.TextSize = 14
FetchingText.Font = Enum.Font.Gotham
FetchingText.TextXAlignment = Enum.TextXAlignment.Left
FetchingText.Parent = LoadingFrame

local PercentText = Instance.new("TextLabel")
PercentText.Size = UDim2.new(0.2, -20, 0, 20)
PercentText.Position = UDim2.new(0.8, 0, 0.6, 0)
PercentText.BackgroundTransparency = 1
PercentText.Text = "0%"
PercentText.TextColor3 = Color3.fromRGB(130, 90, 255)
PercentText.TextSize = 14
PercentText.Font = Enum.Font.GothamBold
PercentText.TextXAlignment = Enum.TextXAlignment.Right
PercentText.Parent = LoadingFrame

local ProgressBarBG = Instance.new("Frame")
ProgressBarBG.Size = UDim2.new(1, -40, 0, 10)
ProgressBarBG.Position = UDim2.new(0, 20, 0.75, 0)
ProgressBarBG.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
ProgressBarBG.Parent = LoadingFrame
Instance.new("UICorner", ProgressBarBG).CornerRadius = UDim.new(1, 0)

local ProgressBarFill = Instance.new("Frame")
ProgressBarFill.Size = UDim2.new(0, 0, 1, 0)
ProgressBarFill.BackgroundColor3 = Color3.fromRGB(130, 90, 255)
ProgressBarFill.Parent = ProgressBarBG
Instance.new("UICorner", ProgressBarFill).CornerRadius = UDim.new(1, 0)
-- ЧАСТЬ 2: Иконка и главное окно меню

local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 20, 0, 20)
ToggleButton.BackgroundColor3 = Color3.fromRGB(130, 90, 255)
ToggleButton.Text = "HUB"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 14
ToggleButton.Visible = false
ToggleButton.Parent = ScreenGui
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1, 0)

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 500, 0, 300)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Visible = false
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local UserInputService = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 120, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Sidebar.Parent = MainFrame
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)

local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -130, 1, -20)
ContentArea.Position = UDim2.new(0, 130, 0, 10)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame
-- ЧАСТЬ 3: Система вкладок и создание разделов

local tabs = {}
local pages = {}

local function CreateTab(name, yPos, isFirst)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, 0, 0, 40)
    TabBtn.Position = UDim2.new(0, 0, 0, yPos)
    TabBtn.BackgroundTransparency = 1
    TabBtn.Text = name
    TabBtn.TextColor3 = isFirst and Color3.fromRGB(130, 90, 255) or Color3.fromRGB(200, 200, 200)
    TabBtn.Font = Enum.Font.GothamBold
    TabBtn.TextSize = 14
    TabBtn.Parent = Sidebar

    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.ScrollBarThickness = 4
    Page.Visible = isFirst
    Page.Parent = ContentArea
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, 10)
    UIListLayout.Parent = Page

    table.insert(tabs, TabBtn)
    table.insert(pages, Page)

    TabBtn.MouseButton1Click:Connect(function()
        for i, v in pairs(pages) do v.Visible = false end
        for i, v in pairs(tabs) do v.TextColor3 = Color3.fromRGB(200, 200, 200) end
        Page.Visible = true
        TabBtn.TextColor3 = Color3.fromRGB(130, 90, 255)
    end)

    return Page
end

local function CreateButton(parent, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -10, 0, 35)
    Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 14
    Btn.Parent = parent
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 5)
    
    Btn.MouseButton1Click:Connect(callback)
end

local ModsPage = CreateTab("Mods Hub", 10, true)
local SpawnersPage = CreateTab("Spawners", 50, false)
local EditorPage = CreateTab("Entity Editor", 90, false)
local ViewersPage = CreateTab("Viewers", 130, false)
-- ЧАСТЬ 4: Инъекция твоих скриптов (Моды и Спавн сущностей)

CreateButton(ModsPage, "Load Doors Modes Hub V34", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes-Hub/refs/heads/main/Doors-Modes-Hub-V34-(Beta)"))()
end)

CreateButton(ModsPage, "Zombie Mode", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/GrampyMods/ZombieMode/refs/heads/main/mode'))()
end)

CreateButton(ModsPage, "Rainbow Mode (Color Rooms)", function()
    task.spawn(function()
        local rooms = workspace:WaitForChild("CurrentRooms")
        local colors = {
            Color3.fromRGB(255,0,0), Color3.fromRGB(255,127,0), Color3.fromRGB(255,255,0),
            Color3.fromRGB(0,255,0), Color3.fromRGB(0,255,255), Color3.fromRGB(0,0,255),
            Color3.fromRGB(170,0,255)
        }
        local i = 1
        while true do
            for _, room in pairs(rooms:GetChildren()) do
                for _, obj in pairs(room:GetDescendants()) do
                    if obj:IsA("BasePart") then
                        obj.Color = colors[i]
                    end
                end
            end
            i += 1
            if i > #colors then i = 1 end
            task.wait(1)
        end
    end)
end)

CreateButton(SpawnersPage, "Spawn Smiler", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/rrealblueyt-oss/Smiler/refs/heads/main/Smi6"))()
end)

CreateButton(SpawnersPage, "Spawn Trollface (Door 50)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Custom-Entity/refs/heads/main/Trollface-Entity-Only-Appears-On-Door-50-So-Good-Luck-Reaching-Door-50-lol"))()
end)

CreateButton(SpawnersPage, "Hardcore Figure (Door 50)", function()
    loadstring(game:HttpGet("https://pastefy.app/HqYkpRqh/raw"))()
end)

CreateButton(SpawnersPage, "Silence Entity", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/rrealblueyt-oss/Silence/refs/heads/main/Silence-entities20%2525.lua", true))()
end)

CreateButton(SpawnersPage, "Report Entity", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/rrealblueyt-oss/Report-/refs/heads/main/README.md", true))()
end)
-- ЧАСТЬ 5: Редактор, логика экрана загрузки и запуск скрипта

local EditorDesc = Instance.new("TextLabel")
EditorDesc.Size = UDim2.new(1, -10, 0, 50)
EditorDesc.BackgroundTransparency = 1
EditorDesc.Text = "Entity Editor (WIP)\nSelect behavior and design."
EditorDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
EditorDesc.Font = Enum.Font.Gotham
EditorDesc.TextSize = 14
EditorDesc.Parent = EditorPage

CreateButton(EditorPage, "Behavior: Rush Mechanic", function()
    print("Rush behavior selected (Awaiting backend implementation)")
end)

CreateButton(EditorPage, "Open Pixel Paint", function()
    print("Pixel Paint feature coming soon...")
end)

CreateButton(EditorPage, "Get Spawn Script", function()
    setclipboard("print('Your custom entity script goes here!')")
    print("Script copied to clipboard!")
end)

local ViewDesc = Instance.new("TextLabel")
ViewDesc.Size = UDim2.new(1, -10, 0, 50)
ViewDesc.BackgroundTransparency = 1
ViewDesc.Text = "Asset Viewer requires bypass\nto load all hidden models & photos."
ViewDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
ViewDesc.Font = Enum.Font.Gotham
ViewDesc.TextSize = 14
ViewDesc.Parent = ViewersPage

CreateButton(ViewersPage, "Scan Game Photos", function()
    print("Scanning for Decals in workspace...")
end)

CreateButton(ViewersPage, "View Hidden Models", function()
    print("Cannot render full 3D models in basic GUI.")
end)

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local function StartLoading()
    for i = 1, 100 do
        PercentText.Text = tostring(i) .. "%"
        ProgressBarFill.Size = UDim2.new(i/100, 0, 1, 0)
        
        if i == 30 then FetchingText.Text = "Loading Hub V34 core..." end
        if i == 60 then FetchingText.Text = "Injecting Entity Spawners..." end
        if i == 85 then FetchingText.Text = "Bypassing..." end
        
        task.wait(0.02)
    end
    
    FetchingText.Text = "Done!"
    task.wait(0.5)
    
    TweenService:Create(LoadingFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(LoadTitle, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(LoadSub, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(FetchingText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(PercentText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(ProgressBarBG, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(ProgressBarFill, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    
    task.wait(0.5)
    LoadingFrame.Visible = false
    ToggleButton.Visible = true
    MainFrame.Visible = true
end

StartLoading()
