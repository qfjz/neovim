-- headlines.nvim
local ok, configs = pcall(require, 'headlines')
if not ok then return end

vim.cmd [[highlight Headline1 guibg=#1e2718]]
vim.cmd [[highlight Headline2 guibg=#21262d]]
vim.cmd [[highlight Headline3 guibg=#21262d]]
vim.cmd [[highlight Headline4 guibg=#21262d]]
vim.cmd [[highlight Headline5 guibg=#21262d]]
vim.cmd [[highlight CodeBloc6 guibg=#21262d]]
vim.cmd [[highlight Dash guifg=#536073 guibg=#21262d gui=bold]]

configs.setup({
    markdown = {
        headline_highlights = { "Headline" },
        bullet_highlights = {
            "@text.title.1.marker.markdown",
            "@text.title.2.marker.markdown",
            "@text.title.3.marker.markdown",
            "@text.title.4.marker.markdown",
            "@text.title.5.marker.markdown",
            "@text.title.6.marker.markdown",
        },
        bullets = { "◉", "○", "✸", "✿" },
        -- bullets = { "󰎤", "󰎧", "󰎪", "󰎭", "󰎱", "󰎳" },
        -- bullets = { "󰎤", "󰎧", "󰎪", "󰎮", "󰎰", "󰎵" },
        codeblock_highlight = "CodeBlock",
        dash_highlight = "Dash",
        dash_string = "-",
        quote_highlight = "Quote",
        quote_string = "┃",
        fat_headlines = true,
        fat_headline_upper_string = "▃",
        fat_headline_lower_string = "🬂"
    },
    norg = {
        headline_highlights = { "Headline" },
        bullet_highlights = {
            "@neorg.headings.1.prefix",
            "@neorg.headings.2.prefix",
            "@neorg.headings.3.prefix",
            "@neorg.headings.4.prefix",
            "@neorg.headings.5.prefix",
            "@neorg.headings.6.prefix",
        },
        bullets = { "◉", "○", "✸", "✿" },
        -- bullets = { "󰎤", "󰎧", "󰎪", "󰎭", "󰎱", "󰎳" },
        -- bullets = { "󰎤", "󰎧", "󰎪", "󰎮", "󰎰", "󰎵" },
        codeblock_highlight = "CodeBlock",
        dash_highlight = "Dash",
        dash_string = "-",
        doubledash_highlight = "DoubleDash",
        doubledash_string = "=",
        quote_highlight = "Quote",
        quote_string = "┃",
        fat_headlines = true,
        fat_headline_upper_string = "▃",
        fat_headline_lower_string = "🬂",
    },
})
