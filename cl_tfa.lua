local convars = {
    ["cl_tfa_hud_enabled"] = 0,
    ["cl_tfa_hud_crosshair_color_r"] = 255,
    ["cl_tfa_hud_crosshair_color_g"] = 255,
    ["cl_tfa_hud_crosshair_color_b"] = 255,
    ["cl_tfa_hud_crosshair_color_a"] = 255,
    ["cl_tfa_hud_crosshair_dot"] = 0,
    ["cl_tfa_hud_crosshair_outline_color_r"] = 5,
    ["cl_tfa_hud_crosshair_outline_color_g"] = 5,
    ["cl_tfa_hud_crosshair_outline_color_b"] = 5,
    ["cl_tfa_hud_crosshair_outline_color_a"] = 200,
    ["cl_tfa_hud_hitmarker_enabled"] = 0,
    ["cl_tfa_hud_crosshair_length"] = 0.57,
    ["cl_tfa_hud_crosshair_color_team"] = 0,
    ["cl_tfa_hud_crosshair_enable_custom"] = 1,
    ["cl_tfa_hud_crosshair_outline_enabled"] = 1,
}

-- Let's block the convar change
for k, v in pairs(convars) do
    RunConsoleCommand(k, v)
    
    cvars.AddChangeCallback(k, function()
        RunConsoleCommand(k, v)
    end)
end

hook.Add("DarkRPFinishedLoading", "CPG_CLTFA", function()
	hook.Remove("HUDPaint", "TFA_CheckEnv")
    hook.Remove("HUDPaint", "tfaDrawHitmarker")
    hook.Remove("PopulateToolMenu", "tfaAddOption")
	hook.Remove("PopulateToolMenu", "TFA_AddKeyBinds")
	hook.Remove("NotifyShouldTransmit", "TFA_AttachmentsRequest")
	hook.Remove("NetworkEntityCreated", "TFA_AttachmentsRequest")
	hook.Remove("OnEntityCreated", "TFA_AttachmentsRequest")
	hook.Remove("Think", "TFAInspectionMenu")
	hook.Remove("ContextMenuOpen", "TFAContextBlock")
end)

net.Receive("tfaHitmarker", function() end)
net.Receive("tfaHitmarker3D", function() end)
