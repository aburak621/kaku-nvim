vim.loader.enable()
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.colorscheme"
require "user.cmp"
require "user.bufferline"
require "user.mason"
-- require "user.lsp"
require "user.telescope"
require "user.treesitter"
require "user.autopairs"
require "user.comment"
require "user.gitsigns"
require "user.lualine"
require "user.toggleterm"
require "user.project"
-- require "user.indentline"
require "user.alpha"
require "user.whichkey"
require "user.dap"
require "user.code_runner"
require "user.cmake-tools"
require "user.semicolon"
require "user.illuminate"
require "user.nvim-tree"
require "user.luasnip"
require "user.ufofold"
require "user.change_cwd_plugin"
-- require "user.tabout_kakule"
-- require "user.tabout"
require "user.autocommands"
