local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

require("luasnip.loaders.from_vscode").lazy_load()
local autopairs = require("nvim-autopairs.completion.cmp")

local check_backspace = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

cmp.event:on("confirm_done", autopairs.on_confirm_done())

-- 󰃐 󰆩 󰙅 󰛡  󰅲 some other good icons
local kind_icons = {
  Text = "󰉿",
  Method = "m",
  Function = "󰊕",
  Constructor = "",
  Field = "",
  Variable = "󰆧",
  Class = "󰌗",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "",
  File = "󰈙",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "󰇽",
  Struct = "",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "󰊄",
}

cmp.setup({
  -- enabled = function()
  --     local in_prompt = vim.api.nvim_buf_get_option(0, "buftype") == "prompt"
  --     if in_prompt then -- this will disable cmp in the Telescope window (taken from the default config)
  --         return false
  --     end
  --     local context = require("cmp.config.context")
  --     return not (context.in_treesitter_capture("comment") == true or context.in_syntax_group("Comment"))
  -- end,

  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)       -- For `luasnip` users.
    end,
  },
  -- completion = { completeopt = "menu, menuone, noinsert, preview" }, -- This fucker was a huge lag causer.
  -- performance = {
  --     debounce = 0,
  --     throttle = 250,
  --     fetching_timeout = 100,
  --     max_view_entries = 20,
  -- },
  mapping = {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-2), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(2), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable,     -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- ESC key aborts completion while staying in insert mode
    ["<ESC>"] = cmp.mapping.abort(),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({ select = true })
        -- elseif luasnip.expandable() then
        --     luasnip.expand()
        -- elseif luasnip.jumpable() then
        --     luasnip.jump()
      elseif luasnip.expand_or_jumpable() then       -- Unfortunately jumpable check affects fluidity of typing.
        luasnip.expand_or_jump()
        -- elseif check_backspace() then
        --     fallback()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        cmp.complete()
        -- fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
  formatting = {
    expandable_indicator = true,
    fields = { "abbr", "kind" },
    format = function(entry, vim_item)
      -- Max width
      vim_item.abbr = string.sub(vim_item.abbr, 1, 60)
      -- Kind icons
      -- vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      vim_item.kind = vim_item.kind
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    -- { name = "copilot", group_index = 2 },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    -- { name = "buffer" },
    { name = "path" },
    { name = "nvim_lsp_signature_help" },
    { name = "neorg" },
    { name = "emoji" },
  },
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      require("cmp-under-comparator").under,
      cmp.config.compare.kind,
    },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  -- window = {
  --     completion = cmp.config.window.bordered(),
  --     documentation = cmp.config.window.bordered(),
  --     -- documentation = {
  --     -- 	border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  --     -- },
  -- },
  -- experimental = {
  --     ghost_text = false,
  --     native_menu = false,
  -- },
})



--  -- Set up nvim-cmp.
--  local cmp = require'cmp'
--
--  cmp.setup({
--    snippet = {
--      -- REQUIRED - you must specify a snippet engine
--      expand = function(args)
--        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
--      end,
--    },
--    window = {
--      -- completion = cmp.config.window.bordered(),
--      -- documentation = cmp.config.window.bordered(),
--    },
--    -- mapping = {
--    --     ["<C-k>"] = cmp.mapping.select_prev_item(),
--    --     ["<C-j>"] = cmp.mapping.select_next_item(),
--    --     ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-2), { "i", "c" }),
--    --     ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(2), { "i", "c" }),
--    --     ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
--    --     ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
--    --     ["<C-e>"] = cmp.mapping({
--    --         i = cmp.mapping.abort(),
--    --         c = cmp.mapping.close(),
--    --     }),
--    --     -- ESC key aborts completion while staying in insert mode
--    --     ["<ESC>"] = cmp.mapping.abort(),
--    --     -- Accept currently selected item. If none selected, `select` first item.
--    --     -- Set `select` to `false` to only confirm explicitly selected items.
--    --     ["<CR>"] = cmp.mapping.confirm({ select = true }),
--    --     ["<Tab>"] = cmp.mapping(function(fallback)
--    --         if cmp.visible() then
--    --             cmp.confirm({ select = true })
--    --         -- elseif luasnip.expandable() then
--    --         --     luasnip.expand()
--    --         elseif luasnip.expand_or_jumpable() then
--    --             luasnip.expand_or_jump()
--    --         -- elseif check_backspace() then
--    --         --     fallback()
--    --         else
--    --             fallback()
--    --         end
--    --     end, {
--    --         "i",
--    --         "s",
--    --     }),
--    --     ["<S-Tab>"] = cmp.mapping(function(fallback)
--    --         if cmp.visible() then
--    --             cmp.select_prev_item()
--    --         elseif luasnip.jumpable(-1) then
--    --             luasnip.jump(-1)
--    --         else
--    --             cmp.complete()
--    --             -- fallback()
--    --         end
--    --     end, {
--    --         "i",
--    --         "s",
--    --     }),
--    -- },
--    mapping = cmp.mapping.preset.insert({
--      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--      ['<C-f>'] = cmp.mapping.scroll_docs(4),
--      ['<C-Space>'] = cmp.mapping.complete(),
--      ['<C-e>'] = cmp.mapping.abort(),
--      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--    }),
--    sources = cmp.config.sources({
--      { name = 'nvim_lsp' },
--      { name = 'luasnip' }, -- For luasnip users.
--    }, {
--      { name = 'buffer' },
--    })
--  })
--
--  -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
--  -- Set configuration for specific filetype.
--  --[[ cmp.setup.filetype('gitcommit', {
--    sources = cmp.config.sources({
--      { name = 'git' },
--    }, {
--      { name = 'buffer' },
--    })
-- })
-- require("cmp_git").setup() ]]--

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})
