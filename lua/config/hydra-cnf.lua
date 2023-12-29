-- hydra
local hydra_status_ok, configs = pcall(require, "hydra")
if not hydra_status_ok then
    return
end

local Hydra = require('hydra')
local cmd = require('hydra.keymap-util').cmd

local hint = [[

 _o_: old files         _c_: colors
 _g_: git status        _k_: keymaps
 _b_: Sort Buffers      _B_: Close All But Current 
 _n_: number            _l_: list
 _r_: relativenumber    _w_: wrap
 _?_: search history    _;_: commands history
 _s_: spell!            _h_: help tags
 _N_: Neorg home        _z_: ZenMode
 _W_: Neorg work        _Z_: Neorg public
 _i_: IBLToggle

 _p_: Przezroczystość 80%  _P_: Przezroczystość 0% 
 _L_: Czcionka 21          _S_: Czcionka 17
 _V_: Czcionka 12
 ^
          _<Enter>_: FzfLua    _<Esc>_
]]

Hydra({
    name = 'QuickMenu',
    hint = hint,
    config = {
        color = 'teal',
        invoke_on_body = true,
        hint = {
            position = 'middle',
            border = 'rounded',
        },
    },
    mode = 'n',
    body = '<M-o>',
    heads = {
        { 'o', cmd 'FzfLua oldfiles', { desc = 'Ostatnio edytowane pliki' } },
        { 'k', cmd 'FzfLua keymaps' },
        { 'i', cmd 'IBLToggle' },
        { 'c', cmd 'FzfLua colorschemes', { desc = 'colorschemes' } },
        { 'h', cmd 'FzfLua help_tags', { desc = 'vim help' } },
        { 'b', cmd 'BufferOrderByBufferNumber', { desc = 'Sort Buffers' } },
        { 'B', cmd 'BufferCloseAllButCurrent', { desc = 'Zamyka wszystkie bufory poza bieżącym' } },
        { 'g', cmd [[lua require'fzf-lua'.git_status({ winopts = { height=1, width=1 } })]] },
        { 'n', cmd 'set number!' },
        { 'w', cmd 'set wrap!' },
        { 'r', cmd 'set relativenumber!' },
        { 's', cmd 'set spell!' },
        { 'l', cmd 'set list!' },
        { '?', cmd 'FzfLua search_history',  { desc = 'search history' } },
        { ';', cmd 'FzfLua command_history', { desc = 'command-line history' } },
        { 'z', cmd 'ZenMode', { desc = 'ZenMode' } },
        { 'p', cmd 'lua vim.g.neovide_transparency = 0.2' },
        { 'P', cmd 'lua vim.g.neovide_transparency = 1' },
        { 'L', cmd 'lua vim.o.guifont = "Source Code Pro:h21"' },
        { 'S', cmd 'lua vim.o.guifont = "Source Code Pro:h17"' },
        { 'V', cmd 'lua vim.o.guifont = "Source Code Pro:h12"' },
        { 'N', cmd 'Neorg workspace home', { desc = 'Neorg home workspace' } },
        { 'Z', cmd 'Neorg workspace public', { desc = 'Neorg public workspace' } },
        { 'W', cmd 'Neorg workspace work', { desc = 'Neorg work workspace' } },
        { '<Enter>', cmd 'FzfLua', { exit = true, desc = 'list all pickers' } },
        { '<Esc>', nil, { exit = true, nowait = true } },
    }
})
