local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Save
keymap("n", "<C-s>", "<cmd>w<CR>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<TAB>", ":bnext<CR>", opts)
keymap("n", "<S-TAB>", ":bprevious<CR>", opts)
keymap("n", "<C-W>", "<cmd>Bdelete!<CR>", opts)

-- Tabs
keymap("n", "<S-h>", "<cmd>tabprevious<CR>", opts)
keymap("n", "<S-l>", "<cmd>tabnext<CR>", opts)
keymap("n", "<C-t>", "<cmd>tabnew<CR>", opts)
keymap("n", "<A-w>", "<cmd>tabclose<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- keymap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)

-- Insert --
-- keymap("i", "<C-y><TAB>", "<Plug>(emmet-expand-abbr)", opts)

-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Move with ctrl + hjkl
-- Ctrl-h equals to Ctrl-backspace you need to choose one or the other
keymap("i", "<C-h>", "<C-w>", opts)
-- keymap("i", "<C-h>", "<Left>", opts)
-- keymap("i", "<C-j>", "<Down>", opts)
-- keymap("i", "<C-k>", "<Up>", opts)
-- keymap("i", "<C-l>", "<Right>", opts)
-- Press ctrl + backspace to delete word
-- Press ctrl + del to delete word to right
keymap("i", "<C-Del>", "<C-o>de", opts)
-- Alt + Enter to insert new line from anywhere
keymap("i", "<A-CR>", "<ESC>o", opts)

-- Visual --
-- Stay in indent mode
keymap("x", "<TAB>", ">gv", opts)
keymap("x", "<S-TAB>", "<gv", opts)
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
keymap("n", "<A-j>", "<cmd>ToggleTerm<cr>", opts)
keymap("i", "<A-j>", "<cmd>ToggleTerm<cr>", opts)
keymap("t", "<A-k>", [[<C-\><C-n>]], opts)
-- Better terminal navigation
keymap("t", "<A-j>", "<cmd>ToggleTerm<cr>", opts)
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- LSP
keymap("n", "<A-q>", "<cmd>lua vim.lsp.buf.hover()<CR>", term_opts)
keymap("i", "<A-q>", "<cmd>lua vim.lsp.buf.hover()<CR>", term_opts)

keymap("n", "<F10>", "<cmd>ClangdSwitchSourceHeader<CR>", opts)

keymap("c", "<C-h>", "<C-w>", { noremap = true, silent = false })

-- DAP
keymap("n", "<F5>", "<cmd>DapContinue<CR>", opts)
keymap("n", "<F6>", "<cmd>DapStepInto<CR>", opts)
keymap("n", "<F7>", "<cmd>DapStepOver<CR>", opts)
keymap("n", "<F8>", "<cmd>DapStepOut<CR>", opts)

-- Bind the function to the semicolon key in insert mode.
vim.api.nvim_set_keymap(
	"i",
	";",
	'<C-o>:lua require("user.semicolon").place_semicolon()<CR>',
	{ noremap = true, silent = true }
)

-- Copilot
keymap("i", "<C-l>", "<cmd>lua require('copilot.suggestion').accept()<CR>", opts)
-- vim.cmd [[imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")]]
vim.cmd([[let g:copilot_no_tab_map = v:true]])
