local addonName, HPBar = ...

HPBar.defaults = {
    width = 200,
    height = 20,
    color = {r = 0, g = 1, b = 0},
    point = {"CENTER", UIParent, "CENTER", 0, -200},
}

local db

local frame = CreateFrame("StatusBar", "HPBarFrame", UIParent)
frame:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
frame:SetMinMaxValues(0, UnitHealthMax("player"))
frame:SetValue(UnitHealth("player"))
frame:SetReverseFill(true)
frame:SetOrientation("HORIZONTAL")
frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    local point, _, _, x, y = self:GetPoint()
    db.point = {point, UIParent, point, x, y}
end)

local function ApplySettings()
    frame:SetSize(db.width, db.height)
    frame:SetStatusBarColor(db.color.r, db.color.g, db.color.b)
    frame:ClearAllPoints()
    frame:SetPoint(unpack(db.point))
end
HPBar.ApplySettings = ApplySettings

frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("UNIT_HEALTH")
frame:SetScript("OnEvent", function(self, event, arg1)
    if event == "UNIT_HEALTH" and arg1 ~= "player" then return end
    self:SetMinMaxValues(0, UnitHealthMax("player"))
    self:SetValue(UnitHealth("player"))
end)

SLASH_HPBAR1 = "/hp"
SlashCmdList["HPBAR"] = function()
    if HPBar.Config then
        HPBar.Config:Toggle()
    end
end

function HPBar:Initialize()
    if not HPBarDB then
        HPBarDB = CopyTable(self.defaults)
    end
    db = HPBarDB
    ApplySettings()
    frame:Show()
    if HPBar.Minimap then
        HPBar.Minimap:Create() -- create minimap icon if available
    end
end

HPBar.frame = frame

C_Timer.After(0, function() HPBar:Initialize() end)

