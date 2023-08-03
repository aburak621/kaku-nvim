vim.loader.enable()
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.colorscheme"
require "user.cmp"
require "user.bufferline"
-- require "user.coc"
require "user.mason"
require "user.lsp"
require "user.telescope"
require "user.treesitter"
require "user.autopairs"
require "user.comment"
require "user.gitsigns"
require "user.nvim-tree"
require "user.tabout"
require "user.lualine"
require "user.toggleterm"
require "user.project"
require "user.indentline"
require "user.alpha"
require "user.whichkey"
require "user.dap"
-- require "user.autocommands"
-- require "user.renamer"
-- -- require "user.coq_nvim"
require "user.code_runner"
require "user.cmake-tools"

require "user.semicolon"
-- Bind the function to the semicolon key in insert mode.
vim.api.nvim_set_keymap('i', ';', '<C-o>:lua require("user.semicolon").place_semicolon()<CR>', { noremap = true, silent = true })
