local function map(mode, key, value, silent)
  local options = { noremap = true, silent = (silent and true) }
  vim.keymap.set(mode, key, value, options)
end

-- Shortcuts for split navigation
-- Do later
vim.cmd('map <C-h> <C-w>h')
vim.cmd('map <C-j> <C-w>j')
vim.cmd('map <C-k> <C-w>k')
vim.cmd('map <C-l> <C-w>l')

-- " Adding an empty line below, above and below with insert
map('n', 'op', 'o<Esc>k')
map('n', 'oi', 'O<Esc>j')
map('n', 'oo', 'A<CR>')
map('n', 'oj', 'O')

-- navigation between buffers
map('n', 'ty', ':bn<CR>') -- goto right buffer
map('n', 'tr', ':bp<CR>') -- goto left buffer
map('n', 'td', ':bd<CR>') -- delete buffer

map('n', 'th', ':split<CR>') -- split horizontal
map('n', 'tv', ':vsplit<CR>') -- split vertical

map('n', 'tc', ':!') -- call command
map('n', 'ss', ':w<cr>') -- save file

vim.cmd(':inoremap jj <Esc>') -- best keybind


-- Moving lines
vim.cmd('nnoremap ∆ :m .+1<CR>==')
vim.cmd('nnoremap ˚ :m .-2<CR>==')
vim.cmd('inoremap <A-j> <Esc>:m .+1<CR>==gi')
vim.cmd('inoremap <A-k> <Esc>:m .-2<CR>==gi')
-- vim.cmd('vnoremap <A-j> :m '>+1<CR>gv=gv')
-- vim.cmd('vnoremap <A-k> :m '<-2<CR>gv=gv')

-- Utilities
map('n', 'gb', '`.') --go back
map('n', 'sh', ':noh <CR>') -- remove search highlight

-- GitGutter Mappings
map('n', 'ghs', '<Plug>(GitGutterStageHunk)')
map('n', 'ghu', '<Plug>(GitGutterUndoHunk)')
map('n', 'ghp', '<Plug>(GitGutterPreviewHunk)')

-- Fugitive Mappings
map('n', '<C-g>', ':G <CR>')
map('n', '<space>b', ':G blame <CR>')

-- Vim Go
map('n', 'gt', ':GoTest <CR>')
map('n', 'tg', '<C-j> :bd <CR>')

map('n', '<space>t', ':TestNearest<CR>', true)
map('n', '<space>ft', ':TestFile<CR>', true)
map('n', '<space>fs', ':TestSuite<CR>', true)
map('n', '<space>l', ':TestLast<CR>', true)

vim.cmd('tmap <C-o> <C-\\><C-n>')
