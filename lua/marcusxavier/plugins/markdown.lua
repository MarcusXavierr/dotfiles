require('render-markdown').setup({
    file_types = { 'markdown', 'vimwiki' },
})

vim.treesitter.language.register('markdown', 'vimwiki')
