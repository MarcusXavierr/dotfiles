require('marcusxavier.themes.tokyonight')
require('marcusxavier.themes.onedark')
require('marcusxavier.themes.fluoromachine')

vim.g.gruvbox_contrast_light = 'soft'
local is_light = true

if is_light then
    vim.cmd.colorscheme('catppuccin-latte')
    vim.o.background = 'light'
else
-- vim.cmd.colorscheme('catppuccin-macchiato')
-- vim.cmd.colorscheme('gruvbox')
vim.cmd.colorscheme('onedark')
end
