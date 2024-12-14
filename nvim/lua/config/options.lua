-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt
-- Disable netrw for oil.nvim
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

opt.relativenumber = true
opt.number = true

-- tabs & indents
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- search
opt.ignorecase = true
opt.smartcase = true -- make case sensitive if searching with mixed casing

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- splits
opt.splitright = true
opt.splitbelow = true

-- set split separator color
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#1c1c1c" })
  end,
})

opt.hidden = true
-- Add some general UI improvements
vim.opt.mousemoveevent = true
vim.opt.cursorline = true