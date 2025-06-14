local addonName, HPBar = ...
local Config = {}
HPBar.Config = Config

local panel

local function CreateSlider(name, parent, minVal, maxVal, step, text)
    local slider = CreateFrame("Slider", name, parent, "OptionsSliderTemplate")
    slider:SetMinMaxValues(minVal, maxVal)
    slider:SetValueStep(step)
    slider:SetObeyStepOnDrag(true)
    _G[slider:GetName() .. 'Low']:SetText(tostring(minVal))
    _G[slider:GetName() .. 'High']:SetText(tostring(maxVal))
    _G[slider:GetName() .. 'Text']:SetText(text)
    return slider
end

function Config:CreateOptions()
    panel = CreateFrame("Frame", "HPBarOptionsPanel", UIParent)
    panel.name = "HP Bar"

    local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("HP Bar Configuration")

    local widthSlider = CreateSlider("HPBarWidthSlider", panel, 50, 400, 1, "Width")
    widthSlider:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -40)
    widthSlider:SetValue(HPBarDB.width)
    widthSlider:SetScript("OnValueChanged", function(self, value)
        HPBarDB.width = value
        HPBar.ApplySettings()
    end)

    local heightSlider = CreateSlider("HPBarHeightSlider", panel, 10, 50, 1, "Height")
    heightSlider:SetPoint("TOPLEFT", widthSlider, "BOTTOMLEFT", 0, -30)
    heightSlider:SetValue(HPBarDB.height)
    heightSlider:SetScript("OnValueChanged", function(self, value)
        HPBarDB.height = value
        HPBar.ApplySettings()
    end)

    local colorBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    colorBtn:SetSize(100, 22)
    colorBtn:SetPoint("TOPLEFT", heightSlider, "BOTTOMLEFT", 0, -30)
    colorBtn:SetText("Color")
    colorBtn:SetScript("OnClick", function()
        local function callback()
            local r,g,b = ColorPickerFrame:GetColorRGB()
            HPBarDB.color = {r=r, g=g, b=b}
            HPBar.ApplySettings()
        end
        ColorPickerFrame.func = callback
        ColorPickerFrame:SetColorRGB(HPBarDB.color.r, HPBarDB.color.g, HPBarDB.color.b)
        ColorPickerFrame:Hide() -- Need to run the OnShow
        ColorPickerFrame:Show()
    end)

    InterfaceOptions_AddCategory(panel)
end

function Config:Toggle()
    if not panel then
        self:CreateOptions()
    end
    InterfaceOptionsFrame_OpenToCategory(panel)
    InterfaceOptionsFrame_OpenToCategory(panel)
end

return Config
