vim.cmd[[silent! language en_US]]
vim.opt.timeoutlen = 600
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.autowrite = false
vim.opt.encoding = "utf-8"
vim.opt.numberwidth = 5
vim.opt.cmdheight = 2
vim.opt.laststatus = 3
vim.opt.clipboard:append({"unnamed", "unnamedplus"})
vim.opt.completeopt = ({"menu", "menuone", "noselect"})
vim.opt.conceallevel = 0
vim.opt.whichwrap:append("<,>,h,l")
vim.opt.iskeyword:append("-,_,*")
vim.opt.listchars = "nbsp:⦸,tab:▸ ,eol:¬,extends:»,precedes:«,trail:•,space:·" -- eol ↲
vim.opt.showbreak = "↪"
vim.opt.confirm = true
vim.opt.autochdir = false
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.list = true
vim.opt.backspace = "3"
vim.opt.path:remove("/usr/include")
vim.opt.path:append("**")
vim.opt.wildignore = "*/.git/*,*/.hg/*,*/.svn/*.,*/.DS_Store,*/node_modules/*"
vim.opt.wildignore:append("*share/nvim/runtime/colors/*")  -- wyłączenie standardowych schematów kolorystycznych
vim.opt.backup = false
vim.opt.scrolloff = 999
vim.opt.textwidth = 100
vim.opt.colorcolumn = "+1"  -- textwidth + 1
vim.opt.conceallevel = 0
vim.opt.confirm = true
vim.opt.fillchars = { eob = ' ' }
vim.opt.incsearch = true
vim.opt.inccommand = "split"
vim.opt.redrawtime = 1000
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.magic = true
vim.opt.virtualedit = "block"  -- block, insert, all, onemore, none
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true -- enable persistent undo
vim.opt.undolevels = 10000
vim.opt.signcolumn = "yes"  -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.foldmethod = "manual"
vim.opt.foldenable = false
vim.opt.updatetime = 300
-- Neovide
if vim.g.neovide then
    local function alpha()
        return string.format("%x", math.floor((255 * vim.g.transparency) or 0.8))
    end
    vim.o.guifont = "Source Code Pro:h12"
    vim.g.neovide_transparency = 1
    -- vim.g.neovide_transparency = 0.7
    vim.g.transparency = 0.9
    vim.g.neovide_background_color = "#0f1117" .. alpha()
    vim.g.neovide_cursor_animation_length = 0.03
    vim.g.neovide_cursor_vfx_mode = "railgun"
    vim.cmd[[silent! colorscheme bamboo]]
    vim.cmd[[highlight Cursor guifg=black guibg=#fbb829]]
    vim.cmd[[highlight iCursor guifg=black guibg=#0aaeb3]]
    vim.cmd[[highlight oCursor guifg=black guibg=#ff5f00]]
    vim.cmd[[set guicursor=n-v-c:block-Cursor]]
    vim.cmd[[set guicursor+=i-ci-ve:ver25-iCursor,r-cr:hor20-iCursor,o:hor50-oCursor]]
    vim.cmd[[set guicursor+=a:blinkwait700-blinkoff400-blinkon250]]
    vim.keymap.set("n", "<c-/>", "<Plug>kommentary_line_default", {})
    vim.keymap.set("x", "<c-/>", "<Plug>kommentary_visual_default", {})
    vim.keymap.set("i", "<S-Insert>", "<c-r>*")
    vim.keymap.set("i", "<C-S-V>", "<c-r>*")
    vim.keymap.set("n", "<S-Insert>", [["*p]])
    vim.keymap.set("n", "<C-S-V>", [["*p]])
end
