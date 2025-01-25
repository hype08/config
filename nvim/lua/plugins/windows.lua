return {
  "anuvyklack/windows.nvim",
  dependencies = {
    "anuvyklack/middleclass",
    "anuvyklack/animation.nvim",
  },
  config = function()
    vim.o.winwidth = 5 -- Minimum width of active window
    vim.o.winminwidth = 1 -- Minimum width of inactive windows
    vim.o.equalalways = false -- Don't auto-resize windows

    require("windows").setup({
      autowidth = {
        enable = true,
        winwidth = 0, -- Let windows.nvim handle the sizing
        filetype = {
          help = 2,
          qf = 1,
        },
      },
      ignore = {
        buftype = { "quickfix" },
        filetype = { "NvimTree", "neo-tree", "undotree", "gundo" },
      },
      animation = {
        enable = true,
        duration = 300,
      },
    })

    vim.keymap.set("n", "<C-w>z", function()
      require("windows.commands").maximize()
    end, { desc = "Maximize current window" })
  end,
}
