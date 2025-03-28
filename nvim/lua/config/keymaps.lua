-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

-- Paste and move cursor to end of pasted text
keymap.set({ "n", "v" }, "p", "p`]", { noremap = true, desc = "Paste and move cursor to end" })
keymap.set({ "n", "v" }, "P", "P`]", { noremap = true, desc = "Paste before and move cursor to end" })

-- Yank and keep cursor position
keymap.set({ "n", "v" }, "y", "y`]", { noremap = true, desc = "Yank and keep cursor position" })
keymap.set({ "n", "v" }, "Y", "Y`]", { noremap = true, desc = "Yank line and keep cursor position" })

-- Copy file path to cb
keymap.set(
  "n",
  "<leader>xc",
  "<Cmd>let @+=expand('%:~:.')<CR><Cmd>lua vim.notify('File path copied to clipboard')<CR>",
  { silent = true, desc = "Copy current file path to clipboard" }
)

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

-- Tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew<CR>", { desc = "Open current buffer in new tab" })

-- LSP
keymap.set("n", "<leader>dt", function()
  local current_config = vim.diagnostic.config()
  vim.diagnostic.config({
    virtual_text = not current_config.virtual_text,
  })
end, { desc = "Toggle diagnostic virtual text" })

keymap.set("n", "<leader>ds", function()
  vim.diagnostic.open_float(nil, { focus = false })
end, { desc = "Open diagnostic in float" })

-- Lols
keymap.set("n", "yc", "yy<cmd>normal gcc<CR>p", { desc = "Duplicate a line and comment out the first line" })
keymap.set("n", "<C-c>", "ciw", { desc = "Change word" })
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected up" }) -- thanks Prime
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected down" })
-- keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search" })

-- Buffers
keymap.set("n", "<leader>wq", "<cmd>w<CR><cmd>bd<CR>", { desc = "Save and close buffer" })

-- Yank entire buffer
keymap.set("n", "<leader>ya", "<cmd>%y+<CR>", { silent = true, desc = "Yank entire buffer to system clipboard" })
keymap.set("n", "<leader>yA", "<cmd>%y<CR>", { silent = true, desc = "Yank entire buffer to unnamed register" })

-- Obsidian
keymap.set({ "n", "v" }, "<leader>on", function()
  -- If in visual mode, proceed with selection
  if vim.fn.mode() == "v" or vim.fn.mode() == "V" then
    local title = vim.fn.input("Title (optional): ")
    if title == "" then
      vim.cmd("ObsidianLinkNew")
    else
      vim.cmd("ObsidianLinkNew " .. title)
    end
  else
    -- If in normal mode, select word under cursor
    local title = vim.fn.input("Title (optional): ")
    if title == "" then
      vim.cmd("normal! viw")
      vim.cmd("ObsidianLinkNew")
    else
      vim.cmd("normal! viw")
      vim.cmd("ObsidianLinkNew " .. title)
    end
  end
end, { desc = "Create and link new note" })

-- Add ObsidianExtract command to visual mode only, since it requires selection
keymap.set("v", "<leader>oe", "<cmd>ObsidianExtract<CR>", { desc = "Extract selection to new note" })
