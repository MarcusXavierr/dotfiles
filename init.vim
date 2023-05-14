call plug#begin()
Plug 'sainnhe/sonokai'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'dense-analysis/ale'
Plug 'vimwiki/vimwiki'
" Plug 'neoclide/coc.nvim' , { 'branch' : 'release' }
" Plug 'neoclide/coc.nvim' , { 'commit' : '52032ad89121f16633f23672cec06f1039889879' }
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim', {'for': ['html', 'vue', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact']}
Plug 'voldikss/vim-floaterm'
Plug 'APZelos/blamer.nvim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate', 'commit' : '4cccb6f494eb255b32a290d37c35ca12584c74d0'}
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate' }
Plug 'rmagatti/auto-session'
" Plug 'ActivityWatch/aw-watcher-vim'
" Plug 'OmniSharp/omnisharp-vim'
" Plug 'fatih/vim-go', {'for': 'go'}
Plug 'vim-test/vim-test'
" Plug 'ap/vim-css-color'
" Plug 'christoomey/vim-tmux-navigator'
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
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'folke/tokyonight.nvim'
    " Plug 'anuvyklack/pretty-fold.nvim', { 'for': 'markdown' }
    " Plug 'p00f/nvim-ts-rainbow'
    endif

call plug#end()

lua require('marcusxavier.plugins.lsp')
" lua require('marcusxavier.plugins.coc')

"LuaSnip file
lua require('marcusxavier.plugins.luasnip')
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
filetype on          " Detect and set the filetype option and trigger the FileType Event
filetype plugin on   " Load the plugin file for the file type, if any
filetype indent on   " Load the indent file for the file type, if any
"set clipboard=unnamed
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
" autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync()
" autocmd FileType markdown setlocal foldmethod=marker foldexpr=0

let g:auto_session_root_dir = '/Users/marcusxavier/.config/vim_sessions'
let g:go_doc_keywordprg_enabled = 0

" vim-test configuration
if has('nvim')
    let test#strategy='neovim'
else
    let test#strategy = "floaterm"
endif
let test#php#runner='phpunit'
let test#php#phpunit#executable=' docker-compose -f ./docker-compose.yml exec -u appmax -T php-fpm vendor/bin/phpunit'


"emmet
let g:user_emmet_leader_key=','
let g:user_emmet_mode='nv'

autocmd VimEnter * call s:setup_bufferline()
function! s:setup_bufferline() abort
lua<<EOF
require('bufferline').setup {
    options= {
            max_name_length = 30,
            tab_size = 15
        }
    }
EOF
endfunction

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
  \ 'transparent': v:false,
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

nnoremap <silent><space>1 <cmd>lua require("bufferline").go_to_buffer(1, true)<cr>
nnoremap <silent><space>2 <cmd>lua require("bufferline").go_to_buffer(2, true)<cr>
nnoremap <silent><space>3 <cmd>lua require("bufferline").go_to_buffer(3, true)<cr>
nnoremap <silent><space>4 <cmd>lua require("bufferline").go_to_buffer(4, true)<cr>
nnoremap <silent><space>5 <cmd>lua require("bufferline").go_to_buffer(5, true)<cr>
nnoremap <silent><space>6 <cmd>lua require("bufferline").go_to_buffer(6, true)<cr>
nnoremap <silent><space>7 <cmd>lua require("bufferline").go_to_buffer(7, true)<cr>
nnoremap <silent><space>8 <cmd>lua require("bufferline").go_to_buffer(8, true)<cr>
nnoremap <silent><space>9 <cmd>lua require("bufferline").go_to_buffer(9, true)<cr>
nnoremap <silent><space>$ <cmd>lua require("bufferline").go_to_buffer(-1, true)<cr>

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



" NVIM"""""""""""""""""""
if (has("nvim"))

    " Telescope """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    nnoremap <space>ff <cmd>Telescope find_files<cr>
    nnoremap <space>fg <cmd>Telescope live_grep<cr>
    nnoremap <space>fb <cmd>Telescope buffers<cr>
    nnoremap <space>of <cmd>Telescope oldfiles<cr>
    nnoremap <leader>fh <cmd>Telescope help_tags<cr>
    nnoremap <space>fr <cmd>Telescope resume<cr>
endif




lua <<EOF
local actions = require('telescope.actions')

require('telescope').setup{
    defaults = {
        file_ignore_patterns = {'vendor', 'public', 'node_modules'},
        width=0.9,
        use_less=true,
        results_width=0.8,
        mappings = {
            n = {
               ['q'] = actions.close,
               ['dd'] = actions.delete_buffer,
            }
        }
    },
     extensions = {
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                           -- the default case_mode is "smart_case"
        }
      },
    pickers = {
        buffers = {
         path_display = {'tail'},
        }
      }
}

require('telescope').load_extension('fzf')
EOF

"TREESITTER """"""""""""""""""""""""""""""
if has("nvim-0.5.0")
"nvim-treesitter configuration



lua << EOF

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "vue", "javascript", "php" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = {},

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = {'html', 'css'},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = {'rkt'},
  },

  indent = {
    enable = true,
    disable = {'vue', 'js', 'html'}
  },
  rainbow = {
      enable = {'rkt'},
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
 -- colors = {
 --      "#68a0b0",
 --      "#946EaD",
 --      "#c7aA6D",
 --    },
    -- colors = {}, -- table of hex strings
    termcolors = {
      "Gold",
      "Orchid",
      "DodgerBlue",
      "Cornsilk",
      "Salmon",
      "LawnGreen",
    } -- table of colour name strings
  }
}
EOF

lua <<EOF
require('neoscroll').setup()
local t = {}
-- Syntax: t[keys] = {function, {function arguments}}
t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '200'}}
t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '200'}}

t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '400'}}
t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '400'}}

require('neoscroll.config').set_mappings(t)
EOF

" lua vim.api.nvim_set_hl(0, "TSPunctBracket", { fg = "#888D97" })
" lua vim.api.nvim_set_hl(0, "TSPunctDelimiter", { fg = "#888D97" })

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


require('Comment').setup(
{
    toggler = {
        ---Line-comment toggle keymap
        line = 'gcc',
        ---Block-comment toggle keymap
        block = '<space>cc',
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
        ---Line-comment keymap
        line = 'gc',
        ---Block-comment keymap
        block = '<space>c',
    },
    ---LHS of extra mappings
    extra = {
        ---Add comment on the line above
        above = 'gcO',
        ---Add comment on the line below
        below = 'gco',
        ---Add comment at the end of line
        eol = 'gcA',
    },
    ---Enable keybindings
    ---NOTE: If given `false` then the plugin won't create any mappings
    mappings = {
        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = true,
    },
}
)

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

" Now, configure vim wiki list
let g:vimwiki_list = [wiki, interviews]
" let g:vimwiki_folding = 'list'
let g:vimwiki_listsyms = ' ○◐●✓'
" =======================================================


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

