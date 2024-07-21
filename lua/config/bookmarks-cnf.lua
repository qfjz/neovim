-- bookmarks.nvim
local ok, configs = pcall(require, 'bookmarks')
if not ok then return end

configs.setup()
