return {
  "epwalsh/obsidian.nvim",
  event = { "BufReadPre", "BufNewFile" },
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    -- Basic note operations
    { "<leader>oo", "<cmd>ObsidianOpen<cr>", desc = "Open in Obsidian" },
    { "<leader>of", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick switch note" },
    { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Search notes" },

    -- Links and references
    { "<leader>kl", "<cmd>ObsidianLink<cr>", desc = "Create link" },
    { "<leader>kn", "<cmd>ObsidianLinkNew<cr>", desc = "Create and link new note" },
    { "<leader>kb", "<cmd>ObsidianBacklinks<cr>", desc = "Show backlinks" },
    { "<leader>kf", "<cmd>ObsidianFollowLink<cr>", desc = "Follow link" },
    { "<leader>ka", "<cmd>ObsidianLinks<cr>", desc = "Show all links" },
    { "<leader>ke", "<cmd>ObsidianExtractNote<cr>", desc = "Extract to new note" },

    -- Templates and content
    { "<leader>ott", "<cmd>ObsidianNewFromTemplate<cr>", desc = "New from template" },
    { "<leader>oti", "<cmd>ObsidianPasteImg<cr>", desc = "Paste image" },
    { "<leader>otc", "<cmd>ObsidianTOC<cr>", desc = "Table of contents" },

    -- Organization
    { "<leader>ogt", "<cmd>ObsidianTags<cr>", desc = "Search tags" },
    { "<leader>ogr", "<cmd>ObsidianRename<cr>", desc = "Rename note" },
    { "<leader>ogw", "<cmd>ObsidianWorkspace<cr>", desc = "Switch workspace" },

    { "<leader>oc", "<cmd>ObsidianToggleCheckbox<cr>", desc = "Toggle checkbox" },
  },
  opts = {
    workspaces = {
      {
        name = "vault",
        path = "/Users/henry/Documents/vault",
      },
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },
  },
}
