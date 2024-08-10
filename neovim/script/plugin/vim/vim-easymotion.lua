-- ================================
-- -------- vim-easymotion --------
-- ================================

return {
    "easymotion/vim-easymotion",
    init = function()
        vim.g.EasyMotion_do_mapping = false
        vim.g.EasyMotion_keys = "abcdefghijklmnopqrstuvwxyz"
        vim.g.EasyMotion_smartcase = true
        vim.g.EasyMotion_startofline = false
    end,
    keys = {
        { "<Leader>mw", "<Plug>(easymotion-w)" },
        { "<Leader>mW", "<Plug>(easymotion-W)" },
        { "<Leader>me", "<Plug>(easymotion-e)" },
        { "<Leader>mE", "<Plug>(easymotion-E)" },
        { "<Leader>mb", "<Plug>(easymotion-b)" },
        { "<Leader>mB", "<Plug>(easymotion-B)" },
        { "<Leader>mj", "<Plug>(easymotion-j)" },
        { "<Leader>mk", "<Plug>(easymotion-k)" },
        { "<Leader>mn", "<Plug>(easymotion-n)" },
        { "<Leader>mN", "<Plug>(easymotion-N)" },
        { "<Leader>m/", "<Plug>(easymotion-sn)" },
        { "<Leader>mm", "<Plug>(easymotion-jumptoanywhere)" },
    },
}
