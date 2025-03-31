repeat wait() until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character
getgenv().Settings = {
    --[[ MAIN ]]
    Train_Fuel = 0,
    Train_Distance = 0,
    AutoWin = nil,
    AutoCollectBond = nil,
    AutoCollectCashBag = nil,
    NoPromotCooldown = nil,
    AutoPickUpBandage = nil,
    AutoBandageSlide = nil,
    AutoUseBandage = nil,
    RapidFire = nil,
    FastReload = nil,
    NoSpread = nil,
    --[[ AIMBOT ]]
    HitboxExpanderSlide = nil,
    Hitbox = nil,
    AimbotSlide = nil,
    Aimbot = nil,
    --[[ ESP ]]
    ESPMobs = nil,
    ESPItem = nil,
    ESPBond = nil,
    --[[ Misc ]]
    FOVSlide = nil,
    EnableThirdPerson = nil,
    Noclip = nil,
    FullBright = nil,
    StandKeybind = nil,
    StandWalkSpeed = nil,
    StandToggleWalkSpeed = nil,

}

local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/TheG450/ThisHubNotPublicEnoughForUs/refs/heads/main/UpsideRemakeBeta_UI.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Fearise Hub" .. " | ".."Dead Rails".." |",
    SubTitle = "by Blobby",
    TabWidth = 160,
    Size =  UDim2.fromOffset(620, 460), --UDim2.fromOffset(480, 360), --default size (580, 460)
    Acrylic = false, -- การเบลออาจตรวจจับได้ การตั้งค่านี้เป็น false จะปิดการเบลอทั้งหมด
    Theme = "FeariseHub", --Amethyst
    MinimizeKey = Enum.KeyCode.LeftAlt
})

local Tabs = {
    --[[ TABS --]]
    pageMain = Window:AddTab({ Title = "|| Main", Icon = "home" }),
    pageAimbot = Window:AddTab({ Title = "|| Hitbox & AimAssist", Icon = "crosshair" }),
    pageESP = Window:AddTab({ Title = "|| ESP", Icon = "eye" }),
    pageMisc = Window:AddTab({ Title = "|| Misc", Icon = "component" }),
}

do
    --[[ VARIABLES ]]--------------------------------------------------------
    local RunService = game:GetService("RunService")
    local TweenService = game:GetService("TweenService")
    local ProximityPromptService = game:GetService("ProximityPromptService")
    local CollectionService = game:GetService("CollectionService")
    local userInputService = game:GetService("UserInputService")
    local Lighting = game:GetService("Lighting")
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidrootpart = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart", 5)
    local humanoid = character:FindFirstChild("Humanoid") or character:WaitForChild("Humanoid", 5)
    local camera = workspace.CurrentCamera

    player.CharacterAdded:Connect(function(newcharacter)
        character = newcharacter
        humanoidrootpart = newcharacter:FindFirstChild("HumanoidRootPart") or newcharacter:WaitForChild("HumanoidRootPart", 5)
        humanoid = newcharacter:FindFirstChild("Humanoid") or newcharacter:WaitForChild("Humanoid", 5)
    end)

    --[[ MAIN ]]--------------------------------------------------------
    local TrainTitle = Tabs.pageMain:AddSection("Train")
    local TrainInfo = Tabs.pageMain:AddParagraph({
        Title = "Train Info",
        Content = "Train Fuel: "..getgenv().Settings.Train_Fuel.."\nTrain Distance: "..getgenv().Settings.Train_Distance,
    })
    local HonkTrain = Tabs.pageMain:AddButton({
        Title = "Honk Train",
        Callback = function()
            for i,v in pairs(workspace.Train:GetDescendants()) do
                if v:IsA("ClickDetector") then
                    fireclickdetector(v)
                end
            end
        end
    })
    local AutomaticTitle = Tabs.pageMain:AddSection("Automatic")
    local AutoWin = Tabs.pageMain:AddToggle("AutoWin", {Title = "Auto Win (Fixing)", Default = getgenv().Settings.AutoWin or false })
    local MainTitle = Tabs.pageMain:AddSection("Main")
    local AutoCollectBond = Tabs.pageMain:AddToggle("AutoCollectBond", {Title = "Auto Collect Bond (Be Near)", Default = getgenv().Settings.AutoCollectBond or false })
    local AutoCollectCashBag = Tabs.pageMain:AddToggle("AutoCollectCashBag", {Title = "Auto Collect CashBag", Default = getgenv().Settings.AutoCollectCashBag or false })
    local NoPromotCooldown = Tabs.pageMain:AddToggle("NoPromotCooldown", {Title = "No Promot Cooldown", Default = getgenv().Settings.NoPromotCooldown or false })
    local AutoPickUpBandage = Tabs.pageMain:AddToggle("AutoPickUpBandage", {Title = "Auto PickUp Bandage", Default = getgenv().Settings.AutoPickUpBandage or false })
    local AutoBandageSlide = Tabs.pageMain:AddSlider("AutoBandageSlide", {
        Title = "[Bandage] Auto Use When Health <= ",
        Default = getgenv().Settings.AutoBandageSlide or 50,
        Min = 1,
        Max = 100,
        Rounding = 0,
        Callback = function(Value)
            getgenv().Settings.AutoBandageSlide = Value
        end
    })
    AutoBandageSlide:OnChanged(function(Value)
        getgenv().Settings.AutoBandageSlide = Value
    end)
    local AutoUseBandage = Tabs.pageMain:AddToggle("AutoUseBandage", {Title = "Auto Use Bandage", Default = getgenv().Settings.AutoUseBandage or false })
    local GunTitle = Tabs.pageMain:AddSection("Gun Mods")
    local RapidFire = Tabs.pageMain:AddToggle("RapidFire", {Title = "Rapid Fire", Default = getgenv().Settings.RapidFire or false })
    local FastReload = Tabs.pageMain:AddToggle("FastReload", {Title = "Fast Reload", Default = getgenv().Settings.FastReload or false })
    local NoSpread = Tabs.pageMain:AddToggle("NoSpread", {Title = "No Spread", Default = getgenv().Settings.NoSpread or false })

    --[[ AIMBOT ]]--------------------------------------------------------
    local HitboxExpanderSlide = Tabs.pageAimbot:AddSlider("HitboxExpanderSlide", {
        Title = "Hitbox Size ",
        Default = getgenv().Settings.HitboxExpanderSlide or 10,
        Min = 1,
        Max = 30,
        Rounding = 0,
        Callback = function(Value)
            getgenv().Settings.HitboxExpanderSlide = Value
        end
    })
    HitboxExpanderSlide:OnChanged(function(Value)
        getgenv().Settings.HitboxExpanderSlide = Value
    end)
    local Hitbox = Tabs.pageAimbot:AddToggle("Hitbox", {Title = "Hitbox", Default = getgenv().Settings.Hitbox or false })
    local AimbotSlide = Tabs.pageAimbot:AddSlider("AimbotSlide", {
        Title = "Aimbot Distance",
        Default = getgenv().Settings.AimbotSlide or 100,
        Min = 50,
        Max = 300,
        Rounding = 0,
        Callback = function(Value)
            getgenv().Settings.AimbotSlide = Value
        end
    })
    AimbotSlide:OnChanged(function(Value)
        getgenv().Settings.AimbotSlide = Value
    end)
    local Aimbot = Tabs.pageAimbot:AddToggle("Aimbot", {Title = "Aimbot", Default = getgenv().Settings.Aimbot or false })

    --[[ ESP ]]--------------------------------------------------------
    local ESPMobs = Tabs.pageESP:AddToggle("ESPMobs", {Title = "[ESP] Mobs", Default = getgenv().Settings.ESPMobs or false })
    local ESPItem = Tabs.pageESP:AddToggle("ESPItem", {Title = "[ESP] Item", Default = getgenv().Settings.ESPItem or false })
    local ESPBond = Tabs.pageESP:AddToggle("ESPBond", {Title = "[ESP] Bond", Default = getgenv().Settings.ESPBond or false })

    --[[ MISC ]]--------------------------------------------------------
    local CameraTitle = Tabs.pageMisc:AddSection("Camera")
    local FOVSlide = Tabs.pageMisc:AddSlider("FOVSlide", {
        Title = "FOV Changer <= ",
        Default = getgenv().Settings.FOVSlide or 130,
        Min = 130,
        Max = 1000,
        Rounding = 0,
        Callback = function(Value)
            getgenv().Settings.FOVSlide = Value
        end
    })
    FOVSlide:OnChanged(function(Value)
        getgenv().Settings.FOVSlide = Value
    end)
    local EnableThirdPerson = Tabs.pageMisc:AddToggle("EnableThirdPerson", {Title = "Enable Third Person", Default = getgenv().Settings.EnableThirdPerson or false })
    local PlayerTitle = Tabs.pageMisc:AddSection("Player")
    local Noclip = Tabs.pageMisc:AddToggle("Noclip", {Title = "Noclip", Default = getgenv().Settings.Noclip or false })
    local FullBright = Tabs.pageMisc:AddToggle("FullBright", {Title = "Full Bright", Default = getgenv().Settings.FullBright or false })
    local StandTitle = Tabs.pageMisc:AddSection("Stand")
    local StandKeybind = Tabs.pageMisc:AddKeybind("StandKeybind", {
        Title = "Summon Stand Keybind",
        Mode = "Toggle",
        Default = "T",
        Callback = function(Value)
            getgenv().Settings.StandKeybind = Value
        end,
        ChangedCallback = function(New)
            getgenv().Settings.StandKeybind = New
        end
    })
    StandKeybind:OnChanged(function()
        getgenv().Settings.StandKeybind = StandKeybind.Value
    end)
    local StandWalkSpeed = Tabs.pageMisc:AddSlider("StandWalkSpeed", {
        Title = "Stand WalkSpeed ",
        Default = getgenv().Settings.StandWalkSpeed or 16,
        Min = 16,
        Max = 100,
        Rounding = 0,
        Callback = function(Value)
            getgenv().Settings.StandWalkSpeed = Value
        end
    })
    StandWalkSpeed:OnChanged(function(Value)
        getgenv().Settings.StandWalkSpeed = Value
    end)
    local StandToggleWalkSpeed = Tabs.pageMisc:AddToggle("StandToggleWalkSpeed", {Title = "Walk Speed", Default = getgenv().Settings.StandToggleWalkSpeed or false })
    
    --[[ FUNCTIONS ]]--------------------------------------------------------
    function CreateItemESP(parent, name, Color)
        local eSPUI = Instance.new("BillboardGui")
        eSPUI.Name = "ESPUI"
        eSPUI.Active = true
        eSPUI.AlwaysOnTop = true
        eSPUI.ClipsDescendants = true
        eSPUI.ExtentsOffsetWorldSpace = Vector3.new(0, 1, 0)
        eSPUI.LightInfluence = 1
        eSPUI.Size = UDim2.fromOffset(150, 15)
        eSPUI.ResetOnSpawn = false
        eSPUI.Parent = parent
    
        local textLabel = Instance.new("TextLabel")
        textLabel.Name = "TextLabel"
        textLabel.FontFace = Font.new(
            "rbxasset://fonts/families/Arial.json",
            Enum.FontWeight.Bold,
            Enum.FontStyle.Normal
        )
        textLabel.Text = name
        textLabel.TextColor3 = Color
        textLabel.TextScaled = true
        textLabel.TextSize = 14
        textLabel.TextWrapped = true
        textLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
        textLabel.BorderSizePixel = 0
        textLabel.Size = UDim2.fromScale(1, 1)
    
        local uIStroke = Instance.new("UIStroke")
        uIStroke.Name = "UIStroke"
        uIStroke.Parent = textLabel
    
        textLabel.Parent = eSPUI
    end
    function CreateCountdownUI(parent, time, name)
        local countdownUI = Instance.new("ScreenGui")
        countdownUI.Name = "CountdownUI"
        countdownUI.DisplayOrder = 1e+07
        countdownUI.IgnoreGuiInset = true
        countdownUI.ScreenInsets = Enum.ScreenInsets.None
        countdownUI.ResetOnSpawn = false
        countdownUI.Parent = parent

        local mainFrame = Instance.new("Frame")
        mainFrame.Name = "MainFrame"
        mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        mainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        mainFrame.BorderSizePixel = 0
        mainFrame.Position = UDim2.fromScale(0.5, 0.499)
        mainFrame.Size = UDim2.fromScale(1, 1)

        local countdownLabel = Instance.new("TextLabel")
        countdownLabel.Name = "CountdownLabel"
        countdownLabel.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json")
        countdownLabel.Text = "COUNTDOWN"
        countdownLabel.TextColor3 = Color3.fromRGB(211, 211, 211)
        countdownLabel.TextScaled = true
        countdownLabel.TextSize = 14
        countdownLabel.TextWrapped = true
        countdownLabel.AnchorPoint = Vector2.new(0.5, 0.5)
        countdownLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        countdownLabel.BackgroundTransparency = 1
        countdownLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
        countdownLabel.BorderSizePixel = 0
        countdownLabel.Position = UDim2.fromScale(0.5, 0.282)
        countdownLabel.Size = UDim2.fromScale(0.307, 0.0869)

        local uITextSizeConstraint = Instance.new("UITextSizeConstraint")
        uITextSizeConstraint.Name = "UITextSizeConstraint"
        uITextSizeConstraint.MaxTextSize = 49
        uITextSizeConstraint.Parent = countdownLabel

        countdownLabel.Parent = mainFrame

        local timeLabel = Instance.new("TextLabel")
        timeLabel.Name = "TimeLabel"
        timeLabel.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json")
        timeLabel.TextColor3 = Color3.fromRGB(211, 211, 211)
        timeLabel.TextScaled = true
        timeLabel.TextSize = 14
        timeLabel.TextWrapped = true
        timeLabel.AnchorPoint = Vector2.new(0.5, 0.5)
        timeLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        timeLabel.BackgroundTransparency = 1
        timeLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
        timeLabel.BorderSizePixel = 0
        timeLabel.Position = UDim2.fromScale(0.5, 0.5)
        timeLabel.Size = UDim2.fromScale(0.583, 0.0782)

        local uITextSizeConstraint1 = Instance.new("UITextSizeConstraint")
        uITextSizeConstraint1.Name = "UITextSizeConstraint"
        uITextSizeConstraint1.MaxTextSize = 44
        uITextSizeConstraint1.Parent = timeLabel

        timeLabel.Parent = mainFrame

        local playerLabel = Instance.new("TextLabel")
        playerLabel.Name = "PlayerLabel"
        playerLabel.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json")
        playerLabel.Text = "PLAYER: "..name
        playerLabel.TextColor3 = Color3.fromRGB(211, 211, 211)
        playerLabel.TextScaled = true
        playerLabel.TextSize = 14
        playerLabel.TextWrapped = true
        playerLabel.AnchorPoint = Vector2.new(0.5, 0.5)
        playerLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        playerLabel.BackgroundTransparency = 1
        playerLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
        playerLabel.BorderSizePixel = 0
        playerLabel.Position = UDim2.fromScale(0.5, 0.694)
        playerLabel.Size = UDim2.fromScale(0.583, 0.0556)

        local uITextSizeConstraint2 = Instance.new("UITextSizeConstraint")
        uITextSizeConstraint2.Name = "UITextSizeConstraint"
        uITextSizeConstraint2.MaxTextSize = 32
        uITextSizeConstraint2.Parent = playerLabel

        playerLabel.Parent = mainFrame

        mainFrame.Parent = countdownUI
    
        task.spawn(function()
            local startTime = 15 * 60
        
            while true do
                local remainingTime = startTime - workspace.DistributedGameTime

                if remainingTime <= 0 then
                    timeLabel.Text = "DONE"
                    break
                else
                    local minutes = math.floor(remainingTime / 60)
                    local seconds = math.floor(remainingTime % 60)
        
                    timeLabel.Text = string.format("%02d:%02d", minutes, seconds)
                end
        
                task.wait(1)
            end
        end)
    
        return countdownUI
    end

    --[[ SCRIPTS ]]--------------------------------------------------------
    -- task.spawn(function()
    --     if game.PlaceId ~= 116495829188952 then
    --         ProximityPromptService.PromptShown:Connect(function(prompt)
    --             if AutoWin.Value then
    --                 prompt.HoldDuration = 0
    --             end
    --         end)    
        
    --         local function Goto(TargetPosition)
    --             humanoid:MoveTo(TargetPosition)
    --             humanoid.MoveToFinished:Wait()
    --         end
    
    --         RunService.Stepped:Connect(function()
    --             if character and AutoWin.Value then
    --                 for _, part in pairs(player.Character:GetDescendants()) do
    --                     if part:IsA("BasePart") and part.CanCollide then
    --                         part.CanCollide = false
    --                     end
    --                 end
    --             else
    --                 for _, part in pairs(player.Character:GetDescendants()) do
    --                     if part:IsA("BasePart") then
    --                         part.CanCollide = true
    --                     end
    --                 end
    --             end
    --         end)
        
    --         RunService.Heartbeat:Connect(function()
    --             local seconds = math.floor(workspace.DistributedGameTime)
    --             local minutes = math.floor(workspace.DistributedGameTime / 60)
    --             local hours = math.floor(workspace.DistributedGameTime / 60 / 60)
    --             local Sseconds = seconds - (minutes * 60)
    --             local Sminutes = minutes - (hours * 60)
    --             local Baseplate = workspace:FindFirstChild("Baseplates")
    --             if seconds > 20 and AutoWin.Value then
    --                 if Baseplate:FindFirstChild("FinalBasePlate") then
    --                     local FinalBasePlate = Baseplate:FindFirstChild("FinalBasePlate")
    --                     if FinalBasePlate then
    --                         local OutlawBase = FinalBasePlate:FindFirstChild("OutlawBase")
    --                         if OutlawBase then
    --                             local Bridge = OutlawBase:FindFirstChild("Bridge")
    --                             if Bridge then
    --                                 local BridgeControl = Bridge:FindFirstChild("BridgeControl")
    --                                 if BridgeControl then
    --                                     local Crank = BridgeControl:FindFirstChild("Crank")
    --                                     if Crank then
    --                                         local Model = Crank:FindFirstChild("Model")
    --                                         if Model then
    --                                             local Mid = Model:FindFirstChild("Mid")
    --                                             if Mid then
    --                                                 local Prompt = Mid:FindFirstChild("EndGame")
    --                                                 if Prompt then
    --                                                     task.wait(1)
    --                                                     for _, SandValue in pairs(FinalBasePlate:GetChildren()) do
    --                                                         if SandValue.Name == "SandWall" and SandValue:IsA("BasePart") then
    --                                                             SandValue.Size = Vector3.new(SandValue.Size.X, SandValue.Size.Y, 300)
    --                                                         end
    --                                                     end
    --                                                     if Sminutes >= 10 and Sseconds >= 10 then
    --                                                         if Prompt.Enabled then
    --                                                             Goto(Vector3.new(-341.84686279296875, 2.999938726425171, -49044.8203125))
    --                                                             fireproximityprompt(Prompt)
    --                                                         else
    --                                                             Goto(Vector3.new(-319.56329345703125, 3.999938488006592, -49045.80078125))
    --                                                         end
    --                                                     else
    --                                                         Goto(Vector3.new(-319.56329345703125, 3.999938488006592, -49045.80078125))
    --                                                     end
    --                                                 end
    --                                             end
    --                                         end
    --                                     end
    --                                 end
    --                             end
    --                         end
    --                     end
    --                 else
    --                     if not game:GetService("CoreGui"):FindFirstChild("CountdownUI") then
    --                         CreateCountdownUI(game:GetService("CoreGui"), Sminutes, player.Name)
    --                     else
    --                         character:PivotTo(CFrame.new(Vector3.new(346, -69, -49455)))
    --                     end
    --                 end
    --             end
    --         end)
    --     end
    -- end)
    AutoWin:OnChanged(function()
        task.spawn(function()
            if AutoWin.Value then
                Fluent:Notify({
                    Title = "Fearise Hub",
                    Content = "Wait For Fixing",
                    Duration = 5
                })
                task.wait(.1)
                AutoWin:SetValue(false)
            end
        end)
    end)
    AutoCollectBond:OnChanged(function()
        task.spawn(function()
            while AutoCollectBond.Value do
                task.wait()
                for i,v in pairs(workspace.RuntimeItems:GetChildren()) do
                    if v.Name == "Bond" and v:IsA("Model") then
                        local Part = v:FindFirstChild("Part")
                        local Distance = (Part.Position - humanoidrootpart.Position).Magnitude
                        if Distance <= 17 then
                            game:GetService("ReplicatedStorage").Packages.RemotePromise.Remotes.C_ActivateObject:FireServer(v)
                        end
                    end
                end
            end
        end)
    end)
    AutoCollectCashBag:OnChanged(function()
        task.spawn(function()
            while AutoCollectCashBag.Value do
                task.wait()
                for i,v in pairs(workspace.RuntimeItems:GetChildren()) do
                    if v.Name == "Moneybag" and v:FindFirstChild("MoneyBag") then
                        local MoneyBag = v:FindFirstChild("MoneyBag")
                        if MoneyBag then
                            local Prompt = MoneyBag:FindFirstChild("CollectPrompt")
                            Prompt.MaxActivationDistance = math.huge
                            fireproximityprompt(Prompt)
                        end
                    end
                end
            end
        end)
    end)
    NoPromotCooldown:OnChanged(function()
        task.spawn(function()
            ProximityPromptService.PromptShown:Connect(function(prompt)
                if NoPromotCooldown.Value then
                    prompt.HoldDuration = 0
                end
            end)
        end)
    end)
    AutoPickUpBandage:OnChanged(function()
        task.spawn(function()
            while AutoPickUpBandage.Value do
                task.wait()
                for i,v in pairs(workspace.RuntimeItems:GetChildren()) do
                    if v.Name == "Bandage" and v:IsA("Model") then
                        local Handle = v:FindFirstChild("Handle")
                        local Distance = (Handle.Position - humanoidrootpart.Position).Magnitude
                        if Distance <= 17 then
                            game:GetService("ReplicatedStorage").Remotes.Tool.PickUpTool:FireServer(v)
                        end
                    end
                end
            end
        end)
    end)
    AutoUseBandage:OnChanged(function()
        task.spawn(function()
            while AutoUseBandage.Value do
                task.wait()
                if humanoid.Health <= getgenv().Settings.AutoBandageSlide then
                    for i, v in pairs(player.Backpack:GetChildren()) do
                        if v.Name == "Bandage" and v:IsA("Tool") then
                            local UseRemote = v:FindFirstChild("Use")
                            UseRemote:FireServer()
                        end
                    end
                end
            end
        end)
    end)
    Hitbox:OnChanged(function()
        task.spawn(function()
            while Hitbox.Value do
                task.wait()
                for _, model in pairs(CollectionService:GetTagged("Enemy")) do
                    if model:IsA("Model") and model:FindFirstChild("Humanoid") then
                        local modelHumanoid = model:FindFirstChild("Humanoid")
                        local modelHead = model:FindFirstChild("Head")
                        if modelHumanoid and modelHead then
                            if modelHumanoid.Health > 0 then
                                modelHead.Size = Vector3.new(getgenv().Settings.HitboxExpanderSlide, getgenv().Settings.HitboxExpanderSlide, getgenv().Settings.HitboxExpanderSlide)
                                modelHead.Transparency = 0.5
                            end
                        end
                    end
                end
            end
        end)
    end)
    Aimbot:OnChanged(function()
        task.spawn(function()
            while Aimbot.Value do
                task.wait()
                for _, model in pairs(CollectionService:GetTagged("Enemy")) do
                    if model:IsA("Model") and model:FindFirstChild("Humanoid") then
                        local modelHumanoidRootPart = model:FindFirstChild("HumanoidRootPart")
                        local modelHead = model:FindFirstChild("Head")
                        if modelHumanoidRootPart and modelHead then
                            local Distance = (modelHumanoidRootPart.Position - humanoidrootpart.Position).Magnitude
                            if Distance <= 100 then
                                player.CameraMode = Enum.CameraMode.Classic
                                camera.CameraSubject = modelHead
                                player.CameraMinZoomDistance = 15
                                camera.CameraType = Enum.CameraType.Orbital
                            else
                                player.CameraMode = Enum.CameraMode.LockFirstPerson
                                camera.CameraSubject = humanoid
                                player.CameraMinZoomDistance = 0.5
                                camera.CameraType = Enum.CameraType.Custom
                            end
                        end
                    end
                end
            end
            task.wait(.1)
            if not Aimbot.Value and game.PlaceId ~= 116495829188952 then
                if player.CameraMode ~= Enum.CameraMode.LockFirstPerson then
                    player.CameraMode = Enum.CameraMode.LockFirstPerson
                    camera.CameraSubject = humanoid
                    player.CameraMinZoomDistance = 0.5
                    camera.CameraType = Enum.CameraType.Custom
                end
            end
        end)
    end)
    task.spawn(function()
        if game.PlaceId ~= 116495829188952 then
            RunService.Heartbeat:Connect(function()
                for _, model in pairs(CollectionService:GetTagged("Enemy")) do
                    if model:IsA("Model") and model ~= character then
                        local targetHumanoid = model:FindFirstChild("Humanoid")
                        if targetHumanoid then
                            if ESPMobs.Value and targetHumanoid.Health > 0 then
                                if not model:FindFirstChild("HighlightMob") then 
                                    local highlight = Instance.new("Highlight")
                                    highlight.Name = "HighlightMob"
                                    highlight.FillColor = Color3.fromRGB(239, 151, 19)
                                    highlight.OutlineColor = Color3.fromRGB(239, 151, 19)
                                    highlight.OutlineTransparency = 0.5
                                    highlight.Parent = model
                                end
                            else
                                local highlight = model:FindFirstChild("HighlightMob")
                                if highlight then
                                    highlight:Destroy()
                                end
                            end
                        end
                    end
                end
                for _, model in pairs(CollectionService:GetTagged("Corpse")) do
                    if ESPMobs.Value and model:FindFirstChild("HighlightMob") then
                        local highlight = model:FindFirstChild("HighlightMob")
                        highlight:Destroy()
                    end
                end
            end)
        end
    end)
    task.spawn(function()
        if game.PlaceId ~= 116495829188952 then
            RunService.Heartbeat:Connect(function()
                if ESPItem.Value then
                    for i, v in pairs(workspace.RuntimeItems:GetChildren()) do
                        if v:IsA("Model") and not v:FindFirstChild("ESPUI") then
                            CreateItemESP(v, v.Name, Color3.fromRGB(105, 218, 99))
                        end
                    end
                else
                    for i, v in pairs(workspace.RuntimeItems:GetChildren()) do
                        if v:IsA("Model") and v:FindFirstChild("ESPUI") then
                            local UI = v:FindFirstChild("ESPUI")
                            if UI then
                                UI:Destroy()
                            end
                        end
                    end
                end
            end) 
        end
    end)
    task.spawn(function()
        if game.PlaceId ~= 116495829188952 then
            RunService.Heartbeat:Connect(function()
                if ESPBond.Value then
                    for i, v in pairs(workspace.RuntimeItems:GetChildren()) do
                        if v.Name == "Bond" and v:IsA("Model") and not v:FindFirstChild("ESPUI") then
                            CreateItemESP(v, v.Name, Color3.fromRGB(218, 38, 38))
                            if not v:FindFirstChild("HighlightBond") then
                                local highlight = Instance.new("Highlight")
                                highlight.Name = "HighlightBond"
                                highlight.OutlineColor = Color3.fromRGB(218, 38, 38)
                                highlight.OutlineTransparency = 0.5
                                highlight.Parent = v
                            end
                        end
                    end
                else
                    for i, v in pairs(workspace.RuntimeItems:GetChildren()) do
                        if v.Name == "Bond" and v:IsA("Model") and v:FindFirstChildOfClass("BasePart") and v:FindFirstChild("ESPUI") then
                            local highlight = v:FindFirstChild("HighlightBond")
                            local UI = v:FindFirstChild("ESPUI")
                            if highlight and UI then
                                highlight:Destroy()
                                UI:Destroy()
                            end
                        end
                    end
                end
            end)
        end
    end)
    EnableThirdPerson:OnChanged(function()
        task.spawn(function()
            if game.PlaceId ~= 116495829188952 then
                while EnableThirdPerson.Value do
                    task.wait()
                    if player.CameraMode == Enum.CameraMode.LockFirstPerson then
                        player.CameraMode = Enum.CameraMode.Classic
                        player.CameraMaxZoomDistance = getgenv().Settings.FOVSlide
                    end
                end            
                task.wait(.1)
                if not EnableThirdPerson.Value then
                    player.CameraMode = Enum.CameraMode.LockFirstPerson
                    player.CameraMaxZoomDistance = 130
                end
            end
        end)
    end)
    FullBright:OnChanged(function()
        task.spawn(function()
            local brightLoop = nil
            if FullBright.Value then
                if brightLoop then
                    brightLoop:Disconnect()
                end
                local function brightFunc()
                    Lighting.Brightness = 2
                    Lighting.ClockTime = 14
                    Lighting.FogEnd = 100000
                    Lighting.GlobalShadows = false
                    Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
                end
            
                brightLoop = RunService.RenderStepped:Connect(brightFunc)
            else
                if brightLoop then
                    brightLoop:Disconnect()
                end
            end
        end)
    end)
    task.spawn(function()
        if game.PlaceId ~= 116495829188952 then
            game:GetService("RunService").Stepped:Connect(function()
                if Noclip.Value and character then
                    for _, part in pairs(player.Character:GetDescendants()) do
                        if part:IsA("BasePart") and part.CanCollide then
                            part.CanCollide = false
                        end
                    end
                else
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = true
                        end
                    end
                end
            end)
        end
    end)

    task.spawn(function()
        while true do
            getgenv().Settings.Train_Distance = getgenv().Settings.Train_Distance + 1
            getgenv().Settings.Train_Fuel = getgenv().Settings.Train_Fuel + 1
            task.wait(1)
        end
    end)

    task.spawn(function()
        if game.PlaceId ~= 116495829188952 then
            local Summoncharacter = player.Character or player.CharacterAdded:Wait()
            local Summonhumanoid = Summoncharacter:FindFirstChildOfClass("Humanoid") or Summoncharacter:WaitForChild("Humanoid", 9e99)
            local SummonrootPart = Summoncharacter:FindFirstChild("HumanoidRootPart") or Summoncharacter:WaitForChild("HumanoidRootPart", 9e99)
            local workspace = game.Workspace
    
            local controllingAvatar = false
    
            local function enableAvatarControl()
                if controllingAvatar then return end
                controllingAvatar = true
    
                SummonrootPart.Anchored = false
    
                local avatar = workspace:FindFirstChild("ControlledAvatar")
    
                if avatar then
                    local avatarHumanoid = avatar:FindFirstChildOfClass("Humanoid")
                    if avatarHumanoid then
                        workspace.CurrentCamera.CameraSubject = avatarHumanoid
                        player.Character = avatar
                    end
                else
                    avatar = Instance.new("Model")
                    avatar.Name = "ControlledAvatar"
                    avatar.Parent = workspace
    
                    local avatarRoot = Instance.new("Part")
                    avatarRoot.Name = "HumanoidRootPart"
                    avatarRoot.Size = Vector3.new(2, 6, 1)
                    avatarRoot.CFrame = SummonrootPart.CFrame * CFrame.new(0, 0, 3)
                    avatarRoot.Anchored = false
                    avatarRoot.CanCollide = true
                    avatarRoot.Parent = avatar
    
                    local avatarHumanoid = Instance.new("Humanoid")
                    avatarHumanoid.Parent = avatar
    
                    -- กำหนดให้ผู้เล่นควบคุมอวาตาร์ใหม่
                    workspace.CurrentCamera.CameraSubject = avatarHumanoid
                    player.Character = avatar
                end
            end
    
            local function disableAvatarControl()
                if not controllingAvatar then return end
                controllingAvatar = false
    
                SummonrootPart.Anchored = false
    
                local avatar = workspace:FindFirstChild("ControlledAvatar")
                if avatar then
                    avatar:Destroy()
                end
    
                workspace.CurrentCamera.CameraSubject = Summonhumanoid
                player.Character = Summoncharacter
            end
    
            userInputService.InputBegan:Connect(function(input, gameProcessed)
                if gameProcessed then return end
    
                if input.KeyCode == Enum.KeyCode[StandKeybind.Value] then
                    if controllingAvatar then
                        disableAvatarControl()
                    else
                        enableAvatarControl()
                    end
                end
            end) 
        end
    end)
    StandToggleWalkSpeed:OnChanged(function()
        task.spawn(function()
            while StandToggleWalkSpeed.Value do
                task.wait()
                local CameraMonitor = workspace:FindFirstChild("ControlledAvatar")
                if CameraMonitor then
                    local CameraMonitorHumanoid = CameraMonitor:FindFirstChildOfClass("Humanoid")
                    if CameraMonitorHumanoid then
                        CameraMonitorHumanoid.WalkSpeed = getgenv().Settings.StandWalkSpeed
                    end
                end
            end
        end)
    end)
    
    
    --[[ HOOKS ]]--------------------------------------------------------
    getgenv().Weapon = {
        FireDelay = nil,
        ReloadDuration = nil,
        SpreadAngle = nil
    }
    task.spawn(function()
        while wait() do
            for i, v in pairs(character:GetChildren()) do
                if v:IsA("Tool") and v:FindFirstChild("WeaponConfiguration") then
                    local WeaponConfiguration = v:FindFirstChild("WeaponConfiguration")
                    if WeaponConfiguration then
                        local FireDelay = WeaponConfiguration:FindFirstChild("FireDelay")
                        local ReloadDuration = WeaponConfiguration:FindFirstChild("ReloadDuration")
                        local SpreadAngle = WeaponConfiguration:FindFirstChild("SpreadAngle")
                        if FireDelay and ReloadDuration and SpreadAngle then
                            getgenv().Weapon.FireDelay = FireDelay
                            getgenv().Weapon.ReloadDuration = ReloadDuration
                            getgenv().Weapon.SpreadAngle = SpreadAngle
                        end
                    end
                end
            end
        end
    end)
    if getrawmetatable then
        local mt = getrawmetatable(game)
        setreadonly(mt, false)

        local OldIndex = mt.__index

        mt.__index = function(Obj, Value)
        if Obj == getgenv().Weapon.FireDelay and Value == "Value" and RapidFire.Value and getgenv().Weapon.FireDelay then
            return 0.1
        end

        if Obj == getgenv().Weapon.ReloadDuration and Value == "Value" and FastReload.Value and getgenv().Weapon.ReloadDuration then
            return 0
        end

        if Obj == getgenv().Weapon.SpreadAngle and Value == "Value" and NoSpread.Value and getgenv().Weapon.SpreadAngle then
            return 0
        end
            return OldIndex(Obj, Value)
        end
                        
        setreadonly(mt, true)
    else
        Fluent:Notify({
            Title = "Fearise Hub",
            Content = "This Exclutor Dont Support Some Function.",
            Duration = 5
        })
    end

    -- local ohNumber1 = 1742506570.669918
    -- local ohInstance2 = workspace.nxcfxbc973.Rifle
    -- local ohCFrame3 = CFrame.new(-353.04187, 13.5693903, 13925.0156, -0.727757335, 0.137108758, -0.671989858, 0, 0.979813099, 0.1999152, 0.685834587, 0.145489752, -0.713066339)
    -- local ohTable4 = {
    --     ["1"] = workspace.Towns.MediumTownTemplate.ZombiePart.Zombies.Runner.Humanoid
    -- }

    -- game:GetService("ReplicatedStorage").Remotes.Weapon.Shoot:FireServer(ohNumber1, ohInstance2, ohCFrame3, ohTable4)

    --Tame a Unicorn Put a saddle on a wild unicorn or find one already tamed
    --Escape  Travel 80km and successfully lower the bridge
    --Bounty Hunter  Kill 5 outlaws and turn in their bounties at a sheriffs office
    --New Sheriff in Town  Kill 50 outlaws in one game
    --Werewolf Hunter  Kill 50 werewolves in one game
    --Zombie Hunter  Kill 200 zombies in one game
    --Unkillable  Complete the game without having any player die
    --Pacifist  Complete the game without any player killing an enemy (Safezone turrents dont count)
    --Pony Express  Complete the game without any player using the train
end
-- Anti AFK
task.spawn(function()
    while wait(320) do
        pcall(function()
            local anti = game:GetService("VirtualUser")
            game:GetService("Players").LocalPlayer.Idled:connect(function()
                anti:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                wait(1)
                anti:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            end)
        end)
    end
end)

Fluent:Notify({
    Title = "Fearise Hub",
    Content = "Anti AFK Is Actived",
    Duration = 5
})

-- InterfaceManager:SetLibrary(Fluent)
-- InterfaceManager:BuildInterfaceSection(Tabs.pageAimbot)
Window:SelectTab(1)


--[[
    getgenv().Mob = nil

    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local rootPart = character:FindFirstChild("HumanoidRootPart")

    if not rootPart then
        return
    end

    local radius = 100

    -- ฟังก์ชันสำหรับค้นหา Model ที่มี Humanoid ในระยะที่กำหนด
    local function findNearbyHumanoids()
        local nearbyModels = {}

        for _, model in ipairs(workspace:GetDescendants()) do
            if model:IsA("Model") and model ~= character then
                local humanoid = model:FindFirstChild("Humanoid")
                if humanoid and humanoid.Health > 0 then
                    local modelRootPart = model:FindFirstChild("HumanoidRootPart")
                    if modelRootPart then
                        local distance = (modelRootPart.Position - rootPart.Position).Magnitude
                        if distance <= radius then
                            table.insert(nearbyModels, {model = model, distance = distance})
                        end
                    end
                end
            end
        end

        return nearbyModels
    end

    -- ฟังก์ชันสำหรับหาตัวที่ใกล้ที่สุด
    local function findClosestMob(nearbyModels)
        local closestMob = nil
        local closestDistance = math.huge

        for _, data in ipairs(nearbyModels) do
            if data.distance < closestDistance then
                closestDistance = data.distance
                closestMob = data.model
            end
        end

        return closestMob
    end

    task.spawn(function()
        while true do
            local nearbyModels = findNearbyHumanoids()

            if #nearbyModels > 0 then
                local closestMob = findClosestMob(nearbyModels)

                -- ตรวจสอบว่า Mob ที่ใกล้ที่สุดเปลี่ยนไปหรือไม่
                if getgenv().Mob ~= closestMob then
                    getgenv().Mob = closestMob
                    --print("New closest Mob: " .. closestMob.Name)
                end
            else
                -- ถ้าไม่มี Mob ในระยะ 100 ให้ set เป็น nil
                if getgenv().Mob ~= nil then
                    getgenv().Mob = nil
                    print("No Mob in range. Clearing target.")
                end
            end

            wait(.1)
        end
    end)

    local mt = getrawmetatable(game)
    setreadonly(mt, false)

    local oldNamecall = mt.__namecall

    mt.__namecall = newcclosure(function(self, ...)
        local args = {...}
        local method = getnamecallmethod()
        
        if method == "FireServer" and self.Name == "Shoot" and getgenv().Mob then
            local MobTarget = getgenv().Mob
            args[3] = MobTarget.Head.CFrame
            return oldNamecall(self, unpack(args))
        end
        return oldNamecall(self, ...)
    end)

    setreadonly(mt, true)
]]
--loadstring(game:HttpGet("https://raw.githubusercontent.com/Marco8642/science/refs/heads/ok/dead%20rails"))()
