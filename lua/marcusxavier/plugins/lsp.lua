local capabilities = require('cmp_nvim_lsp').default_capabilities()
local map = vim.keymap.set
---@diagnostic disable-next-line: unused-local
local function keymap_lsp(client)
    map('n', 'K', vim.lsp.buf.hover, {buffer=0})
    map('n', 'gd', vim.lsp.buf.definition, {buffer=0})
    map('n', 'gt', vim.lsp.buf.type_definition, {buffer=0})
    map('n', 'gi', vim.lsp.buf.implementation, {buffer=0})
    map('n', '<space>dj', vim.diagnostic.goto_next, {buffer=0})
    map('n', '<space>dk', vim.diagnostic.goto_prev, {buffer=0})
    map('n', '<space>r', vim.lsp.buf.rename, {buffer=0})
    map('n', '<space>ac', vim.lsp.buf.code_action, {buffer=0})
    map('v', '<space>ar', vim.lsp.buf.range_code_action, {buffer=0})
end

require'lspconfig'.gopls.setup{
    capabilities=capabilities,
    on_attach = keymap_lsp,
}

require'lspconfig'.tsserver.setup{
    capabilities=capabilities,
    on_attach=keymap_lsp,
}

require'lspconfig'.sumneko_lua.setup {
  capabilities=capabilities,
  on_attach=keymap_lsp,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

vim.opt.completeopt={"menu", "menuone", "noselect"}

-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
    }, {
            { name = 'buffer' },
        })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
            { name = 'buffer' },
        })
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
            { name = 'cmdline' }
        })
})

-- Set up lspconfig.
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
