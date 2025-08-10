require('marcusxavier.themes.tokyonight')
require('marcusxavier.themes.onedark')
require('marcusxavier.themes.fluoromachine')
-- require('marcusxavier.themes.catppuccin')

vim.g.gruvbox_contrast_light = 'soft'
local is_light = false

if is_light then
    vim.cmd.colorscheme('catppuccin-latte')
    vim.o.background = 'light'
else
vim.cmd.colorscheme('catppuccin-macchiato')
-- vim.cmd.colorscheme('catppuccin')
-- vim.cmd.colorscheme('gruvbox')
-- vim.cmd.colorscheme('onedark')
-- vim.cmd.colorscheme('tokyonight')
end
