return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    default_file_explorer = true,
    columns = {
      "icon",
      { "permissions", highlight = "Comment" },
      { "size", highlight = "Special", min_width = 10 },
      { "mtime", highlight = "Number", format = "%Y-%m-%d %H:%M" },
    },
    float = {
      padding = 2,
      max_width = 100,
      max_height = 40,
      border = "rounded",
      win_options = {
        winblend = 0,
      },
    },
    vertical = {
      size = function()
        local width = math.floor(vim.o.columns * 0.25)
        return math.max(20, math.min(60, width))
      end,
      position = "left",
    },

    view_options = {
      show_hidden = true,
      sort = {
        { "directory", "asc" },
        { "name", "asc" },
      },
      is_hidden_file = function(name)
        return vim.startswith(name, ".")
          and name ~= ".gitignore"
          and name ~= ".env"
          and name ~= ".eslintrc"
          and name ~= ".prettierrc"
      end,
      is_always_hidden = function(name)
        return name == ".." or name == ".git"
      end,
      width = "auto",
    },
    keymaps = {
      ["g?"] = { "actions.show_help", mode = "n" },
      ["<CR>"] = "actions.select",
      ["<C-s>"] = { "actions.select", opts = { vertical = true } },
      ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
      ["<C-t>"] = { "actions.select", opts = { tab = true } },
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = { "actions.close", mode = "n" },
      ["<C-l>"] = "actions.refresh",
      ["-"] = { "actions.parent", mode = "n" },
      ["_"] = { "actions.open_cwd", mode = "n" },
      ["`"] = { "actions.cd", mode = "n" },
      ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
      ["gs"] = { "actions.change_sort", mode = "n" },
      ["gx"] = "actions.open_external",
      ["g."] = { "actions.toggle_hidden", mode = "n" },
      ["g\\"] = { "actions.toggle_trash", mode = "n" },
      ["<Esc>"] = "actions.close",
      ["zh"] = "actions.toggle_hidden",
      ["zr"] = "actions.refresh",
      ["q"] = "actions.close",
    },
    use_default_keymaps = false,
  },
  config = function(_, opts)
    require("oil").setup(opts)

    vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })

    vim.keymap.set("n", "<leader>fv", function()
      local oil = require("oil")
      vim.cmd("vsplit")
      vim.cmd("wincmd h")
      oil.open()
      local width = math.floor(vim.o.columns * 0.25) -- 25% of window width
      vim.cmd("vertical resize " .. math.max(20, math.min(60, width)))
    end, { desc = "Open oil in vertical split" })

    vim.keymap.set("n", "<leader>fe", function()
      require("oil").open_float()
    end, { desc = "Open oil in floating window" })
  end,
}