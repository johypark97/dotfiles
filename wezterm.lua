-- ==================================
-- -------- KeyBindingHelper --------
-- ==================================

local KeyBindingHelper = {}

function KeyBindingHelper:new()
    local instance = {}

    instance._keys = {}
    instance._key_tables = {
        -- copy_mode = {},
        search_mode = {},
    }
    instance._bindings = {}

    return setmetatable(instance, { __index = self })
end

function KeyBindingHelper:_add_key_binding(key_table, key, mods, action)
    table.insert(key_table, {
        key = key,
        mods = mods,
        action = action
    })
end

function KeyBindingHelper:_add_mouse_binding(event, streak, button, mods, action)
    table.insert(self._bindings, {
        event = { [event] = { streak = streak, button = button } },
        mods = mods,
        action = action
    })
end

function KeyBindingHelper:add_key(key, mods, action)
    self:_add_key_binding(self._keys, key, mods, action)
end

function KeyBindingHelper:add_copy_mode_key(key, mods, action)
    self:_add_key_binding(self._key_tables["copy_mode"], key, mods, action)
end

function KeyBindingHelper:add_search_mode_key(key, mods, action)
    self:_add_key_binding(self._key_tables["search_mode"], key, mods, action)
end

function KeyBindingHelper:add_mouse_left_down(streak, mods, action)
    self:_add_mouse_binding("Down", streak, "Left", mods, action)
end

function KeyBindingHelper:add_mouse_left_drag(streak, mods, action)
    self:_add_mouse_binding("Drag", streak, "Left", mods, action)
end

function KeyBindingHelper:add_mouse_left_up(streak, mods, action)
    self:_add_mouse_binding("Up", streak, "Left", mods, action)
end

function KeyBindingHelper:add_mouse_right_down(streak, mods, action)
    self:_add_mouse_binding("Down", streak, "Right", mods, action)
end

function KeyBindingHelper:add_mouse_scroll_up(mods, action)
    self:_add_mouse_binding("Down", 1, { WheelUp = 1 }, mods, action)
end

function KeyBindingHelper:add_mouse_scroll_down(mods, action)
    self:_add_mouse_binding("Down", 1, { WheelDown = 1 }, mods, action)
end

function KeyBindingHelper:apply_key_bindings(config_builder, disable_default)
    if disable_default then
        config_builder.disable_default_key_bindings = true
    end

    config_builder.keys = self._keys
end

function KeyBindingHelper:apply_key_tables(config_builder)
    config_builder.key_tables = self._key_tables
end

function KeyBindingHelper:apply_mouse_bindings(config_builder, disable_default)
    if disable_default then
        config_builder.disable_default_mouse_bindings = true
    end

    config_builder.mouse_bindings = self._bindings
end

-- =======================================
-- -------- WezTerm Configuration --------
-- =======================================

-- [Links]
-- Configuration: https://wezterm.org/config/files.html

-- [action_callback]
-- wezterm.action_callback(function(window, pane)
--     action_callback: https://wezterm.org/config/lua/wezterm/action_callback.html
--     window: https://wezterm.org/config/lua/window/index.html
--     pane: https://wezterm.org/config/lua/pane/index.html
-- end)

local wezterm = require("wezterm")

local config = wezterm.config_builder()

config:set_strict_mode(true)

config.color_scheme = "Campbell (Gogh)"
config.colors = { scrollbar_thumb = "#808080" }
config.enable_scroll_bar = true

config.font = wezterm.font("Source Code Pro")
config.font_size = 12.0 -- default: 12.0
config.initial_cols = 112 -- default: 80
config.initial_rows = 30 -- default: 24

config.window_padding = {
    top = "0.5cell",
    right = "1cell",
    bottom = "0.5cell",
    left = "1cell",
}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    config.default_prog = { "powershell.exe" }
    config.default_cwd = "C:\\"
end

-- =============================
-- -------- Key Binding --------
-- =============================

local key_binding = KeyBindingHelper:new()

key_binding:add_key("C", "CTRL", wezterm.action.Multiple({
    wezterm.action.CopyTo("Clipboard"),
    wezterm.action.ClearSelection
}))
key_binding:add_key("V", "CTRL", wezterm.action.PasteFrom("Clipboard"))
key_binding:add_key("C", "CTRL|ALT", wezterm.action.QuickSelect)

key_binding:add_key("X", "CTRL", wezterm.action.ActivateCopyMode)
key_binding:add_key("F", "CTRL", wezterm.action.Search("CurrentSelectionOrEmptyString"))

key_binding:add_key("Enter", "ALT", wezterm.action.ToggleFullScreen)
key_binding:add_key("P", "CTRL", wezterm.action.ActivateCommandPalette)
key_binding:add_key("R", "CTRL", wezterm.action.ReloadConfiguration)
key_binding:add_key("L", "CTRL", wezterm.action.ShowDebugOverlay)
key_binding:add_key("W", "CTRL", wezterm.action.CloseCurrentTab({ confirm = true }))
key_binding:add_key("`", "CTRL", wezterm.action.ShowLauncher)

local function add_arrow_scroll_bindings(helper, mods, action, n)
    helper:add_key("UpArrow", mods, action(-n))
    helper:add_key("DownArrow", mods, action(n))
end

add_arrow_scroll_bindings(key_binding, "ALT", wezterm.action.ScrollByPage, 0.5)
add_arrow_scroll_bindings(key_binding, "CTRL|ALT", wezterm.action.ScrollByPage, 1)
add_arrow_scroll_bindings(key_binding, "ALT|SHIFT", wezterm.action.ScrollByLine, 1)
key_binding:add_key("UpArrow", "CTRL|ALT|SHIFT", wezterm.action.ScrollToTop)
key_binding:add_key("DownArrow", "CTRL|ALT|SHIFT", wezterm.action.ScrollToBottom)

local function add_page_scroll_bindings(helper, mods, action, n)
    helper:add_key("PageUp", mods, action(-n))
    helper:add_key("PageDown", mods, action(n))
end

add_page_scroll_bindings(key_binding, "NONE", wezterm.action.ScrollByPage, 0.5)
add_page_scroll_bindings(key_binding, "CTRL", wezterm.action.ScrollByPage, 1)
add_page_scroll_bindings(key_binding, "ALT", wezterm.action.ScrollByPage, 0.5)
add_page_scroll_bindings(key_binding, "SHIFT", wezterm.action.ScrollByLine, 1)
add_page_scroll_bindings(key_binding, "CTRL|ALT", wezterm.action.ScrollByPage, 1)
add_page_scroll_bindings(key_binding, "CTRL|SHIFT", wezterm.action.ScrollByPage, 0.5)
add_page_scroll_bindings(key_binding, "ALT|SHIFT", wezterm.action.ScrollByLine, 1)
key_binding:add_key("PageUp", "CTRL|ALT|SHIFT", wezterm.action.ScrollToTop)
key_binding:add_key("PageDown", "CTRL|ALT|SHIFT", wezterm.action.ScrollToBottom)

key_binding:add_key("Tab", "CTRL", wezterm.action.ActivateTabRelative(1))
key_binding:add_key("Tab", "SHIFT|CTRL", wezterm.action.ActivateTabRelative(-1))
key_binding:add_key("1", "CTRL", wezterm.action.ActivateTab(0))
key_binding:add_key("2", "CTRL", wezterm.action.ActivateTab(1))
key_binding:add_key("3", "CTRL", wezterm.action.ActivateTab(2))
key_binding:add_key("4", "CTRL", wezterm.action.ActivateTab(3))
key_binding:add_key("5", "CTRL", wezterm.action.ActivateTab(4))
key_binding:add_key("6", "CTRL", wezterm.action.ActivateTab(5))
key_binding:add_key("7", "CTRL", wezterm.action.ActivateTab(6))
key_binding:add_key("8", "CTRL", wezterm.action.ActivateTab(7))
key_binding:add_key("9", "CTRL", wezterm.action.ActivateTab(-1))
key_binding:add_key("0", "CTRL", wezterm.action.ResetFontSize)
key_binding:add_key("-", "CTRL", wezterm.action.DecreaseFontSize)
key_binding:add_key("=", "CTRL", wezterm.action.IncreaseFontSize)
key_binding:add_key("+", "CTRL", wezterm.action.IncreaseFontSize)

key_binding:add_key("LeftArrow", "ALT", wezterm.action.ActivateTabRelative(-1))
key_binding:add_key("RightArrow", "ALT", wezterm.action.ActivateTabRelative(1))
key_binding:add_key("LeftArrow", "ALT|SHIFT", wezterm.action.MoveTabRelative(-1))
key_binding:add_key("RightArrow", "ALT|SHIFT", wezterm.action.MoveTabRelative(1))

key_binding:add_search_mode_key("Escape", "NONE", wezterm.action.CopyMode("Close"))
key_binding:add_search_mode_key("Enter", "NONE", wezterm.action.CopyMode("NextMatch"))
key_binding:add_search_mode_key("Enter", "SHIFT", wezterm.action.CopyMode("PriorMatch"))
key_binding:add_search_mode_key("Tab", "NONE", wezterm.action.CopyMode("CycleMatchType"))
key_binding:add_search_mode_key("c", "CTRL", wezterm.action.CopyMode("ClearPattern"))

local function add_mouse_selection_bindings(helper, streak, action)
    for _, mods in ipairs({ "NONE", "CTRL", "ALT", "CTRL|ALT" }) do
        helper:add_mouse_left_down(streak, mods, wezterm.action.SelectTextAtMouseCursor(action))
        helper:add_mouse_left_drag(streak, mods, wezterm.action.ExtendSelectionToMouseCursor(action))
    end

    for _, mods in ipairs({ "SHIFT", "CTRL|SHIFT", "ALT|SHIFT", "CTRL|ALT|SHIFT" }) do
        helper:add_mouse_left_down(streak, mods, wezterm.action.ExtendSelectionToMouseCursor(action))
        helper:add_mouse_left_drag(streak, mods, wezterm.action.ExtendSelectionToMouseCursor(action))
    end
end

add_mouse_selection_bindings(key_binding, 1, "Cell")
add_mouse_selection_bindings(key_binding, 2, "Word")
add_mouse_selection_bindings(key_binding, 3, "Line")

local function add_mouse_scroll_bindings(helper, mods, action, n)
    helper:add_mouse_scroll_up(mods, n and action(-n) or action)
    helper:add_mouse_scroll_down(mods, n and action(n) or action)
end

add_mouse_scroll_bindings(key_binding, "NONE", wezterm.action.ScrollByCurrentEventWheelDelta)
add_mouse_scroll_bindings(key_binding, "CTRL", wezterm.action.ScrollByPage, 1)
add_mouse_scroll_bindings(key_binding, "ALT", wezterm.action.ScrollByPage, 0.5)
add_mouse_scroll_bindings(key_binding, "SHIFT", wezterm.action.ScrollByLine, 1)
add_mouse_scroll_bindings(key_binding, "CTRL|ALT", wezterm.action.ScrollByPage, 1)
add_mouse_scroll_bindings(key_binding, "CTRL|SHIFT", wezterm.action.ScrollByPage, 0.5)
add_mouse_scroll_bindings(key_binding, "ALT|SHIFT", wezterm.action.ScrollByLine, 1)
add_mouse_scroll_bindings(key_binding, "CTRL|ALT|SHIFT", wezterm.action.ScrollByPage, 1)

-- paste
key_binding:add_mouse_right_down(1, "NONE", wezterm.action.PasteFrom("Clipboard"))

-- open hyperlink
key_binding:add_mouse_left_up(1, "CTRL", wezterm.action_callback(function(window, pane)
    if #window:get_selection_text_for_pane(pane) == 0 then
        window:perform_action(wezterm.action.OpenLinkAtMouseCursor, pane)
    end
end))

key_binding:apply_key_bindings(config, true)
key_binding:apply_key_tables(config)
key_binding:apply_mouse_bindings(config, true)

-- =======================
-- -------- Apply --------
-- =======================

return config
