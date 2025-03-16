repeat wait() until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character
getgenv().Settings = {
    AutoBlock = nil,
    Aimbot = nil,
    CollectFrozen = nil,
    AutoKill = nil,
    WalkSpeedInput = nil,
    WalkSpeed = nil,
    Fly = nil,
    SafeMode = nil,
    AutoUltimate = nil,
    AutoKillMode = nil,
    NumberOfPlayersInput = nil,
    HopServer = nil,
    AutoTrashCan = nil,
}

local function CreateToggle()
    local toggleGui = Instance.new("ScreenGui")
    toggleGui.Name = "ToggleGui"
    toggleGui.DisplayOrder = 1e+04
    toggleGui.IgnoreGuiInset = true
    toggleGui.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
    toggleGui.ResetOnSpawn = false
    toggleGui.Parent = game:GetService("CoreGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    mainFrame.BackgroundTransparency = 1
    mainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    mainFrame.BorderSizePixel = 0
    mainFrame.Position = UDim2.fromScale(0.925, 0.116)
    mainFrame.Size = UDim2.fromScale(0.083, 0.148)

    local uICorner = Instance.new("UICorner")
    uICorner.Name = "UICorner"
    uICorner.CornerRadius = UDim.new(1, 0)
    uICorner.Parent = mainFrame

    local toggleButton = Instance.new("ImageButton")
    toggleButton.Name = "ToggleButton"
    toggleButton.Image = "rbxassetid://112196145837803"
    toggleButton.ImageTransparency = 0.3
    toggleButton.AnchorPoint = Vector2.new(0.5, 0.5)
    toggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.BackgroundTransparency = 1
    toggleButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
    toggleButton.BorderSizePixel = 0
    toggleButton.Position = UDim2.fromScale(0.491, 0.482)
    toggleButton.Size = UDim2.fromScale(1, 1)

    local uICorner1 = Instance.new("UICorner")
    uICorner1.Name = "UICorner"
    uICorner1.CornerRadius = UDim.new(1, 0)
    uICorner1.Parent = toggleButton

    toggleButton.Parent = mainFrame

    local uIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    uIAspectRatioConstraint.Name = "UIAspectRatioConstraint"
    uIAspectRatioConstraint.AspectRatio = 1
    uIAspectRatioConstraint.Parent = mainFrame

    mainFrame.Parent = toggleGui

    return toggleButton
end

local Device;
local function checkDevice()
    local player = game.Players.LocalPlayer
    if player then
        local UserInputService = game:GetService("UserInputService")
        
        if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
            local FeariseToggle = CreateToggle()
            FeariseToggle.MouseButton1Click:Connect(function()
                for _, guiObject in ipairs(game:GetService("CoreGui"):GetChildren()) do
                    if guiObject.Name == "FeariseHub" and guiObject:IsA("ScreenGui") then
                        guiObject.Enabled = not guiObject.Enabled
                    end
                end
            end)
            game:GetService("CoreGui").ChildRemoved:Connect(function(Value)
                if Value.Name == "FeariseHub" then
                    FeariseToggle.Parent.Parent:Destroy()
                end
            end)
            Device = UDim2.fromOffset(480, 360)
        else
            Device = UDim2.fromOffset(580, 460)
        end
    end
end
checkDevice()

local FileName = tostring(game.Players.LocalPlayer.UserId).."_Settings.json"
local BaseFolder = "FeariseHub"
local SubFolder = "TSB"

function SaveSetting() 
    local json
    local HttpService = game:GetService("HttpService")
    
    if writefile then
        json = HttpService:JSONEncode(getgenv().Settings)

        if not isfolder(BaseFolder) then
            makefolder(BaseFolder)
        end
        if not isfolder(BaseFolder.."/"..SubFolder) then
            makefolder(BaseFolder.."/"..SubFolder)
        end
        
        writefile(BaseFolder.."/"..SubFolder.."/"..FileName, json)
    else
        error("ERROR: Can't save your settings")
    end
end

function LoadSetting()
    local HttpService = game:GetService("HttpService")
    if readfile and isfile and isfile(BaseFolder.."/"..SubFolder.."/"..FileName) then
        getgenv().Settings = HttpService:JSONDecode(readfile(BaseFolder.."/"..SubFolder.."/"..FileName))
    end
end

LoadSetting()

local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/Malemz1/FORTUNE-HUB/refs/heads/main/FeariseHub_UI.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Fearise Hub" .. " | ".."[KJ] The Strongest Battlegrounds".." |",
    SubTitle = "by Blobby",
    TabWidth = 160,
    Size =  Device, --UDim2.fromOffset(480, 360), --default size (580, 460)
    Acrylic = false, -- การเบลออาจตรวจจับได้ การตั้งค่านี้เป็น false จะปิดการเบลอทั้งหมด
    Theme = "Rose", --Amethyst
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    --[[ Tabs --]]
    pageMain = Window:AddTab({ Title = "Main", Icon = "home" }),
    pagePlayer = Window:AddTab({ Title = "Player", Icon = "user" }),
    pageFunny = Window:AddTab({ Title = "Funny", Icon = "laugh" }),
    pageServer = Window:AddTab({ Title = "Server", Icon = "server" }),
}

do
    --[[ MAIN ]]--------------------------------------------------------
    local AutomaticTitle = Tabs.pageMain:AddSection("Automatic")
    local AutoKillMode = Tabs.pageMain:AddDropdown("AutoKillMode", {
        Title = "Auto Kill Mode",
        Values = {"Over", "Behide", "Under"},
        Multi = false,
        Default = getgenv().Settings.AutoKillMode or "Behide",
        Callback = function(Value)
            getgenv().Settings.AutoKillMode = Value
            SaveSetting()
        end
    })
    AutoKillMode:OnChanged(function(Value)
        getgenv().Settings.AutoKillMode = Value
        SaveSetting()
    end)
    local AutoKill = Tabs.pageMain:AddToggle("AutoKill", {Title = "Auto Kill", Default = getgenv().Settings.AutoKill or false })
    local AutoUltimate = Tabs.pageMain:AddToggle("AutoUltimate", {Title = "Auto Ultimate", Default = getgenv().Settings.AutoUltimate or false })
    local LegitsTitle = Tabs.pageMain:AddSection("Legits")
    local AutoBlock = Tabs.pageMain:AddToggle("AutoBlock", {Title = "Auto Block", Default = getgenv().Settings.AutoBlock or false })
    local LockOn = Tabs.pageMain:AddToggle("LockOn", {Title = "Lock On", Default = getgenv().Settings.Aimbot or false })
    local CollectFrozen = Tabs.pageMain:AddToggle("CollectFrozen", {Title = "Collect Frozen", Default = getgenv().Settings.CollectFrozen or false })
    local SafeModeTitle = Tabs.pageMain:AddSection("SafeMode")
    Tabs.pageMain:AddParagraph({
        Title = "What Is Safe Mode?",
        Content = "If your health is less than 20%, you will teleport to a safe zone."
    })
    local SafeMode = Tabs.pageMain:AddToggle("SafeMode", {Title = "SafeMode", Default = getgenv().Settings.SafeMode or false })

    --[[ PLAYER ]]--------------------------------------------------------
    local WalkSpeedInput = Tabs.pagePlayer:AddInput("WalkSpeedInput", {
        Title = "WS Input",
        Default = 50,
        Numeric = true,
        Finished = false,
        Callback = function(Value)
            getgenv().Settings.WalkSpeedInput = Value
            SaveSetting()
        end
    })
    WalkSpeedInput:OnChanged(function(Value)
        getgenv().Settings.WalkSpeedInput = Value
        SaveSetting()
    end)
    local WalkSpeed = Tabs.pagePlayer:AddToggle("WalkSpeed", {Title = "Walk Speed", Default = getgenv().Settings.WalkSpeed or false })
    local Fly = Tabs.pagePlayer:AddToggle("Fly", {Title = "Fly", Default = getgenv().Settings.Fly or false })

    --[[ FUNNY ]]--------------------------------------------------------
    local AutoTrashCan = Tabs.pageFunny:AddToggle("AutoTrashCan", {Title = "Auto TrashCan", Default = getgenv().Settings.AutoTrashCan or false })

    --[[ SERVER ]]--------------------------------------------------------
    local NumberOfPlayersInput = Tabs.pageServer:AddInput("NumberOfPlayersInput", {
        Title = "Auto Hop When Kill ≥",
        Description = "ย้ายเซิฟหากฆ่าผู้เล่นมากกว่า",
        Default = getgenv().Settings.NumberOfPlayersInput or 4,
        Numeric = true,
        Finished = false,
        Callback = function(Value)
            getgenv().Settings.NumberOfPlayersInput = Value
            SaveSetting()
        end
    })
    NumberOfPlayersInput:OnChanged(function(Value)
        getgenv().Settings.NumberOfPlayersInput = Value
        SaveSetting()
    end)
    local HopServer = Tabs.pageServer:AddToggle("HopServer", {Title = "Auto Hop", Default = getgenv().Settings.HopServer or false })

    --[[ VARIABLE ]]--------------------------------------------------------
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    --local CollectionService = game:GetService("CollectionService")
    local VirtualInputManager = game:GetService("VirtualInputManager")
    local HttpService = game:GetService("HttpService")
    local TeleportService = game:GetService("TeleportService")
    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidrootpart = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart", 5)
    local humanoid = character:FindFirstChild("Humanoid") or character:WaitForChild("Humanoid", 5)
    local remoteEvent = (character and character:FindFirstChild("Communicate")) or character:WaitForChild("Communicate", 9e99)
    local SafeModeActive = false
    local KilledCount = nil
    local successTeleport = false
    local QueueOnTeleport = false
    local OnTeleporting = false

    --[[ FUNCTION ]]--------------------------------------------------------
    player.CharacterAdded:Connect(function(newcharacter)
        character = newcharacter
        humanoidrootpart = newcharacter:FindFirstChild("HumanoidRootPart") or newcharacter:WaitForChild("HumanoidRootPart", 5)
        humanoid = newcharacter:FindFirstChild("Humanoid") or newcharacter:WaitForChild("Humanoid", 5)
        remoteEvent = newcharacter:FindFirstChild("Communicate") or newcharacter:WaitForChild("Communicate", 9e99)
    end)

    local function ClosestPlayer()
        local closestPlayer = nil
        local shortestDistance = math.huge
        
        local player = game.Players.LocalPlayer
        local playerCharacter = player.Character
        if not playerCharacter or not playerCharacter:FindFirstChild("HumanoidRootPart") then
            return nil
        end
        
        local playerPosition = playerCharacter.HumanoidRootPart.Position
    
        for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
            if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local otherPosition = otherPlayer.Character.HumanoidRootPart.Position
                local distance = (playerPosition - otherPosition).Magnitude
    
                if distance < shortestDistance then
                    shortestDistance = distance
                    closestPlayer = otherPlayer
                end
            end
        end
    
        return closestPlayer
    end
    
    local function UpdateClosestTarget()
        local shortestDistance = math.huge
        local closestTarget = nil
    
        for _, enemy in pairs(workspace.Live:GetChildren()) do --CollectionService:GetTagged("characters")
            if enemy ~= character and enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and not enemy:GetAttribute("NPC") then
                local TargetHumanoidRootPart = enemy:FindFirstChild("HumanoidRootPart")
                if TargetHumanoidRootPart then
                    local Distance = (humanoidrootpart.Position - TargetHumanoidRootPart.Position).Magnitude
                    if Distance < shortestDistance then
                        shortestDistance = Distance
                        closestTarget = enemy
                    end
                end
            end
        end
    
        return closestTarget, shortestDistance
    end

    local function AutoSkill()
        local backpack = player:FindFirstChild("Backpack")
        if backpack then
            for _, tool in ipairs(backpack:GetChildren()) do
                if tool:IsA("Tool") and remoteEvent then
                    task.wait()
                    remoteEvent:FireServer({
                        ["Tool"] = tool,
                        ["Goal"] = "Console Move",
                        ["ToolName"] = tool.Name
                    })
                end
            end
        end
    end
    
    local function AutoUse()
        local playerGui = player:FindFirstChild("PlayerGui")
        if not playerGui then return end
    
        local hotbarScreen = playerGui:FindFirstChild("Hotbar")
        local BackpackFrame = hotbarScreen:FindFirstChild("Backpack")
        local hotbarFrame = BackpackFrame and BackpackFrame:FindFirstChild("Hotbar")
    
        if not hotbarFrame then return end
    
        for i = 1, 4 do
            local slot = hotbarFrame:FindFirstChild(tostring(i))
            local base = slot and slot:FindFirstChild("Base")
            
            if base and not base:FindFirstChild("Cooldown") then
                AutoSkill()
                return
            end
        end
    
        if remoteEvent then
            remoteEvent:FireServer({["Goal"] = "LeftClick"})
            task.wait()
            remoteEvent:FireServer({["Goal"] = "LeftClickRelease"})
        end
    end

    local function randomizeValue(value, range)
        return value + (value * (math.random(-range, range) / 100))
    end

    local function simulateKeyPress(key)
        remoteEvent:FireServer({
            ["MoveDirection"] = Vector3.zero,
            ["Key"] = key,
            ["Goal"] = "KeyPress"
        })
    
        task.wait()
    
        remoteEvent:FireServer({
            ["Goal"] = "KeyRelease",
            ["Key"] = key
        })
    end
    

    --[[ SCRIPTS ]]--------------------------------------------------------
    AutoKill:OnChanged(function()
        getgenv().Settings.AutoKill = AutoKill.Value
        SaveSetting()
        task.spawn(function()
            while AutoKill.Value do
                task.wait()
                local Success, err = pcall(function()
                    for _, enemy in pairs(workspace.Live:GetChildren()) do
                        if enemy ~= character and enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and not enemy:GetAttribute("NPC")  then
                            local TargetHumanoidRootPart = enemy:FindFirstChild("HumanoidRootPart")
                            local TargetHumanoid = enemy:FindFirstChild("Humanoid")
                    
                            if TargetHumanoid.Health > 0 and humanoid.Health > 0 and not SafeModeActive then
                                if HopServer.Value and OnTeleporting then
                                    humanoidrootpart.CFrame = CFrame.new(291.61474609375, 684.2703857421875, 514.2841186523438)
                                else
                                    repeat task.wait()
                                        if humanoidrootpart:FindFirstChild("antifall") then
                                            if getgenv().Settings.AutoKillMode == "Over" then
                                                humanoidrootpart.CFrame = TargetHumanoidRootPart.CFrame * CFrame.new(0, 5, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                                            elseif getgenv().Settings.AutoKillMode == "Behide" then
                                                humanoidrootpart.CFrame = TargetHumanoidRootPart.CFrame * CFrame.new(0, 0, 5) 
                                            elseif getgenv().Settings.AutoKillMode == "Under" then
                                                humanoidrootpart.CFrame = TargetHumanoidRootPart.CFrame * CFrame.new(0, -5, 0) * CFrame.Angles(math.rad(90), 0, 0)
                                            end
                                            task.spawn(function()
                                                AutoUse()
                                            end)
                                        else
                                            local antifall = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character.HumanoidRootPart)
                                            antifall.Velocity = Vector3.new(0, 0, 0)
                                            antifall.MaxForce = Vector3.new(100000, 100000, 100000)
                                            antifall.P = 1250
                                            antifall.Name = "antifall"
                                            game.Players.LocalPlayer.Character.Humanoid.PlatformStand = true
                                        end
                                    until TargetHumanoid.Health <= 0 or humanoid.Health <= 0 or not AutoKill.Value or not TargetHumanoidRootPart or not TargetHumanoid or not game.Players:FindFirstChild(enemy.Name) or SafeModeActive or successTeleport or OnTeleporting
                                end
                                for i,v in pairs(game.Players.LocalPlayer.Character.HumanoidRootPart:GetChildren()) do
                                    if v.Name == "antifall" or v:IsA("BodyVelocity") then
                                        task.wait(.1)
                                        v:Destroy()
                                        game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
                                    end
                                end
                            end
                        end
                    end
                end)
                if not Success then
                    warn("Error: "..err)
                end
            end
        end)
    end)

    AutoUltimate:OnChanged(function()
        getgenv().Settings.AutoUltimate = AutoUltimate.Value
        SaveSetting()
        task.spawn(function()
            while AutoUltimate.Value do
                task.wait(1)
                simulateKeyPress(Enum.KeyCode.G)
            end
        end)
    end)

    AutoBlock:OnChanged(function()
        task.spawn(function()
            getgenv().Settings.AutoBlock = AutoBlock.Value
            SaveSetting()
        end)
    end)

    local lastTarget = nil
    local lastM1Connection = nil
    local lastDashConnection = nil

    RunService.Heartbeat:Connect(function()
        closestTarget, shortestDistance = UpdateClosestTarget()

        if getgenv().Settings.AutoBlock then
            if closestTarget ~= lastTarget then
                -- ยกเลิกการเชื่อมต่อเดิมก่อน
                if lastM1Connection then
                    lastM1Connection:Disconnect()
                    lastM1Connection = nil
                end
                if lastDashConnection then
                    lastDashConnection:Disconnect()
                    lastDashConnection = nil
                end
    
                lastTarget = closestTarget
    
                if closestTarget then
                    local lastComboChange = tick()
                    local lastContinuousChange = tick()
                    local changing = false
    
                    -- สร้าง Connection ใหม่
                    lastM1Connection = closestTarget:GetAttributeChangedSignal("LastM1Fire"):Connect(function()
                        local TargetDistance = 15
                        if shortestDistance <= TargetDistance and getgenv().Settings.AutoBlock then
                            lastComboChange = tick()
                            lastContinuousChange = tick()
                            changing = true
                            if character:GetAttribute("Blocking") == false then
                                local args = {
                                    [1] = {
                                        ["Goal"] = "KeyPress",
                                        ["Key"] = Enum.KeyCode.F
                                    }
                                }
                                local Communicate = character:FindFirstChild("Communicate") or character:WaitForChild("Communicate", 5)
                                Communicate:FireServer(unpack(args))                                
                                --VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
                            end
    
                            task.spawn(function()
                                while closestTarget and shortestDistance <= TargetDistance do
                                    if tick() - lastContinuousChange >= 0.5 then
                                        changing = false
                                    end
                                    if not changing and tick() - lastComboChange >= 1 then
                                        local args = {
                                            [1] = {
                                                ["Goal"] = "KeyRelease",
                                                ["Key"] = Enum.KeyCode.F
                                            }
                                        }
                                        local Communicate = character:FindFirstChild("Communicate") or character:WaitForChild("Communicate", 5)
                                        Communicate:FireServer(unpack(args))  
                                        
                                        --VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
                                        break
                                    end
                                    task.wait()
                                end
                    
                                if closestTarget and shortestDistance > TargetDistance then
                                    local args = {
                                        [1] = {
                                            ["Goal"] = "KeyRelease",
                                            ["Key"] = Enum.KeyCode.F
                                        }
                                    }
                                    local Communicate = character:FindFirstChild("Communicate") or character:WaitForChild("Communicate", 5)
                                    Communicate:FireServer(unpack(args))  
                                    
                                    --VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
                                    lastComboChange = 0
                                    lastContinuousChange = 0
                                    changing = false
                                end
                            end)
                        end
                    end)
                    
                    lastDashConnection = closestTarget:GetAttributeChangedSignal("LastDashSwing"):Connect(function()
                        if shortestDistance <= 70 and getgenv().Settings.AutoBlock then
                            if character:GetAttribute("Blocking") == false then
                                local args = {
                                    [1] = {
                                        ["Goal"] = "KeyPress",
                                        ["Key"] = Enum.KeyCode.F
                                    }
                                }
                                local Communicate = character:FindFirstChild("Communicate") or character:WaitForChild("Communicate", 5)
                                Communicate:FireServer(unpack(args))
                                task.wait(.5)
                                local args = {
                                    [1] = {
                                        ["Goal"] = "KeyRelease",
                                        ["Key"] = Enum.KeyCode.F
                                    }
                                }
                                
                                Communicate:FireServer(unpack(args))
                                
                                -- VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
                                -- task.wait(.3)
                                -- VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
                            end
                        end
                    end)
                end
            end
        end
    end)

    LockOn:OnChanged(function()
        task.spawn(function()
            getgenv().Settings.Aimbot = LockOn.Value
            SaveSetting()

            while LockOn.Value do
                task.wait()
                local closestTarget = nil
                local shortestDistance = math.huge
    
                for i, v in pairs(workspace.Live:GetChildren()) do
                    if v:IsA("Model") and v:FindFirstChild("Humanoid") and not v:GetAttribute("NPC") and v ~= character then
                        if v.Humanoid.Health > 0 then
                            local TargetHumanoidRootPart = v:FindFirstChild("HumanoidRootPart")
                            if TargetHumanoidRootPart then
                                local Distance = (humanoidrootpart.Position - TargetHumanoidRootPart.Position).Magnitude
                                if Distance < shortestDistance then
                                    shortestDistance = Distance
                                    closestTarget = v
                                end
                            end
                        end
                    end
                end
    
                if closestTarget then
                    local TargetHumanoidRoot = closestTarget:FindFirstChild("HumanoidRootPart")
                    local TargetHumanoid = closestTarget:FindFirstChild("Humanoid")
                    if shortestDistance <= 150 and TargetHumanoid and TargetHumanoid.Health > 0 then
                        local state = TargetHumanoid:GetState()
                        local localstate = humanoid:GetState()
                        local lookVector = (TargetHumanoidRoot.Position - humanoidrootpart.Position).Unit
                        humanoidrootpart.CFrame = CFrame.new(humanoidrootpart.Position, humanoidrootpart.Position + Vector3.new(lookVector.X, 0, lookVector.Z))
                        -- if state == Enum.HumanoidStateType.GettingUp or 
                        --     state == Enum.HumanoidStateType.FallingDown or 
                        --     state == Enum.HumanoidStateType.PlatformStanding or 
                        --     localstate == Enum.HumanoidStateType.GettingUp or 
                        --     localstate == Enum.HumanoidStateType.FallingDown or
                        --     localstate == Enum.HumanoidStateType.PlatformStanding then
                        --     task.wait()
                        -- else
                        --     local lookVector = (TargetHumanoidRoot.Position - humanoidrootpart.Position).Unit
                        --     humanoidrootpart.CFrame = CFrame.new(humanoidrootpart.Position, humanoidrootpart.Position + Vector3.new(lookVector.X, 0, lookVector.Z))

                        --     --humanoidrootpart.CFrame = CFrame.lookAt(humanoidrootpart.Position, TargetHumanoidRoot.Position)
                        -- end
                    end
                end
            end
        end)
    end)

    CollectFrozen:OnChanged(function()
        task.spawn(function()
            getgenv().Settings.CollectFrozen = CollectFrozen.Value
            SaveSetting()
            while CollectFrozen.Value do
                task.wait(1)
                for i,v in pairs(workspace.Thrown:GetChildren()) do
                    if v.Name == "Frozen Lock" and v:FindFirstChild("Root") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Root.CFrame * CFrame.new(0, 2.5, 0)
                    end
                end
            end
        end)
    end)

    WalkSpeed:OnChanged(function()
        getgenv().Settings.WalkSpeed = WalkSpeed.Value
        SaveSetting()
        task.spawn(function()
            while WalkSpeed.Value do
                task.wait()
                humanoid.WalkSpeed = getgenv().Settings.WalkSpeedInput
            end
        end)
    end)

    local flySpeed = 100
    local maxFlySpeed = 1000
    local speedIncrement = 0.4
    local originalGravity = workspace.Gravity
    Fly:OnChanged(function()
        getgenv().Settings.Fly = Fly.Value
        SaveSetting()
        task.spawn(function()
            while Fly.Value do
                task.wait()
                workspace.Gravity = 0 
                local MoveDirection = Vector3.new()
                local cameraCFrame = workspace.CurrentCamera.CFrame
                MoveDirection = MoveDirection + (UserInputService:IsKeyDown(Enum.KeyCode.W) and cameraCFrame.LookVector or Vector3.new())
                MoveDirection = MoveDirection - (UserInputService:IsKeyDown(Enum.KeyCode.S) and cameraCFrame.LookVector or Vector3.new())
                MoveDirection = MoveDirection - (UserInputService:IsKeyDown(Enum.KeyCode.A) and cameraCFrame.RightVector or Vector3.new())
                MoveDirection = MoveDirection + (UserInputService:IsKeyDown(Enum.KeyCode.D) and cameraCFrame.RightVector or Vector3.new())
                MoveDirection = MoveDirection + (UserInputService:IsKeyDown(Enum.KeyCode.Space) and Vector3.new(0, 1, 0) or Vector3.new())
                MoveDirection = MoveDirection - (UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and Vector3.new(0, 1, 0) or Vector3.new())

                if MoveDirection.Magnitude > 0 then
                    flySpeed = math.min(flySpeed + speedIncrement, maxFlySpeed) 
                    MoveDirection = MoveDirection.Unit * math.min(randomizeValue(flySpeed, 10), maxFlySpeed)
                    humanoidrootpart.Velocity = MoveDirection * 0.5
                else
                    humanoidrootpart.Velocity = Vector3.new(0, 0, 0) 
                end

                RunService.RenderStepped:Wait() 
            end
            task.wait(.1)
            if not Fly.Value then
                flySpeed = 100 
                humanoidrootpart.Velocity = Vector3.new(0, 0, 0)
                workspace.Gravity = originalGravity
            end
        end)
    end)

    SafeMode:OnChanged(function()
        getgenv().Settings.SafeMode = SafeMode.Value
        SaveSetting()
        task.spawn(function()
            while SafeMode.Value do
                task.wait(.1)
                if humanoid.Health <= (humanoid.MaxHealth * 0.2) and not SafeModeActive then
                    Fluent:Notify({
                        Title = "FeariseHub",
                        Content = "SafeMode Actived",
                        Duration = 5
                    })
                    SafeModeActive = true
                    repeat task.wait()
                        humanoidrootpart.CFrame = CFrame.new(291.61474609375, 684.2703857421875, 514.2841186523438)
                    until humanoid.Health >= (humanoid.MaxHealth * 0.25)
                    Fluent:Notify({
                        Title = "FeariseHub",
                        Content = "SafeMode UnActived",
                        Duration = 5
                    })
                    SafeModeActive = false
                end
            end
        end)
    end)

    HopServer:OnChanged(function()
        getgenv().Settings.HopServer = HopServer.Value
        SaveSetting()
        task.spawn(function()
            while HopServer.Value do
                task.wait(0.1)
                local LeaderBoard = player:FindFirstChild("leaderstats") or player:WaitForChild("leaderstats", 9e99)
                local Kills = LeaderBoard:FindFirstChild("Kills") or LeaderBoard:WaitForChild("Kills", 9e99)
                if KilledCount then
                    local http_request = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
                    if Kills.Value >= (KilledCount + getgenv().Settings.NumberOfPlayersInput) then
                        if http_request then
                            local function findServer()
                                local servers = {}
                                local url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", game.PlaceId)
                            
                                local success, response = pcall(function()
                                    return http_request({ Url = url, Method = "GET" })
                                end)
                            
                                if success and response and response.Body then
                                    local body = HttpService:JSONDecode(response.Body)
                                    if body and body.data then
                                        for _, v in pairs(body.data) do
                                            if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and tonumber(v.queuedPlayers) then
                                                if v.playing < v.maxPlayers and v.id ~= game.JobId then
                                                    table.insert(servers, v.id)
                                                end
                                            end
                                        end
                                    end
                                end
                            
                                return servers
                            end
    
                            pcall(function()
                                repeat
                                    OnTeleporting = true
                                    local availableServers = findServer()
        
                                    if #availableServers > 0 then
                                        local randomServer = availableServers[math.random(#availableServers)]
                                        local success, errorMessage = pcall(function()
                                            TeleportService:TeleportToPlaceInstance(game.PlaceId, randomServer, Players.LocalPlayer)
                                        end)
        
                                        if success then
                                            local queue_on_teleport = queue_on_teleport or syn.queue_on_teleport or fluxus.queue_on_teleport or function(...) return ... end
        
                                            Players.OnTeleport:Connect(function(state)
                                                if state ~= Enum.TeleportState.Started and state ~= Enum.TeleportState.InProgress then return end
                                                queue_on_teleport([[
                                                    repeat wait() until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character
                                                    wait(2)
                                                    loadstring(game:HttpGet("https://raw.githubusercontent.com/Malemz1/FORTUNE-HUB/refs/heads/main/StrongestBattleground.lua"))()
                                                ]])
                                            end)
                                            Fluent:Notify({
                                                Title = "Fearise Hub",
                                                Content = "✅ Teleport สำเร็จ!",
                                                Duration = 5
                                            })
                                            successTeleport = true
                                        else
                                            Fluent:Notify({
                                                Title = "Fearise Hub",
                                                Content = "⚠️ Teleport ล้มเหลว:"..errorMessage,
                                                Duration = 5
                                            })
                                        end
                                    else
                                        Fluent:Notify({
                                            Title = "Fearise Hub",
                                            Content = "❌ ไม่พบเซิร์ฟเวอร์ที่ไม่เต็ม กำลังลองใหม่...",
                                            Duration = 5
                                        })
                                    end
        
                                    task.wait(5) -- รอ 5 วินาทีเพื่อป้องกันการส่ง request ถี่เกินไป
                                until successTeleport or not HopServer.Value
                            end)
                        else
                            Fluent:Notify({
                                Title = "Fearise Hub",
                                Content = "🚫 httprequest ไม่สามารถใช้งานได้",
                                Duration = 5
                            })
                        end
                    end
                elseif not KilledCount then
                    KilledCount = Kills.Value
                    task.wait(0.5)
                end
            end
        end)
    end)

    AutoTrashCan:OnChanged(function()
        task.spawn(function()
            while AutoTrashCan.Value do
                task.wait()
                if character:FindFirstChild("Trash Can") then
                    for PlayerIndex, PlayerValue in pairs(workspace.Live:GetChildren()) do
                        if PlayerValue:IsA("Model") and not PlayerValue:GetAttribute("NPC") and PlayerValue:FindFirstChild("HumanoidRootPart") then
                            local PlayerHumanoidRootPart = PlayerValue:FindFirstChild("HumanoidRootPart")
                            local PlayerHumanoid = PlayerValue:FindFirstChild("Humanoid")
                    
                            -- ตรวจสอบว่าพบ Humanoid และ RootPart หรือไม่
                            if PlayerHumanoid and PlayerHumanoidRootPart then
                                -- ตรวจสอบว่าเลือดต่ำกว่า 20% หรือไม่
                                if PlayerHumanoid.Health > 0 and PlayerHumanoid.Health <= (PlayerHumanoid.MaxHealth * 0.2) then
                                    -- ตรวจสอบว่า humanoidrootpart ถูกกำหนดค่าหรือไม่
                                    if humanoidrootpart then
                                        -- วาร์ปไปหาเป้าหมาย
                                        humanoidrootpart.CFrame = PlayerHumanoidRootPart.CFrame * CFrame.new(0, 0, 7)
                    
                                        -- ตรวจสอบระยะทางก่อนกดโจมตี
                                        task.spawn(function()
                                            task.wait(0.1) -- รอให้วาร์ปก่อนเช็คระยะทาง
                                            local DistanceTrashCan = (PlayerHumanoidRootPart.Position - humanoidrootpart.Position).Magnitude
                                            if DistanceTrashCan <= 10 then
                                                remoteEvent:FireServer({["Goal"] = "LeftClick"})
                                                task.wait()
                                                remoteEvent:FireServer({["Goal"] = "LeftClickRelease"})
                                            end
                                        end)
                                    end
                                else
                                    -- ถ้าเลือดมากกว่า 20% ให้กลับไปที่จุดเริ่มต้น
                                    humanoidrootpart.CFrame = CFrame.new(291.6147, 684.2704, 514.2841)
                                end
                            end
                        end
                    end                    
                else
                    for TrashcanIndex, TrashcanValue in ipairs(workspace.Map.Trash:GetChildren()) do
                        if TrashcanValue:IsA("Model") and TrashcanValue:FindFirstChild("Trashcan") then
                            local TrashcanPart = TrashcanValue:FindFirstChild("Trashcan")
                            if TrashcanPart.Transparency == 0 then
                                humanoidrootpart.CFrame = TrashcanPart.CFrame * CFrame.new(0, 0, 5)
                                task.spawn(function()
                                    remoteEvent:FireServer({["Goal"] = "LeftClick"})
                                    task.wait()
                                    remoteEvent:FireServer({["Goal"] = "LeftClickRelease"})
                                end)
                            end
                        end
                    end
                end
            end
        end)
    end)
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

Window:SelectTab(1)