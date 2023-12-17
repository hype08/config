return {
  "smoka7/hop.nvim",
  keys = {
    { "<leader>h", ":HopWord<CR>", desc = "Hop to word" },
  },
  version = "*",
  opts = {},
  config = function()
    local hop = require("hop")
    hop.setup({ keys = "etovxqpdygfblzhckisuran" })
  end,
}
