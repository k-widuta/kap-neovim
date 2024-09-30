return {
    -- Create annotations with one keybind, and jump your cursor in the inserted annotation
    {
        "danymat/neogen",
        keys = {
            {
                "<leader>cc",
                function()
                    require("neogen").generate {}
                end,
                desc = "Neogen Comment",
            },
        },
        opts = { snippet_engine = "luasnip" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            local neogen = require "neogen"

            neogen.setup {
                snippet_engine = "luasnip",
            }

            vim.keymap.set("n", "<leader>nf", function()
                neogen.generate { type = "func" }
            end)

            vim.keymap.set("n", "<leader>nt", function()
                neogen.generate { type = "type" }
            end)
        end,
    },

    -- Incremental rename
    {
        "smjonas/inc-rename.nvim",
        cmd = "IncRename",
        config = true,
    },

    -- Refactoring tool
    {
        "ThePrimeagen/refactoring.nvim",
        keys = {
            {
                "<leader>r",
                function()
                    require("refactoring").select_refactor()
                end,
                mode = "v",
                noremap = true,
                silent = true,
                expr = false,
            },
        },
        opts = {},
    },

    -- Go forward/backward with square brackets
    {
        "echasnovski/mini.bracketed",
        event = "BufReadPost",
        config = function()
            local bracketed = require "mini.bracketed"
            bracketed.setup {
                file = { suffix = "" },
                window = { suffix = "" },
                quickfix = { suffix = "" },
                yank = { suffix = "" },
                treesitter = { suffix = "n" },
            }
        end,
    },

    -- Better increase/descrease
    {
        "monaqa/dial.nvim",
    -- stylua: ignore
    keys = {
      { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
    },
        config = function()
            local augend = require "dial.augend"
            require("dial.config").augends:register_group {
                default = {
                    augend.integer.alias.decimal,
                    augend.integer.alias.hex,
                    augend.date.alias["%Y/%m/%d"],
                    augend.constant.alias.bool,
                    augend.semver.alias.semver,
                    augend.constant.new { elements = { "let", "const" } },
                },
            }
        end,
    },

    {
        "simrat39/symbols-outline.nvim",
        keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
        cmd = "SymbolsOutline",
        opts = {
            position = "right",
        },
    },

    {
        "nvim-cmp",
        dependencies = { "hrsh7th/cmp-emoji" },
        opts = function(_, opts)
            table.insert(opts.sources, { name = "emoji" })
        end,
    },
    -- Delete <tab> binding to use it for copilot

    {
        "L3MON4D3/LuaSnip",
        keys = function()
            return {}
        end,
        -- keys = {
        -- {
        --     "<S-tab>",
        --     function()
        --         return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<d-tab>"
        --     end,
        --     expr = true,
        --     silent = true,
        --     mode = "i",
        -- },
        -- {
        --     "<D-tab>",
        --     function()
        --         require("luasnip").jump(1)
        --     end,
        --     mode = "s",
        -- },
        -- {
        --     "<A-tab>",
        --     function()
        --         require("luasnip").jump(-1)
        --     end,
        --     mode = { "i", "s" },
        -- },
        -- },
    },
}
