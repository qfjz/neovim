-- telescope
local ok, configs = pcall(require, "telescope")
if not ok then
    return
end

configs.setup {
}
