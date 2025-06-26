--// CONFIG
local imageURL = "https://eforms.com/images/2018/03/Employment-Job-Application.png"
local vineBoomURL = "https://github.com/ZeroCru/VineBoom/raw/main/VineBoom.mp3"
local displayTime = 5 -- how long it stays before fading
local fadeTime = 2 -- how long the fade out takes

--// SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
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
image.Image = "rbxassetid://0" -- placeholder
image.Parent = frame

--// LOAD IMAGE FROM URL
local success, base64 = pcall(function()
	return HttpService:Base64Encode(game:HttpGet(imageURL, true))
end)

if success then
	image.Image = "data:image/png;base64," .. base64
end

--// PLAY VINE BOOM SOUND
local sound = Instance.new("Sound")
sound.SoundId = vineBoomURL
sound.Volume = 1
sound.Looped = false
sound.Parent = frame
sound:Play()

--// WAIT THEN FADE OUT
task.delay(displayTime, function()
	local fadeTween = TweenInfo.new(fadeTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	TweenService:Create(frame, fadeTween, {BackgroundTransparency = 1}):Play()
	TweenService:Create(image, fadeTween, {ImageTransparency = 1}):Play()
	TweenService:Create(sound, fadeTween, {Volume = 0}):Play()

	task.wait(fadeTime + 0.1)
	screenGui:Destroy()
end)
