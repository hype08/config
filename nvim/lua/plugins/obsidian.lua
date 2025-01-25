return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>oo", "<cmd>ObsidianOpen<cr>", desc = "Open in Obsidian" },
    { "<leader>oq", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick switch note" },
    { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Search notes" },
    { "<leader>ol", "<cmd>ObsidianLink<cr>", desc = "Create link" },
    {
      "<leader>on",
      function()
        if vim.fn.mode() == "v" or vim.fn.mode() == "V" then
          local title = vim.fn.input("Title (optional): ")
          if title == "" then
            vim.cmd([[normal! "vy]])
            vim.cmd("ObsidianLinkNew")
          else
            vim.cmd([[normal! "vy]])
            vim.cmd("ObsidianLinkNew " .. title)
          end
        else
          vim.cmd("normal! viw")
          vim.cmd("ObsidianLinkNew")
        end
      end,
      mode = { "n", "v" },
      desc = "Create and link note",
    },
    { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Show backlinks" },
    { "<leader>of", "<cmd>ObsidianFollowLink<cr>", desc = "Follow link" },
    { "<leader>oa", "<cmd>ObsidianLinks<cr>", desc = "Show all links" },
    { "<leader>oe", "<cmd>ObsidianExtractNote<cr>", desc = "Extract to new note" },
    { "<leader>ot", "<cmd>ObsidianNewFromTemplate<cr>", desc = "New from template" },
    { "<leader>oi", "<cmd>ObsidianPasteImg<cr>", desc = "Paste image" },
    { "<leader>oc", "<cmd>ObsidianTOC<cr>", desc = "Table of contents" },
    { "<leader>og", "<cmd>ObsidianTags<cr>", desc = "Search tags" },
    { "<leader>or", "<cmd>ObsidianRename<cr>", desc = "Rename note" },
    { "<leader>ow", "<cmd>ObsidianWorkspace<cr>", desc = "Switch workspace" },
    { "<leader>ox", "<cmd>ObsidianToggleCheckbox<cr>", desc = "Toggle checkbox" },
  },
  opts = {
    workspaces = {
      {
        name = "vault",
        path = "/Users/henry/Documents/vault/slipbox/",
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
    note_id_func = function(title)
      if title then
        return title
      end
      return vim.fn.input("Title: ")
    end,
  },
}
