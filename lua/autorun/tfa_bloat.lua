-- Should we block attachments?
local block_attachments = false

if SERVER then
    -- Spam
    hook.Remove('InitPostEntity', 'TFA_CheckEnv')
    
    -- Useless
    hook.Remove('PlayerSpawnNPC', 'TFACheckNPCWeapon')
    
    -- NZombies
    hook.Remove('InitPostEntity', 'TFA_NZPatch')
    hook.Remove('TFA_AnimationRate', 'NZBase')
    hook.Remove('TFA_Deploy', 'NZBase')
    hook.Remove('InitPostEntity', 'TFA_NZPatch')

    -- Attachments
    if block_attachments then
        hook.Remove('Initialize', 'TFAUpdateAttachmentsIPE')
        hook.Remove('InitPostEntity', 'TFAUpdateAttachmentsIPE')
        hook.Remove('NotifyShouldTransmit', 'TFA_AttachmentsRequest')
        hook.Remove('NetworkEntityCreated', 'TFA_AttachmentsRequest')
        hook.Remove('OnEntityCreated', 'TFA_AttachmentsRequest')

        -- Convar
        GetConVar("sv_tfa_attachments_enabled"):SetInt(0)

        -- Net messages
        net.Receive("TFA_Attachment_Reload", function() end)
        net.Receive("TFA_Attachment_SetStatus", function() end)
        net.Receive("TFA_Attachment_Request", function() end)
        net.Receive("TFA_Attachment_Set", function() end)
    else
        -- Restore
        GetConVar("sv_tfa_attachments_enabled"):SetInt(1)
    end

    -- Well, too bad
    local convars =
    {
        -- Useless
        "sv_tfa_debug",
        "sv_tfa_changelog",
        
        -- Bad
        "sv_tfa_jamming",

        -- Suits the server badly
        "sv_tfa_melee_doordestruction",
        "sv_tfa_bullet_doordestruction",
        "sv_tfa_bullet_doordestruction_keep",
        "sv_tfa_bullet_ricochet",
    }

    -- Null them out
    for k, v in pairs(convars) do
        GetConVar(v):SetInt(0)
    end
end

if CLIENT then
    local convars =
    {
        -- Interface
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
        
        -- Optimizations
        ["cl_tfa_fx_muzzleflashsmoke"] = 0,
        ["cl_tfa_fx_ejectionsmoke"] = 0,
        ["cl_tfa_fx_ejectionlife"] = 6,
        ["cl_tfa_fx_ads_dof"] = 0,
        ["cl_tfa_fx_gasblur"] = 0,

        -- Just in case
        ["cl_tfa_viewmodel_multiplier_fov"] = 1,
    }
    
    -- Don't let the client change them
    for k, v in pairs(convars) do
        RunConsoleCommand(k, v)
        
        cvars.AddChangeCallback(k, function()
            RunConsoleCommand(k, v)
        end)
    end
    
    -- Useless
    hook.Remove("HUDPaint", "TFA_DISPLAY_CHANGELOG")
    hook.Remove("HUDPaint", "tfa_drawdebughud")
    hook.Remove("HUDPaint", "TFA_CheckEnv")
    
    -- Other
    hook.Remove("PopulateMenuBar", "NPCOptions_MenuBar_TFA")
    hook.Remove("HUDPaint", "tfaDrawHitmarker")
    hook.Remove("PopulateToolMenu", "tfaAddOption")
    hook.Remove("PopulateToolMenu", "TFA_AddKeyBinds")
        
    -- Attachments
    if block_attachments then
        hook.Remove("NotifyShouldTransmit", "TFA_AttachmentsRequest")
        hook.Remove("NetworkEntityCreated", "TFA_AttachmentsRequest")
        hook.Remove("OnEntityCreated", "TFA_AttachmentsRequest")
        hook.Remove("Think", "TFAInspectionMenu")
        hook.Remove("ContextMenuOpen", "TFAContextBlock")
    end

    
    -- Eats space
    hook.Add('InitPostEntity', 'CPG_TFAPData', function()
        local var = "tfa_base_version_" .. util.CRC(game.GetIPAddress())
    
        if LocalPlayer():GetPData(var, nil) ~= nil then
            LocalPlayer():RemovePData(var)
        end
    end)
    
    -- Hitmarkers
    net.Receive("tfaHitmarker", function() end)
    net.Receive("tfaHitmarker3D", function() end)
end
