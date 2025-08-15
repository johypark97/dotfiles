-- ==========================
-- -------- function --------
-- ==========================

-- Init.postInitializer = Init.scriptLoader:dofile("script/function/post-initializer.lua"):new()
Init.gruvboxColor = Init.scriptLoader:dofile("script/function/gruvbox-color.lua"):new()
Init.mapSwitcher = Init.scriptLoader:dofile("script/function/map-switcher.lua"):new(Init.name .. ".mapSwitcher")
Init.toggler = Init.scriptLoader:dofile("script/function/toggler.lua"):new()

Init.Set = Init.scriptLoader:dofile("script/function/set.lua")
