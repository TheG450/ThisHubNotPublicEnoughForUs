repeat wait() until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character
getgenv().Settings = {
    SelectedMob = nil,
    AutoFarmMob = nil,

}

local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/Malemz1/FORTUNE-HUB/refs/heads/main/FeariseHub_UI.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Fearise Hub" .. " | ".."Rune Slayer".." |",
    SubTitle = "by Blobby",
    TabWidth = 160,
    Size =  UDim2.fromOffset(580, 460), --UDim2.fromOffset(480, 360), --default size (580, 460)
    Acrylic = false, -- การเบลออาจตรวจจับได้ การตั้งค่านี้เป็น false จะปิดการเบลอทั้งหมด
    Theme = "Rose", --Amethyst
    MinimizeKey = Enum.KeyCode.LeftAlt
})

local Tabs = {
    --[[ Tabs --]]
    pageMain = Window:AddTab({ Title = "Main", Icon = "home" }),
}

do
    --[[ MAIN ]]--------------------------------------------------------
    local MobList = {}
    local function GetMobList()
        for i, v in pairs(game:GetService("ReplicatedStorage").Storage.Mobs:GetChildren()) do
            if v:IsA("Model") then
                table.insert(MobList, v.Name)
            end
        end
        table.sort(MobList)
    end
    GetMobList()
    local SelectedMob = Tabs.pageMain:AddDropdown("SelectedMob", {
        Title = "Selecte Mob",
        Values = MobList,
        Multi = false,
        Default = getgenv().Settings.SelectedMob or "",
        Callback = function(Value)
            getgenv().Settings.SelectedMob = Value
        end
    })
    SelectedMob:OnChanged(function(Value)
        getgenv().Settings.SelectedMob = Value
    end)
    local AutoFarmMob = Tabs.pageMain:AddToggle("AutoFarmMob", {Title = "Auto Farm Mob", Default = getgenv().Settings.AutoFarmMob or false })

    --[[ SCRIPTS ]]--------------------------------------------------------
    local TweenService = game:GetService("TweenService")
    local CollectionService = game:GetService("CollectionService")
    local VirtualUser = game:GetService("VirtualUser")
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidrootpart = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart", 5)
    local humanoid = character:FindFirstChild("Humanoid") or character:WaitForChild("Humanoid", 5)

    player.CharacterAdded:Connect(function(newcharacter)
        character = newcharacter
        humanoidrootpart = newcharacter:FindFirstChild("HumanoidRootPart") or newcharacter:WaitForChild("HumanoidRootPart", 5)
        head = newcharacter:FindFirstChild("Head") or newcharacter:WaitForChild("Head", 5)
        torso = newcharacter:FindFirstChild("Torso") or newcharacter:WaitForChild("Torso", 5)
        humanoid = newcharacter:FindFirstChild("Humanoid") or newcharacter:WaitForChild("Humanoid", 5)
    end)

    character.ChildAdded:Connect(function(child)
        if child.Name == "BodyGyro" then
            for i, v in pairs(humanoidrootpart:GetChildren()) do
                if v.Name == "antifall" then
                    v:Destroy()
                    child:Destroy()
                end
            end 
        end
    end)

    local function Tween(Target)
        local Distance = (Target.Position - humanoidrootpart.Position).Magnitude
        local Speed = 100
        local tween = TweenService:Create(humanoidrootpart, TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear), {CFrame = Target})
        tween:Play()
        tween.Completed:Connect(function()
            if Distance <= 7 then
                VirtualUser:Button1Down(Vector2.new(9999, 9999))
                VirtualUser:Button1Up(Vector2.new(9999, 9999))
            end
        end)
    end

    AutoFarmMob:OnChanged(function()
        task.spawn(function()
            while AutoFarmMob.Value do
                task.wait()
                if humanoidrootpart:FindFirstChild("antifall") and humanoid.Health > 0 and character:WaitForChild("HumanoidRootPart", 9e99) then
                    for MobIndex, MobValue in pairs(workspace.Alive:GetChildren()) do
                        if string.find(MobValue.Name, getgenv().Settings.SelectedMob) and MobValue:FindFirstChild("HumanoidRootPart") then
                            local MobHumanoid = MobValue:FindFirstChild("Humanoid")
                            if MobHumanoid.Health > 0 then
                                repeat task.wait()
                                    local MobHumanoidRootPart = MobValue:FindFirstChild("HumanoidRootPart")
                                    Tween(MobHumanoidRootPart.CFrame * CFrame.new(0, 5, 0) * CFrame.Angles(math.rad(-90), 0, 0))
                                until MobHumanoid.Health <= 0 or humanoid.Health <= 0 or not string.find(MobValue.Name, getgenv().Settings.SelectedMob) or not humanoidrootpart:FindFirstChild("antifall") or not MobValue or not AutoFarmMob.Value
                            end
                        end
                    end
                else
                    local antifall = Instance.new("BodyVelocity", humanoidrootpart)
                    antifall.P = 1250
                    antifall.MaxForce = Vector3.new(1e99, 1e99, 1e99)
                    antifall.Velocity = Vector3.new(0, 0, 0)
                    antifall.Name = "antifall"
                    CollectionService:AddTag(antifall, "Whitelisted")
                    humanoid.PlatformStand = true
                end
            end
            task.wait(.1)
            if not AutoFarmMob.Value then
                Tween(humanoidrootpart.CFrame)
                task.wait(.1)
                for i, v in pairs(humanoidrootpart:GetChildren()) do
                    if v.Name == "antifall" then
                        v:Destroy()
                        humanoid.PlatformStand = false
                    end
                end 
            end
        end)
    end)

    task.spawn(function()
        local Alive = true
        game:GetService("RunService").Heartbeat:Connect(function()
            if AutoFarmMob.Value and Alive then
                for i, v in pairs(character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            else
                Alive = false
            end
        end)

        player.CharacterAdded:Connect(function()
            wait(2)
            Alive = true
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