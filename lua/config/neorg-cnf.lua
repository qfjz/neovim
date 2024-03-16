-- neorg
local ok, configs = pcall(require, 'neorg')
if not ok then return end

local neorg_home = os.getenv("NEORG_HOME")
local neorg_work = os.getenv("NEORG_WORK")
local neorg_public = os.getenv("NEORG_PUBLIC")

if neorg_home == nil then
    neorg_home = "$HOME/Sync/Notes/neorg/home"
end

if neorg_work == nil then
    neorg_work = "$HOME/Sync/Notes/neorg/work"
end

if neorg_public == nil then
    neorg_public = "$HOME/Sync/Notes/neorg/public"
end

configs.setup({
    load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.completion"] = {
            config = {
                engine = "nvim-cmp",
            },
        },
        ['core.export'] = {},
        ['core.export.markdown'] = {
            config = {
                extensions = "all",
            },
        },
        ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
                default_workspace = "home",
                workspaces = {
                    home = neorg_home,
                    work = neorg_work,
                    public = neorg_public,
                },
            },
        },
    },
})
