--===[ SERVICES & DEPENDENCIES ]===
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/TheG450/ThisHubNotPublicEnoughForUs/refs/heads/main/UpsideRemakeBeta_UI.lua"))()
local rs = game:GetService("RunService")
local cs = game:GetService("CollectionService")
local w = game:GetService("Workspace")
local plrs = game:GetService("Players")
local lp = plrs.LocalPlayer
local character = lp.Character or lp.CharacterAdded:Wait()
local humanoidrootpart = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart", 9e99)
local rep = game:GetService("ReplicatedStorage")

lp.CharacterAdded:Connect(function(newCharacter)
	character = newCharacter
	humanoidrootpart = newCharacter:FindFirstChild("HumanoidRootPart") or newCharacter:WaitForChild("HumanoidRootPart", 9e99)
end)

--===[ GLOBAL SETTINGS ]===
getgenv().Settings = getgenv().Settings or {
	--[[ LEGIT ]]----------
	HitboxToggle = false,
	HitboxSize = 10,
	HitboxKeybind = "",
	SpeedToggle = false,
	SpeedValue = 30,
	BallESP = false,
	AutoDribble = false,
	SilentAim = false,
	--[[ AUTOMATIC ]]----------
	AutoFarmToggle = false,
	--[[ SPINS ]]----------
	SelectedStyles = {},
	StyleSpinToggle = false,
}

function SaveSetting() end

--===[ VARIABLES ]===
local hitboxPart, espPart = nil, nil
local ui, tab, AutomaticTab, SpinTab
local Toggles, Sliders, Inputs, Dropdown = {}, {}, {}, {}

--===[ FUNCTIONS ]===

local function GetBall()
	for _, obj in ipairs(w:GetDescendants()) do
		if obj:IsA("BasePart") and obj.Name == "Ball" then
			return obj
		end
	end
	return nil
end

local function DestroyHitbox()
	if hitboxPart then
		hitboxPart:Destroy()
		hitboxPart = nil
	end
	rs:UnbindFromRenderStep("HitboxFollow")
end

local function AutoAttachHitbox()
	rs:BindToRenderStep("HitboxFollow", 1000, function()
		local b = GetBall()
		if not b then return DestroyHitbox() end
		if not hitboxPart then
			hitboxPart = Instance.new("Part")
			hitboxPart.Anchored = true
			hitboxPart.CanCollide = false
			hitboxPart.Transparency = 0.5
			hitboxPart.Material = Enum.Material.ForceField
			hitboxPart.Shape = Enum.PartType.Ball
			local size = getgenv().Settings.HitboxSize
			hitboxPart.Size = Vector3.new(size, size, size)
			hitboxPart.Parent = b
		end
		hitboxPart.Position = b.Position
	end)
end

local function DestroyESP()
	if espPart then
		espPart:Destroy()
		espPart = nil
	end
	rs:UnbindFromRenderStep("BallESP")
end

local function CreateBallESP()
	rs:BindToRenderStep("BallESP", 1000, function()
		local b = GetBall()
		if not b then return DestroyESP() end
		if not espPart then
			espPart = Instance.new("BoxHandleAdornment")
			espPart.Size = b.Size + Vector3.new(0.5, 0.5, 0.5)
			espPart.Adornee = b
			espPart.AlwaysOnTop = true
			espPart.ZIndex = 5
			espPart.Color3 = Color3.fromRGB(255, 255, 0)
			espPart.Transparency = 0.25
			espPart.Parent = b
		end
	end)
end

local function ApplySpeed()
	local c = lp.Character
	if c then
		local h = c:FindFirstChildOfClass("Humanoid")
		if h then
			h.WalkSpeed = getgenv().Settings.SpeedToggle and getgenv().Settings.SpeedValue or 24
		end
	end
end

local function AutoDribbleLoop()
	rs.Heartbeat:Connect(function()
		if not getgenv().Settings.AutoDribble then return end
		local chr = lp.Character
		if not chr or not chr:FindFirstChild("HumanoidRootPart") then return end
		local hrp = chr.HumanoidRootPart

		for _, v in pairs(plrs:GetPlayers()) do
			if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") then
				local hrp2 = v.Character.HumanoidRootPart
				local h = v.Character.Humanoid
				local dist = (hrp.Position - hrp2.Position).Magnitude

				if dist <= 15 then
					local cm = hrp2.AssemblyCenterOfMass
					local rot = hrp2.Rotation
					local ws = h.WalkSpeed
					task.wait()
					if cm ~= hrp2.AssemblyCenterOfMass or rot ~= hrp2.Rotation or ws ~= h.WalkSpeed then
						local bs = rep:WaitForChild("Packages"):WaitForChild("Knit")
							:WaitForChild("Services"):WaitForChild("BallService"):WaitForChild("RE"):WaitForChild("Dribble")
						bs:FireServer(true)
					end
				end
			end
		end
	end)
end

local function GetGoal()
	local hoops = w:FindFirstChild("Hoops")
	if not hoops or not lp.Team then return nil end
	local side = hoops:FindFirstChild(lp.Team.Name)
	return side and side:FindFirstChild("Goal") or nil
end

local function calcSilentAimVel(p0, p1)
	local g = w.Gravity
	local dy = p1.Y - p0.Y
	local dXZ = Vector3.new(p1.X - p0.X, 0, p1.Z - p0.Z)
	local dist = dXZ.Magnitude
	local t = math.clamp(dist / 60, 0.6, 2.5)
	local vxz = dist / t
	local vy = (dy + 0.5 * g * t^2) / t
	local dir = dXZ.Unit
	return Vector3.new(dir.X * vxz, vy, dir.Z * vxz)
end

local function SilentAim(b)
	if not getgenv().Settings.SilentAim then return end
	local g = GetGoal()
	if not g then return end
	b.Velocity = calcSilentAimVel(b.Position, g.Position)
end

local function GetGoalAutoFarm()
    local MyTeam = lp.Team.Name
    local Goal
    if MyTeam ~= "Visitor" then
        if MyTeam == "Home" then
            Goal = CFrame.new(-146.530258, 14.5496578, -297.506836, -1, 0, 0, 0, 1, 0, 0, 0, -1)
        elseif MyTeam == "Away" then
            Goal = CFrame.new(146.469742, 14.6981649, -297.506836, -1, 0, 0, 0, 1, 0, 0, 0, -1)
        end
        return Goal
    end
    return nil
end

local StyleList = {}
local function GetStyleList()
    local Assets = rep:FindFirstChild("Assets")
    if Assets then
        local StyleAnimations = Assets:FindFirstChild("StyleAnimations")
        if StyleAnimations then
            for _, v in ipairs(StyleAnimations:GetChildren()) do
                if v:IsA("Folder") then
                    table.insert(StyleList, v.Name)
                end
            end
        end
    end
end
GetStyleList()

w.ChildAdded:Connect(function(c)
	if c:IsA("BasePart") and c.Name == "Basketball" then
		task.wait()
		SilentAim(c)
	end
end)

--===[ UI SETUP ]===
ui = Fluent:CreateWindow({
	Title = "Fearise Hub",
	SubTitle = "Framework 😼",
	TabWidth = 160,
	Size = UDim2.fromOffset(500, 350),
	Acrylic = false,
	Theme = "FeariseHub",
	MinimizeKey = Enum.KeyCode.RightControl
})

tab = ui:AddTab({ Title = "Legit", Icon = "align-justify" })
AutomaticTab = ui:AddTab({ Title = "Automatic", Icon = "crown" })
SpinTab = ui:AddTab({ Title = "Spins", Icon = "box" })

--===[ UI ELEMENTS ]===

--[[ LEGITS ]]-------------------------------------------------------
tab:AddSection("Hitbox")

Toggles.Hitbox = tab:AddToggle("HitboxToggle", {
	Title = "Enable Hitbox",
	Default = getgenv().Settings.HitboxToggle
})

Inputs.HitboxSize = tab:AddInput("HitboxSize", {
	Title = "Hitbox Size",
	Default = getgenv().Settings.HitboxSize,
	Placeholder = "1-30",
	Numeric = true,
	Finished = false,
	Callback = function(v)
		local val = tonumber(v)
		getgenv().Settings.HitboxSize = val
		if hitboxPart then hitboxPart.Size = Vector3.new(val, val, val) end
		SaveSetting()
	end
})

Inputs.HitboxSize:OnChanged(function(v)
	local val = tonumber(v)
	getgenv().Settings.HitboxSize = val
	if hitboxPart then hitboxPart.Size = Vector3.new(val, val, val) end
	SaveSetting()
end)

tab:AddKeybind("HitboxKeybind", {
	Title = "Toggle Hitbox Keybind",
	Mode = "Toggle",
	Default = "",
	Callback = function()
		local state = not Toggles.Hitbox.Value
		Toggles.Hitbox:SetValue(state)
	end,
	ChangedCallback = function(k)
		getgenv().Settings.HitboxKeybind = k
		SaveSetting()
	end
})

tab:AddSection("Movement")

Toggles.Speed = tab:AddToggle("SpeedToggle", {
	Title = "Enable Speed",
	Default = getgenv().Settings.SpeedToggle
})

Sliders.Speed = tab:AddSlider("SpeedSlider", {
	Title = "WalkSpeed",
	Default = getgenv().Settings.SpeedValue,
	Min = 16,
	Max = 100,
	Rounding = 0,
	Callback = function(v)
		getgenv().Settings.SpeedValue = v
		SaveSetting()
	end
})

tab:AddSection("Extras")

Toggles.ESP = tab:AddToggle("BallESP", {
	Title = "Ball ESP",
	Default = getgenv().Settings.BallESP
})

Toggles.Dribble = tab:AddToggle("AutoDribble", {
	Title = "Auto Dribble",
	Default = getgenv().Settings.AutoDribble
})

Toggles.SilentAim = tab:AddToggle("SilentAim", {
	Title = "Silent Aim",
	Default = getgenv().Settings.SilentAim
})

--[[ AUTOMATIC ]]-------------------------------------------------------
AutomaticTab:AddSection("AutoFarm")
Toggles.AutoFarm = AutomaticTab:AddToggle("AutoFarmToggle", {
	Title = "Enable AutoFarm",
	Default = getgenv().Settings.AutoFarmToggle
})

--[[ SPINS ]]-------------------------------------------------------
SpinTab:AddSection("Styles Spin")
Dropdown.StyleSpin = SpinTab:AddDropdown("StylesDropdown", {
	Title = "Styles List",
	Values = StyleList,
	Multi = true,
	Default = getgenv().Settings.SelectedStyles or {},
})
Dropdown.StyleSpin:OnChanged(function(Value)
	local Values = {}
	for Value, State in next, Value do
		table.insert(Values, Value)
	end
	getgenv().Settings.SelectedStyles = Values
end)
Toggles.StyleSpinToggle = SpinTab:AddToggle("StyleSpinToggle", {
	Title = "Enable Style Spin",
	Default = getgenv().Settings.StyleSpinToggle
})

--===[ TOGGLE HANDLERS ]===

Toggles.Hitbox:OnChanged(function()
	task.spawn(function()
		getgenv().Settings.HitboxToggle = Toggles.Hitbox.Value
		SaveSetting()
		if Toggles.Hitbox.Value then AutoAttachHitbox() else DestroyHitbox() end
	end)
end)

Toggles.Speed:OnChanged(function()
	getgenv().Settings.SpeedToggle = Toggles.Speed.Value
	SaveSetting()
end)

Toggles.ESP:OnChanged(function()
	getgenv().Settings.BallESP = Toggles.ESP.Value
	SaveSetting()
	if Toggles.ESP.Value then CreateBallESP() else DestroyESP() end
end)

Toggles.Dribble:OnChanged(function()
	getgenv().Settings.AutoDribble = Toggles.Dribble.Value
	SaveSetting()
end)

Toggles.SilentAim:OnChanged(function()
	getgenv().Settings.SilentAim = Toggles.SilentAim.Value
	SaveSetting()
end)

Toggles.AutoFarm:OnChanged(function()
	task.spawn(function()
		getgenv().Settings.AutoFarmToggle = Toggles.AutoFarm.Value
		SaveSetting()
	end)
end)

Toggles.StyleSpinToggle:OnChanged(function()
	task.spawn(function()
		getgenv().Settings.StyleSpinToggle = Toggles.StyleSpinToggle.Value
		SaveSetting()
		while getgenv().Settings.StyleSpinToggle do
			task.wait()
			if next(getgenv().Settings.SelectedStyles) == nil then
				Toggles.StyleSpinToggle:SetValue(false)
				Fluent:Notify({
					Title = "Fearise Hub",
					Content = "No styles selected. Stopping spin.",
					Duration = 5
				})
				break
			end
			local MyStyle = lp:FindFirstChild("Style")
			if MyStyle then
				for _, v in pairs(getgenv().Settings.SelectedStyles) do
					if type(v) == "table" and not table.find(v, MyStyle.Value) then
						game:GetService("ReplicatedStorage").Packages.Knit.Services.StyleService.RE.Spin:FireServer()
						task.wait(0.1)
					else
						task.wait(0.1)
						Toggles.StyleSpinToggle:SetValue(false)
						Fluent:Notify({
							Title = "Fearise Hub",
							Content = "You got Style: " .. MyStyle.Value,
							Duration = 5
						})
						break
					end
				end
			end
		end		
	end)
end)

--===[ MAIN LOOP ]===
rs.RenderStepped:Connect(ApplySpeed)
rs.Heartbeat:Connect(function()
    if getgenv().Settings.AutoFarmToggle and lp.Team.Name ~= "Visitor" then
        for _, obj in pairs(cs:GetTagged("Basketball")) do
            if obj.Parent == workspace and obj.Name == "Basketball" then
                local Values = obj:FindFirstChild("Values")
                if Values then
                    local Char = Values:FindFirstChild("Char")
                    if Char and Char.Value ~= character then
                        character.HumanoidRootPart.CFrame = obj.CFrame
                    elseif Char and Char.Value == character then
                        local Goal = GetGoalAutoFarm()
						if Goal then
							obj.CFrame = Goal
						end
                    end
                end
            elseif obj.Parent ~= workspace and obj.Parent ~= character and obj.Name == "Basketball" then
                local Values = obj:FindFirstChild("Values")
                if Values then
                    local Char = Values:FindFirstChild("Char")
                    if Char and Char.Value ~= character then
                        local Target = obj.Parent
                        local TargetHumanoidRootPart = Target:FindFirstChild("HumanoidRootPart")
                        if TargetHumanoidRootPart then
                            character.HumanoidRootPart.CFrame = TargetHumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                            local Distance = (humanoidrootpart.Position - obj.Position).Magnitude
                            if Distance <= 5 then
                                game:GetService("ReplicatedStorage").Packages.Knit.Services.BallService.RE.Steal:FireServer(TargetHumanoidRootPart.CFrame)
                            end
                        end
                    end
                end
            elseif obj.Parent ~= workspace and obj.Parent == character and obj.Name == "Basketball" then
                game:GetService("ReplicatedStorage").Packages.Knit.Services.BallService.RE.Throw:FireServer(nil, true)
                task.wait(.1)
                game:GetService("ReplicatedStorage").Packages.Knit.Services.BallService.RE.Throw:FireServer(Vector2.new(0,0))
            end
        end
    end
end)
AutoDribbleLoop()

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
ui:SelectTab(1)