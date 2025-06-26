--// CONFIG
local imageAssetId = 117916471237115 -- Your uploaded job application decal ID
local soundAssetId = 0 -- Replace with your uploaded Vine Boom sound asset ID
local displayTime = 5 -- seconds before fade
local fadeTime = 2 -- fade duration

--// SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

--// CLEANUP
if player:FindFirstChild("JobAppGui") then
	player.JobAppGui:Destroy()
end

--// GUI SETUP
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "JobAppGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 600, 0, 400)
frame.Position = UDim2.new(0.5, -300, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.BackgroundTransparency = 0
frame.BorderSizePixel = 2
frame.Parent = screenGui

local image = Instance.new("ImageLabel")
image.Size = UDim2.new(1, -20, 1, -20)
image.Position = UDim2.new(0, 10, 0, 10)
image.BackgroundTransparency = 1
image.ImageTransparency = 0
image.Image = "rbxassetid://" .. tostring(imageAssetId)
image.Parent = frame

--// SOUND SETUP
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://" .. tostring(soundAssetId)
sound.Volume = 1
sound.Looped = false
sound.Parent = frame

-- Play the sound (only if soundAssetId is set)
if soundAssetId ~= 0 then
	sound:Play()
end

--// FADE OUT & CLEANUP
task.delay(displayTime, function()
	local tweenInfo = TweenInfo.new(fadeTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	TweenService:Create(frame, tweenInfo, {BackgroundTransparency = 1}):Play()
	TweenService:Create(image, tweenInfo, {ImageTransparency = 1}):Play()
	TweenService:Create(sound, tweenInfo, {Volume = 0}):Play()

	task.wait(fadeTime + 0.1)
	screenGui:Destroy()
end)
