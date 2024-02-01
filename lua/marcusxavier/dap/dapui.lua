require("dapui").setup({
    controls = {
      element = "scopes",
      enabled = true,
      icons = {
        disconnect = "",
        pause = "",
        play = "",
        run_last = "",
        step_back = "",
        step_into = "",
        step_out = "",
        step_over = "",
        terminate = "",
      },
    },
    element_mappings = {},
    expand_lines = false,
    floating = {
        height = 0.9,
        border = "single",
        position="center",
        mappings = {
          close = { "q", "<Esc>" },
        },
    },
    layouts = {
      --   { -- Left panel, I remove it to make my UI more clean
      --   elements = { {
      --       id = "watches",
      --       size = 0.25
      --     }, {
      --       id = "breakpoints",
      --       size = 0.25
      --     }, {
      --       id = "stacks",
      --       size = 0.25
      --     }, {
      --       id = "repl",
      --       size = 0.25
      --     } },
      --   position = "left",
      --   size = 40
      -- },
        {
        elements = {
            {
                id = "stacks",
                size = 0.25
            },
            {
                id = "scopes",
                size = 0.75
            }
        },
        position = "bottom",
        size = 15
      } },
    mappings = {
      edit = "e",
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      repl = "r",
      toggle = "t"
    },
    render = {
      indent = 1,
      max_value_lines = 100
    }
})

local dap, dapui = require("dap"), require("dapui")

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end
