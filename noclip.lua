local cfg = _G.Config
local Players = game.Players
local localPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")

UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == cfg.noclipKey then
        _G.NoClipEnabled = not _G.NoClipEnabled
    end
end)

game:GetService("RunService").Stepped:Connect(function()
    if _G.NoClipEnabled and localPlayer.Character then
        for _, v in pairs(localPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)