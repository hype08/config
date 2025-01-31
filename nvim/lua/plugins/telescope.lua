return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local transform_mod = require("telescope.actions.mt").transform_mod
    local action_state = require("telescope.actions.state")

    local trouble = require("trouble")
    local trouble_telescope = require("trouble.providers.telescope")

    local select_and_move_up = function(prompt_bufnr)
      actions.toggle_selection(prompt_bufnr)
      actions.move_selection_previous(prompt_bufnr)
    end

    local custom_actions = transform_mod({
      open_trouble_qflist = function(prompt_bufnr)
        trouble.toggle("quickfix")
      end,
    })

    local select_one_or_multi = function(prompt_bufnr)
      local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
      local multi = picker:get_multi_selection()
      if not vim.tbl_isempty(multi) then
        require("telescope.actions").close(prompt_bufnr)
        for _, j in pairs(multi) do
          if j.path ~= nil then
            vim.cmd(string.format("%s %s", "edit", j.path))
          end
        end
      else
        require("telescope.actions").select_default(prompt_bufnr)
      end
    end

    telescope.setup({
      defaults = {
        sorting_strategy = "descending",
        layout_config = {
          prompt_position = "bottom",
        },
        path_display = { "smart" },
        mappings = {
          i = {
            ["<CR>"] = select_one_or_multi,
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
          },
        },
        attach_mappings = function(prompt_bufnr, map)
          map("i", "<Tab>", select_and_move_up)
          return true
        end,
      },
      pickers = {
        git_files = {
          mappings = {
            i = {
              ["<Tab>"] = select_and_move_up,
            },
          },
          attach_mappings = function(prompt_bufnr, map)
            map("i", "<Tab>", select_and_move_up)
            return true
          end,
        },
      },
    })

    telescope.load_extension("fzf")

    local keymap = vim.keymap

    keymap.set("n", "<C-p>", function()
      require("telescope.builtin").git_files({ cache_picker = false })
    end, { desc = "Find git files" })

    keymap.set("n", "<leader>/", function()
      require("telescope.builtin").live_grep({ cache_picker = false })
    end, { desc = "Live grep" })

    keymap.set("n", "<leader>ff", function()
      require("telescope.builtin").find_files({ cache_picker = false })
    end, { desc = "Find files in cwd" })

    keymap.set("n", "<leader>fh", "<cmd>Telescope oldfiles cwd_only=true<cr>", { desc = "File history" })
    keymap.set("n", "<leader>fa", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor" })
    keymap.set("n", "<leader>fg", function()
      require("telescope.builtin").live_grep({ cache_picker = false })
    end, { desc = "Live grep in cwd" })

    keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })

    require("config.telescope.live_multigrep").setup()
  end,
}
