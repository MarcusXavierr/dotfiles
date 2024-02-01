local function map(mode, key, value, silent)
  local options = { noremap = true, silent = (silent and true) }
  vim.keymap.set(mode, key, value, options)
end


-- INFO: Shortcuts for split navigation
-- Do later
vim.cmd('map <C-h> <C-w>h')
vim.cmd('map <C-j> <C-w>j')
vim.cmd('map <C-k> <C-w>k')
vim.cmd('map <C-l> <C-w>l')

-- INFO:  Adding an empty line below, above and below with insert
map('n', 'op', 'o<Esc>k')
map('n', 'oi', 'O<Esc>j')
map('n', 'oo', 'A<CR>')
map('n', 'oj', 'O')

-- INFO: navigation between buffers
map('n', 'ty', ':bn<CR>') -- goto right buffer
map('n', 'tr', ':bp<CR>') -- goto left buffer
map('n', 'td', ':bd<CR>') -- delete buffer

map('n', 'th', ':split<CR>') -- split horizontal
map('n', 'tv', ':vsplit<CR>') -- split vertical

map('n', 'tc', ':!') -- call command
map('n', 'ss', ':w<cr>') -- save file

vim.cmd(':inoremap jj <Esc>') -- HACK: best keybind


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
map('n', '<leader>c', '<cmd>G commit <CR>')

-- Vim Go
map('n', 'gt', ':GoTest <CR>')
map('n', 'tg', '<C-j> :bd <CR>')

map('n', '<space>t', ':TestNearest<CR>', true)
map('n', '<space>ft', ':TestFile<CR>', true)
map('n', '<space>fs', ':TestSuite<CR>', true)
map('n', '<space>l', ':TestLast<CR>', true)

vim.cmd('tmap <C-o> <C-\\><C-n>')
map('n', '<leader>t', '<cmd>0r !~/Projects/obsidian/template.py <CR>')

--Vimwiki bindings
map('n', '<space>ww', '<cmd> VimwikiIndex<cr>') -- Open Vimwiki index
map('n', '<space>wd', '<cmd> VimwikiDiaryIndex<cr>') -- Open Vimwiki diary index
map('n', '<space>wn', '<cmd> VimwikiMakeDiaryNote<cr>') -- Open today's diary note
map('n', '<space>wt', '<cmd> VimwikiMakeTomorrowDiaryNote<cr>') -- Open tomorrow's diary note
map('n', '<space>wl', '<cmd> VimwikiDiaryGenerateLinks<cr>') -- Open tomorrow's diary note
map({'n', 'v'}, '<space>m', ':VimwikiToggleListItem<cr>') -- Toggle (or create) checkbox
-- map('n', '<space>ml', '<cmd> loadview<cr>') -- Load folds
-- map('n', '<space>mf', '<cmd> mkview<cr>') -- Save folds
-- map('n', '<space>wm', ':norm gg0/----V/----:g/    =Äkb-/norm zzfkÄkbÄkbÄkbÄkbzfksh<cr>')

-- webdev utilitaries
-- map('n', '<space>p', '<cmd>!prettier -w --tab-width=2 % <cr>')
-- Diary cards

-- INFO: Telescope stuff
local builtin = require('telescope.builtin')
map('n', '<space>ff', builtin.find_files)
map('n', '<space>fg', builtin.live_grep)
map('n', '<space>fb', builtin.buffers)
map('n', '<space>of', builtin.oldfiles)
map('n', '<space>fh', builtin.help_tags)
map('n', '<space>fr', builtin.resume)

-- INFO: Buffeline
local b = require("bufferline")
local function bufferline(buffer_number)
   return function()
        b.go_to_buffer(buffer_number, true)
    end
end

map('n', '<space>1', bufferline(1))
map('n', '<space>2', bufferline(2))
map('n', '<space>3', bufferline(3))
map('n', '<space>4', bufferline(4))
map('n', '<space>5', bufferline(5))
map('n', '<space>6', bufferline(6))
map('n', '<space>7', bufferline(7))
map('n', '<space>8', bufferline(8))
map('n', '<space>9', bufferline(9))

-- Just a backup
-- map('n', '<space>1', '<cmd>lua require("bufferline").go_to_buffer(1, true)<cr>')
-- map('n', '<space>2', '<cmd>lua require("bufferline").go_to_buffer(2, true)<cr>')
-- map('n', '<space>3', '<cmd>lua require("bufferline").go_to_buffer(3, true)<cr>')
-- map('n', '<space>4', '<cmd>lua require("bufferline").go_to_buffer(4, true)<cr>')
-- map('n', '<space>5', '<cmd>lua require("bufferline").go_to_buffer(5, true)<cr>')
-- map('n', '<space>6', '<cmd>lua require("bufferline").go_to_buffer(6, true)<cr>')
-- map('n', '<space>7', '<cmd>lua require("bufferline").go_to_buffer(7, true)<cr>')
-- map('n', '<space>8', '<cmd>lua require("bufferline").go_to_buffer(8, true)<cr>')
-- map('n', '<space>9', '<cmd>lua require("bufferline").go_to_buffer(9, true)<cr>')


-- INFO:
map('n', '<space>x', '<cmd>!npx eslint --fix %<cr>') -- HACK: run eslint
map('n', '<space>jx', '<cmd>%! jq . <cr>') -- HACK: format json
map('n', '<space>jm', '<cmd>%! jq -r tostring <cr>') -- HACK: minimize JSON
map('n', '<space>jp', '<cmd>!./vendor/bin/phpcbf --standard=PSR12 --encoding=utf-8 -p --report=code --colors % <cr>')
