local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local human = char:WaitForChild("Humanoid")
local cfg = require(script.Parent.Parent.config)

human.WalkSpeed = 16 * cfg.speed_mult
human.JumpPower = 50 * cfg.jump_mult

-- синхронизация при респавне
player.CharacterAdded:Connect(function(newChar)
    wait(0.5)
    local newHuman = newChar:WaitForChild("Humanoid")
    newHuman.WalkSpeed = 16 * cfg.speed_mult
    newHuman.JumpPower = 50 * cfg.jump_mult
end)