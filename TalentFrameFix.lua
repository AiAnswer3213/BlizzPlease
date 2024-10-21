-- The PlayerTalentFrameTitleText is too high in the frame
-- Move it in the middle of the header bar of the talent frame

-- The lua for Talent frame is lazyloaded when its opened

BPHookMaster:DeferredHookSecureHook("Blizzard_TalentUI", "PlayerTalentFrame_OnShow", function()
    _G["PlayerTalentFrameTitleText"]:SetPoint("TOP", 0, -19)
end)