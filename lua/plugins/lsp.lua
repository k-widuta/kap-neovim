return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        -- Useful status updates for LSP.
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        { "j-hui/fidget.nvim", opts = {} },

        -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        { "folke/neodev.nvim", opts = {} },
    },
    -- opts = {
    --     autoformat = false,
    -- },
    config = function()
        --  This function gets run when an LSP attaches to a particular buffer.
        --    That is to say, every time a new file is opened that is associated with
        --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
        --    function will be executed to configure the current buffer
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
            callback = function(event)
                -- NOTE: Remember that Lua is a real programming language, and as such it is possible
                -- to define small helper and utility functions so you don't have to repeat yourself.
                --
                -- In this case, we create a function that lets us more easily define mappings specific
                -- for LSP related items. It sets the mode, buffer and description for us each time.
                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end

                -- Jump to the definition of the word under your cursor.
                --  This is where a variable was first declared, or where a function is defined, etc.
                --  To jump back, press <C-t>.
                map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

                -- Find references for the word under your cursor.
                map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

                -- Jump to the implementation of the word under your cursor.
                --  Useful when your language has ways of declaring types without an actual implementation.
                map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

                -- Jump to the type of the word under your cursor.
                --  Useful when you're not sure what type a variable is and you want to see
                --  the definition of its *type*, not where it was *defined*.
                map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

                -- Fuzzy find all the symbols in your current document.
                --  Symbols are things like variables, functions, types, etc.
                map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

                -- Fuzzy find all the symbols in your current workspace.
                --  Similar to document symbols, except searches over your entire project.
                map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

                -- Rename the variable under your cursor.
                --  Most Language Servers support renaming across files, etc.
                map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

                -- Execute a code action, usually your cursor needs to be on top of an error
                -- or a suggestion from your LSP for this to activate.
                map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

                -- Opens a popup that displays documentation about the word under your cursor
                --  See `:help K` for why this keymap.
                map("K", vim.lsp.buf.hover, "Hover Documentation")

                -- WARN: This is not Goto Definition, this is Goto Declaration.
                --  For example, in C this would take you to the header.
                map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                -- The following two autocommands are used to highlight references of the
                -- word under your cursor when your cursor rests there for a little while.
                --    See `:help CursorHold` for information about when this is executed
                --
                -- When you move your cursor, the highlights will be cleared (the second autocommand).
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client.server_capabilities.documentHighlightProvider then
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = event.buf,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                        buffer = event.buf,
                        callback = vim.lsp.buf.clear_references,
                    })
                end
            end,
        })

        -- LSP servers and clients are able to communicate to each other what features they support.
        --  By default, Neovim doesn't support everything that is in the LSP specification.
        --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
        --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

        -- Enable the following language servers
        --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
        --
        --  Add any additional override configuration in the following tables. Available keys are:
        --  - cmd (table): Override the default command used to start the server
        --  - filetypes (table): Override the default list of associated filetypes for the server
        --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
        --  - settings (table): Override the default settings passed when initializing the server.
        --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
        local servers = {
            -- clangd = {},
            rust_analyzer = {},
            python = {},
            gopls = {},
            lua_ls = {
                -- cmd = {...},
                -- filetypes = { ...},
                -- capabilities = {},
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace",
                        },
                        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                        -- diagnostics = { disable = { 'missing-fields' } },
                    },
                },
            },
        }
        -- Ensure the servers and tools above are installed
        --  To check the current status of installed tools and/or manually install
        --  other tools, you can run
        --    :Mason
        --
        --  You can press `g?` for help in this menu.
        require("mason").setup()

        -- You can add other tools here that you want Mason to install
        -- for you, so that they are available from within Neovim.
        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            "stylua", -- Used to format Lua code
        })
        require("mason-tool-installer").setup { ensure_installed = ensure_installed }

        require("mason-lspconfig").setup {
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    -- This handles overriding only values explicitly passed
                    -- by the server configuration above. Useful when disabling
                    -- certain features of an LSP (for example, turning off formatting for tsserver)
                    server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                    require("lspconfig")[server_name].setup(server)
                end,
            },
        }
        -- local cmp = require "cmp"
        -- local luasnip = require "luasnip"
        -- -- require("fidget").setup {}
        -- -- require("mason").setup()
        -- -- require("mason-lspconfig").setup {
        -- --     ensure_installed = {
        -- --         "lua_ls",
        -- --         "rust_analyzer",
        -- --     },
        -- --     handlers = {
        -- --         function(server_name) -- default handler (optional)
        -- --             require("lspconfig")[server_name].setup {
        -- --                 capabilities = capabilities,
        -- --             }
        -- --         end,
        -- --
        -- --         ["lua_ls"] = function()
        -- --             local lspconfig = require "lspconfig"
        -- --             lspconfig.lua_ls.setup {
        -- --                 capabilities = capabilities,
        -- --                 settings = {
        -- --                     Lua = {
        -- --                         diagnostics = {
        -- --                             globals = { "vim", "it", "describe", "before_each", "after_each" },
        -- --                         },
        -- --                     },
        -- --                 },
        -- --             }
        -- --         end,
        -- --     },
        -- -- }
        -- --
        -- local cmp_select = { behavior = cmp.SelectBehavior.Select }
        --
        -- cmp.setup {
        --     snippet = {
        --         expand = function(args)
        --             require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        --         end,
        --     },
        --     completion = { completeopt = "menu,menuone,noinsert" },
        --
        --     mapping = cmp.mapping.preset.insert {
        --         ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        --         ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        --         ["<C-y>"] = cmp.mapping.confirm { select = true },
        --         ["<C-Space>"] = cmp.mapping.complete(),
        --
        --         -- Scroll the documentation window [b]ack / [f]orward
        --         ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        --         ["<C-f>"] = cmp.mapping.scroll_docs(4),
        --
        --         -- Think of <c-l> as moving to the right of your snippet expansion.
        --         --  So if you have a snippet that's like:
        --         --  function $name($args)
        --         --    $body
        --         --  end
        --         --
        --         -- <c-l> will move you to the right of each of the expansion locations.
        --         -- <c-h> is similar, except moving you backwards.
        --
        --         ["<C-l>"] = cmp.mapping(function()
        --             if luasnip.expand_or_locally_jumpable() then
        --                 luasnip.expand_or_jump()
        --             end
        --         end, { "i", "s" }),
        --         ["<C-h>"] = cmp.mapping(function()
        --             if luasnip.locally_jumpable(-1) then
        --                 luasnip.jump(-1)
        --             end
        --         end, { "i", "s" }),
        --     },
        --     sources = cmp.config.sources({
        --         { name = "nvim_lsp" },
        --         { name = "luasnip" }, -- For luasnip users.
        --     }, {
        --         { name = "buffer" },
        --         { name = "path" },
        --     }),
        -- }

        vim.diagnostic.config {
            update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        }
    end,
}

-- return {
--     -- tools
--     {
--         "williamboman/mason.nvim",
--         opts = function(_, opts)
--             vim.list_extend(opts.ensure_installed, {
--                 "stylua",
--                 "selene",
--                 "luacheck",
--                 "shellcheck",
--                 "shfmt",
--                 "tailwindcss-language-server",
--                 "typescript-language-server",
--                 "css-lsp",
--             })
--         end,
--     },
--
--     -- lsp servers
--     {
--         "neovim/nvim-lspconfig",
--         init = function()
--             local keys = require("lazyvim.plugins.lsp.keymaps").get()
--             keys[#keys + 1] = {
--                 "gd",
--                 function()
--                     -- DO NOT RESUSE WINDOW
--                     require("telescope.builtin").lsp_definitions { reuse_win = false }
--                 end,
--                 desc = "Goto Definition",
--                 has = "definition",
--             }
--         end,
--         opts = {
--             inlay_hints = { enabled = false },
--             ---@type lspconfig.options
--             servers = {
--                 cssls = {},
--                 tailwindcss = {
--                     root_dir = function(...)
--                         return require("lspconfig.util").root_pattern ".git"(...)
--
--                     end,
--                 },
--                 tsserver = {
--                     root_dir = function(...)
--                         return require("lspconfig.util").root_pattern ".git"(...)
--                     end,
--                     single_file_support = false,
--                     settings = {
--                         typescript = {
--                             inlayHints = {
--                                 includeInlayParameterNameHints = "literal",
--                                 includeInlayParameterNameHintsWhenArgumentMatchesName = false,
--                                 includeInlayFunctionParameterTypeHints = true,
--                                 includeInlayVariableTypeHints = false,
--                                 includeInlayPropertyDeclarationTypeHints = true,
--                                 includeInlayFunctionLikeReturnTypeHints = true,
--                                 includeInlayEnumMemberValueHints = true,
--                             },
--                         },
--                         javascript = {
--                             inlayHints = {
--                                 includeInlayParameterNameHints = "all",
--                                 includeInlayParameterNameHintsWhenArgumentMatchesName = false,
--                                 includeInlayFunctionParameterTypeHints = true,
--                                 includeInlayVariableTypeHints = true,
--                                 includeInlayPropertyDeclarationTypeHints = true,
--                                 includeInlayFunctionLikeReturnTypeHints = true,
--                                 includeInlayEnumMemberValueHints = true,
--                             },
--                         },
--                     },
--                 },
--                 html = {},
--                 yamlls = {
--                     settings = {
--                         yaml = {
--                             keyOrdering = false,
--                         },
--                     },
--                 },
--                 lua_ls = {
--                     -- enabled = false,
--                     single_file_support = true,
--                     settings = {
--                         Lua = {
--                             workspace = {
--                                 checkThirdParty = false,
--                             },
--                             completion = {
--                                 workspaceWord = true,
--                                 callSnippet = "Both",
--                             },
--                             misc = {
--                                 parameters = {
--                                     -- "--log-level=trace",
--                                 },
--                             },
--                             hint = {
--                                 enable = true,
--                                 setType = false,
--                                 paramType = true,
--                                 paramName = "Disable",
--                                 semicolon = "Disable",
--                                 arrayIndex = "Disable",
--                             },
--                             doc = {
--                                 privateName = { "^_" },
--                             },
--                             type = {
--                                 castNumberToInteger = true,
--                             },
--                             diagnostics = {
--                                 disable = { "incomplete-signature-doc", "trailing-space" },
--                                 -- enable = false,
--                                 groupSeverity = {
--                                     strong = "Warning",
--                                     strict = "Warning",
--                                 },
--                                 groupFileStatus = {
--                                     ["ambiguity"] = "Opened",
--                                     ["await"] = "Opened",
--                                     ["codestyle"] = "None",
--                                     ["duplicate"] = "Opened",
--                                     ["global"] = "Opened",
--                                     ["luadoc"] = "Opened",
--                                     ["redefined"] = "Opened",
--                                     ["strict"] = "Opened",
--                                     ["strong"] = "Opened",
--                                     ["type-check"] = "Opened",
--                                     ["unbalanced"] = "Opened",
--                                     ["unused"] = "Opened",
--                                 },
--                                 unusedLocalExclude = { "_*" },
--                             },
--                             format = {
--                                 enable = false,
--                                 defaultConfig = {
--                                     indent_style = "space",
--                                     indent_size = "2",
--                                     continuation_indent_size = "2",
--                                 },
--                             },
--                         },
--                     },
--                 },
--             },
--             setup = {},
--         },
--     },
-- }
