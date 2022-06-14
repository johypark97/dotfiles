-- =========================
-- -------- mapping --------
-- =========================

local args = { ... }
local gInit = args[1]

gInit.scriptLoader:loadfile('script/mapping/common.lua')(gInit)
gInit.scriptLoader:loadfile('script/mapping/plugin.lua')(gInit)
