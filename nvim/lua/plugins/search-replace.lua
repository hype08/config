return {
  "MagicDuck/grug-far.nvim",
  config = function()
    require("grug-far").setup({})
    local keymap = vim.keymap

    -- Main search toggle/open
    keymap.set("n", "<leader>sr", function()
      require("grug-far").toggle_instance({ instanceName = "far", staticTitle = "Find and Replace" })
    end, { desc = "GrugFar Search Toggle" })

    -- Search in current file only
    keymap.set("n", "<leader>srf", function()
      require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
    end, { desc = "GrugFar Search limited to current file" })

    -- Search with word under cursor
    keymap.set("n", "<leader>sw", function()
      require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
    end, { desc = "GrugFar Search with current word" })
  end,
}
