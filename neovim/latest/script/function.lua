-- ==========================
-- -------- function --------
-- ==========================

local args = { ... }
local gInit = args[1]

gInit.gruvboxColor = gInit.scriptLoader:dofile('script/function/gruvbox-color.lua')
gInit.mapSwitcher = gInit.scriptLoader:dofile('script/function/map-switcher.lua'):new(gInit.name .. '.mapSwitcher')
gInit.toggler = gInit.scriptLoader:dofile('script/function/toggler.lua'):new()
