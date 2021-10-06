hook.Add("DarkRPFinishedLoading", "CPG_TFA", function()
    net.Receive("TFA_Attachment_Request", function() end)
    net.Receive("TFA_Attachment_Set", function() end)
   
    hook.Remove('InitPostEntity', 'TFA_NZPatch')
    hook.Remove('TFA_AnimationRate', 'NZBase')
    hook.Remove('TFA_Deploy', 'NZBase')
    hook.Remove('InitPostEntity', 'TFA_CheckEnv')
end)