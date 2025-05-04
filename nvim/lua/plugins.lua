return {
        {
                "nvzone/volt",
                config = function()
                require("volt")
                end,
        },
        {
                "nvzone/typr",
                dependencies = { "nvzone/volt" },
                config = function()
                require("typr").setup({})
                end,
                cmd = { "Typr", "TyprStats" },
        },

        -- {
        --   "ellisonleao/gruvbox.nvim",
        --   priority = 1000,
        --   config = true,
        --   opts = {}, -- your options here
        -- },
}
