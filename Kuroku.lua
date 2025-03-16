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
    Title = "Fearise Hub" .. " | " .. "Kuroku" .. " | " .. "[Version X]",
    SubTitle = "by Rowlet/Blobby",
    TabWidth = 160,
    Size = Device,
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Tabs = {
    Legit = Window:AddTab({ Title = "Legit", Icon = "align-justify" }),
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
--------------------------------------------------- Legit Tab ----------------------------------------------------
--------------------------------------------------- Legit Tab ----------------------------------------------------
--------------------------------------------------- Legit Tab ----------------------------------------------------
--------------------------------------------------- Legit Tab ----------------------------------------------------
--------------------------------------------------- Legit Tab ----------------------------------------------------
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local p = game:GetService("Players").LocalPlayer
local g = p:FindFirstChild("PlayerGui", true)
local s = g and g:FindFirstChild("ShootMeter", true)
local t = s and s:FindFirstChild("TweenVal", true)
local w = game:GetService("Workspace")
local teams = game:GetService("Teams")

local c = p.Character or p.CharacterAdded:Wait()
local hrp = c:WaitForChild("HumanoidRootPart")
local cam = w.CurrentCamera

local minHeight = 10
local maxHeight = 150
local maxDistance = 50
local heightMultiplier = 3

local holding = false
local enabled = false

local Toggle = Tabs.Legit:AddToggle("MyToggle", {Title = "Aimbot", Default = false})

Toggle:OnChanged(function(state)
    enabled = state
end)

local function findGoal()
    local map = w:FindFirstChild("Round", true) and w.Round:FindFirstChild("CurMap", true)
    if not map then return end
    local home, visitor
    for _, d in ipairs(map:GetDescendants()) do
        if d:IsA("Part") then
            if d.Name == "Home" then home = d end
            if d.Name == "Visitor" then visitor = d end
        end
    end
    return p.Team == teams:FindFirstChild("Home") and visitor or home
end

uis.InputBegan:Connect(function(i, gpe)
    if gpe or not enabled then return end
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        holding = true
    end
end)

uis.InputEnded:Connect(function(i, gpe)
    if gpe or not enabled then return end
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        holding = false
    end
end)

rs.RenderStepped:Connect(function()
    if not enabled then return end

    if holding and t and t.Value >= 0.85 then
        holding = false
        mouse1release()
    end

    if holding and hrp then
        local goal = findGoal()
        if goal then
            local lookAt = CFrame.lookAt(hrp.Position, Vector3.new(goal.Position.X, hrp.Position.Y, goal.Position.Z))
            hrp.CFrame = hrp.CFrame:Lerp(lookAt, 0.2)

            local distance = (goal.Position - hrp.Position).Magnitude
            local heightFactor = 1 - math.clamp((distance / maxDistance) ^ heightMultiplier, 0, 1)
            local newCamY = minHeight + (maxHeight - minHeight) * heightFactor

            local camPos = Vector3.new(hrp.Position.X, hrp.Position.Y + newCamY, hrp.Position.Z)
            local camLook = CFrame.lookAt(camPos, Vector3.new(goal.Position.X, goal.Position.Y, goal.Position.Z))
            cam.CFrame = cam.CFrame:Lerp(camLook, 0.2)
        end
    end
end)

local HitboxTitle = Tabs.Legit:AddSection("Hitbox")

local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local p = game:GetService("Players").LocalPlayer
local c = p.Character or p.CharacterAdded:Wait()

local enabled = false
local hitboxSize = Vector3.new(5, 5, 5) -- Default hitbox size
local forceField = nil

-- Function to show/hide hitbox with ForceField
local function toggleHitbox(state)
    if not c then return end

    local hitbox = c:FindFirstChild("Hitbox")
    if not hitbox then return end

    if state then
        hitbox.Size = hitboxSize
        hitbox.Transparency = 0.7 -- Make hitbox slightly visible

        -- Create ForceField effect
        if not forceField then
            forceField = Instance.new("ForceField", hitbox)
            forceField.Visible = true
        end
    else
        hitbox.Size = Vector3.new(2, 2, 1) -- Reset to default
        hitbox.Transparency = 1 -- Fully invisible again

        if forceField then
            forceField:Destroy()
            forceField = nil
        end
    end
end

-- Toggle UI
local Toggle = Tabs.Legit:AddToggle("HitboxToggle", {Title = "Hitbox Toggle", Default = false})

Toggle:OnChanged(function(state)
    enabled = state
    toggleHitbox(enabled)
end)

-- Input for Hitbox Size
local Input = Tabs.Legit:AddInput("HitboxSize", {
    Title = "Hitbox Size",
    Default = "5",
    Placeholder = "Enter size",
    Numeric = true,
    Finished = true,
    Callback = function(Value)
        local num = tonumber(Value)
        if num then
            hitboxSize = Vector3.new(num, num, num)
            if enabled then
                toggleHitbox(true)
            end
        end
    end
})

-- Keybind to Toggle Hitbox
local Keybind = Tabs.Legit:AddKeybind("HitboxKeybind", {
    Title = "Toggle Keybind",
    Mode = "Toggle",
    Default = "H",
    Callback = function(Value)
        enabled = Value
        Toggle:SetValue(enabled) -- Update UI Toggle
        toggleHitbox(enabled)
    end,
    ChangedCallback = function(New)
        print("Keybind changed to:", New)
    end
})

-- Update Hitbox every frame
rs.RenderStepped:Connect(function()
    if enabled and c and c:FindFirstChild("Hitbox") then
        local hitbox = c:FindFirstChild("Hitbox")
        if hitbox then
            hitbox.Size = hitboxSize
            hitbox.Transparency = 0.7 -- Keep hitbox visible
        end
    end
end)

--------------------------------------------------- Setting Tab ----------------------------------------------------
--------------------------------------------------- Setting Tab ----------------------------------------------------
--------------------------------------------------- Setting Tab ----------------------------------------------------
--------------------------------------------------- Setting Tab ----------------------------------------------------
--------------------------------------------------- Setting Tab ----------------------------------------------------

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
SaveManager:SetFolder("Fearise Hub/Kuroko")

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
