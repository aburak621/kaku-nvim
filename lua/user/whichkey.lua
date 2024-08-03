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
            nav = true,  -- misc bindings to work with windows
            z = true,    -- bindings for folds, spelling and others prefixed with z
            g = true,    -- bindings for prefixed with g
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
    --DEPRECATED popup_mappings = {
    --     scroll_down = "<c-d>", -- binding to scroll down inside the popup
    --     scroll_up = "<c-u>", -- binding to scroll up inside the popup
    -- },
    --DEPRECATED window = {
    --     border = "rounded", -- none, single, double, shadow
    --     position = "bottom", -- bottom, top
    --     margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    --     padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    --     winblend = 0,
    -- },
    layout = {
        height = { min = 4, max = 25 },                                        -- min and max height of the columns
        width = { min = 20, max = 50 },                                        -- min and max width of the columns
        spacing = 3,                                                           -- spacing between columns
        align = "left",                                                        -- align columns left, center or right
    },

    filter = function(mapping)
        -- example to exclude mappings without a description
        -- return mapping.desc and mapping.desc ~= ""
        return true
    end,
    -- DEPRECATED hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true,                                                          -- show help message on the command line when the popup is visible
    triggers = { "<leader>", mode = "n" },                                                         -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    --DEPRECATED triggers_blacklist = {
    --     -- list of mode / prefixes that should never be hooked by WhichKey
    --     -- this is mostly relevant for key maps that start with a native binding
    --     -- most people should not need to change this
    --     i = { "j", "k" },
    --     v = { "j", "k" },
    -- },
}

local opts = {
    mode = "n",  -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

which_key.add({
    -- Leader key mappings
    { "<leader>a",   "<cmd>Alpha<cr>",                                                                                                      desc = "Alpha" },

    -- Other
    { "<leader><leader>", group = "Other" },

    -- Buffer mappings
    { "<leader>b",   group = "Buffer" },
    { "<leader>bb",  "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{})<cr>",                       desc = "Buffers" },
    { "<leader>bc",  "<cmd>Bdelete!<CR>",                                                                                                   desc = "Close Buffer" },
    { "<leader>bC",  "<cmd>%bd!|e#|bd!#|'\"<CR>",                                                                                           desc = "Close Other Buffers" },
    { "<leader>bn",  "<cmd>enew<CR>",                                                                                                       desc = "New Empty Buffer" },

    -- DAP mappings
    { "<leader>d",   group = "Debug" },
    { "<leader>dc",  "<cmd>DapContinue<CR>",                                                                                                desc = "Start/Continue" },
    { "<leader>di",  "<cmd>DapStepInto<CR>",                                                                                                desc = "Step Into" },
    { "<leader>do",  "<cmd>DapStepOver<CR>",                                                                                                desc = "Step Over" },
    { "<leader>dq",  "<cmd>DapTerminate<CR>",                                                                                               desc = "Terminate" },
    { "<leader>dr",  "<cmd>DapToggleRepl<CR>",                                                                                              desc = "Toggle Repl" },
    { "<leader>dt",  "<cmd>DapToggleBreakpoint<CR>",                                                                                        desc = "Toggle Breakpoint" },
    { "<leader>du",  "<cmd>DapStepOut<CR>",                                                                                                 desc = "Step Out" },
    { "<leader>dU",  "<cmd>lua require'dapui'.toggle({reset = true})<cr>",                                                                  desc = "Toggle UI" },

    -- Explorer mappings
    { "<leader>e",   "<cmd>NvimTreeToggle<cr>",                                                                                             desc = "Explorer" },
    { "<leader>E",   [[<cmd>lua require 'telescope'.extensions.file_browser.file_browser({ grouped = true, hidden = true })<CR>]],          desc = "File Browser" },

    -- Window mappings
    { "<leader>w",   group = "Window" },
    { "<leader>wc",  "<cmd>close<CR>",                                                                                                      desc = "Close" },
    { "<leader>wC",  "<cmd>Bdelete!<CR><cmd>close<CR>",                                                                                     desc = "Close and Kill Buffer" },
    { "<leader>we",  "<C-W>=",                                                                                                              desc = "Equal Size" },
    { "<leader>wm",  "<C-W>_<C-W>|",                                                                                                        desc = "Maximize" },
    { "<leader>wo",  "<cmd>only<CR>",                                                                                                       desc = "Close other windows" },
    { "<leader>wr",  "<C-W>r",                                                                                                              desc = "Rotate Clockwise" },
    { "<leader>wR",  "<C-W>R",                                                                                                              desc = "Rotate Counter-clockwise" },
    { "<leader>ws",  "<cmd>split<CR>",                                                                                                      desc = "Split Horizontal" },
    { "<leader>wv",  "<cmd>vsplit<CR>",                                                                                                     desc = "Split Vertical" },

    -- Quit mappings
    { "<leader>q",   group = "Quit" },
    { "<leader>qa",  "<cmd>qa<CR>",                                                                                                         desc = "Close All" },
    { "<leader>qA",  "<cmd>qa!<CR>",                                                                                                        desc = "Close All (force)" },
    { "<leader>qq",  "<cmd>q<CR>",                                                                                                          desc = "Close" },
    { "<leader>qQ",  "<cmd>q!<CR>",                                                                                                         desc = "Close (force)" },
    { "<leader>qw",  "<cmd>wq<CR>",                                                                                                         desc = "Save and Close" },
    { "<leader>qW",  "<cmd>wqa<CR>",                                                                                                        desc = "Save and Close All" },

    -- Code mappings
    { "<leader>c",   group = "Code" },
    { "<leader>cb",  group = "Bracey" },
    { "<leader>cbb", "<cmd>Bracey<CR>",                                                                                                     desc = "Start" },
    { "<leader>cbs", "<cmd>BraceyStop<CR>",                                                                                                 desc = "Stop" },
    { "<leader>cc",  "<cmd>CMakeRun<CR>",                                                                                                   desc = "CMake Run" },
    { "<leader>cd",  "<cmd>CMakeDebug<CR>",                                                                                                 desc = "CMake Debug" },
    { "<leader>cr",  "<cmd>RunFile toggleterm<CR>",                                                                                         desc = "Run" },
    { "<leader>cR",  "<cmd>RunProject toggleterm<CR>",                                                                                      desc = "Run Project" },
    { "<leader>cl",  "<cmd>LoveRun<CR>",                                                                                                    desc = "Run Love" },

    -- No Highlight
    { "<leader>h",   "<cmd>nohlsearch<CR>",                                                                                                 desc = "No Highlight" },

    -- Find files
    { "<leader>f",   "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{ previewer = false })<CR>", desc = "Find files" },

    -- Git mappings
    { "<leader>g",   group = "Git" },
    { "<leader>gg",  "<cmd>LazyGit<CR>",                                                                                                    desc = "Lazygit" },
    { "<leader>gj",  "<cmd>lua require 'gitsigns'.next_hunk()<cr>",                                                                         desc = "Next Hunk" },
    { "<leader>gk",  "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",                                                                         desc = "Prev Hunk" },
    { "<leader>gl",  "<cmd>lua require 'gitsigns'.blame_line()<cr>",                                                                        desc = "Blame" },
    { "<leader>gp",  "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",                                                                      desc = "Preview Hunk" },
    { "<leader>gr",  "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",                                                                        desc = "Reset Hunk" },
    { "<leader>gR",  "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",                                                                      desc = "Reset Buffer" },
    { "<leader>gs",  "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",                                                                        desc = "Stage Hunk" },
    { "<leader>gu",  "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",                                                                   desc = "Undo Stage Hunk" },
    { "<leader>go",  "<cmd>Telescope git_status<cr>",                                                                                       desc = "Open Changed File" },
    { "<leader>gb",  "<cmd>Telescope git_branches<cr>",                                                                                     desc = "Checkout Branch" },
    { "<leader>gc",  "<cmd>Telescope git_commits<cr>",                                                                                      desc = "Checkout Commit" },
    { "<leader>gd",  "<cmd>DiffviewOpen<cr>",                                                                                               desc = "Diffview Open" },
    { "<leader>gD",  "<cmd>DiffviewClose<cr>",                                                                                              desc = "Diffview Close" },

    -- LSP mappings
    { "<leader>l",   group = "LSP" },
    { "<leader>la",  "<cmd>lua vim.lsp.buf.code_action()<cr>",                                                                              desc = "Code Action" },
    { "<leader>lf",  "<cmd>lua vim.lsp.buf.format()<cr>",                                                                                   desc = "Format" },
    { "<leader>li",  "<cmd>LspInfo<cr>",                                                                                                    desc = "Info" },
    { "<leader>lj",  "<cmd>lua vim.diagnostic.goto_next()<CR>",                                                                             desc = "Next Diagnostic" },
    { "<leader>lk",  "<cmd>lua vim.diagnostic.goto_prev()<cr>",                                                                             desc = "Prev Diagnostic" },
    { "<leader>ll",  "<cmd>lua vim.lsp.codelens.run()<cr>",                                                                                 desc = "CodeLens Action" },
    { "<leader>lo",  "<cmd>Outline<cr>",                                                                                                    desc = "Toggle Outline" },
    { "<leader>ls",  "<cmd>Telescope lsp_document_symbols<cr>",                                                                             desc = "Document Symbols" },
    { "<leader>lS",  "<cmd>Telescope lsp_workspace_symbols<cr>",                                                                            desc = "Workspace Symbols" },
    { "<leader>lr",  "<cmd>lua require('telescope.builtin').lsp_references()<cr>",                                                          desc = "Find References" },
    { "<leader>lt",  "<cmd>Trouble diagnostics toggle<CR>",                                                                                 desc = "Trouble" },

    -- Search mappings
    { "<leader>s",   group = "Search" },
    { "<leader>sc",  "<cmd>lua require('telescope.builtin').colorscheme({ enable_preview = true })<cr>",                                    desc = "Colorscheme with Preview" },
    { "<leader>sd",  "<cmd>DevdocsOpenCurrentFloat<cr>",                                                                                    desc = "Devdocs Search" },
    { "<leader>sg",  "<cmd>Telescope live_grep<cr>",                                                                                        desc = "Live Grep" },
    { "<leader>sh",  "<cmd>Telescope help_tags<cr>",                                                                                        desc = "Find Help" },
    { "<leader>sM",  "<cmd>Telescope man_pages<cr>",                                                                                        desc = "Man Pages" },
    { "<leader>sr",  "<cmd>Telescope oldfiles<cr>",                                                                                         desc = "Open Recent File" },
    { "<leader>sR",  "<cmd>Telescope registers<cr>",                                                                                        desc = "Registers" },
    { "<leader>sk",  "<cmd>Telescope keymaps<cr>",                                                                                          desc = "Keymaps" },
    { "<leader>sl",  "<cmd>Telescope resume<cr>",                                                                                           desc = "Resume Last Search" },
    { "<leader>sC",  "<cmd>Telescope commands<cr>",                                                                                         desc = "Commands" },

    -- Session mappings
    { "<leader>S",   group = "Session" },
    { "<leader>Sd",  "<cmd>SessionManager delete_session<cr>",                                                                              desc = "Delete Session" },
    { "<leader>Ss",  "<cmd>SessionManager save_current_session<cr>",                                                                        desc = "Save Session" },
    { "<leader>Sl",  "<cmd>SessionManager load_session<cr>",                                                                                desc = "Load Session" },
    { "<leader>SL",  "<cmd>SessionManager load_last_session<cr>",                                                                           desc = "Load Last Session" },
})

-- local mappings = {
--     a = { "<cmd>Alpha<cr>", "Alpha" },
--
--     b = {
--         name = "Buffer",
--         b = {
--             "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{})<cr>",
--             "Buffers",
--         },
--         c = { "<cmd>Bdelete!<CR>", "Close Buffer" },
--         C = { "<cmd>%bd!|e#|bd!#|'\"<CR>", "Close Other Buffers" },
--         n = { "<cmd>enew<CR>", "New Empty Buffer" },
--     },
--
--     d = {
--         c = { "<cmd>DapContinue<CR>", "Start/Continue" },
--         i = { "<cmd>DapStepInto<CR>", "Step Into" },
--         o = { "<cmd>DapStepOver<CR>", "Step Over" },
--         q = { "<cmd>DapTerminate<CR>", "Terminate" },
--         r = { "<cmd>DapToggleRepl<CR>", "Toggle Repl" },
--         t = { "<cmd>DapToggleBreakpoint<CR>", "Toggle Breakpoint" },
--         u = { "<cmd>DapStepOut<CR>", "Step Out" },
--         U = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle UI" },
--     },
--
--     e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
--     E = { [[<cmd>lua require 'telescope'.extensions.file_browser.file_browser({ grouped = true, hidden = true })<CR>]], "File Browser" },
--
--     w = {
--         name = "Window",
--         c = { "<cmd>close<CR>", "Close" },
--         C = { "<cmd>Bdelete!<CR><cmd>close<CR>", "Close and Kill Buffer" },
--         e = { "<C-W>=", "Equal Size" },
--         m = { "<C-W>_<C-W>|", "Maximize" },
--         o = { "<cmd>only<CR>", "Close other windows." },
--         r = { "<C-W>r", "Rotate Clockwise" },
--         R = { "<C-W>R", "Rotate Counter-clockwise" },
--         s = { "<cmd>split<CR>", "Split Horizontal" },
--         v = { "<cmd>vsplit<CR>", "Split Vertical" },
--     },
--
--     q = {
--         name = "Quit",
--         a = { "<cmd>qa<CR>", "Close All" },
--         A = { "<cmd>qa!<CR>", "Close All (force)" },
--         q = { "<cmd>q<CR>", "Close" },
--         Q = { "<cmd>q!<CR>", "Close (force)" },
--         w = { "<cmd>wq<CR>", "Save and Close" },
--         W = { "<cmd>wqa<CR>", "Save and Close All" },
--     },
--
--     c = {
--         name = "Code",
--         b = {
--             name = "Bracey",
--             b = { "<cmd>Bracey<CR>", "Start" },
--             s = { "<cmd>BraceyStop<CR>", "Stop" },
--         },
--         c = { "<cmd>CMakeRun<CR>", "CMake Run" },
--         d = { "<cmd>CMakeDebug<CR>", "CMake Debug" },
--         r = { "<cmd>RunFile toggleterm<CR>", "Run" },
--         R = { "<cmd>RunProject toggleterm<CR>", "Run Project" },
--         l = { "<cmd>LoveRun<CR>", "Run Love" },
--     },
--
--     ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
--
--     ["f"] = {
--         "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{ previewer = false })<CR>",
--         "Find files",
--     },
--
--     g = {
--         name = "Git",
--         g = { "<cmd>LazyGit<CR>", "Lazygit" },
--         j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
--         k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
--         l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
--         p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
--         r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
--         R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
--         s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
--         u = {
--             "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
--             "Undo Stage Hunk",
--         },
--         o = { "<cmd>Telescope git_status<cr>", "Open Changed File" },
--         b = { "<cmd>Telescope git_branches<cr>", "Checkout Branch" },
--         c = { "<cmd>Telescope git_commits<cr>", "Checkout Commit" },
--         d = { "<cmd>DiffviewOpen<cr>", "Diffview Open" },
--         D = { "<cmd>DiffviewClose<cr>", "Diffview Close" },
--     },
--
--     l = {
--         name = "LSP",
--         a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
--         f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" },
--         i = { "<cmd>LspInfo<cr>", "Info" },
--         j = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostic" },
--         k = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
--         l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
--         o = { "<cmd>Outline<cr>", "Toggle Outline" },
--         s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
--         S = { "<cmd>Telescope lsp_workspace_symbols<cr>", "Workspace Symbols" },
--         r = { "<cmd>lua require('telescope.builtin').lsp_references()<cr>", "Find References" },
--         t = { "<cmd>Trouble diagnostics toggle<CR>", "Trouble" },
--     },
--     s = {
--         name = "Search",
--         c = {
--             "<cmd>lua require('telescope.builtin').colorscheme({ enable_preview = true })<cr>",
--             "Colorscheme with Preview",
--         },
--         d = { "<cmd>DevdocsOpenCurrentFloat<cr>", "Devdocs Search" },
--         g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
--         h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
--         M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
--         r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
--         R = { "<cmd>Telescope registers<cr>", "Registers" },
--         k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
--         l = { "<cmd>Telescope resume<cr>", "Resume Last Search" },
--         C = { "<cmd>Telescope commands<cr>", "Commands" },
--     },
--     S = {
--         name = "Session",
--         d = { "<cmd>SessionManager delete_session<cr>", "Delete Session" },
--         s = { "<cmd>SessionManager save_current_session<cr>", "Save Session" },
--         l = { "<cmd>SessionManager load_session<cr>", "Load Session" },
--         L = { "<cmd>SessionManager load_last_session<cr>", "Load Last Session" },
--     },
-- }

which_key.setup(setup)
-- which_key.register(mappings, opts)
