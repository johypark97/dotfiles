-- ===========================
-- -------- blink.cmp --------
-- ===========================

local function createKeymap()
    local acceptForward = {
        function(cmp)
            if cmp.snippet_active() then
                return cmp.accept()
            else
                return cmp.select_and_accept()
            end
        end,
        "snippet_forward",
        "fallback",
    }

    local accept = { "accept", "fallback" }
    local selectNext = { "select_next", "fallback" }
    local selectPrevious = { "select_prev", "fallback" }

    return {
        preset        = "none",
        ["<Tab>"]     = acceptForward,
        ["<CR>"]      = accept,
        ["<C-y>"]     = accept,
        ["<S-Tab>"]   = { "snippet_backward", "fallback" },
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<ESC>"]     = { "cancel", "fallback" },
        ["<Up>"]      = selectPrevious,
        ["<Down>"]    = selectNext,
        ["<C-k>"]     = selectPrevious,
        ["<C-j>"]     = selectNext,
        ["<A-k>"]     = selectPrevious,
        ["<A-j>"]     = selectNext,
        ["<C-p>"]     = { "select_prev", "fallback_to_mappings" },
        ["<C-n>"]     = { "select_next", "fallback_to_mappings" },
        ["<C-u>"]     = { "scroll_documentation_up", "fallback" },
        ["<C-d>"]     = { "scroll_documentation_down", "fallback" },
    }
end

return {
    "saghen/blink.cmp",
    version = "1.*",
    opts = {
        cmdline = { enabled = false },
        completion = {
            list = {
                selection = {
                    auto_insert = true,
                    preselect = false,
                },
            },
        },
        keymap = createKeymap(),
    },
}
