hook.Add("DarkRPFinishedLoading", "CPG_TFA", function()
    -- Anti chat-spam
    hook.Remove('InitPostEntity', 'TFA_CheckEnv')
    
    -- Useless
    hook.Remove('PlayerSpawnNPC', 'TFACheckNPCWeapon')

    -- Attachments
    hook.Remove('Initialize', 'TFAUpdateAttachmentsIPE')
    hook.Remove('InitPostEntity', 'TFAUpdateAttachmentsIPE')
    hook.Remove('NotifyShouldTransmit', 'TFA_AttachmentsRequest')
    hook.Remove('NetworkEntityCreated', 'TFA_AttachmentsRequest')
    hook.Remove('OnEntityCreated', 'TFA_AttachmentsRequest')

    hook.Remove('InitPostEntity', 'TFA_NZPatch')
    hook.Remove('TFA_AnimationRate', 'NZBase')
    hook.Remove('TFA_Deploy', 'NZBase')
    hook.Remove('InitPostEntity', 'TFA_NZPatch')
end)

hook.Add('InitPostEntity', 'CPG_TFAPData', function(ply)
    local pdatavar = "tfa_base_version_" .. util.CRC(game.GetIPAddress())

    if ply:GetPData(pdatavar, nil) ~= nil then
        ply:RemovePData(pdatavar)
    end
end)

net.Receive("TFA_Attachment_Reload", function() end)
net.Receive("TFA_Attachment_SetStatus", function() end)
net.Receive("TFA_Attachment_Request", function() end)
net.Receive("TFA_Attachment_Set", function() end)
