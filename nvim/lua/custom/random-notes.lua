local M = {}

M.config = {
  vault_path = vim.fn.expand("~/Documents/vault/slipbox"):gsub("'", "\\'"),
  file_pattern = "*.md",
  exclude_patterns = {
    "%.stversions",
    "%.git",
    "%.obsidian",
    ".*idx_",
  },
}

-- Function to get all directories in the vault
local function get_vault_directories()
  local vault_root = vim.fn.expand("~/Documents/vault")
  local directories = {}

  -- Get all directories using fd if available (faster) or find
  local cmd = vim.fn.executable("fd") == 1 and string.format("fd . %s --type d", vim.fn.shellescape(vault_root))
    or string.format("find %s -type d", vim.fn.shellescape(vault_root))

  local handle = io.popen(cmd)
  if handle then
    for dir in handle:lines() do
      -- Skip directories that match exclude patterns
      local exclude = false
      for _, pattern in ipairs(M.config.exclude_patterns) do
        if dir:match(pattern) then
          exclude = true
          break
        end
      end

      if not exclude then
        -- Make path relative to vault root
        local relative_path = dir:sub(#vault_root + 2)
        if relative_path ~= "" then
          table.insert(directories, relative_path)
        end
      end
    end
    handle:close()
  end

  return directories
end

local function get_markdown_files(custom_path)
  local search_path = custom_path or M.config.vault_path
  local files = {}
  search_path = vim.fn.shellescape(search_path)
  local handle = io.popen(string.format('find %s -type f -name "%s"', search_path, M.config.file_pattern))
  if handle then
    for file in handle:lines() do
      local exclude = false
      for _, pattern in ipairs(M.config.exclude_patterns) do
        if file:match(pattern) then
          exclude = true
          break
        end
      end
      if not exclude then
        table.insert(files, file)
      end
    end
    handle:close()
  end
  return files
end

-- Function to prompt for directory using Telescope
function M.prompt_directory_telescope()
  local telescope = require("telescope.builtin")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local vault_root = vim.fn.expand("~/Documents/vault")

  -- Create a custom telescope picker
  local opts = {
    prompt_title = "Select Directory for Random Note",
    results_title = "Vault Directories",
    layout_config = {
      width = 0.8,
      height = 0.6,
    },
    finder = require("telescope.finders").new_table({
      results = get_vault_directories(),
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry,
          ordinal = entry,
        }
      end,
    }),
    sorter = require("telescope.sorters").get_generic_fuzzy_sorter(),
    attach_mappings = function(prompt_bufnr, map)
      -- Override selection behavior
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()

        if selection then
          local full_path = vim.fn.resolve(vault_root .. "/" .. selection.value)
          M.open_random_note({ args = full_path })
        end
      end)

      -- Add custom mapping for opening in default directory
      map("i", "<C-d>", function()
        actions.close(prompt_bufnr)
        M.open_random_note({ args = "" })
      end)

      return true
    end,
  }

  -- Open the picker
  require("telescope.pickers").new(opts):find()
end

function M.open_random_note(args)
  local path
  if args and args.args and args.args ~= "" then
    path = vim.fn.fnamemodify(args.args, ":p")
  end

  local files = get_markdown_files(path)

  if #files == 0 then
    local message = path and string.format("No markdown files found in: %s", path)
      or "No markdown files found in the vault"
    vim.notify(message, vim.log.levels.WARN)
    return
  end

  math.randomseed(os.time())
  local random_file = files[math.random(#files)]
  vim.cmd(string.format("edit %s", vim.fn.fnameescape(random_file)))
  vim.notify(string.format("Opened random note: %s", vim.fn.fnamemodify(random_file, ":t")), vim.log.levels.INFO)
end

function M.setup(opts)
  -- Merge user config with defaults
  if opts then
    M.config = vim.tbl_deep_extend("force", M.config, opts)
  end

  -- Create the basic command
  vim.api.nvim_create_user_command("RandomNote", function(args)
    M.open_random_note(args)
  end, {
    nargs = "?",
    complete = "dir",
    desc = "Open random note from vault or specified directory",
  })

  -- Keymap for default vault path
  vim.keymap.set("n", "<leader>R", function()
    M.open_random_note({ args = "" })
  end, {
    noremap = true,
    silent = true,
    desc = "Open random note from vault",
  })

  -- Keymap for directory selection with Telescope
  vim.keymap.set("n", "<leader>r", function()
    M.prompt_directory_telescope()
  end, {
    noremap = true,
    silent = true,
    desc = "Select directory and open random note",
  })
end

return M
