-- lualine
-- Oryginalny plik konfiguracyjny: https://raw.githubusercontent.com/nvim-lualine/lualine.nvim/master/examples/evil_lualine.lua
local ok, lualine = pcall(require, 'lualine')
if not ok then return end

local lualine = require('lualine')

-- Color table for highlights
-- stylua: ignore
local colors = {
    bg       = '#202328',
    fg       = '#bbc2cf',
    yellow   = '#ECBE7B',
    cyan     = '#008080',
    darkblue = '#081633',
    green    = '#98be65',
    orange   = '#FF8800',
    violet   = '#a9a1e1',
    magenta  = '#c678dd',
    blue     = '#51afef',
    red      = '#ec5f67',
}

local function line_count()
    if vim.fn.mode():find('[\22vV]') then
        local ln_beg = vim.fn.line("v")
        local ln_end = vim.fn.line(".")

        local lines = ln_beg <= ln_end
            and ln_end - ln_beg + 1
            or ln_beg - ln_end + 1

        return lines
        -- znaki + linie
        -- return tostring(vim.fn.wordcount().visual_chars) .. " chars" .. " / " .. tostring(lines) .. " lines"
    else
        return string.upper(vim.fn.mode())
    end
end

local function location()
    -- local line = vim.fn.line('.')
    local col = vim.fn.virtcol('.')
    -- return string.format('%3d:%-2d', line, col)
    return string.format('%-2d', col)
end

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

-- sprawdza listę pluginów do aktualizacji
local lazy_status = require("lazy.status")

-- Config
local config = {
    options = {
        -- Disable sections and component separators
        component_separators = '',
        section_separators = '',
        theme = {
        -- We are going to use lualine_c an lualine_x as left and
        -- right section. Both are highlighted by c theme .  So we
        -- are just setting default looks o statusline
        normal = { c = { fg = colors.fg, bg = colors.bg } },
        inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },
    },
    sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {},
    },
    inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
    },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
end

ins_left {
    function()
        return '▊'
    end,
    color = function()
        -- auto change color according to neovims mode
        local mode_color = {
            n = colors.red,
            i = colors.green,
            v = colors.blue,
            [''] = colors.blue,
            V = colors.blue,
            c = colors.magenta,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [''] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ['r?'] = colors.cyan,
            ['!'] = colors.red,
            t = colors.red,
        }
        return { fg = mode_color[vim.fn.mode()] }
    end,
    padding = { right = 0 },
}

ins_left({
    function()
        local total_lines = vim.fn.line("$")
        return total_lines
    end,
    color = { fg = colors.green, bg = colors.bg },
})

ins_left({ location })

ins_left({
    function()
        -- return char_and_line_count()
        return line_count()
    end,
    color = { fg = colors.blue },
})

ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

ins_left {
    'filesize',
    cond = conditions.buffer_not_empty,
}

ins_left {
    function()
        return '%='
    end,
}

ins_left {
    'filename',
    cond = conditions.buffer_not_empty,
    color = { fg = colors.yellow },
}

ins_right {
    function()
        local ok, pomo = pcall(require, "pomo")
        if not ok then
          return ""
        end

        local timer = pomo.get_first_to_finish()
        if timer == nil then
          return ""
        end

        return "󰄉 " .. tostring(timer)
    end,
}

ins_right {
    lazy_status.updates,
    cond = lazy_status.has_updates,
    color = { fg = colors.white, gui = "bold" },
}

-- ins_right {
    -- 'branch',
    -- icon = '',
    -- color = { fg = colors.violet, gui = 'bold' },
-- }

ins_right {
    'diff',
    -- Is it me or the symbol for modified us really weird
    symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
    diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
    },
    cond = conditions.hide_in_width,
}

ins_right {
    "filetype",
    cond = conditions.hide_in_width,
    color = {},
}

ins_right {
    function()
        local SSH_Client = os.getenv("SSH_CLIENT")
        if SSH_Client ~= nil then
            return "[" .. os.getenv("HOSTNAME") .. "]"
        else
            return ""
        end
    end,
    color = { fg = colors.green },
}

ins_right {
    function()
        return '▊'
    end,
    color = { fg = colors.blue },
    padding = { left = 1 },
}

lualine.setup(config)
