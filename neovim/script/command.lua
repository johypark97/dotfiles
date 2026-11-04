-- =========================
-- -------- command --------
-- =========================

-- :help nvim_create_user_command()
-- :help user-commands

vim.api.nvim_create_user_command("InitFileFormatLF", function()
    vim.bo.fileformat = "unix"
    vim.notify("File format set to Unix (LF)")
end, {
    desc = "Set current buffer line endings to Unix (LF)",
})

vim.api.nvim_create_user_command("InitInspectLanguageSupport", function()
    -- filetype
    vim.notify("[Filetype]\n" .. vim.bo.filetype .. "\n\n")

    -- lsp
    vim.notify("[LSP]")
    local lspClientList = vim.lsp.get_clients({ bufnr = 0 })
    if #lspClientList == 0 then
        vim.notify("No active client", vim.log.levels.WARN)
    else
        local list = vim.tbl_map(function(client) return client.name end, lspClientList)
        vim.notify("Active clients: " .. table.concat(list, ", "))
    end
    vim.notify("\n")

    -- treesitter
    vim.notify("[Treesitter]")
    local parser = vim.treesitter.get_parser()
    if parser == nil then
        vim.notify("No active parser", vim.log.levels.WARN)
    else
        vim.notify("Active parser: " .. parser:lang())

        local bufferNumber = vim.api.nvim_get_current_buf()
        if vim.treesitter.highlighter.active[bufferNumber] == nil then
            vim.notify("Highlighter: inactive", vim.log.levels.WARN)
        else
            vim.notify("Highlighter: active")
        end
    end
    vim.notify("\n")

    -- conform
    vim.notify("[Conform]")
    local conform = require("conform")
    local formatterList, formatterLspFallback = conform.list_formatters_to_run()
    if #formatterList == 0 then
        vim.notify("No active formatter", vim.log.levels.WARN)
    else
        local list = vim.tbl_map(function(info) return info.name end, formatterList)
        vim.notify("Active formatters: " .. table.concat(list, ", "))
    end
    vim.notify("LSP fallback: " .. tostring(formatterLspFallback))
end, {})
