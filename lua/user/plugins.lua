local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", })
end
vim.opt.rtp:prepend(lazypath)

-- Install your plugins here
local plugins = {
    --------------------------------------------------------------
    ------------------------ Dependencies ------------------------
    --------------------------------------------------------------
    { "nvim-lua/popup.nvim" }, -- An implementation of the Popup API from vim in Neovim
    { "nvim-lua/plenary.nvim" }, -- Useful lua functions used by lots of plugins
    { "nvim-tree/nvim-web-devicons" },
    { "moll/vim-bbye" },
    { "antoinemadec/FixCursorHold.nvim" }, -- This is needed to fix lsp doc highlight
    { "ap/vim-css-color" },
    { "mattn/emmet-vim" },

    --------------------------------------------------------
    ------------------------ Editor ------------------------
    --------------------------------------------------------
    { "goolord/alpha-nvim" }, -- Startup screen
    { "kyazdani42/nvim-tree.lua" },
    { "akinsho/bufferline.nvim", dependencies = "nvim-tree/nvim-web-devicons" },
    { "nvim-lualine/lualine.nvim" },
    { "SmiteshP/nvim-navic", opts = {} },
    { "akinsho/toggleterm.nvim" }, -- Terminal inside nvim
    { "ahmedkhalf/project.nvim" },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }, -- Visual indentlines
    {
        "okuuva/auto-save.nvim",
        opts = {
            execution_message = {
                enabled = false,
            },
            debounce_delay = 135,
        },
    },
    { "folke/trouble.nvim" },
    { "mbbill/undotree" },
    {
        "Shatur/neovim-session-manager",
        config = function()
            require("session_manager").setup({
                autoload_mode = require("session_manager.config").AutoloadMode.Disabled,
                autosave_ignore_buftypes = { "terminal" },
            })
        end,
        commit = "4376507a99af4a92c85263c30ab8efee0bb2857f",
    },
    { "echasnovski/mini.align", version = false, opts = {} },
    { "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },
    -- { "nmac427/guess-indent.nvim", opts = {} },

    ----------------------------------------------------------------------------------
    ------------------------ Colorschemes (Themes) and Visual ------------------------
    ----------------------------------------------------------------------------------
    { "navarasu/onedark.nvim" },
    { "lunarvim/darkplus.nvim" },
    { "Mofiqul/dracula.nvim" },
    -- { "LunarVim/Colorschemes" },
    { "morhetz/gruvbox" },
    { "tomasiser/vim-code-dark" },
    { "NTBBloodbath/doom-one.nvim" },
    { "Mofiqul/vscode.nvim" },
    { "BoHomola/vsassist.nvim" },
    { "bartekprtc/gruv-vsassist.nvim" },
    { "rktjmp/lush.nvim" },
    { "folke/tokyonight.nvim" },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000, opts = { no_italic = true } },
    { "Shatur/neovim-ayu" },
    { "projekt0n/github-nvim-theme" },
    { "Th3Whit3Wolf/one-nvim" },
    { "xiyaowong/transparent.nvim" },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    {
        "echasnovski/mini.hipatterns",
        config = function()
            local hipatterns = require("mini.hipatterns")
            hipatterns.setup({
                highlighters = {
                    -- Highlight hex color strings (`#rrggbb`) using that color
                    hex_color = hipatterns.gen_highlighter.hex_color(),
                },
            })
        end,
    },

    -----------------------------------------------------------
    ------------------------ Telescope ------------------------
    -----------------------------------------------------------
    { "nvim-telescope/telescope.nvim" },
    { "nvim-telescope/telescope-media-files.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-telescope/telescope-file-browser.nvim", dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" } },

    -------------------------------------------------------
    ------------------------ Input ------------------------
    -------------------------------------------------------
    { "numToStr/Comment.nvim" }, -- Easily comment stuff
    { "windwp/nvim-autopairs" }, -- Autopairs, integrates with both cmp and treesitter
    { "folke/which-key.nvim" },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end,
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "S",
                mode = { "n", "o", "x" },
                function()
                require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "C",
                mode = { "n", "o", "x" },
                function()
                require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
            {
                "R",
                mode = { "n", "o", "x" },
                function()
                require("flash").treesitter_search()
                end,
                desc = "Treesitter Search",
            },
        },
    },
    { "max397574/better-escape.nvim", opts = { timeout = 300, mapping = "jk" } },

    ------------------------------------------------------------
    ------------------------ Completion ------------------------
    ------------------------------------------------------------
    {
        "zbirenbaum/copilot.lua",
        config = function()
            require("copilot").setup({
                suggestion = { auto_trigger = true },
                -- panel = { enabled = false },
            })
        end,
        enabled = false,
    },
    {
        "zbirenbaum/copilot-cmp",
        config = function()
            require("copilot_cmp").setup()
        end,
    },

    -----------------------------------------------------
    ------------------------ Cmp ------------------------
    -----------------------------------------------------
    { "hrsh7th/nvim-cmp" }, -- The completion plugin
    { "hrsh7th/cmp-buffer" }, -- buffer completions
    { "hrsh7th/cmp-path" }, -- path completions
    { "hrsh7th/cmp-copilot" }, -- path completions
    { "hrsh7th/cmp-nvim-lua" }, -- path completions
    { "hrsh7th/cmp-calc" }, -- path completions
    { "hrsh7th/cmp-cmdline" }, -- cmdline completions
    { "saadparwaiz1/cmp_luasnip" }, -- snippet completions
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lsp-signature-help" },

    ----------------------------------------------------------
    ------------------------ Snippets ------------------------
    ----------------------------------------------------------
    { "L3MON4D3/LuaSnip" }, --snippet engine
    { "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use

    -----------------------------------------------------
    ------------------------ LSP ------------------------
    -----------------------------------------------------
    { "neovim/nvim-lspconfig" }, -- enable LSP
    { "williamboman/mason.nvim" }, -- simple to use language server installer
    { "williamboman/mason-lspconfig.nvim" },
    { "nvimtools/none-ls.nvim" }, -- for formatters and linters
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
        config = function()
            require("user.null-ls") -- require your null-ls config here (example below)
        end,
    },
    { "RRethy/vim-illuminate", enabled = true }, -- Disabled because of lag.
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "folke/lazydev.nvim", ft = "lua" },
    -- { "habamax/vim-godot", event = "VimEnter" },

    -------------------------------------------------------------
    ------------------------ Programming ------------------------
    -------------------------------------------------------------
    { "CRAG666/code_runner.nvim", dependencies = "nvim-lua/plenary.nvim" },
    { "Civitasv/cmake-tools.nvim", commit = "565d3a07cf0605a347cb68714015c0eef7213b16" },
    -- { "turbio/bracey.vim", run = "npm install --prefix server"}, -- Live server for Web Dev
    {
        'barrett-ruth/live-server.nvim',
        build = 'npm add -g live-server',
        cmd = { 'LiveServerStart', 'LiveServerStop' },
        config = true
    },

    -----------------------------------------------------
    ------------------------ Git ------------------------
    -----------------------------------------------------
    { "lewis6991/gitsigns.nvim" },
    { "tpope/vim-fugitive" },
    { "kdheepak/lazygit.nvim" },
    { "sindrets/diffview.nvim" },
    { "wintermute-cell/gitignore.nvim" },

    -------------------------------------------------------
    ------------------------ Debug ------------------------
    -------------------------------------------------------
    { "mfussenegger/nvim-dap" },
    { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"}, event = "VeryLazy" },
    {
        "Weissle/persistent-breakpoints.nvim",
        opts = {
            load_breakpoints_event = { "BufReadPost" },
        },
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        event = "VeryLazy",
        dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
        opts = {
            handlers = {},
        },
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        opts = {
            highlight_new_as_changed = true,
            all_references = true,
        },
    },

    --------------------------------------------------------
    ------------------------ Other ------------------------
    --------------------------------------------------------
    {
        "S1M0N38/love2d.nvim",
        cmd = "LoveRun",
        opts = {},
        pin = true,
    },
}

local opts = {}

require("lazy").setup(plugins, opts)
