-- INSTANCE             ID      << table header, stays constant (not part of the scroll frame)
-- Zul'Gurub            1       << instance name set from -2 to 0 xoffset
-- Resets in 2 days             << 

-- in RaidFrame.xml the RaidInfoInstanceTemplate the RaidInfoInstance1Name is offset by -2 which clips the text
-- The other elements are positioned relative to the name
-- Moving the names right to 0 offset fixes the clipping and aligns the other elements
-- Move the RaidInfoScrolLFrame to the left by 2 to align it back to the design

-- The ID header alignment in relation to the ID data alignment looks odd when scrolling is enabled
-- right aligning it looks a lot better: /run RaidInfoInstance1ID:SetPoint("RIGHT", "RaidInfoInstance1Name", "RIGHT", 35, -1)

-- TODO: Check if the first reset text is misaligned to the 2nd one

-- Coordinates are in format: defaultPosition+moveBy
local function BPHook_RaidInfoFrame_Update()
    for i = 1, MAX_RAID_INFOS do
        local instname = _G["RaidInfoInstance" .. i .. "Name"]
        if (instname) then
            instname:SetPoint("TOPLEFT", 0, 0)
        end

        -- reposition ids when scrolling is enabled
        if (RaidInfoFrame.scrolling) then
            local instid = _G["RaidInfoInstance" .. i .. "ID"]
            if (instid) then
                local point, relativeTo, relativePoint, xOfs, yOfs = instid:GetPoint()
                instid:SetPoint("RIGHT", relativeTo, "RIGHT", 35, yOfs)
            end
        end
    end

    local scrollFrame = _G["RaidInfoScrollFrame"]
    if (scrollFrame) then
        local point, relativeTo, relativePoint, xOfs, yOfs = scrollFrame:GetPoint()
        scrollFrame:SetPoint(point, relativeTo, relativePoint, 21-2, yOfs)
        scrollFrame:SetWidth(235+2)
    end
end

BPHookMaster:DeferredHookSecureHook("BlizzPlease", "RaidInfoFrame_Update", BPHook_RaidInfoFrame_Update)

local ENABLE_TESTS = false
if ENABLE_TESTS then
    function GetNumSavedInstances()
        return 20
    end

    -- Return RANDOM test data row
    -- "Coilfang: Serpentshine Cavern", 235, 265123
    -- "Magtheridon's Lair", 9123, 123456
    function GetSavedInstanceInfo(index)
        if (index == 1) then
            return "TestData: Not a real instance", 123, 456
        end

        local instances = {
            { "Coilfang: Serpentshine Cavern"},
            { "Magtheridon's Lair"},
            { "Blackwing Lair"},
            { "Molten Core"},
            { "Onyxia's Lair"},
            { "Ruins of Ahn'Qiraj"},
            { "Temple of Ahn'Qiraj"},
            { "Zul'Gurub"},
            { "Zul'Aman"},
            { "Karazhan"},
            { "Gruul's Lair"},
            { "Magtheridon's Lair"},
            { "Serpentshrine Cavern"},
            { "The Eye"},
            { "Battle for Mount Hyjal"},
            { "Black Temple"},
            { "Sunwell Plateau"},
            { "Naxxramas"},
            { "The Obsidian Sanctum"},
            { "The Eye of Eternity"}
        }

        local randomIndex = math.random(1, #instances)
        local randomID = math.random(1, 9999)
        local randomReset = math.random(1, 999999)
        return instances[randomIndex][1], randomID, randomReset
    end
end