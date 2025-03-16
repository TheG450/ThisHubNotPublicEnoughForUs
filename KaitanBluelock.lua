local function CreateKaitanGui()
    local KaitanGui = Instance.new("ScreenGui")
    local BackgroundFrame = Instance.new("Frame")
    local FeariseHub = Instance.new("ImageLabel")
    local TextLabel = Instance.new("TextLabel")
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
    local TextLabel_2 = Instance.new("TextLabel")
    local UITextSizeConstraint_2 = Instance.new("UITextSizeConstraint")
    local InfoFrame = Instance.new("Frame")
    local StyleLabel = Instance.new("TextLabel")
    local UITextSizeConstraint_3 = Instance.new("UITextSizeConstraint")
    local StyleText = Instance.new("TextLabel")
    local UITextSizeConstraint_4 = Instance.new("UITextSizeConstraint")
    local MoneyLabel = Instance.new("TextLabel")
    local UITextSizeConstraint_5 = Instance.new("UITextSizeConstraint")
    local LevelLabel = Instance.new("TextLabel")
    local UITextSizeConstraint_6 = Instance.new("UITextSizeConstraint")
    local MoneyText = Instance.new("TextLabel")
    local UITextSizeConstraint_7 = Instance.new("UITextSizeConstraint")
    local LevelText = Instance.new("TextLabel")
    local UITextSizeConstraint_8 = Instance.new("UITextSizeConstraint")
    local PlayerLabel = Instance.new("TextLabel")
    local UITextSizeConstraint_9 = Instance.new("UITextSizeConstraint")
    local PlayerText = Instance.new("TextLabel")
    local UITextSizeConstraint_10 = Instance.new("UITextSizeConstraint")
    local TimeLabel = Instance.new("TextLabel")
    local UITextSizeConstraint_11 = Instance.new("UITextSizeConstraint")
    local TimeText = Instance.new("TextLabel")
    local UITextSizeConstraint_12 = Instance.new("UITextSizeConstraint")

    --Properties:

	local ParentUi
	if gethui then
		ParentUi = gethui(game:GetService("CoreGui"))
	else
		ParentUi = game:GetService("CoreGui")
	end

    KaitanGui.Name = "KaitanGui_FreariseHub"
    KaitanGui.Parent = ParentUi
    KaitanGui.DisplayOrder = 999999999
    KaitanGui.ResetOnSpawn = false
    KaitanGui.SafeAreaCompatibility = "None"
    KaitanGui.ScreenInsets = "None"

    BackgroundFrame.Name = "BackgroundFrame"
    BackgroundFrame.Parent = KaitanGui
    BackgroundFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    BackgroundFrame.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
    BackgroundFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    BackgroundFrame.BorderSizePixel = 0
    BackgroundFrame.Position = UDim2.new(0.499981791, 0, 0.499471098, 0)
    BackgroundFrame.Size = UDim2.new(1, 0, 1, 0)

    FeariseHub.Name = "FeariseHub"
    FeariseHub.Parent = BackgroundFrame
    FeariseHub.AnchorPoint = Vector2.new(0.5, 0.5)
    FeariseHub.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    FeariseHub.BackgroundTransparency = 1.000
    FeariseHub.BorderColor3 = Color3.fromRGB(0, 0, 0)
    FeariseHub.BorderSizePixel = 0
    FeariseHub.Position = UDim2.new(0.499730855, 0, 0.0977600515, 0)
    FeariseHub.Size = UDim2.new(0.090625003, 0, 0.161260426, 0)
    FeariseHub.Image = "rbxassetid://91079820393464"

    TextLabel.Parent = BackgroundFrame
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.BackgroundTransparency = 1.000
    TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.BorderSizePixel = 0
    TextLabel.Position = UDim2.new(0.499999911, 0, 0.223354965, 0)
    TextLabel.Size = UDim2.new(0.238541663, 0, 0.105653383, 0)
    TextLabel.Font = Enum.Font.FredokaOne
    TextLabel.Text = "BLUE LOCK RIVALS"
    TextLabel.TextColor3 = Color3.fromRGB(221, 221, 221)
    TextLabel.TextScaled = true
    TextLabel.TextSize = 14.000
    TextLabel.TextWrapped = true

    UITextSizeConstraint.Parent = TextLabel
    UITextSizeConstraint.MaxTextSize = 58

    TextLabel_2.Parent = BackgroundFrame
    TextLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
    TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel_2.BackgroundTransparency = 1.000
    TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel_2.BorderSizePixel = 0
    TextLabel_2.Position = UDim2.new(0.499999911, 0, 0.269694149, 0)
    TextLabel_2.Size = UDim2.new(0.122395836, 0, 0.0537534766, 0)
    TextLabel_2.Font = Enum.Font.FredokaOne
    TextLabel_2.Text = "KAITAN"
    TextLabel_2.TextColor3 = Color3.fromRGB(221, 221, 221)
    TextLabel_2.TextScaled = true
    TextLabel_2.TextSize = 14.000
    TextLabel_2.TextWrapped = true

    UITextSizeConstraint_2.Parent = TextLabel_2
    UITextSizeConstraint_2.MaxTextSize = 57

    InfoFrame.Name = "InfoFrame"
    InfoFrame.Parent = BackgroundFrame
    InfoFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    InfoFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    InfoFrame.BackgroundTransparency = 1.000
    InfoFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    InfoFrame.BorderSizePixel = 0
    InfoFrame.Position = UDim2.new(0.50000006, 0, 0.658590376, 0)
    InfoFrame.Size = UDim2.new(1, 0, 0.682113051, 0)

    StyleLabel.Name = "StyleLabel"
    StyleLabel.Parent = InfoFrame
    StyleLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    StyleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    StyleLabel.BackgroundTransparency = 1.000
    StyleLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    StyleLabel.BorderSizePixel = 0
    StyleLabel.Position = UDim2.new(0.499037862, 0, 0.364232928, 0)
    StyleLabel.Size = UDim2.new(0.119270831, 0, 0.0760869533, 0)
    StyleLabel.Font = Enum.Font.FredokaOne
    StyleLabel.Text = "STYLE"
    StyleLabel.TextColor3 = Color3.fromRGB(221, 221, 221)
    StyleLabel.TextScaled = true
    StyleLabel.TextSize = 14.000
    StyleLabel.TextWrapped = true

    UITextSizeConstraint_3.Parent = StyleLabel
    UITextSizeConstraint_3.MaxTextSize = 54

    StyleText.Name = "StyleText"
    StyleText.Parent = InfoFrame
    StyleText.AnchorPoint = Vector2.new(0.5, 0.5)
    StyleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    StyleText.BackgroundTransparency = 1.000
    StyleText.BorderColor3 = Color3.fromRGB(0, 0, 0)
    StyleText.BorderSizePixel = 0
    StyleText.Position = UDim2.new(0.499297678, 0, 0.44983077, 0)
    StyleText.Size = UDim2.new(0.23385416, 0, 0.0760869533, 0)
    StyleText.Font = Enum.Font.FredokaOne
    StyleText.Text = "???"
    StyleText.TextColor3 = Color3.fromRGB(221, 221, 221)
    StyleText.TextScaled = true
    StyleText.TextSize = 14.000
    StyleText.TextWrapped = true

    UITextSizeConstraint_4.Parent = StyleText
    UITextSizeConstraint_4.MaxTextSize = 54

    MoneyLabel.Name = "MoneyLabel"
    MoneyLabel.Parent = InfoFrame
    MoneyLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    MoneyLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MoneyLabel.BackgroundTransparency = 1.000
    MoneyLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    MoneyLabel.BorderSizePixel = 0
    MoneyLabel.Position = UDim2.new(0.19226703, 0, 0.364232928, 0)
    MoneyLabel.Size = UDim2.new(0.119270831, 0, 0.0760869533, 0)
    MoneyLabel.Font = Enum.Font.FredokaOne
    MoneyLabel.Text = "MONEY"
    MoneyLabel.TextColor3 = Color3.fromRGB(221, 221, 221)
    MoneyLabel.TextScaled = true
    MoneyLabel.TextSize = 14.000
    MoneyLabel.TextWrapped = true

    UITextSizeConstraint_5.Parent = MoneyLabel
    UITextSizeConstraint_5.MaxTextSize = 54

    LevelLabel.Name = "LevelLabel"
    LevelLabel.Parent = InfoFrame
    LevelLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    LevelLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    LevelLabel.BackgroundTransparency = 1.000
    LevelLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    LevelLabel.BorderSizePixel = 0
    LevelLabel.Position = UDim2.new(0.80841291, 0, 0.364232928, 0)
    LevelLabel.Size = UDim2.new(0.119270831, 0, 0.0760869533, 0)
    LevelLabel.Font = Enum.Font.FredokaOne
    LevelLabel.Text = "LEVEL"
    LevelLabel.TextColor3 = Color3.fromRGB(221, 221, 221)
    LevelLabel.TextScaled = true
    LevelLabel.TextSize = 14.000
    LevelLabel.TextWrapped = true

    UITextSizeConstraint_6.Parent = LevelLabel
    UITextSizeConstraint_6.MaxTextSize = 54

    MoneyText.Name = "MoneyText"
    MoneyText.Parent = InfoFrame
    MoneyText.AnchorPoint = Vector2.new(0.5, 0.5)
    MoneyText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MoneyText.BackgroundTransparency = 1.000
    MoneyText.BorderColor3 = Color3.fromRGB(0, 0, 0)
    MoneyText.BorderSizePixel = 0
    MoneyText.Position = UDim2.new(0.192006022, 0, 0.440319896, 0)
    MoneyText.Size = UDim2.new(0.23385416, 0, 0.0760869533, 0)
    MoneyText.Font = Enum.Font.FredokaOne
    MoneyText.Text = "???"
    MoneyText.TextColor3 = Color3.fromRGB(221, 221, 221)
    MoneyText.TextScaled = true
    MoneyText.TextSize = 14.000
    MoneyText.TextWrapped = true

    UITextSizeConstraint_7.Parent = MoneyText
    UITextSizeConstraint_7.MaxTextSize = 54

    LevelText.Name = "LevelText"
    LevelText.Parent = InfoFrame
    LevelText.AnchorPoint = Vector2.new(0.5, 0.5)
    LevelText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    LevelText.BackgroundTransparency = 1.000
    LevelText.BorderColor3 = Color3.fromRGB(0, 0, 0)
    LevelText.BorderSizePixel = 0
    LevelText.Position = UDim2.new(0.808151901, 0, 0.440319896, 0)
    LevelText.Size = UDim2.new(0.23385416, 0, 0.0760869533, 0)
    LevelText.Font = Enum.Font.FredokaOne
    LevelText.Text = "???"
    LevelText.TextColor3 = Color3.fromRGB(221, 221, 221)
    LevelText.TextScaled = true
    LevelText.TextSize = 14.000
    LevelText.TextWrapped = true

    UITextSizeConstraint_8.Parent = LevelText
    UITextSizeConstraint_8.MaxTextSize = 54

    PlayerLabel.Name = "PlayerLabel"
    PlayerLabel.Parent = InfoFrame
    PlayerLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    PlayerLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    PlayerLabel.BackgroundTransparency = 1.000
    PlayerLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    PlayerLabel.BorderSizePixel = 0
    PlayerLabel.Position = UDim2.new(0.497996211, 0, 0.095211193, 0)
    PlayerLabel.Size = UDim2.new(0.119270831, 0, 0.0760869533, 0)
    PlayerLabel.Font = Enum.Font.FredokaOne
    PlayerLabel.Text = "PLAYER"
    PlayerLabel.TextColor3 = Color3.fromRGB(221, 221, 221)
    PlayerLabel.TextScaled = true
    PlayerLabel.TextSize = 14.000
    PlayerLabel.TextWrapped = true

    UITextSizeConstraint_9.Parent = PlayerLabel
    UITextSizeConstraint_9.MaxTextSize = 54

    PlayerText.Name = "PlayerText"
    PlayerText.Parent = InfoFrame
    PlayerText.AnchorPoint = Vector2.new(0.5, 0.5)
    PlayerText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    PlayerText.BackgroundTransparency = 1.000
    PlayerText.BorderColor3 = Color3.fromRGB(0, 0, 0)
    PlayerText.BorderSizePixel = 0
    PlayerText.Position = UDim2.new(0.499818504, 0, 0.171298146, 0)
    PlayerText.Size = UDim2.new(0.23385416, 0, 0.0760869533, 0)
    PlayerText.Font = Enum.Font.FredokaOne
    PlayerText.Text = "???"
    PlayerText.TextColor3 = Color3.fromRGB(221, 221, 221)
    PlayerText.TextScaled = true
    PlayerText.TextSize = 14.000
    PlayerText.TextWrapped = true

    UITextSizeConstraint_10.Parent = PlayerText
    UITextSizeConstraint_10.MaxTextSize = 54

    TimeLabel.Name = "TimeLabel"
    TimeLabel.Parent = InfoFrame
    TimeLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    TimeLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TimeLabel.BackgroundTransparency = 1.000
    TimeLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TimeLabel.BorderSizePixel = 0
    TimeLabel.Position = UDim2.new(0.499785721, 0, 0.766406834, 0)
    TimeLabel.Size = UDim2.new(0.0963541642, 0, 0.0760869533, 0)
    TimeLabel.Font = Enum.Font.FredokaOne
    TimeLabel.Text = "TIME"
    TimeLabel.TextColor3 = Color3.fromRGB(221, 221, 221)
    TimeLabel.TextScaled = true
    TimeLabel.TextSize = 14.000
    TimeLabel.TextWrapped = true

    UITextSizeConstraint_11.Parent = TimeLabel
    UITextSizeConstraint_11.MaxTextSize = 54

    TimeText.Name = "TimeText"
    TimeText.Parent = InfoFrame
    TimeText.AnchorPoint = Vector2.new(0.5, 0.5)
    TimeText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TimeText.BackgroundTransparency = 1.000
    TimeText.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TimeText.BorderSizePixel = 0
    TimeText.Position = UDim2.new(0.499535471, 0, 0.858798146, 0)
    TimeText.Size = UDim2.new(0.482812494, 0, 0.0760869533, 0)
    TimeText.Font = Enum.Font.FredokaOne
    TimeText.Text = "00W 00D 00H 00M 00S"
    TimeText.TextColor3 = Color3.fromRGB(221, 221, 221)
    TimeText.TextScaled = true
    TimeText.TextSize = 14.000
    TimeText.TextWrapped = true

    UITextSizeConstraint_12.Parent = TimeText
    UITextSizeConstraint_12.MaxTextSize = 54

    local UIList = {
        Style = StyleText,
        Money = MoneyText,
        Level = LevelText,
        Player = PlayerText,
        Time = TimeText
    }
    return UIList
end

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidrootpart = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart", 9e99)
local PlayerStats = player:FindFirstChild("PlayerStats") or player:WaitForChild("PlayerStats", 9e99)
local ProfileStats = player:FindFirstChild("ProfileStats") or player:WaitForChild("ProfileStats", 9e99)

player.CharacterAdded:Connect(function(newcharacter)
	character = newcharacter
	humanoidrootpart = newcharacter:FindFirstChild("HumanoidRootPart") or newcharacter:WaitForChild("HumanoidRootPart", 5)
end)

local Teams = {
	"Home",
	"Away"
}
local Position = {
	"CF",
	"LE",
	"RW",
	"CM",
	"GK",
}

local UI = CreateKaitanGui()

-- เวลาเริ่มต้น
local startTime = tick()
RunService:Set3dRenderingEnabled(false)
RunService.RenderStepped:Connect(function()
    local elapsedTime = tick() - startTime  -- เวลาที่ผ่านไป
    
    -- แปลงเวลาเป็นสัปดาห์, วัน, ชั่วโมง, นาที และวินาที
    local weeks = math.floor(elapsedTime / (7 * 24 * 60 * 60))
    local days = math.floor(elapsedTime / (24 * 60 * 60)) % 7
    local hours = math.floor(elapsedTime / (60 * 60)) % 24
    local minutes = math.floor(elapsedTime / 60) % 60
    local seconds = math.floor(elapsedTime) % 60

    -- กำหนดรูปแบบเวลาที่แสดงขึ้นอยู่กับเวลาที่ผ่านไป
    local formattedTime = ""

    if weeks > 0 then
        formattedTime = string.format("%02dW %02dD %02dH %02dM %02dS", weeks, days, hours, minutes, seconds)
    elseif days > 0 then
        formattedTime = string.format("%02dD %02dH %02dM %02dS", days, hours, minutes, seconds)
    elseif hours > 0 then
        formattedTime = string.format("%02dH %02dM %02dS", hours, minutes, seconds)
    elseif minutes > 0 then
        formattedTime = string.format("%02dM %02dS", minutes, seconds)
    else
        formattedTime = string.format("%02dS", seconds)  -- แสดงเฉพาะวินาทีเมื่อยังไม่ถึง 1 นาที
    end

    -- อัปเดต UI
    UI.Style.Text = PlayerStats.Style.Value
    UI.Money.Text = ProfileStats.Money.Value
    UI.Level.Text = ProfileStats.Level.Value
    UI.Player.Text = player.Name
    UI.Time.Text = formattedTime
end)

task.wait(3)

task.spawn(function()
	while wait() do
		if player.Team.Name == "Visitor" then
			if player.Team and player.Team.Name == "Visitor" then
				for _, team in ipairs(Teams) do
					for _, position in ipairs(Position) do
						ReplicatedStorage.Packages.Knit.Services.TeamService.RE.Select:FireServer(team, position)
					end
				end                    
			end
		else
			if getgenv().KAITAN_CONFIGS["FARM MODE"] == "TP" then
				function Goto(t, g, a)
					humanoidrootpart.CFrame = t
					if a == "Slide" then
						game:GetService("ReplicatedStorage").Packages.Knit.Services.BallService.RE.Slide:FireServer()
					elseif a == "Kick" then
						game:GetService("ReplicatedStorage").Packages.Knit.Services.BallService.RE.Shoot:FireServer(100, nil, nil, workspace.Goals[g].Position)
						task.wait(.1)
						local ball = workspace:FindFirstChild("Football") or workspace:WaitForChild("Football", 5)
						if ball then
							repeat task.wait()
								ball.CFrame = workspace.Goals[g].CFrame * CFrame.new(0, 0, 10)
							until ball.CFrame == workspace.Goals[g].CFrame * CFrame.new(0, 0, 10)
						end
					end
				end

				function ClosestCharacter(o, w)
					local c, d = nil, math.huge
					if not o or not o:FindFirstChild("HumanoidRootPart") then return nil end
					for _, m in ipairs((w or workspace):GetDescendants()) do
						if m:IsA("Model") and m ~= o and m:FindFirstChild("Humanoid") and m:FindFirstChild("HumanoidRootPart") and m:FindFirstChild("Football") then
							local dist = (o.HumanoidRootPart.Position - m.HumanoidRootPart.Position).Magnitude
							if dist < d then c, d = m, dist end
						end
					end
					return c
				end

				while player.Team.Name ~= "Visitor" do
					task.wait()
					local v = character:FindFirstChild("Values") or character:WaitForChild("Values", 5)
					local h = v:FindFirstChild("HasBall") or v:WaitForChild("HasBall", 5)
					local g = {["Away"] = "Away", ["Home"] = "Home"}
					if player.Team.Name == "Visitor" then
						task.wait(.1)
					else
						if humanoidrootpart:FindFirstChild("Antifall") then
							if h.Value then
								Goto(humanoidrootpart.CFrame * CFrame.new(0, 50, 0), g[player.Team.Name], "Kick")
								task.wait(2)
							else
								local b = workspace:FindFirstChild("Football")
								if b then
									for _, v in pairs(workspace:GetChildren()) do
										if v.Name == "Football" and v:FindFirstChild("Hitbox") then
											Goto(v.CFrame * CFrame.new(0, 3.5, 0), g[player.Team.Name])
										end
									end
								else
									local t = ClosestCharacter(character)
									local b = t and t:FindFirstChild("Football") or t:WaitForChild("Football")
									if b then Goto(b.CFrame, g[player.Team.Name], "Slide") end
								end
							end
						else
							local af = Instance.new("BodyVelocity", humanoidrootpart)
							af.P = 1250
							af.Velocity = Vector3.new(0, 0, 0)
							af.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
							af.Name = "Antifall"
						end
					end
				end
				task.wait(.1)
				if player.Team.Name == "Visitor" then
					for _, v in pairs(humanoidrootpart:GetChildren()) do
						if v.Name == "Antifall" and v:IsA("BodyVelocity") then
							v:Destroy()
						end
					end
				end
			elseif getgenv().KAITAN_CONFIGS["FARM MODE"] == "TWEEN" then
				local function noclip()
					for i, v in pairs(character:GetChildren()) do
						if v:IsA("BasePart") and v.CanCollide == true then
							v.CanCollide = false
							humanoidrootpart.Velocity = Vector3.new(0,0,0)
						end
					end
				end

				local function Goto(Target, Goal, Action)
					local NoClipConnect
					local TweenService = game:GetService("TweenService")
					local Distance = (humanoidrootpart.Position - Target.Position).Magnitude
					local Speed = 80
					local Tween = TweenService:Create(humanoidrootpart, TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear), {CFrame = Target})
					NoClipConnect = game:GetService("RunService").Stepped:Connect(noclip)
					Tween:Play()
					local ActionActive = Action or "None"
					if ActionActive == "Slide" then
						Tween.Completed:Connect(function()
							if Distance < 3 then
								game:GetService("ReplicatedStorage").Packages.Knit.Services.BallService.RE.Slide:FireServer()
							end
						end)
					elseif ActionActive == "Kick" then
						Tween.Completed:Connect(function()
							local args = {
								[1] = 100,
								[4] = workspace.Goals[Goal].Position
							}
							game:GetService("ReplicatedStorage").Packages.Knit.Services.BallService.RE.Shoot:FireServer(unpack(args))
							task.wait(.1)
							local Ball = workspace:FindFirstChild("Football") or workspace:WaitForChild("Football", 5)
							if Ball then
								repeat task.wait()
									Ball.CFrame = workspace.Goals[Goal].CFrame * CFrame.new(0, 0, 10)
									NoClipConnect:Disconnect()
								until Ball.CFrame == workspace.Goals[Goal].CFrame * CFrame.new(0, 0, 10)
							end
						end)
					end
				end

				function ClosestCharacter(originCharacter, searchInWorkspace)
					local closestCharacter = nil
					local shortestDistance = math.huge
					
					if not originCharacter or not originCharacter:FindFirstChild("HumanoidRootPart") then
						return nil
					end
					
					local originPosition = originCharacter.HumanoidRootPart.Position

					local searchArea = searchInWorkspace or game.Workspace

					for _, model in ipairs(searchArea:GetDescendants()) do
						if model:IsA("Model") and model ~= originCharacter and model:FindFirstChild("Humanoid") and model:FindFirstChild("HumanoidRootPart") and model:FindFirstChild("Football") then
							local targetPosition = model.HumanoidRootPart.Position
							local distance = (originPosition - targetPosition).Magnitude

							if distance < shortestDistance then 
								shortestDistance = distance
								closestCharacter = model
							end
						end
					end

					return closestCharacter
				end

				while player.Team.Name ~= "Visitor" do
					task.wait()
					local Values = character:FindFirstChild("Values") or character:WaitForChild("Values", 5)
					local HasBall = Values:FindFirstChild("HasBall") or Values:WaitForChild("HasBall", 5)
					local Goal = {
						["Away"] = "Away",
						["Home"] = "Home"
					}
					if player.Team.Name == "Visitor" then
						task.wait(.1)
					else
						if humanoidrootpart:FindFirstChild("Antifall") then
							if HasBall.Value then
								Goto(humanoidrootpart.CFrame * CFrame.new(0, 50, 0), Goal[game.Players.LocalPlayer.Team.Name], "Kick")
								task.wait(2)
							else
								if workspace:FindFirstChild("Football") then
									for BallIndex, BallValue in pairs(workspace:GetChildren()) do
										if BallValue.Name == "Football" and BallValue:FindFirstChild("Hitbox") then
											Goto(BallValue.CFrame * CFrame.new(0, 3.5, 0), Goal[game.Players.LocalPlayer.Team.Name])
										end
									end
								else
									local Target = ClosestCharacter(character)
									local Ball = Target:FindFirstChild("Football") or Target:WaitForChild("Football")

									Goto(Ball.CFrame, Goal[game.Players.LocalPlayer.Team.Name], "Slide")
								end
							end
						else
							local antifall = Instance.new("BodyVelocity", humanoidrootpart)
							antifall.P = 1250
							antifall.Velocity = Vector3.new(0, 0, 0)
							antifall.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
							antifall.Name = "Antifall"
						end
					end
				end
				task.wait(.1)
				if player.Team.Name == "Visitor" then
					for i, v in pairs(humanoidrootpart:GetChildren()) do
						if v.Name == "Antifall" and v:IsA("BodyVelocity") then
							v:Destroy()
						end
					end
				end
			else
				player:Kick("Please Select Farm Mode In Configs!")
			end
		end
	end
end)