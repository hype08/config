return {
  "MagicDuck/grug-far.nvim",
  config = function()
    require("grug-far").setup({})
    local keymap = vim.keymap
    keymap.set("n", "<leader>srg", function()
      require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
    end, { desc = "GrugFar Search with current word" })

    keymap.set("n", "<leader>srf", function()
      require("grug-far").with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })
    end, { desc = "GrugFar Search limited to current file" })
  end,
}
