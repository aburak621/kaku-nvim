-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Install your plugins here
local plugins = {
  --------------------------------------------------------------
  ------------------------ Dependencies ------------------------
  --------------------------------------------------------------
  { "nvim-lua/popup.nvim" },   -- An implementation of the Popup API from vim in Neovim
  { "nvim-lua/plenary.nvim" }, -- Useful lua functions used by lots of plugins
  { "nvim-tree/nvim-web-devicons" },
  { "echasnovski/mini.icons" },
  { "moll/vim-bbye" },
  { "antoinemadec/FixCursorHold.nvim" }, -- This is needed to fix lsp doc highlight
  { "ap/vim-css-color" },
  { "mattn/emmet-vim" },

  --------------------------------------------------------
  ------------------------ Editor ------------------------
  --------------------------------------------------------
  { "goolord/alpha-nvim" }, -- Startup screen
  -- { "kyazdani42/nvim-tree.lua" },
  { 'echasnovski/mini.files', version = '*', opts = { windows = { max_number = 3, preview = true } } },
  { "akinsho/bufferline.nvim", dependencies = "nvim-tree/nvim-web-devicons" },
  { "nvim-lualine/lualine.nvim" },
  { "SmiteshP/nvim-navic", opts = {} },
  { "akinsho/toggleterm.nvim" },                                                                     -- Terminal inside nvim
  { "ahmedkhalf/project.nvim" },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }, -- Visual indentlines
  { "okuuva/auto-save.nvim", opts = { debounce_delay = 135 } },
  { "folke/trouble.nvim", opts = "" },
  { "mbbill/undotree" },
  {
    "Shatur/neovim-session-manager",
    config = function()
      require("session_manager").setup({
        autoload_mode = require("session_manager.config").AutoloadMode.Disabled,
        autosave_ignore_buftypes = { "terminal" },
      })
    end,
  },
  { "echasnovski/mini.align", version = false, opts = {} },
  { "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },
  { "hedyhli/outline.nvim", opts = { outline_window = { position = "left", } } },
  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()
      vim.keymap.set("n", "<F2>", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end, { expr = true })
    end,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    opts = {}
  },
  {
    'b0o/incline.nvim',
    config = function()
      require('incline').setup()
    end,
    event = 'VeryLazy',
  },
  { "LunarVim/bigfile.nvim", },

  ----------------------------------------------------------------------------------
  ------------------------ Colorschemes (Themes) and Visual ------------------------
  ----------------------------------------------------------------------------------
  { "navarasu/onedark.nvim" },
  { "lunarvim/darkplus.nvim" },
  { "Mofiqul/dracula.nvim" },
  { "morhetz/gruvbox" },
  { "tomasiser/vim-code-dark" },
  { "NTBBloodbath/doom-one.nvim" },
  { "Mofiqul/vscode.nvim" },
  { "BoHomola/vsassist.nvim" },
  { "bartekprtc/gruv-vsassist.nvim" },
  { "rktjmp/lush.nvim" },
  { "folke/tokyonight.nvim" },
  { "AstroNvim/astrotheme", opts = "" },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000, opts = { no_italic = true } },
  { "Shatur/neovim-ayu" },
  { "projekt0n/github-nvim-theme" },
  { "xiyaowong/transparent.nvim" },
  { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {}, },
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
  { "nvim-telescope/telescope-ui-select.nvim" },
  { "nvim-telescope/telescope-file-browser.nvim", dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" } },

  -------------------------------------------------------
  ------------------------ Input ------------------------
  -------------------------------------------------------
  { "numToStr/Comment.nvim", opts = {} }, -- Easily comment stuff
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
  {
    "max397574/better-escape.nvim",
    opts = {
      timeout = 300,
      default_mappings = false,
      mappings = {
        i = {
          j = {
            -- These can all also be functions
            k = "<Esc>",
            j = "<Esc>",
          },
        },
      },
    },
  },
  {
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup({ disable_legacy_commands = true })
      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<Leader><Leader>=", "<cmd>IconPickerNormal<cr>", opts)
      vim.keymap.set("n", "<Leader><Leader>+", "<cmd>IconPickerYank<cr>", opts) --> Yank the selected icon into register
      vim.keymap.set("i", "<M-i>", "<cmd>IconPickerInsert<cr>", opts)
    end
  },

  ------------------------------------------------------------
  -------------------------- Copilot -------------------------
  ------------------------------------------------------------
  {
    "zbirenbaum/copilot.lua",
    enabled = true,
    config = function()
      require("copilot").setup({
        suggestion = { auto_trigger = true },
        -- panel = { enabled = false },
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = { "zbirenbaum/copilot.lua", "nvim-lua/plenary.nvim" },
    opts = {},
  },

  -----------------------------------------------------
  ------------------------ Cmp ------------------------
  -----------------------------------------------------
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
  { "hrsh7th/cmp-emoji" },
  { "lukas-reineke/cmp-under-comparator" },

  ----------------------------------------------------------
  ------------------------ Snippets ------------------------
  ----------------------------------------------------------
  { "L3MON4D3/LuaSnip" },             --snippet engine
  { "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use

  -----------------------------------------------------
  ------------------------ LSP ------------------------
  -----------------------------------------------------
  { "williamboman/mason.nvim" }, -- simple to use language server installer
  { "neovim/nvim-lspconfig" },   -- enable LSP
  { "williamboman/mason-lspconfig.nvim" },
  { "nvimtools/none-ls.nvim", dependencies = { "nvimtools/none-ls-extras.nvim" } },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require("user.null-ls") -- require your null-ls config here
    end,
  },
  { "RRethy/vim-illuminate", enabled = true }, -- Disabled because of lag.
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "folke/lazydev.nvim", ft = "lua" },
  { "Bakudankun/PICO-8.vim" },

  -------------------------------------------------------------
  ------------------------ Programming ------------------------
  -------------------------------------------------------------
  { "CRAG666/code_runner.nvim", dependencies = "nvim-lua/plenary.nvim" },
  { "Civitasv/cmake-tools.nvim", ft = "*.cpp", commit = "565d3a07cf0605a347cb68714015c0eef7213b16" },
  -- { "turbio/bracey.vim", run = "npm install --prefix server"}, -- Live server for Web Dev
  {
    'barrett-ruth/live-server.nvim',
    build = 'npm add -g live-server',
    cmd = { 'LiveServerStart', 'LiveServerStop' },
    opts = { args = { '--browser=chrome' } },
  },
  { "danymat/neogen", config = true },

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
  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }, event = "VeryLazy" },
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
  { "Weissle/persistent-breakpoints.nvim", event = "BufReadPost", opts = {} },
  { "LiadOz/nvim-dap-repl-highlights", opts = {} },
  {
    "daic0r/dap-helper.nvim",
    dependencies = { "rcarriga/nvim-dap-ui", "mfussenegger/nvim-dap" },
    config = function()
      require("dap-helper").setup()
    end,
  },
  { "leoluz/nvim-dap-go" },
  { "mfussenegger/nvim-dap-python" },

  --------------------------------------------------------
  ------------------------ Other ------------------------
  --------------------------------------------------------
  { "S1M0N38/love2d.nvim", cmd = "LoveRun", opts = {}, pin = true },
  {
    'mrcjkb/rustaceanvim',
    enabled = false,
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    version = '^6', -- Recommended
    lazy = false,   -- This plugin is already lazy
  },
  {
    "QuickGD/quickgd.nvim",
    ft = { "gdshader", "gdshaderinc" },
    cmd = { "GodotRun", "GodotRunLast", "GodotStart" },
    -- Use opts if passing in settings else use config
    init = function()
      vim.filetype.add {
        extension = {
          gdshaderinc = "gdshaderinc",
        },
      }
    end,
    opts = { godot_path = "C:\\Users\\Kakule\\Desktop\\Godot4.4.1.exe" }
  },
}

local opts = {}

require("lazy").setup(plugins, opts)
