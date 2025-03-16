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

local ToggleGui = Instance.new("ScreenGui")
local Toggle = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

local IsOpen = true

ToggleGui.Name = "ToggleGui"
ToggleGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui") -- Parent the GUI to the player's screen
ToggleGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ToggleGui.ResetOnSpawn = false

Toggle.Name = "Toggle"
Toggle.Parent = ToggleGui
Toggle.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
Toggle.Position = UDim2.new(0, 10, 0.8, 0)
Toggle.Size = UDim2.new(0, 100, 0, 40)
Toggle.Font = Enum.Font.SourceSansBold
Toggle.Text = "Close GUI"
Toggle.TextColor3 = Color3.fromRGB(203, 122, 49)
Toggle.TextSize = 20
Toggle.Draggable = true

UICorner.Parent = Toggle

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Fearise Hub" .. " | " .. "Haikyuu Legend" .. " | " .. "[Version 0.1]",
    SubTitle = "by Rowlet",
    TabWidth = 160,
    Size = Device,
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Tabs = {
    Legit = Window:AddTab({ Title = "Legit", Icon = "align-justify" }),
    Spin = Window:AddTab({ Title = "Spin", Icon = "box" }),
    OP = Window:AddTab({ Title = "OP", Icon = "apple"}),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

Toggle.MouseButton1Click:Connect(function()
    IsOpen = not IsOpen

    if Window then

        local gui = Window.Instance or game:GetService("CoreGui"):FindFirstChild("ScreenGui")
        if gui then
            gui.Enabled = IsOpen
        end
    end


    Toggle.Text = IsOpen and "Close GUI" or "Open GUI"
end)

task.spawn(function()
    while task.wait(1) do
        if Fluent.Unloaded then
            Toggle:Destroy()
            break
        end
    end
end)
----------------- Legit Tab ------------------
local Options = {}

local SpeedTitle = Tabs.Legit:AddSection("Player Modifiers")

local p = game:GetService("Players").LocalPlayer
local h
local WalkSpeed = 16
local WalkSpeedEnabled = false
local WalkSpeedConn

local function enforceWalkSpeed()
    if h and WalkSpeedEnabled then
        if WalkSpeedConn then
            WalkSpeedConn:Disconnect()
        end
        WalkSpeedConn = h:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
            if h.WalkSpeed ~= WalkSpeed then
                h.WalkSpeed = WalkSpeed
            end
        end)

        task.spawn(function()
            while WalkSpeedEnabled do
                task.wait(0.1)
                if h and h.WalkSpeed ~= WalkSpeed then
                    h.WalkSpeed = WalkSpeed
                end
            end
        end)
    end
end

local function onCharacterAdded(character)
    h = character:WaitForChild("Humanoid")
    if WalkSpeedEnabled then
        h.WalkSpeed = WalkSpeed
        enforceWalkSpeed()
    end
end

if p.Character then
    onCharacterAdded(p.Character)
end
p.CharacterAdded:Connect(onCharacterAdded)

local WalkSpeedToggle = Tabs.Legit:AddToggle("WalkSpeedToggle", {
    Title = "Toggle WalkSpeed",
    Default = false,
    Callback = function(state)
        WalkSpeedEnabled = state
        if state and h then
            h.WalkSpeed = WalkSpeed
            enforceWalkSpeed()
            Fluent:Notify({
                Title = "WalkSpeed",
                Content = "WalkSpeed enabled: " .. tostring(WalkSpeed),
                Duration = 3
            })
        elseif h then
            if WalkSpeedConn then
                WalkSpeedConn:Disconnect()
            end
            WalkSpeedEnabled = false
            h.WalkSpeed = 16
            Fluent:Notify({
                Title = "WalkSpeed",
                Content = "WalkSpeed reset to default.",
                Duration = 3
            })
        end
    end
})

local WalkSpeedSlider = Tabs.Legit:AddSlider("WalkSpeedSlider", {
    Title = "WalkSpeed Slider",
    Min = 16,   
    Max = 90,
    Default = WalkSpeed,
    Rounding = 1,
    Callback = function(value)
        WalkSpeed = value
        if WalkSpeedEnabled and h then
            h.WalkSpeed = WalkSpeed
        end
    end
})

local MiscTitle = Tabs.Legit:AddSection("Misc")

local p = game:GetService("Players").LocalPlayer
local h = p.Character and p.Character:FindFirstChildOfClass("Humanoid")
local toggleEnabled = true
local autoRotateState = true

local Toggle = Tabs.Legit:AddToggle("MyToggle", {
    Title = "Toggle AutoRotate",
    Default = false,
    Callback = function(Value)
        toggleEnabled = Value
        if toggleEnabled and h then
            h.AutoRotate = autoRotateState
        end
    end
})

if h then
    h.StateChanged:Connect(function(_, new)
        if new == Enum.HumanoidStateType.Jumping or new == Enum.HumanoidStateType.Freefall then
            task.wait(0.01)
            if h and toggleEnabled then
                h.AutoRotate = autoRotateState
            end
        end
    end)
end


local Hitboxed = Tabs.Legit:AddSection("Hitbox")

local rs = game:GetService("ReplicatedStorage")
local ts = game:GetService("TweenService")
local hitboxes = rs.Assets.Hitboxes

local BlockSlider = Tabs.Legit:AddSlider("Block_Slider", {
    Title = "Block Size",
    Description = "Adjusts the size of parts in Block",
    Default = 1,
    Min = 1,
    Max = 100,
    Rounding = 1,
    Callback = function(Value)
        local folder = hitboxes:FindFirstChild("Block")
        if folder then
            for _, part in ipairs(folder:GetChildren()) do
                if part:IsA("BasePart") then
                    ts:Create(part, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = part.Size * Value}):Play()
                end
            end
        end
    end
})
BlockSlider:SetValue(1)

local BumpSlider = Tabs.Legit:AddSlider("Bump_Slider", {
    Title = "Bump Size",
    Description = "Adjusts the size of parts in Bump",
    Default = 1,
    Min = 1,
    Max = 100,
    Rounding = 1,
    Callback = function(Value)
        local folder = hitboxes:FindFirstChild("Bump")
        if folder then
            for _, part in ipairs(folder:GetChildren()) do
                if part:IsA("BasePart") then
                    ts:Create(part, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = part.Size * Value}):Play()
                end
            end
        end
    end
})
BumpSlider:SetValue(1)

local BumpServeSlider = Tabs.Legit:AddSlider("BumpServe_Slider", {
    Title = "BumpServe Size",
    Description = "Adjusts the size of parts in BumpServe",
    Default = 1,
    Min = 1,
    Max = 100,
    Rounding = 1,
    Callback = function(Value)
        local folder = hitboxes:FindFirstChild("BumpServe")
        if folder then
            for _, part in ipairs(folder:GetChildren()) do
                if part:IsA("BasePart") then
                    ts:Create(part, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = part.Size * Value}):Play()
                end
            end
        end
    end
})
BumpServeSlider:SetValue(1)

local DiveSlider = Tabs.Legit:AddSlider("Dive_Slider", {
    Title = "Dive Size",
    Description = "Adjusts the size of parts in Dive",
    Default = 1,
    Min = 1,
    Max = 100,
    Rounding = 1,
    Callback = function(Value)
        local folder = hitboxes:FindFirstChild("Dive")
        if folder then
            for _, part in ipairs(folder:GetChildren()) do
                if part:IsA("BasePart") then
                    ts:Create(part, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = part.Size * Value}):Play()
                end
            end
        end
    end
})
DiveSlider:SetValue(1)

local JumpSetSlider = Tabs.Legit:AddSlider("JumpSet_Slider", {
    Title = "JumpSet Size",
    Description = "Adjusts the size of parts in JumpSet",
    Default = 1,
    Min = 1,
    Max = 100,
    Rounding = 1,
    Callback = function(Value)
        local folder = hitboxes:FindFirstChild("JumpSet")
        if folder then
            for _, part in ipairs(folder:GetChildren()) do
                if part:IsA("BasePart") then
                    ts:Create(part, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = part.Size * Value}):Play()
                end
            end
        end
    end
})
JumpSetSlider:SetValue(1)

local ServeSlider = Tabs.Legit:AddSlider("Serve_Slider", {
    Title = "Serve Size",
    Description = "Adjusts the size of parts in Serve",
    Default = 1,
    Min = 1,
    Max = 100,
    Rounding = 1,
    Callback = function(Value)
        local folder = hitboxes:FindFirstChild("Serve")
        if folder then
            for _, part in ipairs(folder:GetChildren()) do
                if part:IsA("BasePart") then
                    ts:Create(part, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = part.Size * Value}):Play()
                end
            end
        end
    end
})
ServeSlider:SetValue(1)

local SetSlider = Tabs.Legit:AddSlider("Set_Slider", {
    Title = "Set Size",
    Description = "Adjusts the size of parts in Set",
    Default = 1,
    Min = 1,
    Max = 100,
    Rounding = 1,
    Callback = function(Value)
        local folder = hitboxes:FindFirstChild("Set")
        if folder then
            for _, part in ipairs(folder:GetChildren()) do
                if part:IsA("BasePart") then
                    ts:Create(part, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = part.Size * Value}):Play()
                end
            end
        end
    end
})
SetSlider:SetValue(1)

local SpikeSlider = Tabs.Legit:AddSlider("Spike_Slider", {
    Title = "Spike Size",
    Description = "Adjusts the size of parts in Spike",
    Default = 1,
    Min = 1,
    Max = 100,
    Rounding = 1,
    Callback = function(Value)
        local folder = hitboxes:FindFirstChild("Spike")
        if folder then
            for _, part in ipairs(folder:GetChildren()) do
                if part:IsA("BasePart") then
                    ts:Create(part, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = part.Size * Value}):Play()
                end
            end
        end
    end
})
SpikeSlider:SetValue(1)

local SteelBlockSlider = Tabs.Legit:AddSlider("SteelBlock_Slider", {
    Title = "SteelBlock Size",
    Description = "Adjusts the size of parts in SteelBlock",
    Default = 1,
    Min = 1,
    Max = 100,
    Rounding = 1,
    Callback = function(Value)
        local folder = hitboxes:FindFirstChild("SteelBlock")
        if folder then
            for _, part in ipairs(folder:GetChildren()) do
                if part:IsA("BasePart") then
                    ts:Create(part, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = part.Size * Value}):Play()
                end
            end
        end
    end
})
SteelBlockSlider:SetValue(1)

------------------ Spin Tabs -------------------
local p = game:GetService("Players").LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local r = rs.Packages._Index["sleitnick_knit@1.7.0"].knit.Services.StylesService.RF.Roll

local spinning = false
local lockedStyles = {}

local Toggle = Tabs.Spin:AddToggle("AutoSpin", {Title = "Auto Spin", Default = false})

local MultiDropdown = Tabs.Spin:AddDropdown("StyleDropdown", {
    Title = "Lock Styles",
    Description = "Select multiple styles to lock.",
    Values = {
        "Sanu", "Oigawa", "Bokuto", "Azamena", "Kosumi", "Kagayomo", "Uchishima", "Iwaezeni",
        "Yomomute", "Sagafura", "Yabu", "Kuzee", "Haibo", "Tsuzichiwa",
        "Hinoto", "Tonoko", "Yamegushi", "Iwaezeni", "Ojiri", "Saguwuru", "Kito", "Nichinoya"
    },
    Multi = true,
    Default = {}
})

local function notify(title, content, duration)
    Fluent:Notify({
        Title = title,
        Content = content,
        Duration = duration or 5
    })
end

local function formatStyleName(str)
    return str:sub(1,1):upper() .. str:sub(2):lower()
end

local function getCurrentStyle()
    local char = p.Character
    if not char then return nil end
    local jb = char:FindFirstChild("JerseyBack")
    if not jb then return nil end
    local styleName = jb:FindFirstChild("StyleName")
    if styleName and styleName:IsA("TextLabel") then
        local formattedText = formatStyleName(styleName.Text:gsub("<[^>]->", ""))
        print("Current Style:", formattedText) -- Debug log
        return formattedText
    end
    return nil
end

Toggle:OnChanged(function(Value)
    spinning = Value
    if spinning then
        if #lockedStyles == 0 then
            notify("Error", "กรุณาเลือก Style ก่อนเปิด Auto Spin!", 3)
            Toggle:SetValue(false)
            return
        end
        notify("Auto Spin", "เริ่มหมุนหา: " .. table.concat(lockedStyles, ", "), 3)
        task.spawn(function()
            while spinning do
                local currentStyle = getCurrentStyle()
                if currentStyle and table.find(lockedStyles, currentStyle) then
                    notify("Style Locked!", "เจอแล้ว: " .. currentStyle, 5)
                    spinning = false
                    Toggle:SetValue(false)
                    break
                end
                r:InvokeServer(false)
                task.wait(0.5)
            end
        end)
    else
        notify("Auto Spin", "ปิดการทำงาน", 3)
    end
end)

MultiDropdown:OnChanged(function(Value)
    lockedStyles = {}
    for style, state in pairs(Value) do
        if state then
            table.insert(lockedStyles, style)
        end
    end
    notify("Style Changed", #lockedStyles > 0 and "เลือก: " .. table.concat(lockedStyles, ", ") or "กรุณาเลือก Style อย่างน้อย 1 รายการ!", 3)
end)

Tabs.OP:AddButton({
    Title = "Start Reward Loop (Risky)",
    Description = "หากเงินเยอะเกินเงินจะลดนะครับ",
    Callback = function()
        local running = true
        local btn

        btn = Window:Dialog({
            Title = "Confirmation",
            Content = "Click confirm to start or cancel to stop.",
            Buttons = {
                {
                    Title = "Confirm",
                    Callback = function()
                        while running do
                            task.wait()
                            game:GetService("ReplicatedStorage").Packages._Index["sleitnick_knit@1.7.0"].knit.Services.RewardService.RF.RequestPlayWithDeveloperAward:InvokeServer()
                        end
                    end
                },
                {
                    Title = "Cancel",
                    Callback = function()
                        running = false
                        print("Stopped the reward loop.")
                    end
                }
            }
        })
    end
})


-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- InterfaceManager (Allows you to have a interface managment system)

-- Hand the library over to our managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManager:SetFolder("Fearise Hub interface")
SaveManager:SetFolder("Fearise Hub/Haikyuu")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)

Fluent:Notify({
    Title = "Fearise Hub",
    Content = "The script has been loaded.",
    Duration = 8
})

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()
