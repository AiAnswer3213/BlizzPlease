-- SpellBookTitleText in SpellBookFrame is too low and looks awkward
-- BlizzDefault GetPoint: CENTER, SpellBookFrame, CENTER, 6, 230

-- Change the anchor point to the top of the frame
-- y offset -18.5 is not the same as talent frame. the frame positions and dimensions aren't uniform
-- x offset 6 puts the text right side in line with the spell icons.

_G["SpellBookTitleText"]:SetPoint("TOP", "SpellBookFrame", "TOP", 6, -18.5)