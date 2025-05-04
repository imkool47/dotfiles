-- return {
--   {
--     "hrsh7th/cmp-nvim-lsp"
--   },
--   {
--     "L3MON4D3/LuaSnip",
--     dependencies = {
--       "saadparwaiz1/cmp_luasnip",
--       "rafamadriz/friendly-snippets",
--     },
--   },
--   {
--     "hrsh7th/nvim-cmp",
--     version = false,
--     config = function()
--       local cmp = require("cmp")
--       require("luasnip.loaders.from_vscode").lazy_load()
--
--       cmp.setup({
--         snippet = {
--           expand = function(args)
--             require("luasnip").lsp_expand(args.body)
--           end,
--         },
--         window = {
--           completion = cmp.config.window.bordered(),
--           documentation = cmp.config.window.bordered(),
--         },
--         mapping = cmp.mapping.preset.insert({
--           ["<C-b>"] = cmp.mapping.scroll_docs(-4),
--           ["<C-f>"] = cmp.mapping.scroll_docs(4),
--           ["<C-Space>"] = cmp.mapping.complete(),
--           ["<C-e>"] = cmp.mapping.abort(),
--           ["<CR>"] = cmp.mapping.confirm({ select = true }),
--         }),
--         sources = cmp.config.sources({
--           { name = "nvim_lsp" },
--           { name = "luasnip" }, -- For luasnip users.
--         }, {
--           { name = "buffer" },
--         }),
--       })
--     end,
--   },
-- }


return {
  {
    "hrsh7th/cmp-nvim-lsp"
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    version = false,
    config = function()
    local cmp = require("cmp")
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Enable/Disable toggle variable
    local completion_enabled = true

    -- Wrapper to conditionally enable completion
    cmp.setup({
      enabled = function()
      return completion_enabled
      end,

      snippet = {
        expand = function(args)
        require("luasnip").lsp_expand(args.body)
        end,
      },

      window = {
        completion = cmp.config.window.bordered(),
              documentation = cmp.config.window.bordered(),
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                                          ["<C-f>"] = cmp.mapping.scroll_docs(4),
                                          ["<C-Space>"] = cmp.mapping(function()
                                          completion_enabled = not completion_enabled
                                          local msg = completion_enabled and "🔛 Auto-Completion ON" or "🔇 Auto-Completion OFF"
                                          vim.notify(msg, vim.log.levels.INFO, { title = "nvim-cmp" })
                                          end, { "i", "c" }),

                                          ["<C-e>"] = cmp.mapping.abort(),
                                          ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
        { name = "buffer" },
      }),
    })
    end,
  },
}
