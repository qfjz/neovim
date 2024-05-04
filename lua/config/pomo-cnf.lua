-- pomo
local ok, configs = pcall(require, 'pomo')
if not ok then return end

configs.setup({
    -- How often the notifiers are updated.
    update_interval = 1000,

    -- nie pokazuje powiadomień, wyświetla informacje w dolnej belce lualine
    -- notifiers = {}

    -- wyświetla standardowe powiadomienia w chmurce
    notifiers = {
        {
            name = "Default",
            opts = {
                sticky = true,
                title_icon = "󱎫",
                text_icon = "󰄉",
            },
        },
    },
})
