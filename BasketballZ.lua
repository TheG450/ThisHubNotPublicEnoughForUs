--===[ SERVICES & DEPENDENCIES ]===
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/TheG450/ThisHubNotPublicEnoughForUs/refs/heads/main/UpsideRemakeBeta_UI.lua"))()
local rs = game:GetService("RunService")
local w = game:GetService("Workspace")
local plrs = game:GetService("Players")
local lp = plrs.LocalPlayer
local rep = game:GetService("ReplicatedStorage")

--===[ GLOBAL SETTINGS ]===
getgenv().Settings = getgenv().Settings or {
	HitboxToggle = false,
	HitboxSize = 10,
	HitboxKeybind = "",
	SpeedToggle = false,
	SpeedValue = 30,
	BallESP = false,
	AutoDribble = false,
	SilentAim = false
}

function SaveSetting() end

--===[ VARIABLES ]===
local hitboxPart, espPart = nil, nil
local ui, tab
local Toggles, Sliders, Inputs = {}, {}, {}

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

tab = ui:AddTab({ Title = "Legit", Icon = "⚙️" })

--===[ UI ELEMENTS ]===

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

--===[ MAIN LOOP ]===
rs.RenderStepped:Connect(ApplySpeed)
AutoDribbleLoop()
