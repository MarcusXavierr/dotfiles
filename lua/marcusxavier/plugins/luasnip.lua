local ls = require "luasnip"
local types = require "luasnip.util.types"


require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/marcusxavier/snippets" })

ls.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI", --update changes as you type
    enable_autosnippets = true,
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { "●", "GruboxOrange" } } -- this may cause problems
            }
        }
    }
}

-- Go foward on jumpable items
vim.keymap.set({ "i", "s" }, "<c-k>", function ()
    if ls.expand_or_jumpable then
        ls.expand_or_jump()
    end
end, { silent = true })

-- Go backwards on jumpable items
vim.keymap.set({ "i", "s" }, "<c-f>", function ()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })


-- Useful for choice nodes
vim.keymap.set({ "i", "s" }, "<c-l>", function ()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, { silent = true })

vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/marcusxavier/plugins/luasnip.lua<cr>")
