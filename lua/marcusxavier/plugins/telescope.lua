local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local Path = require('plenary.path')

-- Função para copiar o path relativo do arquivo
local function copy_file_path()
  local entry = action_state.get_selected_entry()
  if entry then
    local path = entry.path or entry.filename
    if path then
      -- Converte para path relativo ao cwd/git root
      local relative_path = Path:new(path):make_relative(vim.loop.cwd())
      vim.fn.setreg('+', relative_path)
      vim.notify('Path copiado: ' .. relative_path, vim.log.levels.INFO)
    end
  end
end

require('telescope').setup{
    defaults = {
        file_ignore_patterns = {'vendor', 'public', 'node_modules'},
        width=0.9,
        use_less=true,
        results_width=0.8,
        mappings = {
            i = {
               ['<C-y>'] = copy_file_path,
            },
            n = {
               ['q'] = actions.close,
               ['dd'] = actions.delete_buffer,
               ['y'] = copy_file_path,
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
require('telescope').load_extension('dap')
