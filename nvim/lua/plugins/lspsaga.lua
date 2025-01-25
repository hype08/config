return {
  "nvimdev/lspsaga.nvim",
  config = function()
    require("lspsaga").setup({
      outline = {
        auto_preview = false,
        win_position = "left",
        close_after_jump = true,
      },
    })
    local keymap = vim.keymap
    keymap.set("n", "<C-x>", "<Cmd>Lspsaga outline<CR>", { noremap = true, silent = true })
    keymap.set("n", "<C-l>", "<Cmd>Lspsaga peek_definition<CR>", { noremap = true, silent = true })
    keymap.set("n", "<C-t>", "<Cmd>Lspsaga peek_type_definition<CR>", { noremap = true, silent = true })
    keymap.set("n", "<C-a>", "<Cmd>Lspsaga finder<CR>", { noremap = true, silent = true })
    keymap.set(
      "n",
      "<leader>ca",
      "<cmd>Lspsaga code_action<CR>",
      { desc = "Code actions", noremap = true, silent = true }
    )
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
}
