-- hydra
local hydra_status_ok, configs = pcall(require, "hydra")
if not hydra_status_ok then
    return
end

local Hydra = require('hydra')
local cmd = require('hydra.keymap-util').cmd

local hint = [[

 _O_: Ostatnia sesja       _o_: old files
 _n_: number               _l_: list
 _r_: relativenumber       _w_: wrap
 _m_: Usuń Middle Dot      _M_: Dodaj Middle Dot
 _i_: IBLToggle            _z_: ZenMode
 _c_: colors               _k_: keymaps
 _?_: search history       _;_: commands history
 _b_: Sort Buffers         _B_: Close All But Current 
 _s_: spell!               _h_: help tags
 _N_: Neorg home           _W_: Neorg work
 _Z_: Neorg public         _g_: git status

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
        { ';', cmd 'FzfLua command_history', { desc = 'command-line history' } },
        { '?', cmd 'FzfLua search_history',  { desc = 'search history' } },
        { 'B', cmd 'BufferCloseAllButCurrent', { desc = 'Zamyka wszystkie bufory poza bieżącym' } },
        { 'b', cmd 'BufferOrderByBufferNumber', { desc = 'Sort Buffers' } },
        { 'c', cmd 'FzfLua colorschemes', { desc = 'colorschemes' } },
        { 'g', cmd [[lua require'fzf-lua'.git_status({ winopts = { height=1, width=1 } })]] },
        { 'h', cmd 'FzfLua help_tags', { desc = 'vim help' } },
        { 'i', cmd 'IBLToggle' },
        { 'k', cmd 'FzfLua keymaps' },
        { 'L', cmd 'lua vim.o.guifont = "Source Code Pro:h21"' },
        { 'l', cmd 'set list!' },
        { 'M', cmd [[lua vim.opt.listchars:append("space:·")]] },
        { 'm', cmd [[lua vim.opt.listchars:remove("space")]] },
        { 'N', cmd 'Neorg workspace home', { desc = 'Neorg home workspace' } },
        { 'n', cmd 'set number!' },
        { 'o', cmd 'FzfLua oldfiles', { desc = 'Ostatnio edytowane pliki' } },
        { 'O', cmd [[lua require('persistence').load({ last = true })]] },
        { 'p', cmd 'lua vim.g.neovide_transparency = 0.2' },
        { 'P', cmd 'lua vim.g.neovide_transparency = 1' },
        { 'r', cmd 'set relativenumber!' },
        { 'S', cmd 'lua vim.o.guifont = "Source Code Pro:h17"' },
        { 's', cmd 'set spell!' },
        { 'V', cmd 'lua vim.o.guifont = "Source Code Pro:h12"' },
        { 'W', cmd 'Neorg workspace work', { desc = 'Neorg work workspace' } },
        { 'w', cmd 'set wrap!' },
        { 'Z', cmd 'Neorg workspace public', { desc = 'Neorg public workspace' } },
        { 'z', cmd 'ZenMode', { desc = 'ZenMode' } },
        { '<Enter>', cmd 'FzfLua', { exit = true, desc = 'list all pickers' } },
        { '<Esc>', nil, { exit = true, nowait = true } },
    }
})
