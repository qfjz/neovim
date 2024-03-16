-- autocomplete-cnf.lua
-- konfiguracja https://lsp-zero.netlify.app/v3.x/autocomplete.html
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local cmp_format = require('lsp-zero').cmp_format()

cmp.setup({
    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        {
            name = 'buffer',
            option = {
                keyword_pattern = [[\k\+]],
                -- keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%([\-.]\w*\)*\)]],
            }
        },
        { name = 'path' },
    },
    mapping = cmp.mapping.preset.insert({
        -- confirm completion
        -- ['<C-y>'] = cmp.mapping.confirm({select = false}),
        ['<CR>'] = cmp.mapping.confirm({select = false}),

        -- poruszanie się pomiędzy kolejnymi podpowiedziami
        ['<Tab>'] = cmp_action.luasnip_supertab(),
        ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),

        -- uruchamia autocomplete na żądanie
        ['<C-Space>'] = cmp.mapping.complete(),

        -- ['<C-e>'] = cmp.mapping.abort(),
        -- ['<C-e>'] = cmp.mapping.abort(),
        -- ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        -- ['<C-d>'] = cmp.mapping.scroll_docs(4),   
        -- ['<Up>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
        -- ['<Down>'] = cmp.mapping.select_next_item({behavior = 'select'}),
        -- ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        -- ['<C-b>'] = cmp_action.luasnip_jump_backward(),
        ['<C-n>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_next_item({behavior = 'insert'})
            else
                cmp.complete()
            end
        end),
        ['<C-p>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item({behavior = 'insert'})
            else
                cmp.complete()
            end
        end),
    }),
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    formatting = cmp_format,
})
