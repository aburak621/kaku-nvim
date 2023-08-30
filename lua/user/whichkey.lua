local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = false, -- adds help for motions
			text_objects = false, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	a = { "<cmd>Alpha<cr>", "Alpha" },

	-- ["b"] = {
	--   "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
	--   "Buffers",
	-- },
	b = {
		name = "Buffer",
		b = {
			"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{ initial_mode = 'normal' })<cr>",
			"Buffers",
		},
		c = { "<cmd>Bdelete!<CR>", "Close buffer" },
		C = { "<cmd>%bd!|e#|bd!#|'\"<CR>", "Close all other buffers" },
		n = { "<cmd>enew<CR>", "New empty buffer" },
	},

    d = {
        c = { "<cmd>DapContinue<CR>", "Start/Continue"},
        i = { "<cmd>DapStepInto<CR>", "Step Into"},
        o = { "<cmd>DapStepOver<CR>", "Step Over"},
        q = { "<cmd>DapTerminate<CR>", "Terminate"},
        r = { "<cmd>DapToggleRepl<CR>", "Toggle Repl"},
		t = { "<cmd>DapToggleBreakpoint<CR>", "Toggle breakpoint" },
        u = { "<cmd>DapStepOut<CR>", "Step Out"},
        U = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle UI" },
    },

	e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },

	-- ["w"] = { "<cmd>w!<CR>", "Save" },
	w = {
		name = "Window",
		c = { "<cmd>close<CR>", "Close" },
		o = { "<cmd>only<CR>", "Close and kill buffer" },
		C = { "<cmd>Bdelete!<CR><cmd>close<CR>", "Close and kill buffer" },
		s = { "<cmd>split<CR>", "Split horizontal" },
		v = { "<cmd>vsplit<CR>", "Split vertical" },
		m = { "<C-W>_", "Maximize" },
		e = { "<C-W>=", "Equal size" },
		r = { "<C-W>r", "Rotate clockwise" },
		R = { "<C-W>R", "Rotate counter-clockwise" },
	},

	q = {
	  name = "Quit",
      a = { "<cmd>qa<CR>", "Close all" },
      A = { "<cmd>qa!<CR>", "Close all (force)" },
      q = { "<cmd>q<CR>", "Close" },
      Q = { "<cmd>q!<CR>", "Close (force)" },
      w = { "<cmd>wq<CR>", "Save and close" },
      W = { "<cmd>wqa<CR>", "Save and close all" },
	},

	c = {
		name = "Code",
		b = {
			name = "Bracey",
			b = { "<cmd>Bracey<CR>", "Start" },
			s = { "<cmd>BraceyStop<CR>", "Stop" },
		},
        c = { "<cmd>CMakeRun<CR>", "CMake Run" },
        d = { "<cmd>CMakeDebug<CR>", "CMake Debug" },
		r = { "<cmd>RunFile toggleterm<CR>", "Run" },
		R = { "<cmd>RunProject toggleterm<CR>", "Run project" },
	},

	["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
	["f"] = {
		"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{ previewer = false })<CR>",
		"Find files",
	},
	["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
	["P"] = { "<cmd>Telescope projects<cr>", "Projects" },

	-- p = {
	-- 	name = "Packer",
	-- 	c = { "<cmd>PackerCompile<cr>", "Compile" },
	-- 	i = { "<cmd>PackerInstall<cr>", "Install" },
	-- 	s = { "<cmd>PackerSync<cr>", "Sync" },
	-- 	S = { "<cmd>PackerStatus<cr>", "Status" },
	-- 	u = { "<cmd>PackerUpdate<cr>", "Update" },
	-- },

	g = {
		name = "Git",
		g = { "<cmd>LazyGit<CR>", "Lazygit" },
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		d = { "<cmd>DiffviewOpen<cr>", "Diffview Open" },
		D = { "<cmd>DiffviewClose<cr>", "Diffview Close" },
	},

	l = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		d = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to definition" },
		f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
		j = {
			"<cmd>lua vim.diagnostic.goto_next()<CR>",
			"Next Diagnostic",
		},
		k = {
			"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
			"Prev Diagnostic",
		},
		l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
		r = { "<cmd>lua require('telescope.builtin').lsp_references()<cr>", "Find references" },
		w = {
			"<cmd>Telescope lsp_workspace_diagnostics<cr>",
			"Workspace Diagnostics",
		},
	},
	s = {
		name = "Search",
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = {
            "<cmd>lua require('telescope.builtin').colorscheme({ enable_preview = true })<cr>",
            "Colorscheme with Preview"
        },
        d = { "<cmd>DevdocsOpenCurrentFloat<cr>", "Devdocs Search"},
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
        t = { "<cmd>Telescope live_grep<cr>", "Text" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        l = { "<cmd>Telescope resume<cr>", "Resume last search" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
	},
    S = {
        name = "Session",
        d = { "<cmd>SessionManager delete_session<cr>", "Delete Session" },
        s = { "<cmd>SessionManager save_current_session<cr>", "Save Session" },
        l = { "<cmd>SessionManager load_session<cr>", "Load session" },
        L = { "<cmd>SessionManager load_last_session<cr>", "Load last session" },
    },
	t = {
		name = "Telescope",
		g = { "<cmd>Telescope live_grep<CR>", "Live Grep" },
		m = { "<cmd>Telescope media_files<CR>", "Media Files" },
		p = { "<cmd>Telescope projects<CR>", "Projects" },
		k = { "<cmd>Telescope keymaps<CR>", "Keymaps" },
		-- name = "Terminal",
		-- n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
		-- u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
		-- t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
		-- p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
		-- f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
		-- h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
		-- v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
	},
}

which_key.setup(setup)
which_key.register(mappings, opts)
