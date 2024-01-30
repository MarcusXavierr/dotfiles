
-- INFO: nvim surround
require('nvim-surround').setup()

-- INFO: neoscroll
require('neoscroll').setup()
local t = {}
-- Syntax: t[keys] = {function, {function arguments}}
t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '200'}}
t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '200'}}

t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '400'}}
t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '400'}}

require('neoscroll.config').set_mappings(t)


-- INFO: Bufferline
local function setupBufferline()
require('bufferline').setup({
    options= {
        max_name_length = 30,
        tab_size = 15
    }
})
end

vim.api.nvim_create_autocmd("VimEnter", {
  pattern = { "*" },
  callback = setupBufferline,
})
