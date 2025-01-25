return {
  "folke/zen-mode.nvim",
  config = function()
    require("zen-mode").setup({
      window = {
        width = 0.75,
      },
    })
    local keymap = vim.keymap
    keymap.set("n", "<Leader>z", ":ZenMode<CR>", { noremap = true, silent = true })
  end,
}
