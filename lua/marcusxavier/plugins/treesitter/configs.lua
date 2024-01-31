require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "vue", "javascript", "php", "go", "typescript", "python", "dockerfile", "cpp", "bash" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = {},

  highlight = {
    enable = true,
    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = {'html', 'css'},

    additional_vim_regex_highlighting = {'rkt'},
  },

  indent = {
    enable = true,
    disable = {'vue', 'js', 'html'}
  },
  rainbow = {
    enable = {'rkt'},
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
  },
    incremental_selection = {
        enable=true,
        keymaps={
            init_selection="<C-l>",
            node_incremental="<C-l>",
            scope_incremental=false,
            node_decremental="<bs>",
        }
    }
}
