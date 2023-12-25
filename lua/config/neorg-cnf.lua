-- indent-blankline
local ok, configs = pcall(require, 'neorg')
if not ok then return end

configs.setup({
    load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
                default_workspace = "home",
                workspaces = {
                    home = "~/Sync/Notes/neorg/home",
                    work = "~/Sync/Notes/neorg/work",
                    public = "~/Sync/Notes/neorg/public",
                },
            },
        },
    },
})
