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

    local trouble = require("trouble")
    local trouble_telescope = require("trouble.providers.telescope")

    -- Custom action to combine toggle_selection and move_selection_previous
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
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            ["<Tab>"] = select_and_move_up, -- Toggle selection and move up
          },
        },
      },
    })

    telescope.load_extension("fzf")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>fd", function()
      require("telescope.builtin").find_files({ cache_picker = false })
    end, { desc = "Find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles cwd_only=true<cr>", { desc = "Fuzzy find recent files" })
    -- keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fa", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>fw", function()
      require("telescope.builtin").live_grep({ cache_picker = false })
    end, { desc = "Find word in cwd" })

    -- Add fast git files search with multi-select
    keymap.set("n", "<leader>ff", function()
      require("telescope.builtin").git_files({
        cache_picker = false,
      })
    end, { desc = "Find git files (with multi-select)" })
  end,
}
