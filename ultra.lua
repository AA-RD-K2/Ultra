-- ULTRA | ULTRA MENU + FARM + SPEED CAR + MON FARM

local player = game.Players.LocalPlayer
local userInputService = game:GetService("UserInputService")
local tweens = game:GetService("TweenService")
local runService = game:GetService("RunService")
local vim = game:GetService("VirtualInputManager")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Ultra"
screenGui.Parent = player:WaitForChild("PlayerGui")

-- ===== КНОПКА ОТКРЫТИЯ МЕНЮ =====
local openMenuBtn = Instance.new("TextButton")
openMenuBtn.Size = UDim2.new(0, 80, 0, 80)
openMenuBtn.Position = UDim2.new(0, 10, 0.5, -40)
openMenuBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 180)
openMenuBtn.BackgroundTransparency = 0
openMenuBtn.Text = "☰"
openMenuBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openMenuBtn.TextScaled = true
openMenuBtn.Font = Enum.Font.GothamBold
openMenuBtn.Parent = screenGui
openMenuBtn.ZIndex = 999

local openMenuCorner = Instance.new("UICorner")
openMenuCorner.CornerRadius = UDim.new(0, 12)
openMenuCorner.Parent = openMenuBtn

task.spawn(function()
    while true do
        for i = 1, 2 do
            local pulse = tweens:Create(openMenuBtn, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 0.3
            })
            pulse:Play()
            task.wait(0.3)
            pulse = tweens:Create(openMenuBtn, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 0
            })
            pulse:Play()
            task.wait(0.3)
        end
        task.wait(2)
    end
end)

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 1000, 0, 600)
mainFrame.Position = UDim2.new(0.5, -500, 0.5, -300)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

local ultraLabel = Instance.new("TextLabel")
ultraLabel.Size = UDim2.new(0, 100, 0, 25)
ultraLabel.Position = UDim2.new(0, 15, 0, 10)
ultraLabel.BackgroundTransparency = 1
ultraLabel.Text = "ULTRA"
ultraLabel.TextScaled = true
ultraLabel.Font = Enum.Font.GothamBold
ultraLabel.TextXAlignment = Enum.TextXAlignment.Left
ultraLabel.Parent = mainFrame

local closeMenuBtn = Instance.new("TextButton")
closeMenuBtn.Size = UDim2.new(0, 30, 0, 30)
closeMenuBtn.Position = UDim2.new(1, -40, 0, 10)
closeMenuBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeMenuBtn.BackgroundTransparency = 0
closeMenuBtn.Text = "✕"
closeMenuBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeMenuBtn.TextScaled = true
closeMenuBtn.Font = Enum.Font.GothamBold
closeMenuBtn.Parent = mainFrame

local closeMenuCorner = Instance.new("UICorner")
closeMenuCorner.CornerRadius = UDim.new(0, 4)
closeMenuCorner.Parent = closeMenuBtn

local colors = {
    Color3.fromRGB(100, 0, 180),
    Color3.fromRGB(150, 0, 200),
    Color3.fromRGB(255, 100, 200)
}

local colorIndex = 1
local tween = nil

local function startUltraColorCycle()
    while ultraLabel and ultraLabel.Parent do
        local nextColor = colors[colorIndex % #colors + 1]
        tween = tweens:Create(ultraLabel, TweenInfo.new(0.8, Enum.EasingStyle.Linear), {
            TextColor3 = nextColor
        })
        tween:Play()
        tween.Completed:Wait()
        colorIndex = colorIndex % #colors + 1
    end
end

coroutine.wrap(startUltraColorCycle)()

local horizontalLine = Instance.new("Frame")
horizontalLine.Size = UDim2.new(1, -30, 0, 2)
horizontalLine.Position = UDim2.new(0, 15, 0, 38)
horizontalLine.BackgroundColor3 = colors[1]
horizontalLine.BackgroundTransparency = 0
horizontalLine.BorderSizePixel = 0
horizontalLine.Parent = mainFrame

local verticalLine = Instance.new("Frame")
verticalLine.Size = UDim2.new(0, 2, 1, -45)
verticalLine.Position = UDim2.new(0, 135, 0, 38)
verticalLine.BackgroundColor3 = colors[1]
verticalLine.BackgroundTransparency = 0
verticalLine.BorderSizePixel = 0
verticalLine.Parent = mainFrame

local lineColorIndex = 1
local lineTween = nil

local function startLineColorCycle()
    while horizontalLine and horizontalLine.Parent and verticalLine and verticalLine.Parent do
        local nextColor = colors[lineColorIndex % #colors + 1]
        lineTween = tweens:Create(horizontalLine, TweenInfo.new(0.8, Enum.EasingStyle.Linear), {
            BackgroundColor3 = nextColor
        })
        lineTween:Play()
        lineTween = tweens:Create(verticalLine, TweenInfo.new(0.8, Enum.EasingStyle.Linear), {
            BackgroundColor3 = nextColor
        })
        lineTween:Play()
        lineTween.Completed:Wait()
        lineColorIndex = lineColorIndex % #colors + 1
    end
end

coroutine.wrap(startLineColorCycle)()

local contentContainer = Instance.new("Frame")
contentContainer.Size = UDim2.new(1, -150, 1, -50)
contentContainer.Position = UDim2.new(0, 140, 0, 45)
contentContainer.BackgroundTransparency = 1
contentContainer.Parent = mainFrame

local globalCredits = Instance.new("TextLabel")
globalCredits.Size = UDim2.new(1, -150, 0, 30)
globalCredits.Position = UDim2.new(0, 140, 1, -40)
globalCredits.BackgroundTransparency = 1
globalCredits.Text = "Made by AA-Scripts ; t.me/AAscripts"
globalCredits.TextColor3 = Color3.fromRGB(255, 255, 255)
globalCredits.TextScaled = true
globalCredits.Font = Enum.Font.GothamMedium
globalCredits.TextXAlignment = Enum.TextXAlignment.Center
globalCredits.TextYAlignment = Enum.TextYAlignment.Center
globalCredits.Parent = mainFrame

local homePanel = Instance.new("Frame")
homePanel.Size = UDim2.new(1, 0, 1, 0)
homePanel.Position = UDim2.new(0, 0, 0, 0)
homePanel.BackgroundTransparency = 1
homePanel.BorderSizePixel = 0
homePanel.Visible = true
homePanel.Parent = contentContainer

local welcomeLabel = Instance.new("TextLabel")
welcomeLabel.Size = UDim2.new(1, 0, 0, 60)
welcomeLabel.Position = UDim2.new(0, 0, 0.3, -30)
welcomeLabel.BackgroundTransparency = 1
welcomeLabel.Text = "ДОБРО ПОЖАЛОВАТЬ В ULTRA"
welcomeLabel.TextScaled = true
welcomeLabel.Font = Enum.Font.GothamBold
welcomeLabel.TextXAlignment = Enum.TextXAlignment.Center
welcomeLabel.TextYAlignment = Enum.TextYAlignment.Center
welcomeLabel.Parent = homePanel

local welcomeColorIndex = 1
local welcomeTween = nil

local function startWelcomeColorCycle()
    while welcomeLabel and welcomeLabel.Parent do
        local nextColor = colors[welcomeColorIndex % #colors + 1]
        welcomeTween = tweens:Create(welcomeLabel, TweenInfo.new(0.8, Enum.EasingStyle.Linear), {
            TextColor3 = nextColor
        })
        welcomeTween:Play()
        welcomeTween.Completed:Wait()
        welcomeColorIndex = welcomeColorIndex % #colors + 1
    end
end

coroutine.wrap(startWelcomeColorCycle)()

local menuVisible = true
local animationPlaying = false

local function showMenu()
    if animationPlaying then 
        animationPlaying = false
    end
    menuVisible = true
    mainFrame.Visible = true
    openMenuBtn.Visible = true
    animationPlaying = true
    
    mainFrame.BackgroundTransparency = 0.15
    
    local fadeIn = tweens:Create(mainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.15
    })
    fadeIn:Play()
    fadeIn.Completed:Connect(function()
        animationPlaying = false
    end)
    task.wait(0.3)
    animationPlaying = false
end

local function hideMenu()
    if animationPlaying then 
        animationPlaying = false
    end
    menuVisible = false
    animationPlaying = true
    
    local fadeOut = tweens:Create(mainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        BackgroundTransparency = 1
    })
    fadeOut:Play()
    fadeOut.Completed:Connect(function()
        if not menuVisible then
            mainFrame.Visible = false
        end
        animationPlaying = false
    end)
    task.wait(0.3)
    animationPlaying = false
end

local function toggleMenu()
    if animationPlaying then 
        animationPlaying = false
    end
    if menuVisible then
        hideMenu()
    else
        showMenu()
    end
end

closeMenuBtn.MouseButton1Click:Connect(function()
    if menuVisible then
        hideMenu()
    else
        showMenu()
    end
end)

openMenuBtn.MouseButton1Click:Connect(function()
    if menuVisible then
        hideMenu()
    else
        showMenu()
    end
end)

local function forceShowUI()
    screenGui.Enabled = true
    mainFrame.Visible = true
    mainFrame.BackgroundTransparency = 0.15
    openMenuBtn.Visible = true
    menuVisible = true
    animationPlaying = false
    print("Ultra: UI принудительно восстановлен.")
end

openMenuBtn.MouseButton1Click:Connect(function()
    forceShowUI()
end)

closeMenuBtn.MouseButton1Click:Connect(function()
    forceShowUI()
end)

task.spawn(function()
    while true do
        task.wait(2)
        if menuVisible then
            if not screenGui.Enabled or not mainFrame.Visible then
                forceShowUI()
            end
        end
        openMenuBtn.Visible = true
    end
end)

showMenu()

print("Ultra: Меню загружено. Нажми LeftAlt или кнопку ☰ слева для открытия/закрытия.")
