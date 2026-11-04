-- =================================
-- -------- mini.trailspace --------
-- =================================

return {
    "nvim-mini/mini.trailspace",
    version = "*",
    config = function(_, opts)
        local mini_trailspace = require("mini.trailspace")

        mini_trailspace.setup(opts)

        vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function()
                MiniTrailspace.trim()
                MiniTrailspace.trim_last_lines()
            end,
            desc = "Remove trailing whitespace and extra blank lines",
        })
    end,
}
