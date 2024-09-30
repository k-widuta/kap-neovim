function ColorMyPencils(color)
    color = color or "rose-pine-moon"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {

    {
        "erikbackman/brightburn.vim",
    },

    {
        "folke/tokyonight.nvim",
        lazy = false,
        opts = {},
        config = function()
            ColorMyPencils()
        end,
    },
    {
        "ellisonleao/gruvbox.nvim",
        name = "gruvbox",
        config = function()
            require("gruvbox").setup {
                terminal_colors = true, -- add neovim terminal colors
                undercurl = true,
                underline = false,
                bold = true,
                italic = {
                    strings = false,
                    emphasis = false,
                    comments = false,
                    operators = false,
                    folds = false,
                },
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                invert_intend_guides = false,
                inverse = true, -- invert background for search, diffs, statuslines and errors
                contrast = "", -- can be "hard", "soft" or empty string
                palette_overrides = {},
                overrides = {
                    GruvboxAqua = { fg = "#fabd2f" },
                    Type = { fg = "#b8bb26" },
                    Typedef = { fg = "#b8bb26" },
                    ["@lsp.type.class"] = { fg = "#fabd2f" },
                    Operator = { fg = "#ffffff" },
                    Function = { fg = "#fabd2f", bold = true },
                    Special = { fg = "#fabd2f" },
                    String = { fg = "#98971a" },
                },
                dim_inactive = false,
                transparent_mode = true,
            }
        end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
                transparent = false, -- Enable this to disable setting the background color
                terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
                styles = {
                    -- Style to be applied to different syntax groups
                    -- Value is any valid attr-list value for `:help nvim_set_hl`
                    comments = { italic = false },
                    keywords = { italic = false },
                    -- Background styles. Can be "dark", "transparent" or "normal"
                    sidebars = "dark", -- style for sidebars, see below
                    floats = "dark", -- style for floating windows
                },
            }
        end,
    },

    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("rose-pine").setup {
                disable_background = false,
                styles = {
                    italic = false,
                },
            }
        end,
    },
}
-- return {
--     -- add gruvbox
--     {
--         "ellisonleao/gruvbox.nvim",
--         lazy = false,
--         priority = 1000,
--         config = function()
--             require("gruvbox").setup {
--                 terminal_colors = true, -- add neovim terminal colors
--                 undercurl = true,
--                 underline = true,
--                 bold = true,
--                 italic = {
--                     strings = false,
--                     emphasis = false,
--                     comments = true,
--                     operators = false,
--                     folds = true,
--                 },
--                 strikethrough = true,
--                 invert_selection = false,
--                 invert_signs = false,
--                 invert_tabline = false,
--                 invert_intend_guides = false,
--                 inverse = true, -- invert background for search, diffs, statuslines and errors
--                 contrast = "soft", -- can be "hard", "soft" or empty string
--                 palette_overrides = {
--                     dark0_hard = "#1d2021",
--                     dark0 = "#282828",
--                     dark0_soft = "#32302f",
--                     dark1 = "#3c3836",
--                     dark2 = "#504945",
--                     dark3 = "#504945",
--                     dark4 = "#665c54",
--                     light0_hard = "#f9f5d7",
--                     light0 = "#fbf1c7",
--                     light0_soft = "#f2e5bc",
--                     light1 = "#ebdbb2",
--                     light2 = "#d5c4a1",
--                     light3 = "#d4be98",
--                     light4 = "#ddc7a1",
--                     bright_red = "#fb4934",
--                     bright_green = "#b8bb26",
--                     -- bright_yellow = "#fe8019", -- "#fabd2f",
--                     -- bright_blue = "#83a598",
--                     -- bright_purple = "#d3869b",
--                     -- bright_aqua = "#8ec07c",
--                     -- bright_orange = "#fabd2f", -- "#fe8019",
--                     -- neutral_red = "#cc241d",
--                     -- neutral_green = "#98971a",
--                     -- neutral_yellow = "#d65d0e", -- "#d79921",
--                     -- neutral_blue = "#458588",
--                     -- neutral_purple = "#b16286",
--                     -- neutral_aqua = "#689d6a",
--                     -- neutral_orange = "#d79921", -- "#d65d0e",
--                     -- faded_red = "#9d0006",
--                     -- faded_green = "#79740e",
--                     -- faded_yellow = "#af3a03", --"#b57614",
--                     -- faded_blue = "#076678",
--                     -- faded_purple = "#8f3f71",
--                     -- faded_aqua = "#427b58",
--                     -- faded_orange = "#b57614", -- "#af3a03",
--                     dark_red_hard = "#792329",
--                     dark_red = "#722529",
--                     dark_red_soft = "#7b2c2f",
--                     light_red_hard = "#fc9690",
--                     light_red = "#fc9487",
--                     light_red_soft = "#f78b7f",
--                     dark_green_hard = "#5a633a",
--                     dark_green = "#62693e",
--                     dark_green_soft = "#686d43",
--                     light_green_hard = "#d3d6a5",
--                     light_green = "#d5d39b",
--                     light_green_soft = "#cecb94",
--                     dark_aqua_hard = "#3e4934",
--                     dark_aqua = "#49503b",
--                     dark_aqua_soft = "#525742",
--                     light_aqua_hard = "#e6e9c1",
--                     light_aqua = "#e8e5b5",
--                     light_aqua_soft = "#e1dbac",
--                     gray = "#a89984",
--                 },
--                 overrides = {
--                     -- The right one but we do it changes everything to white and we do not want that.
--                     GruvboxAqua = { fg = "#fabd2f" },
--                     Type = { fg = "#b8bb26" },
--                     Typedef = { fg = "#b8bb26" },
--                     ["@lsp.type.class"] = { fg = "#fabd2f" },
--                     Operator = { fg = "#ffffff" },
--                     Function = { fg = "#fabd2f", bold = true },
--                     Special = { fg = "#fabd2f" },
--                     String = { fg = "#98971a" },
--                 },
--                 dim_inactive = false,
--                 -- Change it to flase if you want the real gruvbox background.
--                 transparent_mode = true,
--             }
--             vim.cmd.colorscheme "gruvbox"
--         end,
--     },
--     -- Configure LazyVim to load gruvbox
--     {
--         "LazyVim/LazyVim",
--         opts = {
--             colorscheme = "gruvbox",
--         },
--     },
-- }
--
-- -- return {
-- --     "rose-pine/neovim",
-- --     name = "rose-pine",
-- --     lazy = true,
-- --     priority = 1000,
-- --     config = function()
-- --         require("rose-pine").setup {
-- --             variant = "moon", -- auto, main, moon, or dawn
-- --             dark_variant = "moon", -- main, moon, or dawn
-- --             dim_inactive_windows = false,
-- --             extend_background_behind_borders = true,
-- --             disable_background = true,
-- --             enable = {
-- --                 terminal = true,
-- --                 legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
-- --                 migrations = true, -- Handle deprecated options automatically
-- --             },
-- --
-- --             styles = {
-- --                 bold = true,
-- --                 italic = false,
-- --                 transparency = false,
-- --             },
-- --
-- --             groups = {
-- --                 border = "muted",
-- --                 link = "iris",
-- --                 panel = "surface",
-- --
-- --                 error = "love",
-- --                 hint = "iris",
-- --                 info = "foam",
-- --                 note = "pine",
-- --                 todo = "rose",
-- --                 warn = "gold",
-- --
-- --                 git_add = "foam",
-- --                 git_change = "rose",
-- --                 git_delete = "love",
-- --                 git_dirty = "rose",
-- --                 git_ignore = "muted",
-- --                 git_merge = "iris",
-- --                 git_rename = "pine",
-- --                 git_stage = "iris",
-- --                 git_text = "rose",
-- --                 git_untracked = "subtle",
-- --
-- --                 h1 = "iris",
-- --                 h2 = "foam",
-- --                 h3 = "rose",
-- --                 h4 = "gold",
-- --                 h5 = "pine",
-- --                 h6 = "foam",
-- --             },
-- --
-- --             highlight_groups = {
-- --                 -- Comment = { fg = "foam" },
-- --                 -- VertSplit = { fg = "muted", bg = "muted" },
-- --             },
-- --
-- --             before_highlight = function(group, highlight, palette)
-- --                 -- Disable all undercurls
-- --                 -- if highlight.undercurl then
-- --                 --     highlight.undercurl = false
-- --                 -- end
-- --                 --
-- --                 -- Change palette colour
-- --                 -- if highlight.fg == palette.pine then
-- --                 --     highlight.fg = palette.foam
-- --                 -- end
-- --             end,
-- --         }
-- --         vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- --         vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- --     end,
-- -- }
