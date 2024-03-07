return {
  "folke/zen-mode.nvim",
  config = function()
    require("zen-mode").setup({
      window = {
        width = 0.75, -- width will be 90% of the current window
      },
    })
  end,
}
