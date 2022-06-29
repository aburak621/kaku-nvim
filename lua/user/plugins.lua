local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("numToStr/Comment.nvim") -- Easily comment stuff
	use("kyazdani42/nvim-web-devicons")
	use("kyazdani42/nvim-tree.lua")
	use("akinsho/bufferline.nvim")
	use("moll/vim-bbye")
	use("nvim-lualine/lualine.nvim")
	use("akinsho/toggleterm.nvim") -- Terminal inside nvim
	use("ahmedkhalf/project.nvim")
	use("lewis6991/impatient.nvim")
	use("lukas-reineke/indent-blankline.nvim") -- Visual indentlines
	use("goolord/alpha-nvim") -- Startup screen
	use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
	use("ap/vim-css-color")
	use("max397574/better-escape.nvim")
	-- use { 'filipdutescu/renamer.nvim', branch = 'master', requires = { { 'nvim-lua/plenary.nvim' } } }
	-- use "mattn/emmet-vim"
	use({ "CRAG666/code_runner.nvim", requires = "nvim-lua/plenary.nvim" })
	use("windwp/nvim-ts-autotag")
	use({
		"turbio/bracey.vim", -- Live server for Web Dev
		run = "npm install --prefix server",
	})
	-- Rainbow couldn't get it to work
	-- use "luochen1990/rainbow"
	-- use "junegunn/rainbow_parentheses.vim"

	-- Input
	use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
	use("folke/which-key.nvim")
	use("tpope/vim-surround")
	use("easymotion/vim-easymotion")
	use({
		"abecodes/tabout.nvim",
		config = function()
			require("tabout").setup({
				tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
				backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
				act_as_tab = true, -- shift content if tab out is not possible
				act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
				default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
				default_shift_tab = "<C-d>", -- reverse shift default action,
				enable_backwards = true, -- well ...
				completion = true, -- if the tabkey is used in a completion pum
				tabouts = {
					{ open = "'", close = "'" },
					{ open = '"', close = '"' },
					{ open = "`", close = "`" },
					{ open = "(", close = ")" },
					{ open = "[", close = "]" },
					{ open = "{", close = "}" },
				},
				ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
				exclude = {}, -- tabout will ignore these filetypes
			})
		end,
		wants = { "nvim-treesitter" }, -- or require if not used so far
		-- after = { 'nvim-cmp' } -- if a completion plugin is using tabs load it before
		after = { "coc.nvim" }, -- if a completion plugin is using tabs load it before
	})

	-- Colorschemes
	use("lunarvim/colorschemes") -- A bunch of colorschemes you can try out
	use("lunarvim/darkplus.nvim")
	use("navarasu/onedark.nvim")
	use("morhetz/gruvbox")
	use("rafamadriz/neon")
	use("tomasiser/vim-code-dark")

	-- Completion plugins
	-- use("github/copilot.vim") -- Github Copilot

	-- Coc
	use({ "neoclide/coc.nvim", branch = "release" })
	-- use { "ms-jpq/coq_nvim", branch = "coq"}
	-- use { "ms-jpq/coq.artifacts", branch = "artifacts" }

	-- cmp plugins
	-- use "hrsh7th/nvim-cmp" -- The completion plugin
	-- use "hrsh7th/cmp-buffer" -- buffer completions
	-- use "hrsh7th/cmp-path" -- path completions
	-- use "hrsh7th/cmp-cmdline" -- cmdline completions
	-- use "saadparwaiz1/cmp_luasnip" -- snippet completions
	-- use "hrsh7th/cmp-nvim-lsp"

	-- snippets
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/nvim-lsp-installer") -- simple to use language server installer
	use("tamago324/nlsp-settings.nvim") -- language server settings defined in json for
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-media-files.nvim")

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("JoosepAlviste/nvim-ts-context-commentstring")

	-- Git
	use("lewis6991/gitsigns.nvim")
	use("tpope/vim-fugitive")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
