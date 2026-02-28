local _G = getfenv(0)

-- upvalues
local IsAddOnLoaded = IsAddOnLoaded

-- Bongos
local function GetActionButton_Bongos(action)
    return _G['BActionButton' .. action]
end

-- pfUI
local PF_BARS = {
    { name = "pfActionBarMain",       first = 1 },
    { name = "pfActionBarPaging",     first = 13 },
    { name = "pfActionBarRight",      first = 25 },
    { name = "pfActionBarVertical",   first = 37 },
    { name = "pfActionBarLeft",       first = 49 },
    { name = "pfActionBarTop",        first = 61 },
    { name = "pfActionBarStanceBar1", first = 73 },
    { name = "pfActionBarStanceBar2", first = 85 },
    { name = "pfActionBarStanceBar3", first = 97 },
    { name = "pfActionBarStanceBar4", first = 109 },
}

local function GetActionButton_PF(action)
    for i = 1, table.getn(PF_BARS) do
        local bar = PF_BARS[i]
        local nextFirst = PF_BARS[i + 1] and PF_BARS[i + 1].first or 121
        if action >= bar.first and action < nextFirst then
            local index = action - bar.first + 1
            return _G[bar.name .. "Button" .. index]
        end
    end
end

-- Dragonflight3
local function GetActionButton_Dragonflight3(action)
    local bar, index

    if action >= 1 and action <= 12 then
        bar = 'DF_MainBar'
        index = action

    elseif action >= 13 and action <= 24 then
        bar = 'DF_MultiBar5'
        index = action - 12

    elseif action >= 25 and action <= 36 then
        bar = 'DF_MultiBar4'
        index = action - 24

    elseif action >= 37 and action <= 48 then
        bar = 'DF_MultiBar3'
        index = action - 36

    elseif action >= 49 and action <= 60 then
        bar = 'DF_MultiBar2'
        index = action - 48

    elseif action >= 61 and action <= 72 then
        bar = 'DF_MultiBar1'
        index = action - 60

    elseif action >= 133 and action <= 142 then
        bar = 'DF_PetBar'
        index = action - 132

    elseif action >= 200 and action <= 209 then
        bar = 'DF_StanceBar'
        index = action - 199
    end

    if bar and index then
        return _G[bar .. 'Button' .. index]
    end
end


local function HandleEvent()
    if IsAddOnLoaded('Bongos') and IsAddOnLoaded('Bongos_ActionBar') then
        Flyout_GetActionButton = GetActionButton_Bongos
    end

    if IsAddOnLoaded('pfUI') then
        Flyout_GetActionButton = GetActionButton_PF
    end
	
	if IsAddOnLoaded('-Dragonflight3') then
		Flyout_GetActionButton = GetActionButton_Dragonflight3
	end
end

-- override original functions
local handler = CreateFrame('Frame')
handler:RegisterEvent('VARIABLES_LOADED')
handler:SetScript('OnEvent', HandleEvent)
