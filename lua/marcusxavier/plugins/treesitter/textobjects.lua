require("nvim-treesitter.configs").setup({
      textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
            ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
            ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
            ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

            -- -- works for javascript/typescript files (custom capture I created in after/queries/ecma/textobjects.scm)
            -- ["a:"] = { query = "@property.outer", desc = "Select outer part of an object property" },
            -- ["i:"] = { query = "@property.inner", desc = "Select inner part of an object property" },
            -- ["l:"] = { query = "@property.lhs", desc = "Select left part of an object property" },
            -- ["r:"] = { query = "@property.rhs", desc = "Select right part of an object property" },

            ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
            ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

            ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
            ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

            ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
            ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

            ["am"] = { query = "@call.outer", desc = "Select outer part of a function call" },
            ["im"] = { query = "@call.inner", desc = "Select inner part of a function call" },

            ["af"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
            ["if"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

            ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
          },
        },
        -- swap = { -- I mean, this isn't working as expected
        --   enable = true,
        --   swap_next = {
        --     ["<space>na"] = "@parameter.inner", -- swap parameters/argument with next
        --     ["<space>n:"] = "@property.outer", -- swap object property with next
        --     ["<space>nf"] = "@function.outer", -- swap function with next
        --   },
        --   swap_previous = {
        --     ["<space>pa"] = "@parameter.inner", -- swap parameters/argument with prev
        --     ["<space>p:"] = "@property.outer", -- swap object property with prev
        --     ["<space>pf"] = "@function.outer", -- swap function with previous
        --   },
        -- },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = { query = "@call.outer", desc = "Next function call start" },
            ["]f"] = { query = "@function.outer", desc = "Next method/function def start" },
            -- ["]c"] = { query = "@class.outer", desc = "Next class start" }, -- Conflicts with gitgutter
            ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
            ["]l"] = { query = "@loop.outer", desc = "Next loop start" },

            -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
            -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
            ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
            ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
          },
          goto_next_end = {
            ["]M"] = { query = "@call.outer", desc = "Next function call end" },
            ["]F"] = { query = "@function.outer", desc = "Next method/function def end" },
            -- ["]C"] = { query = "@class.outer", desc = "Next class end" },
            ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
            ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
          },
          goto_previous_start = {
            ["[m"] = { query = "@call.outer", desc = "Prev function call start" },
            ["[f"] = { query = "@function.outer", desc = "Prev method/function def start" },
            -- ["[c"] = { query = "@class.outer", desc = "Prev class start" },
            ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
            ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
          },
          goto_previous_end = {
            ["[M"] = { query = "@call.outer", desc = "Prev function call end" },
            ["[F"] = { query = "@function.outer", desc = "Prev method/function def end" },
            -- ["[C"] = { query = "@class.outer", desc = "Prev class end" },
            ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
            ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
          },
        },
      },
})
