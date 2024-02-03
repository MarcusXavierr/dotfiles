require('marcusxavier.plugins.mason')
require("neodev").setup({
    library = { plugins = { "nvim-dap-ui" }, types = true }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local map = vim.keymap.set
---@diagnostic disable-next-line: unused-local
local function keymap_lsp(client)
    map('n', 'K', vim.lsp.buf.hover, {buffer=0})
    map('n', 'gd', vim.lsp.buf.definition, {buffer=0})
    map('n', 'gt', vim.lsp.buf.type_definition, {buffer=0})
    map('n', 'gi', vim.lsp.buf.implementation, {buffer=0})
    -- map('n', 'gr', vim.lsp.buf.references, {buffer=0})
    map('n', 'gr', function() require('telescope.builtin').lsp_references() end, {buffer=0}) -- This will show references on telescope with nice preview
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

-- require'lspconfig'.intelephense.setup{
--     capabilities=capabilities,
--     on_attach=keymap_lsp,
-- }

require'lspconfig'.phpactor.setup{
    capabilities=capabilities,
    on_attach=keymap_lsp,
}

-- HACK: Docker config
require'lspconfig'.docker_compose_language_service.setup{
    capabilities=capabilities,
    on_attach=keymap_lsp
}

require'lspconfig'.dockerls.setup{
    capabilities=capabilities,
    on_attach=keymap_lsp
}
-- HACK: End docker config

-- require'lspconfig'.volar.setup{
--     capabilities=capabilities,
--     on_attach=keymap_lsp,
-- }

-- require'lspconfig'.vuels.setup{
--     capabilities=capabilities,
--     on_attach=keymap_lsp,
-- }

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

-- require'lspconfig'.tailwindcss.setup{
--     filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'blade'},
--     capabilities=capabilities,
--     on_attach = function(client)
--         keymap_lsp(client)
--         client.server_capabilities.completionProvider = false
--     end
-- }

require'lspconfig'.racket_langserver.setup{
    capabilities=capabilities,
    on_attach=keymap_lsp
}

require'lspconfig'.astro.setup{
    capabilities=capabilities,
    on_attach=keymap_lsp
}

require'lspconfig'.lua_ls.setup {
  capabilities=capabilities,
  on_attach=keymap_lsp,
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT'
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          library = { vim.env.VIMRUNTIME }
          -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
          -- library = vim.api.nvim_get_runtime_file("", true)
        }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end
}

-- Python LSP
require'lspconfig'.pyright.setup{
    capabilities=capabilities,
    on_attach=keymap_lsp
}

require'lspconfig'.csharp_ls.setup{
    capabilities=capabilities,
    on_attach=keymap_lsp
}

-- require'lspconfig'.eslint.setup({
--   on_attach = function(client, bufnr)
--     vim.api.nvim_create_autocmd("BufWritePre", {
--       buffer = bufnr,
--       command = "EslintFixAll",
--     })
--   end,
-- })

vim.opt.completeopt={"menu", "menuone", "noselect"} -- don't autocomplete first option automatically

require('marcusxavier.plugins.cmp')
require('marcusxavier.autocmd')
