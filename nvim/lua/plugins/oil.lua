return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    -- Default configuration
    default_file_explorer = true,
    columns = {
      "icon",
      { "permissions", highlight = "Comment" },
      { "size", highlight = "Special", min_width = 10 },
      { "mtime", highlight = "Number", format = "%Y-%m-%d %H:%M" },
    },
    -- Window layouts
    float = {
      -- Floating window settings
      padding = 2,
      max_width = 100,
      max_height = 40,
      border = "rounded",
      win_options = {
        winblend = 0, -- Adjust for transparency (0-100)
      },
    },
    -- Vertical split settings
    vertical = {
      size = function()
        -- Dynamic width calculation
        local width = math.floor(vim.o.columns * 0.25) -- 25% of window width
        return math.max(20, math.min(60, width)) -- Min 20, max 60
      end,
      position = "left", -- or 'right'
    },
    -- View options
    view_options = {
      show_hidden = true,
      -- Natural sort order (directories first)
      sort = {
        { "directory", "asc" },
        { "name", "asc" },
      },
      -- Improved hidden file handling
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
      -- Add width adapter
      width = "auto",
    },
    -- Enhanced keymaps
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
      -- New keymaps
      ["<Esc>"] = "actions.close",
      ["zh"] = "actions.toggle_hidden",
      ["zr"] = "actions.refresh",
      ["q"] = "actions.close",
    },
    use_default_keymaps = false,
  },
  config = function(_, opts)
    require("oil").setup(opts)

    -- Basic file explorer mapping
    vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })

    -- Vertical split (file tree style)
    vim.keymap.set("n", "<leader>e", function()
      local oil = require("oil")
      -- Open in vertical split
      vim.cmd("vsplit")
      vim.cmd("wincmd h")
      oil.open()
      -- Adjust split width
      local width = math.floor(vim.o.columns * 0.25) -- 25% of window width
      vim.cmd("vertical resize " .. math.max(20, math.min(60, width)))
    end, { desc = "Open oil in vertical split" })

    -- Floating window
    vim.keymap.set("n", "<leader>E", function()
      require("oil").open_float()
    end, { desc = "Open oil in floating window" })

    -- Toggle last used view
    vim.keymap.set("n", "<leader>o", function()
      require("oil").toggle_float()
    end, { desc = "Toggle oil view" })
  end,
}
