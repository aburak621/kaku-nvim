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
    { "nvim-lua/popup.nvim" },   -- An implementation of the Popup API from vim in Neovim
    { "nvim-lua/plenary.nvim" }, -- Useful lua functions used by lots of plugins
    { "numToStr/Comment.nvim" }, -- Easily comment stuff
    { "nvim-tree/nvim-web-devicons" },
    { 'akinsho/bufferline.nvim',            dependencies = 'nvim-tree/nvim-web-devicons' },
    { "kyazdani42/nvim-tree.lua" },
    { "moll/vim-bbye" },
    { "nvim-lualine/lualine.nvim" },
    { "akinsho/toggleterm.nvim" },             -- Terminal inside nvim
    { "ahmedkhalf/project.nvim" },
    { "lukas-reineke/indent-blankline.nvim" }, -- Visual indentlines
    { "goolord/alpha-nvim" },                  -- Startup screen
    { "antoinemadec/FixCursorHold.nvim" },     -- This is needed to fix lsp doc highlight
    { "ap/vim-css-color" },
    { "max397574/better-escape.nvim" },
    { "mattn/emmet-vim" },
    { "CRAG666/code_runner.nvim",           dependencies = "nvim-lua/plenary.nvim" },
    -- { "turbio/bracey.vim", run = "npm install --prefix server"}, -- Live server for Web Dev
    {
        "okuuva/auto-save.nvim",
        opts = {
            execution_message = {
                enabled = false,
            },
            debounce_delay = 135
        }
    },

    -- Input
    { "windwp/nvim-autopairs" }, -- Autopairs, integrates with both cmp and treesitter
    { "folke/which-key.nvim" },
    { "tpope/vim-surround" },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            { "S", mode = { "n", "o", "x" }, function() require("flash").jump() end, desc = "Flash" },
            {
                "C",
                mode = { "n", "o", "x" },
                function() require("flash").treesitter() end,
                desc =
                "Flash Treesitter"
            },
            {
                "R",
                mode = { "n", "o", "x" },
                function() require("flash").treesitter_search() end,
                desc =
                "Treesitter Search"
            },
        },
    },

    -- cmake plugin
    { "Civitasv/cmake-tools.nvim",          commit = "f97b83023eb3798f1ddb8a4e431c5bac032f1949" },

    -- Colorschemes (Themes)
    { "navarasu/onedark.nvim" },
    { "lunarvim/darkplus.nvim" },
    -- { "LunarVim/Colorschemes" },
    { "morhetz/gruvbox" },
    { "tomasiser/vim-code-dark" },
    { "NTBBloodbath/doom-one.nvim" },
    { "Mofiqul/vscode.nvim" },
    { "BoHomola/vsassist.nvim" },
    { "bartekprtc/gruv-vsassist.nvim" },
    { "rktjmp/lush.nvim" },
    { "folke/tokyonight.nvim" },
    { "catppuccin/nvim",                    name = "catppuccin",                                priority = 1000 },

    -- Completion plugins
    { "github/copilot.vim" }, -- Github Copilot
    -- {
    --     "zbirenbaum/copilot.lua",
    --     config = function()
    --         require("copilot").setup({
    --             suggestion = { enabled = false },
    --             panel = { enabled = false },
    --         })
    --     end
    -- },
    -- {
    --     "zbirenbaum/copilot-cmp",
    --     config = function()
    --         require("copilot_cmp").setup()
    --     end
    -- },

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
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "SmiteshP/nvim-navbuddy",
                dependencies = {
                    "SmiteshP/nvim-navic",
                    "MunifTanjim/nui.nvim"
                },
                opts = { lsp = { auto_attach = true } }
            }
        },
    },
    { "williamboman/mason.nvim" },         -- simple to use language server installer
    { "williamboman/mason-lspconfig.nvim" },
    { "jose-elias-alvarez/null-ls.nvim" }, -- for formatters and linters
    { "RRethy/vim-illuminate" },

    -- Debug
    { "mfussenegger/nvim-dap" },
    { "rcarriga/nvim-dap-ui",             dependencies = "mfussenegger/nvim-dap", event = "VeryLazy" },
    {
        "Weissle/persistent-breakpoints.nvim",
        opts = {
            load_breakpoints_event = { "BufReadPost" }
        }
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        event = "VeryLazy",
        dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
        opts = {
            handlers = {}
        }
    },

    -- Telescope
    { "nvim-telescope/telescope.nvim" },
    { "nvim-telescope/telescope-media-files.nvim" },

    -- Treesitter
    { "nvim-treesitter/nvim-treesitter",          build = ":TSUpdate" },

    -- Git
    { "lewis6991/gitsigns.nvim" },
    { "tpope/vim-fugitive" },
    { "sindrets/diffview.nvim" },
    { "kdheepak/lazygit.nvim" },

    {
        "abecodes/tabout.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-cmp" },
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
    },
    { "xiyaowong/transparent.nvim" },
    { "folke/trouble.nvim" },
    { "mbbill/undotree" },
    { "Eandrju/cellular-automaton.nvim" },
    {
        "Shatur/neovim-session-manager",
        config = function()
            require("session_manager").setup({
                autoload_mode = require("session_manager.config").AutoloadMode.Disabled,
                autosave_ignore_buftypes = { "terminal" },
            })
        end
    },
    {
        "luckasRanarison/nvim-devdocs",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {}
    },
    { "MunifTanjim/nui.nvim" },
    {
        "m4xshen/hardtime.nvim",
        dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
        opts = {
            max_time = 0,
        }
    },
    { "wintermute-cell/gitignore.nvim" },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    },
    { "SmiteshP/nvim-navic", opts = {} },
}

local opts = {}

require("lazy").setup(plugins, opts)
