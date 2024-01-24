--
-- TODO - Move this to a helper file
local function map(mode, key, value, silent)
  local options = { noremap = true, silent = (silent and true) }
  vim.keymap.set(mode, key, value, options)
end

require('debugprint').setup({
    display_counter = false,
    display_snippet = false,
    print_tag = "DBG"
})

vim.keymap.set("n", "<space>gp", function()
    return require('debugprint').debugprint()
end, {
    expr = true,
})

vim.keymap.set("n", "<space>gP", function()
    return require('debugprint').debugprint({ above = true })
end, {
    expr = true,
})

vim.keymap.set({"n", "v"}, "<space>gv", function()
    return require('debugprint').debugprint({ variable = true })
end, {
    expr = true,
})

vim.keymap.set("n", "<space>gV", function()
    return require('debugprint').debugprint({ above = true, variable = true })
end, {
    expr = true,
})


map('n', '<space>gd', '<cmd>DeleteDebugPrints<cr>')
