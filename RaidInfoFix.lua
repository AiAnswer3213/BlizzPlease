-- INSTANCE             ID      << table header, stays constant (not part of the scroll frame)
-- Zul'Gurub            1       << instance name set from -2 to 0 xoffset
--  Resets in 2 days            << reset moved right by 2

-- in RaidFrame.xml the RaidInfoInstanceTemplate includes negative 2 x offset which clips the text on the left side
-- We move the contents of the RaidInfoScrolLFrame to the right by 2 so the ..InstanceName starts at xoffset 0
-- Move the RaidInfoScrolLFrame to the left by 2 to align it back to the design

-- Coordinates are in format: defaultPosition+moveBy
local function BPHook_RaidInfoFrame_Update()
    for i = 1, MAX_RAID_INFOS do
        local instname = _G["RaidInfoInstance" .. i .. "Name"]
        if (instname) then
            instname:SetPoint("TOPLEFT", 0, 0)
        end

        local instid = _G["RaidInfoInstance" .. i .. "ID"]
        if (instid) then
            local point, relativeTo, relativePoint, xOfs, yOfs = instid:GetPoint()
            instid:SetPoint(point, relativeTo, relativePoint, 0+2, yOfs)
        end

        local instreset = _G["RaidInfoInstance" .. i .. "Reset"]
        if (instreset) then
            local point, relativeTo, relativePoint, xOfs, yOfs = instreset:GetPoint()
            instreset:SetPoint(point, relativeTo, relativePoint, 0+2, yOfs)
        end
    end

    -- TODO: Check the scrollbar is correct when enough saves to test
    local scrollFrame = _G["RaidInfoScrollFrame"]
    if (scrollFrame) then
        local point, relativeTo, relativePoint, xOfs, yOfs = scrollFrame:GetPoint()
        scrollFrame:SetPoint(point, relativeTo, relativePoint, 21-2, yOfs)
        scrollFrame:SetWidth(235+2)
    end
end

BPHookMaster:DeferredHookSecureHook("BlizzPlease", "RaidInfoFrame_Update", BPHook_RaidInfoFrame_Update)