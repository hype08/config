return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    modes = {
      -- disable char mode since 's' is commonly used for substitution
      char = {
        enabled = false,
      },
      search = {
        enabled = true,
        highlight = { backdrop = true },
        jump = { history = true },
      },
    },
    prompt = {
      prefix = { { "⚡", "FlashPromptIcon" } },
    },
  },
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash jump",
    },
    {
      "S",
      mode = { "n", "o", "x" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
    {
      "r",
      mode = "o",
      function()
        require("flash").remote()
      end,
      desc = "Remote Flash",
    },
    {
      "R",
      mode = { "n", "o", "x" },
      function()
        require("flash").treesitter_search()
      end,
      desc = "Flash Treesitter Search",
    },
  },
}

