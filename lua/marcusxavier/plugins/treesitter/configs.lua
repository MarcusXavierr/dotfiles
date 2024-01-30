require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "vue", "javascript", "php", "go", "typescript", "python" },

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
