-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

-- Copy file path to cb
keymap.set("n", "<leader>xc", "<Cmd>let @+=expand('%:~:.')<CR>", { silent = true })

-- Splits
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-W>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-W>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Resize splits
keymap.set(
  "n",
  "<leader>xu",
  ":resize +10<CR>",
  { noremap = true, silent = true, desc = "Increase height of current split by 15" }
)
keymap.set(
  "n",
  "<leader>xj",
  ":resize -10<CR>",
  { noremap = true, silent = true, desc = "Decrease height of current split by 15" }
)
keymap.set(
  "n",
  "<leader>xl",
  ":vertical resize +10<CR>",
  { noremap = true, silent = true, desc = "Increase width of current split by 15" }
)
keymap.set(
  "n",
  "<leader>xk",
  ":vertical resize -10<CR>",
  { noremap = true, silent = true, desc = "Decrease width of current split by 15" }
)

-- Reset current split to full height
keymap.set("n", "<leader>sfh", "<cmd>resize<CR>", { desc = "Reset current split to full height" })

-- Reset current split to full width
keymap.set("n", "<leader>sfw", "<cmd>vertical resize<CR>", { desc = "Reset current split to full width" })

-- Tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew<CR>", { desc = "Open current buffer in new tab" })

-- Lols
keymap.set("n", "yc", "yy<cmd>normal gcc<CR>p", { desc = "Duplicate a line and comment out the first line" })
keymap.set("n", "<C-c>", "ciw", { desc = "Change word" })
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected up" }) -- thanks Prime
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected down" })
-- keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search" })
