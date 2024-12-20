return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    columns = {
      "icon",
      "size",
      "mtime",
    },
    view_options = {
      show_hidden = true,
    },
    float = {
      padding = 2,
      max_width = 0.4, -- 40% of window width
      max_height = 0.8, -- 80% of window height
      border = "rounded",
      win_options = {
        winblend = 0,
      },
    },
    -- Buffer-local mappings to use while in oil
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
    },
    use_default_keymaps = false,
  },
  config = function(_, opts)
    require("oil").setup(opts)

    -- Regular oil open (parent directory)
    vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })

    -- Open oil in float
    -- vim.keymap.set("n", "<leader>e", function()
    --   require("oil").open_float(vim.fn.getcwd())
    -- end, { desc = "Open oil float" })

    -- Open oil in adaptive vertical split
    vim.keymap.set("n", "<leader>e", function()
      local oil = require("oil")

      -- Calculate desired width (25% of window width, min 20 cols, max 50 cols)
      local width = math.floor(vim.api.nvim_win_get_width(0) * 0.25)
      width = math.max(20, math.min(width, 50))

      vim.cmd("vsplit")
      vim.cmd("vertical resize " .. width)
      vim.cmd("wincmd h")
      oil.open()

      -- Auto-resize based on content (optional)
      vim.api.nvim_create_autocmd("BufReadPost", {
        callback = function()
          local max_width = 0
          local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
          for _, line in ipairs(lines) do
            max_width = math.max(max_width, vim.fn.strdisplaywidth(line))
          end
          -- Add padding and limit max width
          max_width = math.min(max_width + 4, 50)
          max_width = math.max(max_width, 20)
          vim.cmd("vertical resize " .. max_width)
        end,
        buffer = vim.api.nvim_get_current_buf(),
        once = true,
      })
    end, { desc = "Open oil in vertical split" })
  end,
}
