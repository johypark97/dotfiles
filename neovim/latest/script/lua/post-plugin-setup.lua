-- ===================================
-- -------- post plugin setup --------
-- ===================================

local args = { ... }
local gInit = args[1]

-- map the autopairs return
if gInit.isLoaded('nvim-autopairs', 'nvim-cmp') then
    local autopairs_cmp = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')

    cmp.event:on('confirm_done', autopairs_cmp.on_confirm_done({
        map_char = { tex = '' }
    }))
end
