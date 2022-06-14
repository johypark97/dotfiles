-- ===============================
-- -------- gruvbox-color --------
-- ===============================

local GruvboxColor = {}

-- -------- private --------

GruvboxColor._lookup = setmetatable({}, {
    __index = { hard = 'medium', medium = 'soft', soft = 'hard' },
    __newindex = function() error("'_lookup' is read-only") end,
})

function GruvboxColor:_getContrast()
    if vim.o.background == 'dark' then
        return vim.g.gruvbox_contrast_dark
    else
        return vim.g.gruvbox_contrast_light
    end
end

function GruvboxColor:_setContrast(value)
    if vim.o.background == 'dark' then
        vim.g.gruvbox_contrast_dark = value
    else
        vim.g.gruvbox_contrast_light = value
    end
end

function GruvboxColor:_change(changeBackground, changeContrast)
    if vim.g.colors_name ~= 'gruvbox' then
        vim.cmd('echo "colorscheme is not gruvbox"')
        return
    end

    if changeBackground then
        if vim.o.background == 'dark' then
            vim.o.background = 'light'
        else
            vim.o.background = 'dark'
        end
    end

    local contrast = self:_getContrast()
    if changeContrast then
        contrast = self._lookup[contrast]
        self:_setContrast(contrast)
        vim.cmd('colorscheme gruvbox')
    end

    vim.cmd(string.format('echo "colorscheme: gruvbox - %s %s"', contrast, vim.o.background))
end

-- -------- public --------

function GruvboxColor:changeBackground()
    self:_change(true, false)
end

function GruvboxColor:changeContrast()
    self:_change(false, true)
end

function GruvboxColor:cycle()
    local contrast = self:_getContrast()
    self:_change(contrast == 'soft', true)
end

-- -------- return --------

return GruvboxColor
