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

  vim.api.nvim_create_user_command("RandomNote", function(args)
    M.open_random_note(args)
  end, {
    nargs = "?",
    complete = "dir",
    desc = "Open random note from vault or specified directory",
  })

  -- Create keymap for default vault path
  vim.keymap.set("n", "<leader>R", function()
    M.open_random_note({ args = "" })
  end, {
    noremap = true,
    silent = true,
    desc = "Open random note from vault",
  })
end

return M
