repeat wait() until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character

local Device
local Players = game:GetService("Players")

local function checkDevice()
    local player = Players.LocalPlayer
    if player then
        local UserInputService = game:GetService("UserInputService")
        if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
            Device = UDim2.fromOffset(480, 360)
        else
            Device = UDim2.fromOffset(580, 460)
        end
    end
end

checkDevice()

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Private script" .. " | " .. "BlueLock : Rival" .. " | " .. "[Version X]",
    TabWidth = 160,
    Size = Device,
    Acrylic = false,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Tabs = {
    Kaitan = Window:AddTab({ Title = "Feature", Icon = "crown" }),
}

local plrs = game:GetService("Players")
local runService = game:GetService("RunService")
local lp = plrs.LocalPlayer
local bs = game:GetService("ReplicatedStorage").Packages.Knit.Services.BallService
local ig = false

local function getBall()
    for _, o in ipairs(workspace:GetDescendants()) do
        if o:IsA("BasePart") and o.Name == "Football" then
            return o
        end
    end
end

-- สร้างตารางเก็บ CFrame ของเป้าหมายแต่ละฝั่ง
local goalCFrames = {
    Home = {
        CFrame.new(
            323.849396, 11.1665344, -29.958168, -0.346998423, -2.85511348e-08, -0.937865734, 2.543152e-08, 1, -3.98520079e-08, 0.937865734, -3.76799356e-08, -0.346998423
        ),
        CFrame.new(
            326.027893, 11.1665325, -67.0218277, 0.910013974, -1.74189319e-09, -0.414577574, -1.44234642e-08, 1, -3.58616781e-08, 0.414577574, 3.86142709e-08, 0.910013974
        )
        },
    Away = {
        CFrame.new(
            -247.79953, 11.1665344, -68.2236633,
            0.441729337, -3.98036413e-08, -0.897148371,
            8.61732801e-08, 1, -1.93767069e-09,
            0.897148371, -7.64542918e-08, 0.441729337
        ),
        CFrame.new(
            -247.711075, 25.6309118, -30.344408,
            0.936370671, 0.0215997752, -0.350347638,
            -3.86210353e-08, 0.99810493, 0.0615354702,
            0.351012826, -0.0576199964, 0.934596181
        )
    }
}

local function getRandomTargetCFrame(team)
    if team == "Home" then
        return goalCFrames.Away[math.random(1, #goalCFrames.Away)] -- เตะไปเป้าหมายฝั่ง Away
    elseif team == "Away" then
        return goalCFrames.Home[math.random(1, #goalCFrames.Home)] -- เตะไปเป้าหมายฝั่ง Home
    end
end

local function moveWithGravity(ball, startPos, targetCF, height, duration)
    local startTime = tick()
    local connection
    local endPos = targetCF.Position -- ดึงตำแหน่งจาก CFrame
    connection = runService.RenderStepped:Connect(function()
        local elapsed = tick() - startTime
        if elapsed > duration then
            ball.CFrame = targetCF -- ตั้งค่า CFrame ที่กำหนดเมื่อถึงเป้าหมาย
            connection:Disconnect()
            return
        end

        local t = elapsed / duration
        local currentXZ = startPos:Lerp(endPos, t)
        local arcHeight = math.sin(t * math.pi) * height
        ball.Position = Vector3.new(currentXZ.X, startPos.Y + arcHeight, currentXZ.Z)
    end)
end

local function teleportBallToGoal()
    local ball = getBall()
    if ball then
        local team = lp.Team and lp.Team.Name -- ตรวจสอบทีมของผู้เล่น
        if team then
            local startPos = ball.Position
            local targetCFrame = getRandomTargetCFrame(team) -- สุ่มเป้าหมายของทีมตรงข้าม
            if targetCFrame then
                moveWithGravity(ball, startPos, targetCFrame, 25, 1.2) -- ความสูง 25, ความเร็ว 1.2 วินาที
            end
        end
    end
end

bs.RE.Shoot.OnClientEvent:Connect(function()
    if ig then
        teleportBallToGoal()
    end
end)

local toggle = Tabs.Kaitan:AddToggle("InstantGoalToggle", {
    Title = "Instant Goal",
    Default = false,
    Callback = function(state)
        ig = state
    end
})

local keybind = Tabs.Kaitan:AddKeybind("InstantKeybind", {
    Title = "Toggle Instant Goal Keybind",
    Mode = "Toggle",
    Default = "T",
    Callback = function()
        ig = not ig
        toggle:SetValue(ig)
        Fluent:Notify({
            Title = "Instant Goal Toggled",
            Content = "Instant Goal has been " .. (ig and "enabled" or "disabled") .. ".",
            Duration = 3
        })
    end,
    ChangedCallback = function(newKey)
        Fluent:Notify({
            Title = "Keybind Changed",
            Content = "Instant Goal Keybind is now set to: " .. tostring(newKey),
            Duration = 3
        })
    end
})

local Options = {}

    local function findFootball()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj.Name == "Football" then
                return obj
            end
        end
        return nil
    end

local HitboxTitle = Tabs.Kaitan:AddSection("Hitbox")

local dribblingEnabled = false
local currentSize = 2.5 -- Default size

-- Hitbox Toggle
local Toggle = Tabs.Kaitan:AddToggle("MyToggle", { Title = "Hitbox", Default = false })
Options.MyToggle = Toggle

-- Show Hitbox Toggle
local ShowToggle = Tabs.Kaitan:AddToggle("ShowToggle", { Title = "Show Hitbox", Default = true })
Options.ShowToggle = ShowToggle

local function updateHitboxSize()
    local football = findFootball()
    if football then
        local hitbox = football:FindFirstChild("Hitbox")
        if hitbox and hitbox:IsA("Part") then
            hitbox.Material = Enum.Material.ForceField
            hitbox.BrickColor = BrickColor.new("Really red")
            hitbox.Transparency = Options.ShowToggle.Value and 0.5 or 1 -- Adjust visibility
            hitbox.Size = Vector3.new(currentSize, currentSize, currentSize)
        end
    end
end

-- Hitbox Toggle Logic
Toggle:OnChanged(function()
    local toggleValue = Options.MyToggle.Value
    if toggleValue then
        updateHitboxSize()
    else
        local football = findFootball()
        if football then
            local hitbox = football:FindFirstChild("Hitbox")
            if hitbox and hitbox:IsA("Part") then
                hitbox.Material = Enum.Material.Plastic
                hitbox.BrickColor = BrickColor.new("Institutional white")
                hitbox.Transparency = 1
                hitbox.Size = Vector3.new(2.5, 2.5, 2.5)
            end
        end
    end
end)

-- Show Hitbox Toggle Logic
ShowToggle:OnChanged(function()
    if Options.MyToggle.Value then
        updateHitboxSize()
    else
        local football = findFootball()
        if football then
            local hitbox = football:FindFirstChild("Hitbox")
            if hitbox and hitbox:IsA("Part") then
                hitbox.Transparency = 0.5 -- Default to invisible if Hitbox is disabled
            end
        end
    end
end)

-- Input for Hitbox Size
local Input = Tabs.Kaitan:AddInput("Input", {
    Title = "Hitbox Size",
    Default = tostring(currentSize),
    Placeholder = "Enter size (1-30)",
    Numeric = true,
    Finished = true,
    Callback = function(Value)
        local newSize = tonumber(Value)
        if newSize and newSize >= 1 and newSize <= 30 then
            currentSize = newSize
            if Options.MyToggle.Value then
                updateHitboxSize()
            end
        else
            Fluent:Notify({
                Title = "Invalid Input",
                Content = "Size must be between 1 and 30.",
                Duration = 3
            })
        end
    end
})

-- Hitbox Keybind
local HitboxKeybind = Tabs.Kaitan:AddKeybind("HitboxKeybind", {
    Title = "Toggle Hitbox Keybind",
    Mode = "Toggle", 
    Default = "H",
    Callback = function()
        local currentState = Options.MyToggle.Value
        Options.MyToggle:SetValue(not currentState)
        Fluent:Notify({
            Title = "Hitbox Toggled",
            Content = "Hitbox has been " .. (Options.MyToggle.Value and "enabled" or "disabled") .. ".",
            Duration = 3
        })
    end,
    ChangedCallback = function(NewKey)
        Fluent:Notify({
            Title = "Keybind Changed",
            Content = "Hitbox Toggle Keybind is now set to: " .. tostring(NewKey),
            Duration = 3
        })
    end
})

local OPTitle = Tabs.Kaitan:AddSection("OP")

-- Variables
local noCooldownEnabled = false

-- No Cooldown Skill Toggle
-- Toggle for Steal Function Override
Tabs.Kaitan:AddToggle("NoCooldownSteal", {
    Title = "No Cooldown - Steal",
    Default = false,
    Callback = function(state)
        if state then
            local originalSteal = require(game:GetService("ReplicatedStorage").Controllers.AbilityController.Abilities.Bachira.Steal)

            local TweenService = game:GetService("TweenService")
            local originalSteal = require(game:GetService("ReplicatedStorage").Controllers.AbilityController.Abilities.Bachira.Steal)
            
            local newSteal = function(v11, v12, v13)
                -- ข้ามเงื่อนไขคูลดาวน์และพลังงาน
                if false then -- ข้ามการตรวจสอบทุกอย่าง
                    return
                end
            
                if v11.ABC then
                    v11.ABC:Clean()
                end
                if v11.SlideTrove then
                    v11.SlideTrove:Destroy()
                end
            
                -- ส่วนสำหรับเมื่อผู้เล่นมีบอล
                if v13.Values.HasBall.Value then
                    v11.AbilityController:AbilityCooldown("1", 1) -- ไม่มีคูลดาวน์
                    v11.StaminaService.DecreaseStamina:Fire(10) -- ไม่ลด Stamina
                    v11.StatesController.States.Ability = true
                    v11.StatesController.OwnWalkState = true
                    v11.StatesController.SpeedBoost = 5
            
                    task.delay(2, function()
                        v11.StatesController.States.Ability = false
                        v11.StatesController.OwnWalkState = false
                        v11.StatesController.SpeedBoost = 0
                    end)
            
                    v11.Animations:StopAnims()
                    v11.Animations.Abilities.HeelPass.Priority = Enum.AnimationPriority.Action3
                    v11.Animations.Abilities.HeelPass:Play()
                    v11.Animations.Ball.HeelPass.Priority = Enum.AnimationPriority.Action3
                    v11.Animations.Ball.HeelPass:Play()
                    v11.AbilityService.Ability:Fire("HeelPass")
                    v11.ABC:Connect(v11.AbilityService.Ability, function(v14)
                        v11.ABC:Clean()
                        v11.StatesController.States.Ability = false
                        v11.StatesController.OwnWalkState = false
                        v11.StatesController.SpeedBoost = 0
                        v14.AssemblyLinearVelocity = (v13.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 0.55, 0)) * 80
                        v11.BallController:DragBall(v14)
                    end)
                else
                    -- ส่วนสำหรับเมื่อผู้เล่นไม่มีบอล
                    v11.AbilityController:AbilityCooldown("1", 1) -- ไม่มีคูลดาวน์
                    v11.StaminaService.DecreaseStamina:Fire(10) -- ไม่ลด Stamina
                    v11.Animations:StopAnims()
                    v11.Animations.Abilities.Steal.Priority = Enum.AnimationPriority.Action
                    v11.Animations.Abilities.Steal:Play()
            
                    -- เรียกใช้ RemoteEvent "Slide" เพื่อ FireServer
                    game:GetService("ReplicatedStorage").Packages.Knit.Services.BallService.RE.Slide:FireServer()
                    print("Slide RemoteEvent has been fired!")
            
                    -- ใช้ TweenService แทนการพุ่งด้วย BodyVelocity
                    local rootPart = v13.HumanoidRootPart
                    if rootPart then
                        local targetPosition = rootPart.Position + (rootPart.CFrame.LookVector * 30) -- พุ่งไปข้างหน้า 10 หน่วย
            
                        local tweenInfo = TweenInfo.new(
                            0.4, -- ระยะเวลาพุ่ง (0.5 วินาที)
                            Enum.EasingStyle.Linear, -- รูปแบบการเคลื่อนไหวแบบ Linear
                            Enum.EasingDirection.Out, -- ทิศทางการเคลื่อนไหวแบบ Out
                            0, -- จำนวนรอบ (0 = ไม่ทำซ้ำ)
                            false, -- ไม่ย้อนกลับ
                            0 -- ไม่มีดีเลย์ก่อนเริ่ม Tween
                        )
            
                        local tweenGoal = {Position = targetPosition}
                        local tween = TweenService:Create(rootPart, tweenInfo, tweenGoal)
            
                        tween:Play()
                        print("Tween started. Moving to:", targetPosition)
            
                        tween.Completed:Connect(function()
                            print("Tween completed. Reached:", targetPosition)
                            tween:Destroy() -- ลบ Tween หลังการใช้งาน
                        end)
                    end
                end
            end
            
            -- แทนที่ฟังก์ชันใน ModuleScript
            hookfunction(originalSteal, newSteal)
            Fluent:Notify({ Title = "No Cooldown - Steal Enabled", Content = "Cooldown removed for Steal.", Duration = 3 })
        else
            Fluent:Notify({ Title = "No Cooldown - Steal Disabled", Content = "Cooldown restored for Steal.", Duration = 3 })
        end
    end
})

-- Toggle for AirDribble Function Override
Tabs.Kaitan:AddToggle("NoCooldownAirDribble", {
    Title = "No Cooldown - AirDribble",
    Default = false,
    Callback = function(state)
        if state then
            local airdribbleModule = require(game:GetService("ReplicatedStorage").Controllers.AbilityController.Abilities.Nagi.AirDribble)

            -- Hook the original AirDribble function
            local originalAirDribble = airdribbleModule
            
            -- Define the new function
            local function newAirDribble(v13, v14, v15)
                if v13.__trapped then
                    if not v15.Values.HasBall.Value then
                        return
                    else
                        v14.PlayerGui.InGameUI.Bottom.Abilities["1"].Timer.Text = "Trap"
                        v13.Animations:StopAnims()
                        v13.Animations.Abilities.AirDribbleShoot.Priority = Enum.AnimationPriority.Action4
                        v13.Animations.Abilities.AirDribbleShoot:Play()
                        v13.Animations.Ball.AirDribbleShoot.Priority = Enum.AnimationPriority.Action4
                        v13.Animations.Ball.AirDribbleShoot:Play()
                        if v13.ABC then
                            v13.ABC:Clean()
                        end
                        v13.ABC:Add(function()
                            v13.__trapped = nil
                        end)
                        task.delay(0.35, function()
                            v13.AbilityService.Ability:Fire("AirDribble", "shotStart")
                        end)
                        v13.ABC:Add(v13.AbilityService.Ability:Connect(function(v16)
                            v16.AssemblyLinearVelocity = (workspace.CurrentCamera.CFrame.LookVector + Vector3.new(0, 0.35, 0)) * 125
                            v13.BallController:DragBall(v16)
                        end))
                        return
                    end
                else
                    if v13.ABC then
                        v13.ABC:Clean()
                    end
                    v14.PlayerGui.InGameUI.Bottom.Abilities["1"].Timer.Text = "Shoot"
                    task.delay(0.45, function()
                        v13.InAbility = true
                    end)
                    local l_Value_0 = v15.Values.HasBall.Value
                    v15.HumanoidRootPart.Anchored = true
                    v13.AbilityService.Ability:Fire("AirDribble")
                    v13.Animations:StopAnims()
                    if l_Value_0 then
                        v13.Animations.Abilities.AirDribbleUp.Priority = Enum.AnimationPriority.Action2
                        v13.Animations.Abilities.AirDribbleUp:Play()
                        v13.Animations.Ball.AirDribbleUp.Priority = Enum.AnimationPriority.Action2
                        v13.Animations.Ball.AirDribbleUp:Play()
                        v13.Animations.Abilities.AirDribbleUp:AdjustSpeed(1.35)
                        v13.Animations.Ball.AirDribbleUp:AdjustSpeed(1.35)
                    end
                    v13.Animations.Ball.AirDribbleStart.Priority = Enum.AnimationPriority.Action3
                    v13.Animations.Ball.AirDribbleStart:Play()
                    v13.Animations.Ball.AirDribbleStart:AdjustSpeed(1.35)
                    v13.Animations.Abilities.AirDribbleStart.Priority = Enum.AnimationPriority.Action3
                    v13.Animations.Abilities.AirDribbleStart:Play()
                    v13.__trapped = true
                    v13.ABC:Add(function()
                        v13.__trapped = nil
                    end)
                    local v18 = os.time() + 4
                    task.delay(0.65, function()
                        v13.ABC:Connect(game:GetService("RunService").Heartbeat, function()
                            if v15 == nil then
                                if v13.ABC then
                                    v13.ABC:Clean()
                                end
                                v13.InAbility = false
                                return
                            else
                                if v15.Values.HasBall.Value then
                                    l_Value_0 = true
                                end
                                if (v18 < os.time() or not v13.InAbility or not v15.Values.HasBall.Value and l_Value_0) and v13.ABC then
                                    v13.ABC:Clean()
                                end
                                return
                            end
                        end)
                    end)
                    v13.ABC:Add(function()
                        v14.PlayerGui.InGameUI.Bottom.Abilities["1"].Timer.Text = "Trap"
                        task.delay(0.15, function()
                            v15.HumanoidRootPart.Anchored = false
                        end)
                        v13.InAbility = false
                        v13.Animations.Abilities.AirDribbleStart:Stop()
                        v13.Animations.Ball.AirDribbleStart:Stop()
                    end)
                    return
                end
            end
            
            -- Hook the function using hookfunction
            hookfunction(originalAirDribble, newAirDribble)
            Fluent:Notify({ Title = "No Cooldown - AirDribble Enabled", Content = "Cooldown removed for AirDribble.", Duration = 3 })
        else
            Fluent:Notify({ Title = "No Cooldown - AirDribble Disabled", Content = "Cooldown restored for AirDribble.", Duration = 3 })
        end
    end
})

-- Toggle for AirDash Function Override
Tabs.Kaitan:AddToggle("NoCooldownAirDash", {
    Title = "No Cooldown - AirDash",
    Default = false,
    Callback = function(state)
        if state then
            local originalAirDash = require(game:GetService("ReplicatedStorage").Controllers.AbilityController.Abilities.Nagi.AirDash)

            local function newAirDash(v13, v14, v15)
                if v13.ABC then
                    v13.ABC:Clean()
                end
            
                -- Un-anchor the player's HumanoidRootPart
                v15.HumanoidRootPart.Anchored = false
            
                -- Stop animations
                v13.Animations:StopAnims()
            
                -- Determine dash direction
                local dashDirection = "Right"
                if v15.HumanoidRootPart.CFrame:VectorToObjectSpace(v15.Humanoid.MoveDirection).X < 0 then
                    dashDirection = "Left"
                end
                local directionVector = dashDirection == "Right" and v15.HumanoidRootPart.CFrame.RightVector or -v15.HumanoidRootPart.CFrame.RightVector
            
                -- Adjust position instantly
                local dashDistance = 15 -- Dash distance
                v15.HumanoidRootPart.CFrame = v15.HumanoidRootPart.CFrame + (directionVector * dashDistance)
            
                -- Trigger ability and animations
                v13.AbilityService.Ability:Fire("AirDash", directionVector)
                v13.Animations.Abilities["AirDribble" .. dashDirection].Priority = Enum.AnimationPriority.Action4
                v13.Animations.Abilities["AirDribble" .. dashDirection]:Play()
                v13.Animations.Ball["AirDribble" .. dashDirection].Priority = Enum.AnimationPriority.Action4
                v13.Animations.Ball["AirDribble" .. dashDirection]:Play()
            end
            
            -- Hook the original AirDash function

            hookfunction(originalAirDash, newAirDash)
            Fluent:Notify({ Title = "No Cooldown - AirDash Enabled", Content = "Cooldown removed for AirDash.", Duration = 3 })
        else
            Fluent:Notify({ Title = "No Cooldown - AirDash Disabled", Content = "Cooldown restored for AirDash.", Duration = 3 })
        end
    end
})

    local MiscTitle = Tabs.Kaitan:AddSection("Misc")

    local InfiniteStaminaEnabled = false

    Tabs.Kaitan:AddButton({
        Title = "Infinite Stamina",
        Description = "Click to enable Infinite Stamina (cannot be disabled)",
        Callback = function()
            if not InfiniteStaminaEnabled then
                InfiniteStaminaEnabled = true
                Fluent:Notify({
                    Title = "Infinite Stamina",
                    Content = "Enabled",
                    Duration = 3
                })
            else
                Fluent:Notify({
                    Title = "Infinite Stamina",
                    Content = "Already Enabled",
                    Duration = 3
                })
            end
        end
    })


    task.spawn(function()
        while task.wait(0.1) do
            if InfiniteStaminaEnabled then
                pcall(function()
                    local plr = game.Players.LocalPlayer
                    local stats = plr:FindFirstChild("PlayerStats")
                    if stats then
                        local stamina = stats:FindFirstChild("Stamina")
                        if stamina then
                            stamina:Destroy()
                            local fakeStamina = Instance.new("NumberValue")
                            fakeStamina.Name = "Stamina"
                            fakeStamina.Value = math.huge
                            fakeStamina.Parent = stats
                        end
                    end
                end)
            end
        end
    end)


Fluent:Notify({
    Title = "Private",
    Content = "Script By Praerin :>",
    Duration = 8
})

Window:SelectTab(1)
