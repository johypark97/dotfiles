-- ===========================
-- -------- nvim-tree --------
-- ===========================

-- optional: "nvim-tree/nvim-web-devicons"

return {
    "nvim-tree/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    opts = {
        renderer = {
            icons = {
                show = {
                    file = false,
                    folder = false,
                    folder_arrow = false,
                    git = false,
                    modified = false,
                },
            },
        },
    },
}
