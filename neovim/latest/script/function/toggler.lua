-- =========================
-- -------- Toggler --------
-- =========================

local Toggler = {}

-- -------- public --------

function Toggler:new()
    local instance = {}

    instance.guide = {
        list = vim.o.list,
        number = vim.o.number,
        signcolumn = vim.o.signcolumn,
    }

    return setmetatable(instance, { __index = self })
end

function Toggler:toggleGuide()
    if vim.wo.list == self.guide.list
            and vim.wo.number == self.guide.number
            and vim.wo.signcolumn == self.guide.signcolumn then
        vim.wo.list = false
        vim.wo.number = false
        vim.wo.signcolumn = 'no'
    else
        vim.wo.list = self.guide.list
        vim.wo.number = self.guide.number
        vim.wo.signcolumn = self.guide.signcolumn
    end
end

-- -------- return --------

return Toggler
