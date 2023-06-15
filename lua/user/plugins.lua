local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Install your plugins here
local plugins = {
    -- My plugins here
    { "wbthomason/packer.nvim" }, -- Have packer manage itself
    { "nvim-lua/popup.nvim" },    -- An implementation of the Popup API from vim in Neovim
    { "nvim-lua/plenary.nvim" },  -- Useful lua functions used by lots of plugins
    { "numToStr/Comment.nvim" },  -- Easily comment stuff
    { "nvim-tree/nvim-web-devicons" },
    { 'akinsho/bufferline.nvim',            dependencies = 'nvim-tree/nvim-web-devicons' },
    { "kyazdani42/nvim-tree.lua" },
    { "moll/vim-bbye" },
    { "nvim-lualine/lualine.nvim" },
    -- { "akinsho/toggleterm.nvim" }, -- Terminal inside nvim
    { "ahmedkhalf/project.nvim" },
    { "lukas-reineke/indent-blankline.nvim" }, -- Visual indentlines
    { "goolord/alpha-nvim" },                  -- Startup screen
    { "antoinemadec/FixCursorHold.nvim" },     -- This is needed to fix lsp doc highlight
    { "ap/vim-css-color" },
    { "max397574/better-escape.nvim" },
    -- use { 'filipdutescu/renamer.nvim', branch = 'master', dependencies = { { 'nvim-lua/plenary.nvim' } } }
    { "mattn/emmet-vim" },
    { "CRAG666/code_runner.nvim",           dependencies = "nvim-lua/plenary.nvim" },
    --{ "windwp/nvim-ts-autotag" },
    -- { {
    -- 	"turbio/bracey.vim", -- Live server for Web Dev
    -- 	run = "npm install --prefix server",
    -- })
    -- Rainbow couldn't get it to work
    -- use "luochen1990/rainbow"
    -- use "junegunn/rainbow_parentheses.vim"
    {
        "Pocco81/auto-save.nvim",
        opts = {
            execution_message = {
                message = function()
                    return ""
                end
            }
        }
    },

    -- Input
    { "windwp/nvim-autopairs" }, -- Autopairs, integrates with both cmp and treesitter
    { "folke/which-key.nvim" },
    { "tpope/vim-surround" },
    { "easymotion/vim-easymotion" },

    -- cmake plugin
    { "Civitasv/cmake-tools.nvim",          commit = "f97b83023eb3798f1ddb8a4e431c5bac032f1949" },
    -- { "cdelledonne/vim-cmake" },

    -- Colorschemes
    { "navarasu/onedark.nvim" },
    { "lunarvim/darkplus.nvim" },
    { "LunarVim/Colorschemes" },
    { "morhetz/gruvbox" },
    { "tomasiser/vim-code-dark" },
    { "NTBBloodbath/doom-one.nvim" },

    -- Completion plugins
    { "github/copilot.vim" }, -- Github Copilot

    -- Coc
    -- { { "neoclide/coc.nvim", branch = "release" })
    -- use { "ms-jpq/coq_nvim", branch = "coq"}
    -- use { "ms-jpq/coq.artifacts", branch = "artifacts" }

    -- cmp plugins
    { "hrsh7th/nvim-cmp" },         -- The completion plugin
    { "hrsh7th/cmp-buffer" },       -- buffer completions
    { "hrsh7th/cmp-path" },         -- path completions
    { "hrsh7th/cmp-copilot" },      -- path completions
    { "hrsh7th/cmp-nvim-lua" },     -- path completions
    { "hrsh7th/cmp-calc" },         -- path completions
    { "hrsh7th/cmp-cmdline" },      -- cmdline completions
    { "saadparwaiz1/cmp_luasnip" }, -- snippet completions
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lsp-signature-help" },

    -- snippets
    { "L3MON4D3/LuaSnip" },             --snippet engine
    { "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use

    -- LSP
    { "neovim/nvim-lspconfig" }, -- enable LSP
    { {
        "williamboman/mason.nvim",
        build = ":MasonUpdate"
    } },                                   -- simple to use language server installer
    { "williamboman/mason-lspconfig.nvim" },
    { "tamago324/nlsp-settings.nvim" },    -- language server settings defined in json for
    { "jose-elias-alvarez/null-ls.nvim" }, -- for formatters and linters

    -- Telescope
    { "nvim-telescope/telescope.nvim" },
    -- { "nvim-telescope/telescope-media-files.nvim" },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate"
    },
    -- { "JoosepAlviste/nvim-ts-context-commentstring" },

    -- Git
    { "lewis6991/gitsigns.nvim" },
    { "tpope/vim-fugitive" },
    { "sindrets/diffview.nvim" },
    { "kdheepak/lazygit.nvim" },

    { "linux-cultist/venv-selector.nvim" },
    {
        "abecodes/tabout.nvim",
        config = function()
            require("tabout").setup({
                tabkey = "<Tab>",             -- key to trigger tabout, set to an empty string to disable
                backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
                act_as_tab = true,            -- shift content if tab out is not possible
                act_as_shift_tab = false,     -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
                default_tab = "<C-t>",        -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
                default_shift_tab = "<C-d>",  -- reverse shift default action,
                enable_backwards = true,      -- well ...
                completion = true,            -- if the tabkey is used in a completion pum
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
        -- wants = { "nvim-treesitter" }, -- or require if not used so far
        -- after = { 'nvim-cmp' } -- if a completion plugin is using tabs load it before
        -- after = { "coc.nvim" }, -- if a completion plugin is using tabs load it before
    },
    { "xiyaowong/transparent.nvim" },
    { "folke/trouble.nvim" },
    { "mbbill/undotree" },
    { "easymotion/vim-easymotion" },
    { "Eandrju/cellular-automaton.nvim" },
}

local opts = {}

require("lazy").setup(plugins, opts)
