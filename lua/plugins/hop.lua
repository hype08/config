return {
  "smoka7/hop.nvim",
  keys = {
    { "<leader>h", ":HopWord<CR>", desc = "Hop to word" },
    { "<leader>r", ":HopChar1<CR>", desc = "Hop to character" },
  },
  version = "*",
  opts = {},
  config = function()
    local hop = require("hop")
    hop.setup({ keys = "etovxqpdygfblzhckisuran" })
  end,
}
