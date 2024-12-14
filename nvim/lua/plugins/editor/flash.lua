return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    -- ensure better flash defaults based on your setup
    modes = {
      char = {
        enabled = false,  -- disabling char mode as it might conflict with your 's' usage
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
      function() require("flash").jump() end, 
      desc = "Flash jump" 
    },
    { 
      "S", 
      mode = { "n", "x", "o" }, 
      function() require("flash").treesitter() end, 
      desc = "Flash Treesitter" 
    },
    { 
      "r", 
      mode = "o", 
      function() require("flash").remote() end, 
      desc = "Remote Flash" 
    },
    { 
      "R", 
      mode = { "n", "o", "x" }, 
      function() require("flash").treesitter_search() end, 
      desc = "Flash Treesitter Search" 
    },
  },
}