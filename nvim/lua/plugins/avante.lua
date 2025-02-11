return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false,
  opts = {},
  -- enabled = false,
  -- keys = {
  --   { "<leader>aa", "<cmd>AvanteToggle<cr>", desc = "Toggle Avante" },
  --   { "<leader>af", "<cmd>AvanteFocus<cr>", desc = "Jump to Avante" },
  --   { "<leader>ac", "<cmd>AvanteClearHistory<cr>", desc = "Clear History" },
  --   { "<leader>as", "<cmd>AvanteSaveChat<cr>", desc = "Save Chat" },
  --   { "<leader>al", "<cmd>AvanteLoadChat<cr>", desc = "Load Chat" },
  -- },
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf   "nvim-tree/nvim-web-devicons",
    -- {
    --   "HakonHarnes/img-clip.nvim",
    --   event = "VeryLazy",
    --   opts = {
    --     default = {
    --       embed_image_as_base64 = false,
    --       prompt_for_file_name = false,
    --       drag_and_drop = {
    --         insert_mode = false,
    --       },
    --     },
    --   },
    -- },
    -- {
    --   "MeanderingProgrammer/render-markdown.nvim",
    --   opts = {
    --     file_types = { "markdown", "Avante" },
    --   },
    --   ft = { "markdown", "Avante" },
    -- },
  },
}
