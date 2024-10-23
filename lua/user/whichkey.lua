local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true,       -- shows a list of your marks on ' and `
    registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false,    -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false,      -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true,       -- default bindings on <c-w>
      nav = true,           -- misc bindings to work with windows
      z = true,             -- bindings for folds, spelling and others prefixed with z
      g = true,             -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3,                    -- spacing between columns
    align = "left",                 -- align columns left, center or right
  },

  filter = function(mapping)
    -- example to exclude mappings without a description
    -- return mapping.desc and mapping.desc ~= ""
    return true
  end,
  show_help = true,                      -- show help message on the command line when the popup is visible
  triggers = { "<leader>", mode = "n" }, -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
}

local opts = {
  mode = "n",     -- NORMAL mode
  prefix = "<leader>",
  buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true,  -- use `nowait` when creating keymaps
}

which_key.add({
  -- Leader key mappings
  { "<leader>a",        "<cmd>Alpha<cr>",                                                                                                                     desc = "Alpha" },

  -- Other
  { "<leader><leader>", group = "Other" },

  -- Buffer mappings
  { "<leader>b",        group = "Buffer" },
  { "<leader>bb",       "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{})<cr>",                                      desc = "Buffers" },
  { "<leader>bc",       "<cmd>Bdelete!<CR>",                                                                                                                  desc = "Close Buffer" },
  { "<leader>bC",       "<cmd>%bd!|e#|bd!#|'\"<CR>",                                                                                                          desc = "Close Other Buffers" },
  { "<leader>bn",       "<cmd>enew<CR>",                                                                                                                      desc = "New Empty Buffer" },

  -- DAP mappings
  { "<leader>d",        group = "Debug" },
  { "<leader>dc",       "<cmd>DapContinue<CR>",                                                                                                               desc = "Start/Continue" },
  { "<leader>di",       "<cmd>DapStepInto<CR>",                                                                                                               desc = "Step Into" },
  { "<leader>do",       "<cmd>DapStepOver<CR>",                                                                                                               desc = "Step Over" },
  { "<leader>dq",       "<cmd>DapTerminate<CR>",                                                                                                              desc = "Terminate" },
  { "<leader>dr",       "<cmd>DapToggleRepl<CR>",                                                                                                             desc = "Toggle Repl" },
  { "<leader>db",       "<cmd>DapToggleBreakpoint<CR>",                                                                                                       desc = "Toggle Breakpoint" },
  { "<leader>dO",       "<cmd>DapStepOut<CR>",                                                                                                                desc = "Step Out" },
  { "<leader>dU",       "<cmd>lua require'dapui'.toggle({reset = true})<cr>",                                                                                 desc = "Toggle UI" },

  -- Explorer mappings
  -- { "<leader>e",        "<cmd>NvimTreeToggle<cr>",                                                                                                                   desc = "Explorer" },
  -- { "<leader>E",        [[<cmd>lua require 'telescope'.extensions.file_browser.file_browser({ grouped = true, hidden = true, path = vim.fn.expand('%:~:h') })<CR>]], desc = "File Browser" },
  { "<leader>e",        "<cmd>lua if not MiniFiles.close() then MiniFiles.open() end<cr>",                                                                    desc = "Explorer" },
  { "<leader>E",        "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>",                                                                          desc = "Explorer" },

  -- Window mappings
  { "<leader>w",        group = "Window" },
  { "<leader>wc",       "<cmd>close<CR>",                                                                                                                     desc = "Close" },
  { "<leader>wC",       "<cmd>Bdelete!<CR><cmd>close<CR>",                                                                                                    desc = "Close and Kill Buffer" },
  { "<leader>we",       "<C-W>=",                                                                                                                             desc = "Equal Size" },
  { "<leader>wm",       "<C-W>_<C-W>|",                                                                                                                       desc = "Maximize" },
  { "<leader>wo",       "<cmd>only<CR>",                                                                                                                      desc = "Close other windows" },
  { "<leader>wr",       "<C-W>r",                                                                                                                             desc = "Rotate Clockwise" },
  { "<leader>wR",       "<C-W>R",                                                                                                                             desc = "Rotate Counter-clockwise" },
  { "<leader>ws",       "<cmd>split<CR>",                                                                                                                     desc = "Split Horizontal" },
  { "<leader>wv",       "<cmd>vsplit<CR>",                                                                                                                    desc = "Split Vertical" },

  -- Quit mappings
  { "<leader>q",        group = "Quit" },
  { "<leader>qa",       "<cmd>qa<CR>",                                                                                                                        desc = "Close All" },
  { "<leader>qA",       "<cmd>qa!<CR>",                                                                                                                       desc = "Close All (force)" },
  { "<leader>qq",       "<cmd>q<CR>",                                                                                                                         desc = "Close" },
  { "<leader>qQ",       "<cmd>q!<CR>",                                                                                                                        desc = "Close (force)" },
  { "<leader>qw",       "<cmd>wq<CR>",                                                                                                                        desc = "Save and Close" },
  { "<leader>qW",       "<cmd>wqa<CR>",                                                                                                                       desc = "Save and Close All" },

  -- Code mappings
  { "<leader>c",        group = "Code" },
  { "<leader>cb",       group = "Bracey" },
  { "<leader>cbb",      "<cmd>Bracey<CR>",                                                                                                                    desc = "Start" },
  { "<leader>cbs",      "<cmd>BraceyStop<CR>",                                                                                                                desc = "Stop" },
  { "<leader>cc",       "<cmd>CMakeRun<CR>",                                                                                                                  desc = "CMake Run" },
  { "<leader>cd",       "<cmd>CMakeDebug<CR>",                                                                                                                desc = "CMake Debug" },
  { "<leader>cr",       "<cmd>RunFile toggleterm<CR>",                                                                                                        desc = "Run" },
  { "<leader>cR",       "<cmd>RunProject toggleterm<CR>",                                                                                                     desc = "Run Project" },
  { "<leader>cl",       "<cmd>LoveRun<CR>",                                                                                                                   desc = "Run Love" },
  -- { "<leader>cl",       "<cmd>require('toggleterm.terminal'):new({ cmd = 'love .', hidden = true }):toggle()<CR>",                                                                                                                          desc = "Run Love" },

  -- No Highlight
  { "<leader>h",        "<cmd>nohlsearch<CR>",                                                                                                                desc = "No Highlight" },

  -- Find files
  { "<leader>f",        "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{ previewer = false, hidden = true })<CR>", desc = "Find files" },

  -- Git mappings
  { "<leader>g",        group = "Git" },
  { "<leader>gg",       "<cmd>LazyGit<CR>",                                                                                                                   desc = "Lazygit" },
  { "<leader>gj",       "<cmd>lua require 'gitsigns'.next_hunk()<cr>",                                                                                        desc = "Next Hunk" },
  { "<leader>gk",       "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",                                                                                        desc = "Prev Hunk" },
  { "<leader>gl",       "<cmd>lua require 'gitsigns'.blame_line()<cr>",                                                                                       desc = "Blame" },
  { "<leader>gp",       "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",                                                                                     desc = "Preview Hunk" },
  { "<leader>gr",       "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",                                                                                       desc = "Reset Hunk" },
  { "<leader>gR",       "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",                                                                                     desc = "Reset Buffer" },
  { "<leader>gs",       "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",                                                                                       desc = "Stage Hunk" },
  { "<leader>gu",       "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",                                                                                  desc = "Undo Stage Hunk" },
  { "<leader>go",       "<cmd>Telescope git_status<cr>",                                                                                                      desc = "Open Changed File" },
  { "<leader>gb",       "<cmd>Telescope git_branches<cr>",                                                                                                    desc = "Checkout Branch" },
  { "<leader>gc",       "<cmd>Telescope git_commits<cr>",                                                                                                     desc = "Checkout Commit" },
  { "<leader>gd",       "<cmd>DiffviewOpen<cr>",                                                                                                              desc = "Diffview Open" },
  { "<leader>gD",       "<cmd>DiffviewClose<cr>",                                                                                                             desc = "Diffview Close" },

  -- LSP mappings
  { "<leader>l",        group = "LSP" },
  { "<leader>la",       "<cmd>lua vim.lsp.buf.code_action()<cr>",                                                                                             desc = "Code Action" },
  { "<leader>ld",       "<cmd>lua vim.diagnostic.open_float()<cr>",                                                                                           desc = "Open diagnostic" },
  { "<leader>lf",       "<cmd>lua vim.lsp.buf.format()<cr>",                                                                                                  desc = "Format" },
  { "<leader>li",       "<cmd>LspInfo<cr>",                                                                                                                   desc = "Info" },
  { "<leader>lj",       "<cmd>lua vim.diagnostic.goto_next()<CR>",                                                                                            desc = "Next Diagnostic" },
  { "<leader>lk",       "<cmd>lua vim.diagnostic.goto_prev()<cr>",                                                                                            desc = "Prev Diagnostic" },
  { "<leader>ll",       "<cmd>lua vim.lsp.codelens.run()<cr>",                                                                                                desc = "CodeLens Action" },
  { "<leader>lo",       "<cmd>Outline<cr>",                                                                                                                   desc = "Toggle Outline" },
  { "<leader>ls",       "<cmd>Telescope lsp_document_symbols<cr>",                                                                                            desc = "Document Symbols" },
  { "<leader>lS",       "<cmd>Telescope lsp_workspace_symbols<cr>",                                                                                           desc = "Workspace Symbols" },
  { "<leader>lr",       "<cmd>lua require('telescope.builtin').lsp_references()<cr>",                                                                         desc = "Find References" },
  { "<leader>lt",       "<cmd>Trouble diagnostics toggle<CR>",                                                                                                desc = "Trouble" },

  -- Search mappings
  { "<leader>s",        group = "Search" },
  { "<leader>sc",       "<cmd>lua require('telescope.builtin').colorscheme({ enable_preview = true })<cr>",                                                   desc = "Colorscheme with Preview" },
  { "<leader>sd",       "<cmd>DevdocsOpenCurrentFloat<cr>",                                                                                                   desc = "Devdocs Search" },
  { "<leader>sg",       "<cmd>Telescope live_grep<cr>",                                                                                                       desc = "Live Grep" },
  { "<leader>sh",       "<cmd>Telescope help_tags<cr>",                                                                                                       desc = "Find Help" },
  { "<leader>sM",       "<cmd>Telescope man_pages<cr>",                                                                                                       desc = "Man Pages" },
  { "<leader>sr",       "<cmd>Telescope oldfiles<cr>",                                                                                                        desc = "Open Recent File" },
  { "<leader>sR",       "<cmd>Telescope registers<cr>",                                                                                                       desc = "Registers" },
  { "<leader>sk",       "<cmd>Telescope keymaps<cr>",                                                                                                         desc = "Keymaps" },
  { "<leader>sl",       "<cmd>Telescope resume<cr>",                                                                                                          desc = "Resume Last Search" },
  { "<leader>sC",       "<cmd>Telescope commands<cr>",                                                                                                        desc = "Commands" },

  -- Session mappings
  { "<leader>S",        group = "Session" },
  { "<leader>Sd",       "<cmd>SessionManager delete_session<cr>",                                                                                             desc = "Delete Session" },
  { "<leader>Ss",       "<cmd>SessionManager save_current_session<cr>",                                                                                       desc = "Save Session" },
  { "<leader>Sl",       "<cmd>SessionManager load_session<cr>",                                                                                               desc = "Load Session" },
  { "<leader>SL",       "<cmd>SessionManager load_last_session<cr>",                                                                                          desc = "Load Last Session" },

  -- Neorg mappings
  { "<leader>n",        group = "Neorg" },
  { "<leader>nn",       "<cmd>Neorg index<cr>",                                                                                                               desc = "Index" },
  { "<leader>nN",       "<Plug>(neorg.dirman.new-note)",                                                                                                      desc = "Create New Note" },
  { "<leader>nt",       group = "Todo" },
  { "<leader>ntu",      "<Plug>(neorg.qol.todo-items.todo.task-undone)",                                                                                      desc = "Mark as Undone" },
  { "<leader>ntp",      "<Plug>(neorg.qol.todo-items.todo.task-pending)",                                                                                     desc = "Mark as Pending" },
  { "<leader>ntd",      "<Plug>(neorg.qol.todo-items.todo.task-done)",                                                                                        desc = "Mark as Done" },
  { "<leader>nth",      "<Plug>(neorg.qol.todo-items.todo.task-on-hold)",                                                                                     desc = "Mark as On Hold" },
  { "<leader>ntc",      "<Plug>(neorg.qol.todo-items.todo.task-cancelled)",                                                                                   desc = "Mark as Cancelled" },
  { "<leader>ntr",      "<Plug>(neorg.qol.todo-items.todo.task-recurring)",                                                                                   desc = "Mark as Recurring" },
  { "<leader>nti",      "<Plug>(neorg.qol.todo-items.todo.task-important)",                                                                                   desc = "Mark as Important" },
  { "<leader>nta",      "<Plug>(neorg.qol.todo-items.todo.task-ambiguous)",                                                                                   desc = "Mark as Ambiguous" },
  { "<leader>ntt",      "<Plug>(neorg.qol.todo-items.todo.task-cycle)",                                                                                       desc = "Cycle Task" },
  { "<CR>",             "<Plug>(neorg.esupports.hop.hop-link)",                                                                                               desc = "Jump to Link" },
  { "<M-CR>",           "<Plug>(neorg.esupports.hop.hop-link.vsplit)",                                                                                        desc = "Jump to Link (Vertical Split)" },
  { ">.",               "<Plug>(neorg.promo.promote)",                                                                                                        desc = "Promote Object (Non-Recursively)" },
  { "<,",               "<Plug>(neorg.promo.demote)",                                                                                                         desc = "Demote Object (Non-Recursively)" },
  { ">>.",              "<Plug>(neorg.promo.promote.nested)",                                                                                                 desc = "Promote Object (Recursively)" },
  { "<<,",              "<Plug>(neorg.promo.demote.nested)",                                                                                                  desc = "Demote Object (Recursively)" },
  { "<leader>nl",       group = "List" },
  { "<leader>nlt",      "<Plug>(neorg.pivot.list.toggle)",                                                                                                    desc = "Toggle (Un)ordered List" },
  { "<leader>nli",      "<Plug>(neorg.pivot.list.invert)",                                                                                                    desc = "Invert (Un)ordered List" },
  { "<leader>ni",       group = "Insert" },
  { "<leader>nid",      "<Plug>(neorg.tempus.insert-date)",                                                                                                   desc = "Insert Date" },
  { "<leader>nc",       group = "Code" },
  { "<leader>ncm",      "<Plug>(neorg.looking-glass.magnify-code-block)",                                                                                     desc = "Magnify Code Block" },

  -- Insert Mode mappings
  { "<C-n>",            "<Plug>(neorg.itero.next-iteration)",                                                                                                 desc = "Next iteration",                  mode = "i" },
  { "<M-d>",            "<Plug>(neorg.tempus.insert-date.insert-mode)",                                                                                       desc = "Insert Date",                     mode = "i" },

  -- Visual Mode mappings
  -- { ">",                "<Plug>(neorg.promo.promote.range)gv",                                                                                                       desc = "Promote Objects in Range",        mode = "v" },
  -- { "<",                "<Plug>(neorg.promo.demote.range)gv",                                                                                                        desc = "Demote Objects in Range",         mode = "v" },

  -- Toggle mappings
  { "<leader>t",        group = "Toggle" },
  { "<leader>tc",       "<cmd>CopilotChatToggle<cr>",                                                                                                         desc = "Toggle Copilot Chat" },
  { "<leader>tC",       "<cmd>Copilot disable<cr>",                                                                                                           desc = "Toggle Copilot" },
  { "<leader>tu",       "<cmd>UndotreeToggle<cr>",                                                                                                            desc = "Toggle Undotree" },
  { "<leader>t1",       "<cmd>1ToggleTerm<cr>",                                                                                                               desc = "Toggle Toggleterm 1" },
  { "<leader>t2",       "<cmd>2ToggleTerm<cr>",                                                                                                               desc = "Toggle Toggleterm 2" },
  { "<leader>t3",       "<cmd>3ToggleTerm<cr>",                                                                                                               desc = "Toggle Toggleterm 3" },
})

which_key.setup(setup)
-- which_key.register(mappings, opts)
