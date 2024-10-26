-- The Show Cloak and Show Helm options revert to their default setting ("1" for on) when the options are canceled
-- Exit game. Open new game, open interface opts, switch to display tab and click cancel. This results in unexpected behavior
-- The checkboxes seem to change their own state, if clicked twice the state changes 3 times

-- Calling ShowCloak(state) changes the state of the checkbox
-- and changing the checkbox calls ShowCloak(state)
-- The delay looks like it may be event from the server?
-- PLAYER_FLAGS_CHANGED -> SetChecked(ShowingHelm()); value = ShowingHelm() and "1" or "0"

-- InterfaceOptionsDisplayPanelShowCloak.value retuns "1" on login regardless of the state of the checkbox
-- It switches to the correct value when the display tab is opened
-- On cancel the SetValue is called with "1" and wrong setting is saved

-- Display:OnShow currValue = 1
-- Cancel -> both 1

-- This should happen in UIOptionsPanels.xml:642 InterfaceOptionsDisplayPanelShowCloak:OnLoad => UIOptionsPanels.lua:974 BlizzardOptionsPanel_RegisterControl(...)
-- Running it like this should effectively result in the intended behavior
InterfaceOptionsDisplayPanelShowCloak.value = InterfaceOptionsDisplayPanelShowCloak.GetValue()
InterfaceOptionsDisplayPanelShowCloak.currValue = InterfaceOptionsDisplayPanelShowCloak.GetValue()

InterfaceOptionsDisplayPanelShowHelm.value = InterfaceOptionsDisplayPanelShowHelm.GetValue()
InterfaceOptionsDisplayPanelShowHelm.currValue = InterfaceOptionsDisplayPanelShowHelm.GetValue()

-- TODO: There is some kind of race condition if you cancel fast after changing the chekcbox state