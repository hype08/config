-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>xx", "<Cmd>Lspsaga outline<CR>", { noremap = true, silent = true })

keymap.set({ "n", "v" }, "<leader>]", ":Gen<CR>") -- Gen.nvim

-- Vim REST Console
keymap.set("n", "<leader>xr", ":call VrcQuery()<CR>") -- Run REST query

-- Switch
keymap.set("n", "<leader>-", ":Switch<CR>")

-- Copy file path to cb
keymap.set("n", "<leader>xc", "<Cmd>let @+=expand('%:~:.')<CR>", { silent = true })

-- Telescope grep string
keymap.set("n", "<leader>=", "<Cmd>Telescope grep_string<CR>", { noremap = true, silent = true })

-- Zen mode
keymap.set("n", "<Leader>z", ":ZenMode<CR>", { noremap = true, silent = true })
