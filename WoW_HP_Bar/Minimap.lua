local addonName, HPBar = ...
local MinimapMod = {}
HPBar.Minimap = MinimapMod

function MinimapMod:Create()
    if self.button then return end
    local button = CreateFrame("Button", "HPBarMinimapButton", Minimap)
    button:SetSize(32,32)
    button:SetFrameStrata("MEDIUM")
    button:SetFrameLevel(8)
    button:SetNormalTexture("Interface\\Icons\\INV_Misc_ArmorKit_15")
    button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
    button:SetPoint("TOPLEFT", Minimap, "TOPLEFT")
    button:SetScript("OnClick", function()
        if HPBar.Config then
            HPBar.Config:Toggle()
        end
    end)
    self.button = button
end

return MinimapMod
