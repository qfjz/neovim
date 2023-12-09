vim.cmd[[silent! language en_US]]
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
vim.opt.smartcase = true
vim.opt.magic = true
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true -- enable persistent undo
vim.opt.undolevels = 10000
