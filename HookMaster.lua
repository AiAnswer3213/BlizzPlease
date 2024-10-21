BPHookMaster = {
    hooks = {}
}

function BPHookMaster:OnAddonLoaded(addonName)
    if not BPHookMaster.hooks[addonName] then
        return
    end

    for _, hook in ipairs(BPHookMaster.hooks[addonName]) do
        hook()
    end
end

local hookframe = CreateFrame("Frame", "BlizzPleaseHookFrame", UIParent)
hookframe:RegisterEvent("ADDON_LOADED")
hookframe:SetScript("OnEvent", function(self, event, addonName)
    if event == "ADDON_LOADED" then
        BPHookMaster:OnAddonLoaded(addonName)
    end
end)


--[[
    Hooks a function to be executed after a specified addon is loaded.
    
    @param afterAddon (string) - The name of the addon after which the hook should be executed.
    @param hookto (string) - The name of the function to hook into.
    @param func (function) - The function to be executed when the hook is triggered.
    
    inserts a function into the hooks table that will hook the specified function
    using `hooksecurefunc` when the addon is loaded.
]]
function BPHookMaster:DeferredHookSecureHook(afterAddon, hookto, func)
    if not BPHookMaster.hooks[afterAddon] then
        BPHookMaster.hooks[afterAddon] = {}
    end
    table.insert(BPHookMaster.hooks[afterAddon], function()
        hooksecurefunc(hookto, func)
    end)
end