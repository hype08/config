return {
  "nvimdev/lspsaga.nvim",
  config = function()
    require("lspsaga").setup({})
    local keymap = vim.keymap

    keymap.set("n", "<leader>xx", "<Cmd>Lspsaga outline<CR>", { noremap = true, silent = true })
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- optional
    "nvim-tree/nvim-web-devicons", -- optional
  },
}
