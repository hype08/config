return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    columns = {
      "icon",
      { "permissions", highlight = "Comment" },
      { "size", highlight = "Special", min_width = 10 },
      { "mtime", highlight = "Number", format = "%Y-%m-%d %H:%M" },
    },

    view_options = {
      show_hidden = true,
      sort = {
        { "directory", "asc" },
        { "name", "asc" },
      },
      is_hidden_file = function(name)
        return vim.startswith(name, ".") and name ~= ".gitignore" and name ~= ".env"
      end,
      is_always_hidden = function(name)
        return name == ".." or name == ".git"
      end,
    },
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<C-v>"] = "actions.select_vsplit",
      ["<C-s>"] = "actions.select_split",
      ["<C-t>"] = "actions.select_tab",
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["<C-r>"] = "actions.refresh",
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = "actions.tcd",
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
      ["<C-l>"] = "actions.refresh",
      ["<C-h>"] = "actions.toggle_hidden",
    },
    use_default_keymaps = false,
  },
  config = function(_, opts)
    require("oil").setup(opts)

    vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })

    vim.keymap.set("n", "<leader>e", function()
      local oil = require("oil")

      vim.cmd("vsplit")
      vim.cmd("wincmd h")
      oil.open()
    end, { desc = "Open oil in vertical split" })
  end,
}
