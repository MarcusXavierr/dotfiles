local capabilities = require('cmp_nvim_lsp').default_capabilities()
local map = vim.keymap.set
---@diagnostic disable-next-line: unused-local
local function keymap_lsp(client)
    map('n', 'K', vim.lsp.buf.hover, {buffer=0})
    map('n', 'gd', vim.lsp.buf.definition, {buffer=0})
    map('n', 'gt', vim.lsp.buf.type_definition, {buffer=0})
    map('n', 'gi', vim.lsp.buf.implementation, {buffer=0})
    map('n', 'gr', vim.lsp.buf.references, {buffer=0})
    map('n', '<space>dj', vim.diagnostic.goto_next, {buffer=0})
    map('n', '<space>dk', vim.diagnostic.goto_prev, {buffer=0})
    map('n', '<space>df', vim.diagnostic.open_float, {buffer=0})
    map('n', '<space>r', vim.lsp.buf.rename, {buffer=0})
    map('n', '<space>a', vim.lsp.buf.code_action, {buffer=0})
    map('v', '<space>a', vim.lsp.buf.range_code_action, {buffer=0})
end

require'lspconfig'.gopls.setup{
    capabilities=capabilities,
    on_attach = keymap_lsp,
}

require'lspconfig'.tsserver.setup{
    capabilities=capabilities,
    on_attach=keymap_lsp,
}

require'lspconfig'.intelephense.setup{
    capabilities=capabilities,
    on_attach=keymap_lsp,
}

require'lspconfig'.volar.setup{
    capabilities=capabilities,
    on_attach=keymap_lsp,
}

-- C/C++ LSP
require'lspconfig'.clangd.setup{
    capabilities=capabilities,
    on_attach=keymap_lsp,
}

local css_capabilities = require('cmp_nvim_lsp').default_capabilities()
css_capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.cssls.setup{
    capabilities=css_capabilities,
    on_attach=keymap_lsp,
}

require'lspconfig'.tailwindcss.setup{
    filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'blade'},
    capabilities=capabilities,
    on_attach = function(client)
        keymap_lsp(client)
        client.server_capabilities.completionProvider = false
    end
}

require'lspconfig'.racket_langserver.setup{
    capabilities=capabilities,
    on_attach=keymap_lsp
}

require'lspconfig'.astro.setup{
    capabilities=capabilities,
    on_attach=keymap_lsp
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

-- require('trouble').setup{
--     signs = {
--         -- icons / text used for a diagnostic
--         error = "",
--         warning = "",
--         hint = "",
--         information = "",
--         other = "﫠"
--     },
--     use_diagnostic_signs = true
-- }
vim.opt.completeopt={"menu", "menuone", "noselect"} -- don't autocomplete first option automatically

-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
    preselect = cmp.PreselectMode.None,
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
        { name = 'orgmode' }
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
--
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.go" },
  callback = function()
	  vim.lsp.buf.formatting_sync(nil, 500)
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.go" },
	callback = function()
		local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding())
		params.context = {only = {"source.organizeImports"}}

		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
		for _, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding())
				else
					vim.lsp.buf.execute_command(r.command)
				end
			end
		end
	end,
})
