-- nvim-notify
local ok, configs = pcall(require, 'notify')
if not ok then return end

vim.notify = require("notify")

vim.cmd[[highlight NotifyERRORBorder guifg=#8A1F1F]]
vim.cmd[[highlight NotifyWARNBorder guifg=#79491D]]
vim.cmd[[highlight NotifyINFOBorder guifg=#4F6752]]
vim.cmd[[highlight NotifyDEBUGBorder guifg=#8B8B8B]]
vim.cmd[[highlight NotifyTRACEBorder guifg=#4F3552]]
vim.cmd[[highlight NotifyERRORIcon guifg=#F70067]]
vim.cmd[[highlight NotifyWARNIcon guifg=#F79000]]
vim.cmd[[highlight NotifyINFOIcon guifg=#A9FF68]]
vim.cmd[[highlight NotifyDEBUGIcon guifg=#8B8B8B]]
vim.cmd[[highlight NotifyTRACEIcon guifg=#D484FF]]
vim.cmd[[highlight NotifyERRORTitle  guifg=#F70067]]
vim.cmd[[highlight NotifyWARNTitle guifg=#F79000]]
vim.cmd[[highlight NotifyINFOTitle guifg=#A9FF68]]
vim.cmd[[highlight NotifyDEBUGTitle  guifg=#8B8B8B]]
vim.cmd[[highlight NotifyTRACETitle  guifg=#D484FF]]
vim.cmd[[highlight link NotifyERRORBody Normal]]
vim.cmd[[highlight link NotifyWARNBody Normal]]
vim.cmd[[highlight link NotifyINFOBody Normal]]
vim.cmd[[highlight link NotifyDEBUGBody Normal]]
vim.cmd[[highlight link NotifyTRACEBody Normal]]

configs.setup({
    background_colour = "NotifyBackground",
    fps = 30,
    icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = ""
    },
    level = 2,
    minimum_width = 40,
    max_width = 60,
    max_height = 6,
    wrap = true,
    render = "wrapped-compact",
    stages = "static",
    timeout = 2000,
    top_down = true
})
