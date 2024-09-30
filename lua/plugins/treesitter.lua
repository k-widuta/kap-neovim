return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup {
            -- A list of parser names, or "all"
            ensure_installed = {
                "vimdoc",
                "javascript",
                "typescript",
                "go",
                "c",
                "lua",
                "rust",
                "jsdoc",
                "bash",
            },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
            auto_install = true,

            indent = {
                enable = true,
            },

            highlight = {
                -- `false` will disable the whole extension
                enable = true,

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = { "markdown" },
            },
        }

        local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        treesitter_parser_config.templ = {
            install_info = {
                url = "https://github.com/vrischmann/tree-sitter-templ.git",
                files = { "src/parser.c", "src/scanner.c" },
                branch = "master",
            },
        }

        vim.treesitter.language.register("templ", "templ")
    end,
}

-- return {
-- 	{ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
--
-- 	{
-- 		"nvim-treesitter/nvim-treesitter",
-- 		opts = {
-- 			ensure_installed = {
-- 				"astro",
-- 				"cmake",
-- 				"cpp",
-- 				"css",
-- 				"fish",
-- 				"gitignore",
-- 				"go",
-- 				"graphql",
-- 				"http",
-- 				"java",
-- 				"php",
-- 				"rust",
-- 				"scss",
-- 				"sql",
-- 				"svelte",
-- 			},
--
-- 			-- matchup = {
-- 			-- 	enable = true,
-- 			-- },
--
-- 			-- https://github.com/nvim-treesitter/playground#query-linter
-- 			query_linter = {
-- 				enable = true,
-- 				use_virtual_text = true,
-- 				lint_events = { "BufWrite", "CursorHold" },
-- 			},
--
-- 			playground = {
-- 				enable = true,
-- 				disable = {},
-- 				updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
-- 				persist_queries = true, -- Whether the query persists across vim sessions
-- 				keybindings = {
-- 					toggle_query_editor = "o",
-- 					toggle_hl_groups = "i",
-- 					toggle_injected_languages = "t",
-- 					toggle_anonymous_nodes = "a",
-- 					toggle_language_display = "I",
-- 					focus_language = "f",
-- 					unfocus_language = "F",
-- 					update = "R",
-- 					goto_node = "<cr>",
-- 					show_help = "?",
-- 				},
-- 			},
-- 		},
-- 		config = function(_, opts)
-- 			require("nvim-treesitter.configs").setup(opts)
--
-- 			-- MDX
-- 			vim.filetype.add({
-- 				extension = {
-- 					mdx = "mdx",
-- 				},
-- 			})
-- 			vim.treesitter.language.register("markdown", "mdx")
-- 		end,
-- 	},
-- }
