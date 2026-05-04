local cfg = _G.Config
local Players = game.Players
local localPlayer = Players.LocalPlayer

local function applyGod(char)
    local human = char:WaitForChild("Humanoid")
    if cfg.godMode then
        human.MaxHealth = 1e9
        human.Health = 1e9
        human:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        human.BreakJointsOnDeath = false
    end
end

if localPlayer.Character then
    applyGod(localPlayer.Character)
end

localPlayer.CharacterAdded:Connect(function(char)
    wait(0.5)
    applyGod(char)
    if cfg.godMode then
        human = char:WaitForChild("Humanoid")
        human.HealthChanged:Connect(function(health)
            if health < 1e9 then human.Health = 1e9 end
        end)
    end
end)

-- Поддержка изменения через GUI
local function onGodModeChanged(value)
    cfg.godMode = value
    if localPlayer.Character then
        local human = localPlayer.Character:FindFirstChild("Humanoid")
        if human then
            if value then
                human.MaxHealth = 1e9
                human.Health = 1e9
            else
                human.MaxHealth = 100
                human.Health = 100
            end
        end
    end
end
_G.ToggleGodMode = onGodModeChanged