-- ==============================
-- -------- GruvboxColor --------
-- ==============================

local GruvboxColor = {}

-- -------- public --------

function GruvboxColor:new()
    local instance = {}

    instance._LOOKUP_BACKGROUND = setmetatable({}, {
        __index = { dark = "light", light = "dark" },
        __newindex = function() error("_LOOKUP_BACKGROUND is read-only") end,
    })

    instance._LOOKUP_CONTRAST = setmetatable({}, {
        __index = { hard = "medium", medium = "soft", soft = "hard" },
        __newindex = function() error("_LOOKUP_CONTRAST is read-only") end,
    })

    return setmetatable(instance, { __index = self })
end

function GruvboxColor:changeBackground()
    local status, e = pcall(self._changeColor, self, true, false)
    if not status then
        print(e)
    end
end

function GruvboxColor:changeContrast()
    local status, e = pcall(self._changeColor, self, false, true)
    if not status then
        print(e)
    end
end

function GruvboxColor:cycleColor()
    local changeBackground = self:_getContrast() == "soft"

    local status, e = pcall(self._changeColor, self, changeBackground, true)
    if not status then
        print(e)
    end
end

-- -------- private --------

function GruvboxColor:_getBackground()
    return vim.o.background
end

function GruvboxColor:_setBackground(value)
    vim.o.background = value
end

function GruvboxColor:_getContrast()
    if self:_getBackground() == "dark" then
        return vim.g.gruvbox_contrast_dark
    else
        return vim.g.gruvbox_contrast_light
    end
end

function GruvboxColor:_setContrast(value)
    if self:_getBackground() == "dark" then
        vim.g.gruvbox_contrast_dark = value
    else
        vim.g.gruvbox_contrast_light = value
    end
end

function GruvboxColor:_changeColor(changeBackground, changeContrast)
    if vim.g.colors_name ~= "gruvbox" then
        error("GruvboxColor: current colorscheme is not gruvbox", 0)
    end

    if changeBackground then
        self:_setBackground(self._LOOKUP_BACKGROUND[self:_getBackground()])
    end

    if changeContrast then
        self:_setContrast(self._LOOKUP_CONTRAST[self:_getContrast()])
        vim.cmd("colorscheme gruvbox")
    end

    print(string.format("colorscheme: gruvbox - %s %s",
            self:_getContrast(), self:_getBackground()))
end

-- -------- return --------

return GruvboxColor
