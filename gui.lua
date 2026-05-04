-- OrionLib GUI для Absolute CheatPack (Xeno-совместимый)
local cfg = _G.Config
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()

local Window = OrionLib:MakeWindow({
    Name = "Absolute | Roblox Universal",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "Absolute_Config",
    IntroEnabled = true,
    IntroText = "ABSOLUTE"
})

local MovementTab = Window:MakeTab({ Name = "Movement", Icon = "rbxassetid://4483345998", PremiumOnly = false })
local VisualTab = Window:MakeTab({ Name = "Visuals", Icon = "rbxassetid://4483345998", PremiumOnly = false })
local CombatTab = Window:MakeTab({ Name = "Combat", Icon = "rbxassetid://4483345998", PremiumOnly = false })
local SettingsTab = Window:MakeTab({ Name = "Settings", Icon = "rbxassetid://4483345998", PremiumOnly = false })

MovementTab:AddToggle({
    Name = "Fly (X)",
    Default = false,
    Callback = function(s) _G.FlyEnabled = s end
})
MovementTab:AddToggle({
    Name = "NoClip (V)",
    Default = false,
    Callback = function(s) _G.NoClipEnabled = s end
})
MovementTab:AddSlider({
    Name = "Walk Speed",
    Min = 16,
    Max = 500,
    Default = cfg.walkSpeed,
    Increment = 1,
    Callback = function(v)
        _G.WalkSpeed = v
        cfg.walkSpeed = v
        if game.Players.LocalPlayer.Character then
            local human = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
            if human then human.WalkSpeed = v end
        end
    end
})
MovementTab:AddSlider({
    Name = "Jump Power",
    Min = 50,
    Max = 500,
    Default = cfg.jumpPower,
    Increment = 1,
    Callback = function(v)
        _G.JumpPower = v
        cfg.jumpPower = v
        if game.Players.LocalPlayer.Character then
            local human = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
            if human then human.JumpPower = v end
        end
    end
})

VisualTab:AddToggle({
    Name = "ESP Players",
    Default = cfg.espEnabled,
    Callback = function(s) _G.espEnabled = s end
})
VisualTab:AddToggle({
    Name = "Chams (X-Ray)",
    Default = cfg.chamsEnabled,
    Callback = function(s) cfg.chamsEnabled = s end
})

CombatTab:AddToggle({
    Name = "GodMode",
    Default = cfg.godMode,
    Callback = function(s)
        _G.GodMode = s
        if _G.ToggleGodMode then _G.ToggleGodMode(s) end
    end
})
CombatTab:AddTextbox({
    Name = "Set Health",
    Default = "100",
    TextDisappear = false,
    Callback = function(v)
        local n = tonumber(v)
        if n and game.Players.LocalPlayer.Character then
            local human = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
            if human then
                human.MaxHealth = n
                human.Health = n
            end
        end
    end
})

SettingsTab:AddButton({
    Name = "Destroy GUI",
    Callback = function() OrionLib:Destroy() end
})
SettingsTab:AddBind({
    Name = "Toggle GUI",
    Default = cfg.guiToggleKey,
    Hold = false,
    Callback = function() OrionLib:Toggle() end
})

OrionLib:Init()