-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", "<leader>rr", ":RunCode<CR>", { desc = "Run code" })
map("n", "<leader>rf", ":RunFile<CR>", { desc = "Run file" })
map("n", "<leader>rp", ":RunProject<CR>", { desc = "Run Project" })

-- Use <leader>cp for "Copilot toggle"
vim.keymap.set("n", "<leader>cp", function()
-- Toggle Copilot enable/disable
copilot_enabled = not copilot_enabled
vim.cmd(copilot_enabled and "Copilot enable" or "Copilot disable")
vim.notify(
    copilot_enabled and "🤖 Copilot Enabled" or "🛑 Copilot Disabled",
    vim.log.levels.INFO,
    { title = "GitHub Copilot" }
)
end, { desc = "Toggle GitHub Copilot" })

