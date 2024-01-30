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
