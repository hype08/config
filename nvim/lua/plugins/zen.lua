return {
  "folke/zen-mode.nvim",
  config = function()
    require("zen-mode").setup({
      window = {
        width = 0.75, -- width will be 90% of the current window
      },
    })
    local keymap = vim.keymap
    keymap.set("n", "<Leader>z", ":ZenMode<CR>", { noremap = true, silent = true })
  end,
}
