-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
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
  { "nvim-lua/popup.nvim" }, -- An implementation of the Popup API from vim in Neovim
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
  {
    "echasnovski/mini.files",
    version = "*",
    opts = { windows = { max_number = 3, preview = true, width_preview = 45 } },
  },
  { "akinsho/bufferline.nvim", dependencies = "nvim-tree/nvim-web-devicons" },
  { "nvim-lualine/lualine.nvim", opts = { options = { theme = "flexoki" } } },
  { "SmiteshP/nvim-navic", opts = {} },
  { "akinsho/toggleterm.nvim" }, -- Terminal inside nvim
  { "ahmedkhalf/project.nvim" },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }, -- Visual indentlines
  { "okuuva/auto-save.nvim", opts = { debounce_delay = 135 } },
  { "folke/trouble.nvim", opts = "" },
  {
    "mbbill/undotree",
    config = function()
      if vim.fn.has("win32") == 1 then
        vim.g.undotree_DiffCommand = "FC"
      end
    end,
  },
  {
    "Shatur/neovim-session-manager",
    config = function()
      require("session_manager").setup({
        autoload_mode = require("session_manager.config").AutoloadMode.Disabled,
        autosave_ignore_buftypes = { "terminal" },
        autosave_ignore_dirs = { os.getenv("HOME"), os.getenv("UserProfile") },
      })
    end,
  },
  { "echasnovski/mini.align", version = false, opts = {} },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    config = function()
      vim.o.foldcolumn = "0"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
      })
    end,
  },
  { "hedyhli/outline.nvim", opts = { outline_window = { position = "left" } } },
  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup({})
      vim.keymap.set("n", "<F2>", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end, { expr = true })
    end,
  },
  {
    "b0o/incline.nvim",
    config = function()
      require("incline").setup()
    end,
    event = "VeryLazy",
  },
  { "LunarVim/bigfile.nvim" },
  {
    "kawre/neotab.nvim",
    event = "InsertEnter",
    opts = {},
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        width = 126,
      },
      on_open = function()
        vim.b.completion = false
        vim.cmd("Copilot disable")
      end,
      on_close = function()
        vim.b.completion = true
        vim.cmd("Copilot enable")
      end,
    },
  },

  ----------------------------------------------------------------------------------
  ------------------------ Colorschemes (Themes) and Visual ------------------------
  ----------------------------------------------------------------------------------
  { "navarasu/onedark.nvim" },
  { "lunarvim/darkplus.nvim" },
  { "Mofiqul/dracula.nvim" },
  {
    "ellisonleao/gruvbox.nvim",
    -- opts = {
    --   italic = {
    --     strings = false,
    --     emphasis = false,
    --     comments = false,
    --     folds = false,
    --   },
    -- },
  },
  { "tomasiser/vim-code-dark" },
  { "NTBBloodbath/doom-one.nvim" },
  { "Mofiqul/vscode.nvim" },
  { "BoHomola/vsassist.nvim" },
  { "bartekprtc/gruv-vsassist.nvim" },
  { "rktjmp/lush.nvim" },
  { "folke/tokyonight.nvim" },
  { "rebelot/kanagawa.nvim" },
  {
    "cpplain/flexoki.nvim",
    opts = {
      plugins = {
        "gitsigns",
        "nvim_treesitter_context",
        "which_key",
      },
    },
  },
  { "AstroNvim/astrotheme", opts = "" },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000, opts = { no_italic = true } },
  { "Shatur/neovim-ayu" },
  { "projekt0n/github-nvim-theme" },
  { "xiyaowong/transparent.nvim" },
  { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },
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
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },

  -------------------------------------------------------
  ------------------------ Input ------------------------
  -------------------------------------------------------
  { "numToStr/Comment.nvim", opts = {} }, -- Easily comment stuff
  { "echasnovski/mini.pairs", opts = { modes = { insert = true, command = true } } },
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
      vim.keymap.set("n", "<Leader>si", "<cmd>IconPickerYank<cr>", opts) --> Yank the selected icon into register
      vim.keymap.set("i", "<M-i>", "<cmd>IconPickerInsert<cr>", opts)
    end,
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
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = { "zbirenbaum/copilot.lua", "nvim-lua/plenary.nvim" },
    opts = {
      model = "claude-sonnet-4",
    },
  },

  ------------------------------------------------------------
  ------------------------ Completion ------------------------
  ------------------------------------------------------------
  {
    "saghen/blink.cmp",
    dependencies = { "L3MON4D3/LuaSnip" },
    -- use a release tag to download pre-built binaries
    version = "1.*",
    opts = {
      keymap = {
        preset = "super-tab",
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<Enter>"] = { "select_and_accept", "fallback" },
        ["<Escape>"] = { "hide", "fallback" },
        ["<C-p>"] = { "show_signature", "hide_signature", "fallback" },
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        documentation = {
          auto_show = true,
        },
        menu = {
          draw = {
            treesitter = { "lsp" },
          },
        },
        trigger = {
          show_on_blocked_trigger_characters = function()
            if vim.bo.filetype == "python" then
              return { " ", "\n", "\t", ":" }
            end
            if vim.bo.filetype == "gdscript" then
              return { " ", "\n", "\t", ":" }
            end
            return { " ", "\n", "\t" }
          end,
        },
      },
      signature = { enabled = true },
      snippets = { preset = "luasnip" },
      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      cmdline = { completion = { list = { selection = { preselect = false } } } },
    },
    opts_extend = { "sources.default" },
  },

  ----------------------------------------------------------
  ------------------------ Snippets ------------------------
  ----------------------------------------------------------
  { "L3MON4D3/LuaSnip" }, --snippet engine
  { "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use

  -----------------------------------------------------
  ------------------------ LSP ------------------------
  -----------------------------------------------------
  { "williamboman/mason.nvim" }, -- simple to use language server installer
  { "neovim/nvim-lspconfig" }, -- enable LSP
  { "williamboman/mason-lspconfig.nvim" },
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters_by_ft = {}
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    config = function()
      local prettierd = { "prettierd" }
      local clang_format = { "clang_format" }
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" }, -- You can add ", { lsp_format = "fallback" }" to the table to fallback to lsp formatting
          python = { "black" },
          javascript = prettierd,
          typescript = prettierd,
          html = prettierd,
          css = prettierd,
          json = prettierd,
          gdscript = { "gdformat" },
          c = clang_format,
          cpp = clang_format,
        },
        formatters = {
          stylua = {
            prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
          },
          prettierd = {
            prepend_args = { "--semi", "--single-quote", "--jsx-single-quote" },
          },
          clang_format = {
            prepend_args = {
              "--style={BasedOnStyle: Microsoft, BreakBeforeBraces: Allman, IndentCaseLabels: true, PointerAlignment: Left}",
            },
          },
        },
      })
    end,
  },
  { "RRethy/vim-illuminate", enabled = true }, -- Disabled because of lag.
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bakudankun/PICO-8.vim" },

  -------------------------------------------------------------
  ------------------------ Programming ------------------------
  -------------------------------------------------------------
  { "CRAG666/code_runner.nvim", dependencies = "nvim-lua/plenary.nvim" },
  -- { "Civitasv/cmake-tools.nvim", ft = "*.cpp", commit = "565d3a07cf0605a347cb68714015c0eef7213b16" },
  { "aburak621/cmake-tools.nvim", ft = "*.cpp" },
  {
    "barrett-ruth/live-server.nvim",
    build = "npm add -g live-server",
    cmd = { "LiveServerStart", "LiveServerStop" },
    opts = { args = { "--browser=chrome" } },
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
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    event = "VeryLazy",
    opts = {
      layouts = {
        {
          elements = {
            {
              id = "scopes",
              size = 0.4,
            },
            {
              id = "breakpoints",
              size = 0.2,
            },
            {
              id = "stacks",
              size = 0.2,
            },
            {
              id = "watches",
              size = 0.2,
            },
          },
          position = "left",
          size = 36,
        },
      },
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
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      if vim.loop.os_uname().sysname == "Windows_NT" then
        require("dap-python").setup("python")
      else
        require("dap-python").setup("python3")
      end
    end,
  },

  --------------------------------------------------------
  ------------------------ Other ------------------------
  --------------------------------------------------------
  { "S1M0N38/love2d.nvim", cmd = "LoveRun", opts = {}, pin = true },
  {
    "mrcjkb/rustaceanvim",
    enabled = false,
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy
  },
  {
    "QuickGD/quickgd.nvim",
    ft = { "gdshader", "gdshaderinc" },
    cmd = { "GodotRun", "GodotRunLast", "GodotStart" },
    -- Use opts if passing in settings else use config
    init = function()
      vim.filetype.add({
        extension = {
          gdshaderinc = "gdshaderinc",
        },
      })
    end,
    opts = { godot_path = "C:\\Users\\Kakule\\Desktop\\Godot4.4.1.exe" },
  },
}

local opts = {}

require("lazy").setup(plugins, opts)
