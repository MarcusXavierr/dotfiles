call plug#begin()
Plug 'sainnhe/sonokai'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'dense-analysis/ale', {'for': ['html', 'vue', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact']}
Plug 'vimwiki/vimwiki'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim', {'for': ['html', 'vue', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact']}
Plug 'voldikss/vim-floaterm'
Plug 'APZelos/blamer.nvim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'dracula/vim', { 'as': 'dracula' }
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate', 'commit' : '4cccb6f494eb255b32a290d37c35ca12584c74d0'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate' }
Plug 'rmagatti/auto-session', { 'commit': '39319bf7ad15a1881f180fa7c14bf6703775035e' }
" Plug 'ActivityWatch/aw-watcher-vim'
Plug 'vim-test/vim-test'
if (has("nvim"))
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }
    Plug 'karb94/neoscroll.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    Plug 'numToStr/Comment.nvim'
    Plug 'navarasu/onedark.nvim'
    Plug 'nvim-tree/nvim-tree.lua'
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'folke/tokyonight.nvim'
    Plug 'andrewferrier/debugprint.nvim'
    Plug 'folke/todo-comments.nvim'
    Plug 'rafamadriz/friendly-snippets'
    Plug 'kylechui/nvim-surround'
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    " tsserver alternative (too early)
    "Plug 'pmizio/typescript-tools.nvim'
    endif

call plug#end()

" INFO: Plugin configurations
lua require('marcusxavier.plugins.lsp')
lua require('marcusxavier.plugins.debugprint')
lua require('marcusxavier.plugins.todo')
lua require('marcusxavier.plugins.treesitter.index')
lua require('marcusxavier.plugins.luasnip')
lua require('marcusxavier.plugins.comment_nvim')
lua require('marcusxavier.plugins.telescope')

" INFO: A last but not least, others plugins configurations
lua require('marcusxavier.plugins.others')

" Global Sets """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set syntax=off            " Enable syntax highlight
set nu               " Enable line numbers
set rnu
set tabstop=4        " Show existing tab with 4 spaces width
set softtabstop=4    " Show existing tab with 4 spaces width
set shiftwidth=4     " When indenting with '>', use 4 spaces width
set expandtab        " On pressing tab, insert 4 spaces
set smarttab         " insert tabs on the start of a line according to shiftwidth
set smartindent      " Automatically inserts one extra level of indentation in some cases
set hidden           " Hides the current buffer when a new file is openned
set incsearch        " Incremental search
set ignorecase       " Ingore case in search
set smartcase        " Consider case if there is a upper case character
set scrolloff=9      " Minimum number of lines to keep above and below the cursor
set signcolumn=yes   " Add a column on the left. Useful for linting
"set cmdheight=2      " Give more space for displaying messages
set updatetime=100   " Time in miliseconds to consider the changes
set encoding=utf-8   " The encoding should be utf-8 to activate the font icons
set nobackup         " No backup files
set nowritebackup    " No backup files
set splitright       " Create the vertical splits to the right
set splitbelow       " Create the horizontal splits below
set autoread         " Update vim after file update from outside
set mouse=a          " Enable mouse support
set updatecount=100
set foldmethod=marker
filetype on          " Detect and set the filetype option and trigger the FileType Event
filetype plugin on   " Load the plugin file for the file type, if any
filetype indent on   " Load the indent file for the file type, if any
"set clipboard=unnamed "This works on macos only
set clipboard=unnamedplus
let g:blamer_enabled = 1
let g:blamer_show_in_insert_modes = 0
let g:blamer_delay = 300
let NERDTreeShowHidden=1
let g:rainbow_active = 1

autocmd Filetype vue setl shiftwidth=2
autocmd Filetype javascript,typescript setl shiftwidth=2
autocmd Filetype html,javascriptreact,typescriptreact setl shiftwidth=2
autocmd Filetype css,json setl shiftwidth=2
autocmd VimEnter *.md set foldmethod=marker

let g:auto_session_root_dir = '/home/marcus/.config/vim_sessions'
let g:go_doc_keywordprg_enabled = 0

" vim-test configuration
if has('nvim')
    let test#strategy='neovim'
else
    let test#strategy = "floaterm"
endif
let test#php#runner='phpunit'
" let test#php#phpunit#executable=' docker-compose -f ./docker-compose.yml exec -u appmax -T php-fpm vendor/bin/phpunit'
let test#php#phpunit#executable=' docker exec -it optimusPrimeApi vendor/bin/phpunit'


"emmet
let g:user_emmet_leader_key=','
let g:user_emmet_mode='nv'

" Prettier for PHP
function PrettierPhpCursor()
 let save_pos = getpos(".")
  %! prettier --parser=php
  " undo automatically on error
  if v:shell_error | silent undo | endif
  call setpos('.', save_pos)
endfunction
" define custom command

command PrettierPhp call PrettierPhpCursor()

nmap <space>h :call LanguageClient#textDocument_definition()<cr>
nmap <space>k :call LanguageClient#textDocument_codeAction()<cr>
"nmap <space>l :call LanguageClient#handleCodeLensAction()<cr>

nmap <leader><leader>r <cmd>source ~/.config/nvim/init.vim<cr>
"
" Themes """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

"let g:sonokai_style = 'andromeda'
"let g:sonokai_enable_italic = 1
"let g:sonokai_disable_italic_comment = 0
"let g:sonokai_diagnostic_line_highlight = 1
"let g:sonokai_current_word = 'bold'

let g:dracula_italic = 1
let g:dracula_colorterm = 1
let g:dracula_bold = 1
let g:dracula_full_special_attrs_support = 1
let g:airline_theme = 'sonokai'

" colorscheme dracula

let g:onedark_config = {
  \ 'style': 'darker',
  \ 'transparent': v:true,
  \ 'ending_tildes': v:true,
  \ 'diagnostics': {
    \ 'darker': v:false,
    \ 'background': v:true,
    \ 'undercurl': v:true,
  \ },
\ }

" colorscheme onedark
" colorscheme catppuccin

"  syntax on
"  set t_Co=256
"  set cursorline
"  colorscheme onehalfdark
"  let g:airline_theme='onehalfdark'

" if (has("nvim")) "Transparent background. Only for nvim
"    highlight Normal guibg=NONE ctermbg=NONE
"    highlight EndOfBuffer guibg=NONE ctermbg=NONE
" endif

" Remaps"""""""""
lua require('marcusxavier.keybinds')

" Use space as leader"""""""
"  let mapleader=" "
"  nnoremap <SPACE> <Nop>

" Shortcuts for split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l


noremap <space>/ :split<CR> :resize 10<CR> :term<CR>

" Create a tab
nmap te :tabe<CR>

" Navigate between buffers
"nmap ty :BufferNext<CR>
"nmap tr :BufferPrevious<CR>

"Floatterm""""""""""""""""""""
let g:floaterm_keymap_new = '[ft'
let g:floatterm_width = 0.9
let g:floaterm_keymap_hide = '[fc'
let g:floaterm_keymap_toggle = '[fd'
"

"Speller
nnoremap sa zg " Mark word as correct
nnoremap sc z= " Correct word

"mkdx
let g:mkdx#settings = { 'map': { 'prefix': '<space>' } }


" utilitarios
nnoremap <silent><space>i `^
map sd :mksession! ~/vim_session <cr>

"PrettierPhp
nnoremap <leader>p :PrettierPhp<CR>
nmap <space>e :NvimTreeToggle<cr>
lua require("nvim-tree").setup()
"PHP_CODESNIFFER
nnoremap <leader>cs :! php ~/.php/phpcs --standard=PSR12 %:p <CR>
nnoremap <leader>cb :! php ~/.php/phpcbf --standard=PSR12 %:p <CR>
"" A syntax for placeholders
" Pressing Control-j jumps to the next match.
nmap <space><space> <Esc>/<++><CR><Esc>cf>
"
" autocmd"""""""""
augroup teste
autocmd!
autocmd WinEnter ~/appmax/sistema/.git/COMMIT_EDITMSG 0r !~/.config/nvim/.script
augroup END

autocmd BufNewFile ~/my_wiki/diary/*.wiki 0r !~/my_wiki/diary/template.py '%'

autocmd BufNewFile,BufRead *.blade.php set syntax=html
autocmd BufNewFile,BufRead *.blade.php set filetype=html
"
"
" autocmds aqui

" AirLine """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1


" nerdtree"""""""""""""""""""""""""
nmap <space>; :NERDTreeToggle<CR>


" ALE """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_linters = {
\}

let g:ale_fixers = {
\   '*': ['trim_whitespace'],
\}

let g:ale_fix_on_save = 1



"TREESITTER """"""""""""""""""""""""""""""
if has("nvim-0.5.0")

lua << EOF
require'colorizer'.setup({
  '*'; -- Highlight all files, but customize some others.
  css = { rgb_fn = true; names = true; hsl_fn = true}; -- Enable parsing rgb(...) functions in css.
  scss = { rgb_fn = true; names = true; hsl_fn = true}; -- Enable parsing rgb(...) functions in css.
  vue = { names = true; }; -- Enable parsing rgb(...) functions in css.
  },
  { names = false }
)

require("tokyonight").setup({
    style = "storm",
    terminal_colors = true,
    transparent = false,
       styles = {
       sidebars = "transparent",
       floats = "transparent",
    },
})
EOF
end

colorscheme tokyonight

"---------------------------------Fold configuration
set foldtext=CustomText()

function! CustomText()
     "get first non-blank line
    let fs = v:foldstart
    while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
    endwhile
    if fs > v:foldend
        let line = getline(v:foldstart)
    else
        let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
    endif

    let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
    let foldSize = 1 + v:foldend - v:foldstart
    let foldSizeStr = " " . foldSize . " lines "
    let foldLevelStr = repeat(" ┣━━", v:foldlevel)
    let lineCount = line("$")
    let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
    let expansionString = repeat("━", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
    return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endfunction
"------------------------------ End fold configuration

" ========================================================= VIM WIKI CONFIGURATION
let wiki = {}
let wiki.path = '~/tmp/wiki/'
let wiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp', 'haskell': 'hs', 'php': 'php'}
let wiki.syntax = 'markdown'
let wiki.ext = '.md'

let interviews = {}
let interviews.path = "~/tmp/wiki/interviews/"
let interviews.syntax = 'markdown'
let interviews.ext = '.md'

let tasks = {}
let tasks.path = "~/tmp/wiki/tasks/"
let tasks.syntax = 'markdown'
let tasks.ext = '.md'

" Now, configure vim wiki list
let g:vimwiki_list = [wiki, interviews, tasks]
" let g:vimwiki_folding = 'list'
let g:vimwiki_listsyms = ' ○◐●✓'
let g:vimwiki_folding = 'custom'
" =======================================================
"


nmap <leader>d 0oo##jj:pu=strftime('%y-%m-%d %H:%M')0DkA jjpoo   ### Situation: <++>jjoo### Emotions: <++>jjoo### Thoughts: <++>jj
nmap <leader>mc oocardjj:pu=strftime('%y-%m-%d')Dk$a_jjpv0

"Zettelkasten boilerplate
nmap <leader>z :pu=strftime('%Y-%m-%d %H:%M')DkijjpjiStatus: #ideajjooTags:jjopjoo# jj:pu=expand('%:t:r')Dklpjoo----# Referencesjj

" nmap oi Ojjj
" nmap op ojjk
" nmap oo ojjhxi
" nmap ty :bn<cr>
" nmap tr :bp<cr>
" nmap td :bd<cr>

function ApplyMarksToVueFile()
    silent! /<script/mark s
    silent! /computed:/mark c
    silent! /methods:/mark m
    silent! /<style/mark u
    silent! /watch:/mark w
    silent! /data.*(/mark d
endfunction

command SetMarksVue call ApplyMarksToVueFile()
nmap <space>v <cmd>SetMarksVue<cr>

"tmp mappings
nmap <space>jt :!npx jest
