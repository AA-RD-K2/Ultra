-- ROCKET | ULTRA MENU + FARM + SPEED CAR + MON FARM

local player = game.Players.LocalPlayer
local userInputService = game:GetService("UserInputService")
local tweens = game:GetService("TweenService")
local runService = game:GetService("RunService")
local vim = game:GetService("VirtualInputManager")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Ultra"
screenGui.Parent = player:WaitForChild("PlayerGui")

-- ===== КНОПКА ОТКРЫТИЯ МЕНЮ (СЛЕВА, ВСЕГДА ВИДИМА) =====
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

-- Анимация пульсации
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

-- ===== ОСНОВНОЙ ФРЕЙМ (УВЕЛИЧЕННАЯ ШИРИНА 1000px) =====
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

-- ===== ULTRA =====
local ultraLabel = Instance.new("TextLabel")
ultraLabel.Size = UDim2.new(0, 100, 0, 25)
ultraLabel.Position = UDim2.new(0, 15, 0, 10)
ultraLabel.BackgroundTransparency = 1
ultraLabel.Text = "ULTRA"
ultraLabel.TextScaled = true
ultraLabel.Font = Enum.Font.GothamBold
ultraLabel.TextXAlignment = Enum.TextXAlignment.Left
ultraLabel.Parent = mainFrame

-- ===== КНОПКА ЗАКРЫТИЯ МЕНЮ (ПРАВЫЙ ВЕРХНИЙ УГОЛ) =====
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

-- ===== ЦВЕТА =====
local colors = {
    Color3.fromRGB(100, 0, 180),
    Color3.fromRGB(150, 0, 200),
    Color3.fromRGB(255, 100, 200)
}

-- ===== ПЕРЕЛИВ ULTRA =====
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

-- ===== ГОРИЗОНТАЛЬНАЯ ЛИНИЯ =====
local horizontalLine = Instance.new("Frame")
horizontalLine.Size = UDim2.new(1, -30, 0, 2)
horizontalLine.Position = UDim2.new(0, 15, 0, 38)
horizontalLine.BackgroundColor3 = colors[1]
horizontalLine.BackgroundTransparency = 0
horizontalLine.BorderSizePixel = 0
horizontalLine.Parent = mainFrame

-- ===== ВЕРТИКАЛЬНАЯ ЛИНИЯ =====
local verticalLine = Instance.new("Frame")
verticalLine.Size = UDim2.new(0, 2, 1, -45)
verticalLine.Position = UDim2.new(0, 135, 0, 38)
verticalLine.BackgroundColor3 = colors[1]
verticalLine.BackgroundTransparency = 0
verticalLine.BorderSizePixel = 0
verticalLine.Parent = mainFrame

-- ===== ПЕРЕЛИВ ЛИНИЙ =====
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

-- ============================================================
-- ===== КОНТЕЙНЕР ДЛЯ ВКЛАДОК =====
-- ============================================================
local contentContainer = Instance.new("Frame")
contentContainer.Size = UDim2.new(1, -150, 1, -50)
contentContainer.Position = UDim2.new(0, 140, 0, 45)
contentContainer.BackgroundTransparency = 1
contentContainer.Parent = mainFrame

-- ===== ГЛОБАЛЬНЫЕ КРЕДИТЫ (ВИДНЫ ВО ВСЕХ ВКЛАДКАХ) =====
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

-- ============================================================
-- ===== HOME PANEL (ГЛАВНАЯ ВКЛАДКА) =====
-- ============================================================
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

-- ============================================================
-- ===== FLY (ВНУТРИ MISC) =====
-- ============================================================
local flyStatus = false
local flySpeed = 50
local bodyVelocity = nil
local bodyGyro = nil
local flyBindKey = nil

local flyPanel = Instance.new("Frame")
flyPanel.Size = UDim2.new(0, 180, 0, 55)
flyPanel.Position = UDim2.new(0, 10, 0, 45)
flyPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
flyPanel.BackgroundTransparency = 0.2
flyPanel.BorderSizePixel = 0
flyPanel.Visible = false
flyPanel.Parent = contentContainer

local flyPanelCorner = Instance.new("UICorner")
flyPanelCorner.CornerRadius = UDim.new(0, 8)
flyPanelCorner.Parent = flyPanel

local flyTopRow = Instance.new("Frame")
flyTopRow.Size = UDim2.new(1, 0, 0, 30)
flyTopRow.Position = UDim2.new(0, 0, 0, 0)
flyTopRow.BackgroundTransparency = 1
flyTopRow.Parent = flyPanel

local flyTitle = Instance.new("TextLabel")
flyTitle.Size = UDim2.new(0, 50, 1, 0)
flyTitle.Position = UDim2.new(0, 8, 0, 0)
flyTitle.BackgroundTransparency = 1
flyTitle.Text = "FLY"
flyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
flyTitle.TextScaled = true
flyTitle.Font = Enum.Font.GothamBold
flyTitle.TextXAlignment = Enum.TextXAlignment.Left
flyTitle.Parent = flyTopRow

local flyToggleBtn = Instance.new("TextButton")
flyToggleBtn.Size = UDim2.new(0, 80, 1, -4)
flyToggleBtn.Position = UDim2.new(0, 75, 0, 2)
flyToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
flyToggleBtn.Text = "OFF"
flyToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
flyToggleBtn.TextScaled = true
flyToggleBtn.Font = Enum.Font.GothamBold
flyToggleBtn.Parent = flyTopRow

local flyToggleCorner = Instance.new("UICorner")
flyToggleCorner.CornerRadius = UDim.new(0, 4)
flyToggleCorner.Parent = flyToggleBtn

-- FLY SPEED PANEL
local flySpeedPanel = Instance.new("Frame")
flySpeedPanel.Size = UDim2.new(0, 110, 0, 65)
flySpeedPanel.Position = UDim2.new(0.5, -55, 0, 35)
flySpeedPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
flySpeedPanel.BackgroundTransparency = 0.2
flySpeedPanel.BorderSizePixel = 0
flySpeedPanel.Visible = false
flySpeedPanel.ClipsDescendants = true
flySpeedPanel.Parent = flyPanel

local flySpeedPanelCorner = Instance.new("UICorner")
flySpeedPanelCorner.CornerRadius = UDim.new(0, 6)
flySpeedPanelCorner.Parent = flySpeedPanel

local flySpeedContainer = Instance.new("Frame")
flySpeedContainer.Size = UDim2.new(1, 0, 1, 0)
flySpeedContainer.Position = UDim2.new(0, 0, 0, -65)
flySpeedContainer.BackgroundTransparency = 1
flySpeedContainer.Parent = flySpeedPanel

local flySpeedTop = Instance.new("Frame")
flySpeedTop.Size = UDim2.new(1, 0, 0, 20)
flySpeedTop.Position = UDim2.new(0, 0, 0, 0)
flySpeedTop.BackgroundTransparency = 1
flySpeedTop.Parent = flySpeedContainer

local flySpeedTitle = Instance.new("TextLabel")
flySpeedTitle.Size = UDim2.new(0, 45, 1, 0)
flySpeedTitle.Position = UDim2.new(0, 5, 0, 0)
flySpeedTitle.BackgroundTransparency = 1
flySpeedTitle.Text = "SPEED"
flySpeedTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
flySpeedTitle.TextScaled = true
flySpeedTitle.Font = Enum.Font.GothamBold
flySpeedTitle.TextXAlignment = Enum.TextXAlignment.Left
flySpeedTitle.Parent = flySpeedTop

local flySpeedValue = Instance.new("TextLabel")
flySpeedValue.Size = UDim2.new(0, 35, 1, 0)
flySpeedValue.Position = UDim2.new(1, -40, 0, 0)
flySpeedValue.BackgroundTransparency = 1
flySpeedValue.Text = "50"
flySpeedValue.TextColor3 = Color3.fromRGB(200, 200, 255)
flySpeedValue.TextScaled = true
flySpeedValue.Font = Enum.Font.GothamBold
flySpeedValue.TextXAlignment = Enum.TextXAlignment.Right
flySpeedValue.Parent = flySpeedTop

local flySliderContainer = Instance.new("Frame")
flySliderContainer.Size = UDim2.new(0, 95, 0, 20)
flySliderContainer.Position = UDim2.new(0.5, -47.5, 0, 22)
flySliderContainer.BackgroundTransparency = 1
flySliderContainer.Parent = flySpeedContainer

local flySliderHitbox = Instance.new("TextButton")
flySliderHitbox.Size = UDim2.new(1, 0, 1, 0)
flySliderHitbox.Position = UDim2.new(0, 0, 0, 0)
flySliderHitbox.BackgroundTransparency = 1
flySliderHitbox.Text = ""
flySliderHitbox.Parent = flySliderContainer

local flySliderBg = Instance.new("Frame")
flySliderBg.Size = UDim2.new(1, -10, 0, 3)
flySliderBg.Position = UDim2.new(0, 5, 0.5, -1.5)
flySliderBg.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
flySliderBg.BackgroundTransparency = 0
flySliderBg.BorderSizePixel = 0
flySliderBg.Parent = flySliderContainer

local flySliderFill = Instance.new("Frame")
flySliderFill.Size = UDim2.new(0.125, 0, 1, 0)
flySliderFill.Position = UDim2.new(0, 0, 0, 0)
flySliderFill.BackgroundColor3 = colors[1]
flySliderFill.BackgroundTransparency = 0
flySliderFill.BorderSizePixel = 0
flySliderFill.Parent = flySliderBg

local flySliderButton = Instance.new("TextButton")
flySliderButton.Size = UDim2.new(0, 12, 0, 12)
flySliderButton.Position = UDim2.new(0.125, -6, 0.5, -6)
flySliderButton.BackgroundColor3 = Color3.fromRGB(220, 220, 255)
flySliderButton.BackgroundTransparency = 0
flySliderButton.Text = ""
flySliderButton.BorderSizePixel = 0
flySliderButton.Parent = flySliderContainer

local flySliderButtonCorner = Instance.new("UICorner")
flySliderButtonCorner.CornerRadius = UDim.new(1, 0)
flySliderButtonCorner.Parent = flySliderButton

local flyDragging = false

local function updateFlySlider(newPos)
    newPos = math.clamp(newPos, 0, 1)
    flySliderFill.Size = UDim2.new(newPos, 0, 1, 0)
    flySliderButton.Position = UDim2.new(newPos, -6, 0.5, -6)
    flySpeed = math.floor(newPos * 399) + 1
    flySpeedValue.Text = tostring(flySpeed)
end

flySliderButton.MouseButton1Down:Connect(function() flyDragging = true end)
flySliderHitbox.MouseButton1Down:Connect(function() flyDragging = true end)

userInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then flyDragging = false end
end)

userInputService.InputChanged:Connect(function(input)
    if flyDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local containerPos = flySliderContainer.AbsolutePosition.X + 5
        local containerSize = flySliderContainer.AbsoluteSize.X - 10
        local mouseX = input.Position.X
        local newPos = math.clamp((mouseX - containerPos) / containerSize, 0, 1)
        updateFlySlider(newPos)
    end
end)

local function showFlySpeed()
    flySpeedPanel.Visible = true
    flySpeedContainer.Position = UDim2.new(0, 0, 0, -65)
    local slideDown = tweens:Create(flySpeedContainer, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, 0, 0, 0)
    })
    slideDown:Play()
    local pos = (flySpeed - 1) / 399
    updateFlySlider(pos)
end

local function hideFlySpeed()
    local slideUp = tweens:Create(flySpeedContainer, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Position = UDim2.new(0, 0, 0, -65)
    })
    slideUp:Play()
    slideUp.Completed:Connect(function()
        flySpeedPanel.Visible = false
    end)
end

flyToggleBtn.MouseEnter:Connect(function()
    showFlySpeed()
end)

flySpeedPanel.MouseLeave:Connect(function()
    hideFlySpeed()
end)

function enableFly()
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    if bodyVelocity then bodyVelocity:Destroy() end
    if bodyGyro then bodyGyro:Destroy() end

    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = root

    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
    bodyGyro.CFrame = root.CFrame
    bodyGyro.Parent = root

    flyStatus = true
    flyToggleBtn.Text = "ON"
    flyToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
end

function disableFly()
    if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
    if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end

    flyStatus = false
    flyToggleBtn.Text = "OFF"
    flyToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
end

flyToggleBtn.MouseButton1Click:Connect(function()
    if flyStatus then
        disableFly()
    else
        enableFly()
    end
end)

local function handleFly()
    if not flyStatus then return end

    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root or not bodyVelocity then return end

    local camera = workspace.CurrentCamera
    if not camera then return end

    local forward = camera.CFrame.LookVector
    local right = camera.CFrame.RightVector
    local up = camera.CFrame.UpVector

    local moveDir = Vector3.new(0, 0, 0)

    if userInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + forward end
    if userInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - forward end
    if userInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - right end
    if userInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + right end
    if userInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + up end
    if userInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - up end

    if moveDir.Magnitude > 0 then
        bodyVelocity.Velocity = moveDir.Unit * flySpeed
    else
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    end

    local lookDir = Vector3.new(forward.X, 0, forward.Z)
    if lookDir.Magnitude > 0.1 then
        root.CFrame = CFrame.lookAt(root.Position, root.Position + lookDir)
    end

    if bodyGyro then bodyGyro.CFrame = root.CFrame end
end

runService.Heartbeat:Connect(function()
    handleFly()
end)

-- ============================================================
-- ===== SPEED CAR =====
-- ============================================================
local speedCarActive = false
local speedCarSpeed = 300
local speedCarDuration = 0.5
local speedCarBindKey = nil
local speedCarDragging = false

local speedCarPanel = Instance.new("Frame")
speedCarPanel.Size = UDim2.new(0, 180, 0, 55)
speedCarPanel.Position = UDim2.new(0, 10, 0, 115)
speedCarPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
speedCarPanel.BackgroundTransparency = 0.2
speedCarPanel.BorderSizePixel = 0
speedCarPanel.Visible = false
speedCarPanel.Parent = contentContainer

local speedCarPanelCorner = Instance.new("UICorner")
speedCarPanelCorner.CornerRadius = UDim.new(0, 8)
speedCarPanelCorner.Parent = speedCarPanel

local speedCarTopRow = Instance.new("Frame")
speedCarTopRow.Size = UDim2.new(1, 0, 0, 30)
speedCarTopRow.Position = UDim2.new(0, 0, 0, 0)
speedCarTopRow.BackgroundTransparency = 1
speedCarTopRow.Parent = speedCarPanel

local speedCarTitle = Instance.new("TextLabel")
speedCarTitle.Size = UDim2.new(0, 90, 1, 0)
speedCarTitle.Position = UDim2.new(0, 8, 0, 0)
speedCarTitle.BackgroundTransparency = 1
speedCarTitle.Text = "SPEED CAR"
speedCarTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
speedCarTitle.TextScaled = true
speedCarTitle.Font = Enum.Font.GothamBold
speedCarTitle.TextXAlignment = Enum.TextXAlignment.Left
speedCarTitle.Parent = speedCarTopRow

local speedCarToggleBtn = Instance.new("TextButton")
speedCarToggleBtn.Size = UDim2.new(0, 50, 1, -4)
speedCarToggleBtn.Position = UDim2.new(0, 105, 0, 2)
speedCarToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
speedCarToggleBtn.Text = "▶"
speedCarToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
speedCarToggleBtn.TextScaled = true
speedCarToggleBtn.Font = Enum.Font.GothamBold
speedCarToggleBtn.Parent = speedCarTopRow

local speedCarToggleCorner = Instance.new("UICorner")
speedCarToggleCorner.CornerRadius = UDim.new(0, 4)
speedCarToggleCorner.Parent = speedCarToggleBtn

-- SPEED CAR SPEED PANEL
local speedCarSpeedPanel = Instance.new("Frame")
speedCarSpeedPanel.Size = UDim2.new(0, 110, 0, 65)
speedCarSpeedPanel.Position = UDim2.new(0.5, -55, 0, 35)
speedCarSpeedPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
speedCarSpeedPanel.BackgroundTransparency = 0.2
speedCarSpeedPanel.BorderSizePixel = 0
speedCarSpeedPanel.Visible = false
speedCarSpeedPanel.ClipsDescendants = true
speedCarSpeedPanel.Parent = speedCarPanel

local speedCarSpeedPanelCorner = Instance.new("UICorner")
speedCarSpeedPanelCorner.CornerRadius = UDim.new(0, 6)
speedCarSpeedPanelCorner.Parent = speedCarSpeedPanel

local speedCarSpeedContainer = Instance.new("Frame")
speedCarSpeedContainer.Size = UDim2.new(1, 0, 1, 0)
speedCarSpeedContainer.Position = UDim2.new(0, 0, 0, -65)
speedCarSpeedContainer.BackgroundTransparency = 1
speedCarSpeedContainer.Parent = speedCarSpeedPanel

local speedCarSpeedTop = Instance.new("Frame")
speedCarSpeedTop.Size = UDim2.new(1, 0, 0, 20)
speedCarSpeedTop.Position = UDim2.new(0, 0, 0, 0)
speedCarSpeedTop.BackgroundTransparency = 1
speedCarSpeedTop.Parent = speedCarSpeedContainer

local speedCarSpeedTitle = Instance.new("TextLabel")
speedCarSpeedTitle.Size = UDim2.new(0, 45, 1, 0)
speedCarSpeedTitle.Position = UDim2.new(0, 5, 0, 0)
speedCarSpeedTitle.BackgroundTransparency = 1
speedCarSpeedTitle.Text = "SPEED"
speedCarSpeedTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
speedCarSpeedTitle.TextScaled = true
speedCarSpeedTitle.Font = Enum.Font.GothamBold
speedCarSpeedTitle.TextXAlignment = Enum.TextXAlignment.Left
speedCarSpeedTitle.Parent = speedCarSpeedTop

local speedCarSpeedValue = Instance.new("TextLabel")
speedCarSpeedValue.Size = UDim2.new(0, 35, 1, 0)
speedCarSpeedValue.Position = UDim2.new(1, -40, 0, 0)
speedCarSpeedValue.BackgroundTransparency = 1
speedCarSpeedValue.Text = "300"
speedCarSpeedValue.TextColor3 = Color3.fromRGB(200, 200, 255)
speedCarSpeedValue.TextScaled = true
speedCarSpeedValue.Font = Enum.Font.GothamBold
speedCarSpeedValue.TextXAlignment = Enum.TextXAlignment.Right
speedCarSpeedValue.Parent = speedCarSpeedTop

local speedCarSliderContainer = Instance.new("Frame")
speedCarSliderContainer.Size = UDim2.new(0, 95, 0, 20)
speedCarSliderContainer.Position = UDim2.new(0.5, -47.5, 0, 22)
speedCarSliderContainer.BackgroundTransparency = 1
speedCarSliderContainer.Parent = speedCarSpeedContainer

local speedCarSliderHitbox = Instance.new("TextButton")
speedCarSliderHitbox.Size = UDim2.new(1, 0, 1, 0)
speedCarSliderHitbox.Position = UDim2.new(0, 0, 0, 0)
speedCarSliderHitbox.BackgroundTransparency = 1
speedCarSliderHitbox.Text = ""
speedCarSliderHitbox.Parent = speedCarSliderContainer

local speedCarSliderBg = Instance.new("Frame")
speedCarSliderBg.Size = UDim2.new(1, -10, 0, 3)
speedCarSliderBg.Position = UDim2.new(0, 5, 0.5, -1.5)
speedCarSliderBg.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
speedCarSliderBg.BackgroundTransparency = 0
speedCarSliderBg.BorderSizePixel = 0
speedCarSliderBg.Parent = speedCarSliderContainer

local speedCarSliderFill = Instance.new("Frame")
speedCarSliderFill.Size = UDim2.new(0.75, 0, 1, 0)
speedCarSliderFill.Position = UDim2.new(0, 0, 0, 0)
speedCarSliderFill.BackgroundColor3 = colors[1]
speedCarSliderFill.BackgroundTransparency = 0
speedCarSliderFill.BorderSizePixel = 0
speedCarSliderFill.Parent = speedCarSliderBg

local speedCarSliderButton = Instance.new("TextButton")
speedCarSliderButton.Size = UDim2.new(0, 12, 0, 12)
speedCarSliderButton.Position = UDim2.new(0.75, -6, 0.5, -6)
speedCarSliderButton.BackgroundColor3 = Color3.fromRGB(220, 220, 255)
speedCarSliderButton.BackgroundTransparency = 0
speedCarSliderButton.Text = ""
speedCarSliderButton.BorderSizePixel = 0
speedCarSliderButton.Parent = speedCarSliderContainer

local speedCarSliderButtonCorner = Instance.new("UICorner")
speedCarSliderButtonCorner.CornerRadius = UDim.new(1, 0)
speedCarSliderButtonCorner.Parent = speedCarSliderButton

function activateSpeedCar()
    if speedCarActive then return end
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    speedCarActive = true
    
    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    
    local direction = root.CFrame.LookVector
    direction = Vector3.new(direction.X, 0, direction.Z).Unit
    
    if direction.Magnitude < 0.1 then
        direction = Vector3.new(1, 0, 0)
    end
    
    bv.Velocity = direction * speedCarSpeed
    bv.Parent = root
    
    task.wait(speedCarDuration)
    
    if bv and bv.Parent then
        bv:Destroy()
    end
    
    speedCarActive = false
end

local function updateSpeedCarSlider(newPos)
    newPos = math.clamp(newPos, 0, 1)
    speedCarSliderFill.Size = UDim2.new(newPos, 0, 1, 0)
    speedCarSliderButton.Position = UDim2.new(newPos, -6, 0.5, -6)
    speedCarSpeed = math.floor(newPos * 399) + 1
    speedCarSpeedValue.Text = tostring(speedCarSpeed)
end

speedCarSliderButton.MouseButton1Down:Connect(function() speedCarDragging = true end)
speedCarSliderHitbox.MouseButton1Down:Connect(function() speedCarDragging = true end)

userInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then speedCarDragging = false end
end)

userInputService.InputChanged:Connect(function(input)
    if speedCarDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local containerPos = speedCarSliderContainer.AbsolutePosition.X + 5
        local containerSize = speedCarSliderContainer.AbsoluteSize.X - 10
        local mouseX = input.Position.X
        local newPos = math.clamp((mouseX - containerPos) / containerSize, 0, 1)
        updateSpeedCarSlider(newPos)
    end
end)

local function showSpeedCarSpeed()
    speedCarSpeedPanel.Visible = true
    speedCarSpeedContainer.Position = UDim2.new(0, 0, 0, -65)
    local slideDown = tweens:Create(speedCarSpeedContainer, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, 0, 0, 0)
    })
    slideDown:Play()
    local pos = (speedCarSpeed - 1) / 399
    updateSpeedCarSlider(pos)
end

local function hideSpeedCarSpeed()
    local slideUp = tweens:Create(speedCarSpeedContainer, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Position = UDim2.new(0, 0, 0, -65)
    })
    slideUp:Play()
    slideUp.Completed:Connect(function()
        speedCarSpeedPanel.Visible = false
    end)
end

speedCarToggleBtn.MouseEnter:Connect(function()
    showSpeedCarSpeed()
end)

speedCarSpeedPanel.MouseLeave:Connect(function()
    hideSpeedCarSpeed()
end)

speedCarToggleBtn.MouseButton1Click:Connect(function()
    activateSpeedCar()
end)

-- ============================================================
-- ===== NOCLIP =====
-- ============================================================
local noclipActive = false
local noclipConn = nil
local noclipBindKey = nil

local noclipPanel = Instance.new("Frame")
noclipPanel.Size = UDim2.new(0, 200, 0, 55)
noclipPanel.Position = UDim2.new(0, 10, 0, 195)
noclipPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
noclipPanel.BackgroundTransparency = 0.2
noclipPanel.BorderSizePixel = 0
noclipPanel.Visible = false
noclipPanel.Parent = contentContainer

local noclipPanelCorner = Instance.new("UICorner")
noclipPanelCorner.CornerRadius = UDim.new(0, 8)
noclipPanelCorner.Parent = noclipPanel

local noclipTitle = Instance.new("TextLabel")
noclipTitle.Size = UDim2.new(0, 70, 1, 0)
noclipTitle.Position = UDim2.new(0, 8, 0, 0)
noclipTitle.BackgroundTransparency = 1
noclipTitle.Text = "NOCLIP"
noclipTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipTitle.TextScaled = true
noclipTitle.Font = Enum.Font.GothamBold
noclipTitle.TextXAlignment = Enum.TextXAlignment.Left
noclipTitle.Parent = noclipPanel

local noclipToggleBtn = Instance.new("TextButton")
noclipToggleBtn.Size = UDim2.new(0, 80, 1, -6)
noclipToggleBtn.Position = UDim2.new(0, 85, 0, 3)
noclipToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
noclipToggleBtn.Text = "ВКЛ"
noclipToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipToggleBtn.TextScaled = true
noclipToggleBtn.Font = Enum.Font.GothamBold
noclipToggleBtn.Parent = noclipPanel

local noclipToggleCorner = Instance.new("UICorner")
noclipToggleCorner.CornerRadius = UDim.new(0, 4)
noclipToggleCorner.Parent = noclipToggleBtn

function toggleNoclip()
    noclipActive = not noclipActive
    if noclipActive then
        noclipToggleBtn.Text = "ВЫКЛ"
        noclipToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        noclipConn = runService.Heartbeat:Connect(function()
            local char = player.Character
            if char then
                for _, v in pairs(char:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end)
    else
        noclipToggleBtn.Text = "ВКЛ"
        noclipToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        if noclipConn then
            noclipConn:Disconnect()
            noclipConn = nil
        end
        local char = player.Character
        if char then
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = true
                end
            end
        end
    end
end

noclipToggleBtn.MouseButton1Click:Connect(toggleNoclip)

-- ============================================================
-- ===== MISC PANEL (ВКЛАДКА) =====
-- ============================================================
local miscPanel = Instance.new("Frame")
miscPanel.Size = UDim2.new(1, 0, 1, 0)
miscPanel.Position = UDim2.new(0, 0, 0, 0)
miscPanel.BackgroundTransparency = 1
miscPanel.BorderSizePixel = 0
miscPanel.Visible = false
miscPanel.Parent = contentContainer

local miscTitle2 = Instance.new("TextLabel")
miscTitle2.Size = UDim2.new(1, 0, 0, 25)
miscTitle2.Position = UDim2.new(0, 0, 0, 10)
miscTitle2.BackgroundTransparency = 1
miscTitle2.Text = "MISC"
miscTitle2.TextColor3 = Color3.fromRGB(255, 255, 255)
miscTitle2.TextScaled = true
miscTitle2.Font = Enum.Font.GothamBold
miscTitle2.TextXAlignment = Enum.TextXAlignment.Left
miscTitle2.Parent = miscPanel

flyPanel.Parent = miscPanel
flyPanel.Position = UDim2.new(0, 10, 0, 45)
flyPanel.Visible = true

speedCarPanel.Parent = miscPanel
speedCarPanel.Position = UDim2.new(0, 10, 0, 120)
speedCarPanel.Visible = true

noclipPanel.Parent = miscPanel
noclipPanel.Position = UDim2.new(0, 10, 0, 195)
noclipPanel.Visible = true

-- ============================================================
-- ===== MON FARM (ВКЛАДКА FARM С ИНСТРУКЦИЕЙ) =====
-- ============================================================
local monFarmRunning = false
local monFarmBv = nil
local monFarmBg = nil
local monFarmSpeed = 350
local monFarmFlyActive = false
local monFarmStopRequested = false

local monFarmConfig = {
    buyPos = Vector3.new(6804.3, 20.6, 22.7),
    point1 = Vector3.new(6856.6, 17.7, 111.9),
    point2 = Vector3.new(-96.2, 17.7, 111.2),
    point3 = Vector3.new(57.9, 18.1, 369.0),
    exchangePos = Vector3.new(-83.5, 49.7, 432.2),
    sellPos = Vector3.new(6808.8, 17.2, -34.4),
}

local farmPanel = Instance.new("Frame")
farmPanel.Size = UDim2.new(1, 0, 1, 0)
farmPanel.Position = UDim2.new(0, 0, 0, 0)
farmPanel.BackgroundTransparency = 1
farmPanel.BorderSizePixel = 0
farmPanel.Visible = false
farmPanel.Parent = contentContainer

-- ===== ЛЕВАЯ ЧАСТЬ (УПРАВЛЕНИЕ) =====
local leftSide = Instance.new("Frame")
leftSide.Size = UDim2.new(0, 350, 1, 0)
leftSide.Position = UDim2.new(0, 0, 0, 0)
leftSide.BackgroundTransparency = 1
leftSide.Parent = farmPanel

local farmTitle2 = Instance.new("TextLabel")
farmTitle2.Size = UDim2.new(1, 0, 0, 25)
farmTitle2.Position = UDim2.new(0, 0, 0, 10)
farmTitle2.BackgroundTransparency = 1
farmTitle2.Text = "MON FARM"
farmTitle2.TextColor3 = Color3.fromRGB(255, 215, 0)
farmTitle2.TextScaled = true
farmTitle2.Font = Enum.Font.GothamBold
farmTitle2.TextXAlignment = Enum.TextXAlignment.Left
farmTitle2.Parent = leftSide

local farmStatusLabel2 = Instance.new("TextLabel")
farmStatusLabel2.Size = UDim2.new(1, 0, 0, 20)
farmStatusLabel2.Position = UDim2.new(0, 0, 0, 40)
farmStatusLabel2.BackgroundTransparency = 1
farmStatusLabel2.Text = "Статус: Остановлен"
farmStatusLabel2.TextColor3 = Color3.fromRGB(200, 200, 200)
farmStatusLabel2.TextScaled = true
farmStatusLabel2.Font = Enum.Font.GothamMedium
farmStatusLabel2.TextXAlignment = Enum.TextXAlignment.Left
farmStatusLabel2.Parent = leftSide

local farmToggleBtn2 = Instance.new("TextButton")
farmToggleBtn2.Size = UDim2.new(0, 140, 0, 35)
farmToggleBtn2.Position = UDim2.new(0, 40, 0, 65)
farmToggleBtn2.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
farmToggleBtn2.Text = "СТАРТ"
farmToggleBtn2.TextColor3 = Color3.fromRGB(255, 255, 255)
farmToggleBtn2.TextScaled = true
farmToggleBtn2.Font = Enum.Font.GothamBold
farmToggleBtn2.Parent = leftSide

local farmToggleCorner2 = Instance.new("UICorner")
farmToggleCorner2.CornerRadius = UDim.new(0, 4)
farmToggleCorner2.Parent = farmToggleBtn2

-- ===== ПРАВАЯ ЧАСТЬ (ИНСТРУКЦИЯ) =====
local rightSide = Instance.new("Frame")
rightSide.Size = UDim2.new(0, 400, 1, 0)
rightSide.Position = UDim2.new(1, -410, 0, 0)
rightSide.BackgroundTransparency = 1
rightSide.Parent = farmPanel

-- Фон для инструкции
local instrBg = Instance.new("Frame")
instrBg.Size = UDim2.new(1, -20, 1, -20)
instrBg.Position = UDim2.new(0, 10, 0, 10)
instrBg.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
instrBg.BackgroundTransparency = 0.4
instrBg.BorderSizePixel = 0
instrBg.Parent = rightSide

local instrBgCorner = Instance.new("UICorner")
instrBgCorner.CornerRadius = UDim.new(0, 8)
instrBgCorner.Parent = instrBg

local instrTitle = Instance.new("TextLabel")
instrTitle.Size = UDim2.new(1, 0, 0, 25)
instrTitle.Position = UDim2.new(0, 0, 0, 5)
instrTitle.BackgroundTransparency = 1
instrTitle.Text = "📖 ИНСТРУКЦИЯ"
instrTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
instrTitle.TextScaled = true
instrTitle.Font = Enum.Font.GothamBold
instrTitle.TextXAlignment = Enum.TextXAlignment.Center
instrTitle.Parent = instrBg

local instrText = Instance.new("TextLabel")
instrText.Size = UDim2.new(1, -20, 1, -45)
instrText.Position = UDim2.new(0, 10, 0, 35)
instrText.BackgroundTransparency = 1
instrText.Text = "Что-бы авто фарм работал корректно тебе надо:\n\n1️⃣ Включить NOCLIP\n\n2️⃣ Встать в магазин и смотреть на Мона Лизу\n\n3️⃣ Нажать СТАРТ"
instrText.TextColor3 = Color3.fromRGB(255, 255, 255)
instrText.TextScaled = false
instrText.TextSize = 16
instrText.Font = Enum.Font.GothamMedium
instrText.TextXAlignment = Enum.TextXAlignment.Left
instrText.TextYAlignment = Enum.TextYAlignment.Top
instrText.Parent = instrBg

-- ===== ФУНКЦИИ MON FARM =====
local function monFarmStartFly()
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    if monFarmBv then monFarmBv:Destroy() end
    if monFarmBg then monFarmBg:Destroy() end

    monFarmBv = Instance.new("BodyVelocity")
    monFarmBv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    monFarmBv.Velocity = Vector3.new(0, 0, 0)
    monFarmBv.Parent = root

    monFarmBg = Instance.new("BodyGyro")
    monFarmBg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
    monFarmBg.CFrame = root.CFrame
    monFarmBg.Parent = root

    monFarmFlyActive = true
end

local function monFarmStopFly()
    if monFarmBv then monFarmBv:Destroy() monFarmBv = nil end
    if monFarmBg then monFarmBg:Destroy() monFarmBg = nil end
    monFarmFlyActive = false
end

local function monFarmFlyTo(pos)
    if monFarmStopRequested then return end
    if not monFarmFlyActive then monFarmStartFly() end
    
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root or not monFarmBv then return end

    while monFarmRunning and not monFarmStopRequested do
        local dist = (root.Position - pos).Magnitude
        if dist <= 2.5 then break end
        
        local dir = (pos - root.Position).Unit
        monFarmBv.Velocity = dir * monFarmSpeed
        
        local look = Vector3.new(dir.X, 0, dir.Z)
        if look.Magnitude > 0.1 then
            root.CFrame = CFrame.lookAt(root.Position, root.Position + look)
            if monFarmBg then monFarmBg.CFrame = root.CFrame end
        end
        task.wait(0.05)
    end
    
    monFarmBv.Velocity = Vector3.new(0, 0, 0)
    task.wait(0.1)
    
    if not monFarmStopRequested then
        for i = 1, 8 do
            if monFarmStopRequested then break end
            local dist = (root.Position - pos).Magnitude
            if dist <= 0.5 then break end
            local smoothDir = (pos - root.Position).Unit
            root.Position = root.Position + smoothDir * math.min(dist, 0.3)
            task.wait(0.03)
        end
        root.Position = pos
        task.wait(0.15)
    end
end

local function monFarmHoldE(duration)
    if monFarmStopRequested then return end
    vim:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(duration)
    vim:SendKeyEvent(false, Enum.KeyCode.E, false, game)
    task.wait(0.1)
end

local function monFarmBuy()
    for i = 1, 5 do
        if monFarmStopRequested then break end
        monFarmHoldE(0.5)
    end
end

local function monFarmInteract()
    if monFarmStopRequested then return end
    monFarmHoldE(1)
end

local function startFarm()
    if monFarmRunning then return end
    monFarmRunning = true
    monFarmStopRequested = false
    farmToggleBtn2.Text = "СТОП"
    farmToggleBtn2.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    farmStatusLabel2.Text = "Статус: Работает"

    monFarmStartFly()

    coroutine.wrap(function()
        while monFarmRunning and not monFarmStopRequested do
            monFarmFlyTo(monFarmConfig.buyPos)
            if monFarmStopRequested then break end
            monFarmBuy()
            if monFarmStopRequested then break end
            
            monFarmFlyTo(monFarmConfig.point1)
            if monFarmStopRequested then break end
            monFarmFlyTo(monFarmConfig.point2)
            if monFarmStopRequested then break end
            monFarmFlyTo(monFarmConfig.point3)
            if monFarmStopRequested then break end
            
            monFarmFlyTo(monFarmConfig.exchangePos)
            if monFarmStopRequested then break end
            task.wait(0.3)
            monFarmInteract()
            if monFarmStopRequested then break end
            task.wait(0.3)
            
            monFarmFlyTo(monFarmConfig.point3)
            if monFarmStopRequested then break end
            monFarmFlyTo(monFarmConfig.point2)
            if monFarmStopRequested then break end
            monFarmFlyTo(monFarmConfig.point1)
            if monFarmStopRequested then break end
            
            monFarmFlyTo(monFarmConfig.sellPos)
            if monFarmStopRequested then break end
            monFarmInteract()
            if monFarmStopRequested then break end
            
            task.wait(0.5)
        end

        monFarmRunning = false
        monFarmStopFly()
        farmToggleBtn2.Text = "СТАРТ"
        farmToggleBtn2.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        farmStatusLabel2.Text = "Статус: Остановлен"
    end)()
end

local function stopFarm()
    monFarmStopRequested = true
    monFarmRunning = false
end

farmToggleBtn2.MouseButton1Click:Connect(function()
    if monFarmRunning then
        stopFarm()
    else
        startFarm()
    end
end)

-- ============================================================
-- ===== BINDS =====
-- ============================================================
local bindPanel = Instance.new("Frame")
bindPanel.Size = UDim2.new(1, 0, 1, 0)
bindPanel.Position = UDim2.new(0, 0, 0, 0)
bindPanel.BackgroundTransparency = 1
bindPanel.BorderSizePixel = 0
bindPanel.Visible = false
bindPanel.Parent = contentContainer

local bindTitle2 = Instance.new("TextLabel")
bindTitle2.Size = UDim2.new(1, 0, 0, 25)
bindTitle2.Position = UDim2.new(0, 0, 0, 10)
bindTitle2.BackgroundTransparency = 1
bindTitle2.Text = "BINDS"
bindTitle2.TextColor3 = Color3.fromRGB(255, 255, 255)
bindTitle2.TextScaled = true
bindTitle2.Font = Enum.Font.GothamBold
bindTitle2.TextXAlignment = Enum.TextXAlignment.Left
bindTitle2.Parent = bindPanel

local bindFlyBtn2 = Instance.new("TextButton")
bindFlyBtn2.Size = UDim2.new(0, 160, 0, 30)
bindFlyBtn2.Position = UDim2.new(0, 40, 0, 40)
bindFlyBtn2.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
bindFlyBtn2.Text = "Fly: [Не назначен]"
bindFlyBtn2.TextColor3 = Color3.fromRGB(255, 255, 255)
bindFlyBtn2.TextScaled = true
bindFlyBtn2.Font = Enum.Font.GothamMedium
bindFlyBtn2.Parent = bindPanel

local bindFlyCorner2 = Instance.new("UICorner")
bindFlyCorner2.CornerRadius = UDim.new(0, 4)
bindFlyCorner2.Parent = bindFlyBtn2

local bindNoclipBtn2 = Instance.new("TextButton")
bindNoclipBtn2.Size = UDim2.new(0, 160, 0, 30)
bindNoclipBtn2.Position = UDim2.new(0, 40, 0, 75)
bindNoclipBtn2.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
bindNoclipBtn2.Text = "Noclip: [Не назначен]"
bindNoclipBtn2.TextColor3 = Color3.fromRGB(255, 255, 255)
bindNoclipBtn2.TextScaled = true
bindNoclipBtn2.Font = Enum.Font.GothamMedium
bindNoclipBtn2.Parent = bindPanel

local bindNoclipCorner2 = Instance.new("UICorner")
bindNoclipCorner2.CornerRadius = UDim.new(0, 4)
bindNoclipCorner2.Parent = bindNoclipBtn2

local bindSpeedCarBtn2 = Instance.new("TextButton")
bindSpeedCarBtn2.Size = UDim2.new(0, 160, 0, 30)
bindSpeedCarBtn2.Position = UDim2.new(0, 40, 0, 110)
bindSpeedCarBtn2.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
bindSpeedCarBtn2.Text = "Speed Car: [Не назначен]"
bindSpeedCarBtn2.TextColor3 = Color3.fromRGB(255, 255, 255)
bindSpeedCarBtn2.TextScaled = true
bindSpeedCarBtn2.Font = Enum.Font.GothamMedium
bindSpeedCarBtn2.Parent = bindPanel

local bindSpeedCarCorner2 = Instance.new("UICorner")
bindSpeedCarCorner2.CornerRadius = UDim.new(0, 4)
bindSpeedCarCorner2.Parent = bindSpeedCarBtn2

local bindMenuBtn2 = Instance.new("TextButton")
bindMenuBtn2.Size = UDim2.new(0, 160, 0, 30)
bindMenuBtn2.Position = UDim2.new(0, 40, 0, 145)
bindMenuBtn2.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
bindMenuBtn2.Text = "Menu: [LeftAlt]"
bindMenuBtn2.TextColor3 = Color3.fromRGB(255, 255, 255)
bindMenuBtn2.TextScaled = true
bindMenuBtn2.Font = Enum.Font.GothamMedium
bindMenuBtn2.Parent = bindPanel

local bindMenuCorner2 = Instance.new("UICorner")
bindMenuCorner2.CornerRadius = UDim.new(0, 4)
bindMenuCorner2.Parent = bindMenuBtn2

local menuBindKey = Enum.KeyCode.LeftAlt
local waitingForFlyBind2 = false
local waitingForNoclipBind2 = false
local waitingForSpeedCarBind2 = false
local waitingForMenuBind2 = false
local bindConnectionMain2 = nil

local function updateBindDisplay2()
    if flyBindKey then
        bindFlyBtn2.Text = "Fly: [" .. flyBindKey.Name .. "]"
    else
        bindFlyBtn2.Text = "Fly: [Не назначен]"
    end
    
    if noclipBindKey then
        bindNoclipBtn2.Text = "Noclip: [" .. noclipBindKey.Name .. "]"
    else
        bindNoclipBtn2.Text = "Noclip: [Не назначен]"
    end
    
    if speedCarBindKey then
        bindSpeedCarBtn2.Text = "Speed Car: [" .. speedCarBindKey.Name .. "]"
    else
        bindSpeedCarBtn2.Text = "Speed Car: [Не назначен]"
    end
    
    if menuBindKey then
        bindMenuBtn2.Text = "Menu: [" .. menuBindKey.Name .. "]"
    else
        bindMenuBtn2.Text = "Menu: [Не назначен]"
    end
end

bindFlyBtn2.MouseButton1Click:Connect(function()
    waitingForFlyBind2 = true
    bindFlyBtn2.Text = "Нажми клавишу..."
    bindFlyBtn2.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
end)

bindNoclipBtn2.MouseButton1Click:Connect(function()
    waitingForNoclipBind2 = true
    bindNoclipBtn2.Text = "Нажми клавишу..."
    bindNoclipBtn2.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
end)

bindSpeedCarBtn2.MouseButton1Click:Connect(function()
    waitingForSpeedCarBind2 = true
    bindSpeedCarBtn2.Text = "Нажми клавишу..."
    bindSpeedCarBtn2.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
end)

bindMenuBtn2.MouseButton1Click:Connect(function()
    waitingForMenuBind2 = true
    bindMenuBtn2.Text = "Нажми клавишу..."
    bindMenuBtn2.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
end)

-- ============================================================
-- ===== CLOSE PANEL (ВКЛАДКА) =====
-- ============================================================
local closePanel2 = Instance.new("Frame")
closePanel2.Size = UDim2.new(1, 0, 1, 0)
closePanel2.Position = UDim2.new(0, 0, 0, 0)
closePanel2.BackgroundTransparency = 1
closePanel2.BorderSizePixel = 0
closePanel2.Visible = false
closePanel2.Parent = contentContainer

local closeTitle2 = Instance.new("TextLabel")
closeTitle2.Size = UDim2.new(1, 0, 0, 25)
closeTitle2.Position = UDim2.new(0, 0, 0, 10)
closeTitle2.BackgroundTransparency = 1
closeTitle2.Text = "CLOSE"
closeTitle2.TextColor3 = Color3.fromRGB(255, 255, 255)
closeTitle2.TextScaled = true
closeTitle2.Font = Enum.Font.GothamBold
closeTitle2.TextXAlignment = Enum.TextXAlignment.Left
closeTitle2.Parent = closePanel2

local closeStatusLabel2 = Instance.new("TextLabel")
closeStatusLabel2.Size = UDim2.new(1, 0, 0, 20)
closeStatusLabel2.Position = UDim2.new(0, 0, 0, 40)
closeStatusLabel2.BackgroundTransparency = 1
closeStatusLabel2.Text = "Полное выключение скрипта"
closeStatusLabel2.TextColor3 = Color3.fromRGB(200, 200, 200)
closeStatusLabel2.TextScaled = true
closeStatusLabel2.Font = Enum.Font.GothamMedium
closeStatusLabel2.TextXAlignment = Enum.TextXAlignment.Left
closeStatusLabel2.Parent = closePanel2

local closeAllBtn2 = Instance.new("TextButton")
closeAllBtn2.Size = UDim2.new(0, 160, 0, 35)
closeAllBtn2.Position = UDim2.new(0, 40, 0, 65)
closeAllBtn2.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeAllBtn2.BackgroundTransparency = 0
closeAllBtn2.Text = "ВЫКЛЮЧИТЬ"
closeAllBtn2.TextColor3 = Color3.fromRGB(255, 255, 255)
closeAllBtn2.TextScaled = true
closeAllBtn2.Font = Enum.Font.GothamBold
closeAllBtn2.Parent = closePanel2

local closeAllCorner2 = Instance.new("UICorner")
closeAllCorner2.CornerRadius = UDim.new(0, 4)
closeAllCorner2.Parent = closeAllBtn2

closeAllBtn2.MouseButton1Click:Connect(function()
    if flyStatus then
        if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
        if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
        flyStatus = false
    end

    if monFarmRunning then
        monFarmStopRequested = true
        monFarmRunning = false
        if monFarmBv then monFarmBv:Destroy() monFarmBv = nil end
        if monFarmBg then monFarmBg:Destroy() monFarmBg = nil end
        monFarmFlyActive = false
    end

    if noclipActive then
        noclipActive = false
        if noclipConn then
            noclipConn:Disconnect()
            noclipConn = nil
        end
        local char = player.Character
        if char then
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = true
                end
            end
        end
    end

    if bindConnectionMain2 then
        bindConnectionMain2:Disconnect()
        bindConnectionMain2 = nil
    end

    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Part") and v.Name == "SanDiegoBorder" then
            v:Destroy()
        end
    end

    local replicatedStorage = game:GetService("ReplicatedStorage")
    for _, v in pairs(replicatedStorage:GetChildren()) do
        if v:IsA("RemoteEvent") and string.find(v.Name, "Rocket") then
            v:Destroy()
        end
    end

    screenGui:Destroy()
    print("ROCKET: Скрипт полностью выключен.")
    error("ROCKET: Скрипт остановлен.")
end)

-- ============================================================
-- ===== КНОПКИ МЕНЮ =====
-- ============================================================
local function openHomePanel()
    homePanel.Visible = true
    miscPanel.Visible = false
    farmPanel.Visible = false
    bindPanel.Visible = false
    closePanel2.Visible = false
end

local function openMiscPanel()
    homePanel.Visible = false
    farmPanel.Visible = false
    bindPanel.Visible = false
    closePanel2.Visible = false
    miscPanel.Visible = not miscPanel.Visible
end

local function openFarmPanel()
    homePanel.Visible = false
    miscPanel.Visible = false
    bindPanel.Visible = false
    closePanel2.Visible = false
    farmPanel.Visible = not farmPanel.Visible
end

local function openBindPanel()
    homePanel.Visible = false
    miscPanel.Visible = false
    farmPanel.Visible = false
    closePanel2.Visible = false
    bindPanel.Visible = not bindPanel.Visible
end

local function openClosePanel()
    homePanel.Visible = false
    miscPanel.Visible = false
    farmPanel.Visible = false
    bindPanel.Visible = false
    closePanel2.Visible = not closePanel2.Visible
end

local buttonX = 15
local buttonY = 55
local buttonWidth = 110
local buttonHeight = 28
local gap = 8

local buttons = {}

local function createButton(text, yPos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, buttonWidth, 0, buttonHeight)
    btn.Position = UDim2.new(0, buttonX, 0, yPos)
    btn.BackgroundColor3 = colors[1]
    btn.BackgroundTransparency = 0.3
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamMedium
    btn.Parent = mainFrame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = btn

    btn.MouseButton1Down:Connect(function()
        local moveDown = tweens:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, buttonX, 0, yPos + 4)
        })
        moveDown:Play()
    end)

    btn.MouseButton1Up:Connect(function()
        local moveUp = tweens:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, buttonX, 0, yPos)
        })
        moveUp:Play()
    end)

    btn.MouseLeave:Connect(function()
        local moveUp = tweens:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, buttonX, 0, yPos)
        })
        moveUp:Play()
    end)

    btn.MouseButton1Click:Connect(callback)
    table.insert(buttons, btn)
    return btn
end

local homeBtn = createButton("Home", buttonY, openHomePanel)
local miscBtn = createButton("Misc", buttonY + buttonHeight + gap, openMiscPanel)
local farmBtn = createButton("Farm", buttonY + (buttonHeight + gap) * 2, openFarmPanel)
local bindBtn = createButton("Bind", buttonY + (buttonHeight + gap) * 3, openBindPanel)
local closeBtn = createButton("Close", buttonY + (buttonHeight + gap) * 4, openClosePanel)

-- ===== ПЕРЕЛИВ КНОПОК =====
local btnColorIndex = 1
local btnTween = nil

local function startButtonsColorCycle()
    while true do
        local nextColor = colors[btnColorIndex % #colors + 1]
        for _, btn in pairs(buttons) do
            if btn and btn.Parent then
                btnTween = tweens:Create(btn, TweenInfo.new(0.8, Enum.EasingStyle.Linear), {
                    BackgroundColor3 = nextColor
                })
                btnTween:Play()
            end
        end
        btnTween.Completed:Wait()
        btnColorIndex = btnColorIndex % #colors + 1
    end
end

coroutine.wrap(startButtonsColorCycle)()

-- ============================================================
-- ===== АНИМАЦИИ МЕНЮ =====
-- ============================================================
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

-- ============================================================
-- ===== ОСНОВНОЙ ОБРАБОТЧИК БИНДОВ =====
-- ============================================================
local function createBindHandler2()
    if bindConnectionMain2 then
        bindConnectionMain2:Disconnect()
        bindConnectionMain2 = nil
    end
    
    bindConnectionMain2 = userInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.Unknown then return end

        if waitingForFlyBind2 then
            flyBindKey = input.KeyCode
            waitingForFlyBind2 = false
            bindFlyBtn2.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
            updateBindDisplay2()
            print("ROCKET: Fly привязан к " .. flyBindKey.Name)
            return
        end

        if waitingForNoclipBind2 then
            noclipBindKey = input.KeyCode
            waitingForNoclipBind2 = false
            bindNoclipBtn2.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
            updateBindDisplay2()
            print("ROCKET: Noclip привязан к " .. noclipBindKey.Name)
            return
        end

        if waitingForSpeedCarBind2 then
            speedCarBindKey = input.KeyCode
            waitingForSpeedCarBind2 = false
            bindSpeedCarBtn2.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
            updateBindDisplay2()
            print("ROCKET: Speed Car привязан к " .. speedCarBindKey.Name)
            return
        end

        if waitingForMenuBind2 then
            menuBindKey = input.KeyCode
            waitingForMenuBind2 = false
            bindMenuBtn2.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
            updateBindDisplay2()
            print("ROCKET: Menu привязан к " .. menuBindKey.Name)
            return
        end

        if flyBindKey and input.KeyCode == flyBindKey then
            if flyStatus then disableFly() else enableFly() end
            return
        end

        if noclipBindKey and input.KeyCode == noclipBindKey then
            toggleNoclip()
            return
        end

        if speedCarBindKey and input.KeyCode == speedCarBindKey then
            activateSpeedCar()
            return
        end

        if menuBindKey and input.KeyCode == menuBindKey then
            toggleMenu()
            return
        end
    end)
end

createBindHandler2()

-- ============================================================
-- ===== ЗАЩИТА ОТ ВЫКЛЮЧЕНИЯ =====
-- ============================================================
local function safeCall(func)
    local success, err = pcall(func)
    if not success then
        print("ROCKET: Ошибка перехвачена: " .. tostring(err))
    end
    return success
end

game:GetService("GuiService").WindowFocused:Connect(function()
    safeCall(function()
        if menuVisible then
            mainFrame.Visible = true
            mainFrame.BackgroundTransparency = 0.15
        end
    end)
end)

-- ============================================================
-- ===== ПРИНУДИТЕЛЬНОЕ ВОССТАНОВЛЕНИЕ UI =====
-- ============================================================
local function forceShowUI()
    screenGui.Enabled = true
    mainFrame.Visible = true
    mainFrame.BackgroundTransparency = 0.15
    openMenuBtn.Visible = true
    menuVisible = true
    animationPlaying = false
    print("ROCKET: UI принудительно восстановлен.")
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
        safeCall(function()
            if menuVisible then
                if not screenGui.Enabled or not mainFrame.Visible then
                    forceShowUI()
                end
            end
            openMenuBtn.Visible = true
        end)
    end
end)

userInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.U and (userInputService:IsKeyDown(Enum.KeyCode.LeftControl) or userInputService:IsKeyDown(Enum.KeyCode.RightControl)) then
        print("ROCKET: Принудительное восстановление UI (Ctrl+U)...")
        safeCall(function()
            forceShowUI()
            print("ROCKET: UI восстановлен.")
        end)
    end
end)

task.spawn(function()
    while true do
        task.wait(3)
        safeCall(function()
            if menuVisible then
                if not mainFrame.Visible then
                    mainFrame.Visible = true
                    mainFrame.BackgroundTransparency = 0.15
                    print("ROCKET: Меню восстановлено.")
                end
            end
            openMenuBtn.Visible = true
        end)
    end
end)

task.spawn(function()
    while true do
        task.wait(30)
        safeCall(function()
            if not bindConnectionMain2 or not bindConnectionMain2.Connected then
                print("ROCKET: Пересоздаю обработчик биндов...")
                createBindHandler2()
            end
        end)
    end
end)

userInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.R and (userInputService:IsKeyDown(Enum.KeyCode.LeftControl) or userInputService:IsKeyDown(Enum.KeyCode.RightControl)) then
        print("ROCKET: Перезагрузка меню...")
        safeCall(function()
            showMenu()
            print("ROCKET: Меню перезагружено.")
        end)
    end
end)

print("ROCKET: Защита от выключения активирована.")
print("ROCKET: Ctrl+U - принудительное восстановление UI.")

-- ============================================================
-- ===== ЗАПУСК =====
-- ============================================================
updateBindDisplay2()
showMenu()

print("ROCKET: Меню загружено. Нажми LeftAlt или кнопку ☰ слева для открытия/закрытия.")
print("ROCKET: Speed Car активируется по кнопке в меню Misc или по бинду.")
print("ROCKET: Mon Farm в вкладке Farm с инструкцией.")
print("ROCKET: Ctrl+U - принудительное восстановление UI.")