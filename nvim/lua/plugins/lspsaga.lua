return {
  "nvimdev/lspsaga.nvim",
  config = function()
    require("lspsaga").setup({})
    local keymap = vim.keymap

    keymap.set("n", "<C-x>", "<Cmd>Lspsaga outline<CR>", { noremap = true, silent = true })
    keymap.set("n", "<C-i>", "<Cmd>Lspsaga peek_definition<CR>", { noremap = true, silent = true })
    keymap.set("n", "<C-t>", "<Cmd>Lspsaga peek_type_definition<CR>", { noremap = true, silent = true })
    keymap.set("n", "<C-space>", "<Cmd>Lspsaga finder<CR>", { noremap = true, silent = true })
    keymap.set("n", "<leader>;", "<Cmd>Lspsaga term_toggle<CR>", { noremap = true, silent = true })
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- optional
    "nvim-tree/nvim-web-devicons", -- optional
  },
}
