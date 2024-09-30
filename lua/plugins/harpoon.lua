return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require "harpoon"

        harpoon:setup()

        vim.keymap.set("n", "<leader>ha", function()
            harpoon:list():add()
        end, { desc = "Add a new harpoon" })
        vim.keymap.set("n", "<leader>hh", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Toggle harpoon menu" })

        vim.keymap.set("n", "<leader>1", function()
            harpoon:list():select(1)
        end, { desc = "Select harpoon 1" })
        vim.keymap.set("n", "<leader>2", function()
            harpoon:list():select(2)
        end, { desc = "Select harpoon 2" })
        vim.keymap.set("n", "<leader>3", function()
            harpoon:list():select(3)
        end, { desc = "Select harpoon 3" })
        vim.keymap.set("n", "<leader>4", function()
            harpoon:list():select(4)
        end, { desc = "Select harpoon 4" })
        vim.keymap.set("n", "<leader>h1", function()
            harpoon:list():replace_at(1)
        end, { desc = "Replace harpoon 1" })
        vim.keymap.set("n", "<leader>h2", function()
            harpoon:list():replace_at(2)
        end, { desc = "Replace harpoon 2" })
        vim.keymap.set("n", "<leader>h3", function()
            harpoon:list():replace_at(3)
        end, { desc = "Replace harpoon 3" })
        vim.keymap.set("n", "<leader>h4", function()
            harpoon:list():replace_at(4)
        end, { desc = "Replace harpoon 4" })
    end,
}
