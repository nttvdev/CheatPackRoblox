local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local cfg = _G.Config

local espHighlights = {}

local function createESP(player)
    if player == localPlayer then return end
    local function onCharacter(character)
        if espHighlights[player] then
            espHighlights[player]:Destroy()
        end
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESP"
        highlight.Adornee = character
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
        highlight.FillTransparency = 0.5
        highlight.OutlineColor = Color3.new(1, 1, 1)
        highlight.OutlineTransparency = 0
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Parent = character
        espHighlights[player] = highlight

        if cfg.chamsEnabled then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Material = Enum.Material.ForceField
                    part.Transparency = 0.3
                end
            end
        end
    end

    if player.Character then
        onCharacter(player.Character)
    end
    player.CharacterAdded:Connect(onCharacter)
end

for _, player in pairs(Players:GetPlayers()) do
    createESP(player)
end
Players.PlayerAdded:Connect(function(player)
    createESP(player)
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if cfg.chamsEnabled then
        for player, highlight in pairs(espHighlights) do
            local char = player.Character
            if char and highlight then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Material = Enum.Material.ForceField
                        part.Transparency = 0.3
                    end
                end
            end
        end
    end
end)