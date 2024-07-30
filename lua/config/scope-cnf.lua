-- scope
local ok, configs = pcall(require, "scope")
if not ok then return end

configs.setup()
