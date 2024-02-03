require('persistent-breakpoints').setup{
	load_breakpoints_event = { "BufReadPost" }
}

require("nvim-dap-virtual-text").setup()
require("dap-go").setup()
require("marcusxavier.dap.dapui")
require("marcusxavier.dap.langs.php")

-- Control nvim dap with function keys
vim.keymap.set("n", "<F5>", ":lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<F8>", ":lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<F9>", ":lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<F10>", ":lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<F11>", ":lua require'dap'.step_out()<CR>")
vim.keymap.set("n", "<F12>", ":lua require('dapui').toggle()<CR>")
vim.keymap.set("n", "<F1>", "<CMD>DapTerminate <CR>")

-- Dealing with breakpoints
-- vim.keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
-- vim.keymap.set("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
-- vim.keymap.set("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")

vim.keymap.set("n", "<leader>b", ":lua require('persistent-breakpoints.api').toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>B", ":lua require('persistent-breakpoints.api').set_conditional_breakpoint()<CR>")
vim.keymap.set("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
vim.keymap.set("n", "<leader>a", "<cmd>lua require('persistent-breakpoints.api').clear_all_breakpoints()<cr>")

vim.keymap.set("n", "<leader>dt", ":lua require'dap-go'.debug_test()<CR>")

-- Show floating elements from dap ui
vim.keymap.set("n", "<leader>dr", function () require("dapui").float_element("repl", { position = "center" }) end)
vim.keymap.set("n", "<leader>dc", function () require("dapui").float_element("console", { position = "center" }) end)
