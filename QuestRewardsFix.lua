-- Both QuestLogItem1 and QuestLogHonorFrame are set to "TOPLEFT", QuestLogItemReceiveText, "BOTTOMLEFT"
-- If both are visible they overlap
-- If the QuestLogHonorFrame is visible, set the QuestLogItem1 to "TOPLEFT", QuestLogHonorFrame, "BOTTOMLEFT"

-- Same with QuestDetailHonorFrame and QuestDetailItem1
-- If QuestDetailHonorFrame is visible, set the QuestDetailItem1 to "TOPLEFT", QuestDetailHonorFrame, "BOTTOMLEFT"

-- Same with QuestRewardHonorFrame and QuestRewardItem1

-- QuestFrameItems_Update is called with base name of the frame, similar frames such as when accepting quest from npc
hooksecurefunc("QuestFrameItems_Update", function(frameType)
    local curHonorFrame = _G[frameType .. "HonorFrame"]
    local item1 = _G[frameType .. "Item1"]

    if curHonorFrame and curHonorFrame:IsShown() then
        item1:ClearAllPoints()
        item1:SetPoint("TOPLEFT", curHonorFrame, "BOTTOMLEFT", -3, -5)
    end
end)