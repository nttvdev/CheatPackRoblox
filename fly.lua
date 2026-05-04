local cfg = _G.Config
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game.Players

local function startFly(char)
    local human = char:WaitForChild("Humanoid")
    local root = char:WaitForChild("HumanoidRootPart")
    local gyro = Instance.new("BodyGyro")
    gyro.P = 9e4
    gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    gyro.Name = "FlyGyro"
    gyro.Parent = root
    local vel = Instance.new("BodyVelocity")
    vel.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    vel.Name = "FlyVel"
    vel.Parent = root
    human.PlatformStand = true
end

local function stopFly(char)
    local human = char:FindFirstChild("Humanoid")
    if human then human.PlatformStand = false end
    for _, n in pairs({"FlyGyro", "FlyVel"}) do
        local obj = char:FindFirstChild(n, true)
        if obj then obj:Destroy() end
    end
end

UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == cfg.flyKey then
        _G.FlyEnabled = not _G.FlyEnabled
        local char = Players.LocalPlayer.Character
        if char then
            if _G.FlyEnabled then startFly(char) else stopFly(char) end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if not _G.FlyEnabled then return end
    local char = Players.LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local root = char.HumanoidRootPart
    local gyro = root:FindFirstChild("FlyGyro")
    local vel = root:FindFirstChild("FlyVel")
    if not gyro or not vel then return end
    local cam = workspace.CurrentCamera
    gyro.CFrame = cam.CFrame
    local dir = Vector3.zero
    if UIS:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
    if UIS:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
    if UIS:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
    if UIS:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end
    if UIS:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0,1,0) end
    if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0,1,0) end
    vel.Velocity = dir * cfg.flySpeed
end)

Players.LocalPlayer.CharacterAdded:Connect(function(char)
    if _G.FlyEnabled then wait(0.2) startFly(char) end
end)