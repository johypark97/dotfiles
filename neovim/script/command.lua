-- =========================
-- -------- command --------
-- =========================

-- argument handling
--   -nargs=0 (default)
--   -nargs=1
--   -nargs=?
--   -nargs=*
--   -nargs=+

-- special cases
--   -bang -buffer

-- escape sequences
--   <args> <f-args> <q-args>
--   <bang>

vim.api.nvim_create_user_command("InitFileFormatLF", "set fileformat=unix | echo ':set fileformat=unix'", {})
