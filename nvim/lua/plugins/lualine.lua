return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      icons_enabled = false,
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        statusline = { "dashboard", "alpha", "starter" },
        winbar = {},
      },
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        {
          "branch",
          cond = function()
            return vim.fn.exists("*FugitiveHead") == 1
          end,
        },
      },
      lualine_c = {
        {
          "diagnostics",
          update_in_insert = false,
          always_visible = false,
        },
        { "filename", path = 1 },
      },
      lualine_x = {},
      lualine_y = {
        { "filetype", colored = false },
      },
      lualine_z = {
        { "location", padding = { left = 1, right = 1 } },
      },
    },
    extensions = {
      "quickfix",
      "neo-tree",
      "lazy",
    },
  },
  config = function(_, opts)
    require("lualine").setup(opts)

    vim.g.loaded_lualine_git = 0
    vim.g.loaded_lualine_treesitter = 0

    vim.opt.updatetime = 1000

    local filetype_cache = {}
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(ev)
        filetype_cache[ev.buf] = vim.bo[ev.buf].filetype
      end,
    })
  end,
}
