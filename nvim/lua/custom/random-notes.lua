local M = {}

M.config = {
  vault_path = vim.fn.expand("~/Documents/vault/projects/interview"),
  file_pattern = "*.md",
  exclude_patterns = {
    "%.stversions",
    "%.git",
    "%.obsidian",
  },
}

local function get_markdown_files()
  local files = {}
  local handle = io.popen(string.format('find "%s" -type f -name "%s"', M.config.vault_path, M.config.file_pattern))

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

function M.open_random_note()
  local files = get_markdown_files()

  if #files == 0 then
    vim.notify("No markdown files found in the vault", vim.log.levels.WARN)
    return
  end

  math.randomseed(os.time())
  local random_file = files[math.random(#files)]

  vim.cmd("edit " .. vim.fn.fnameescape(random_file))

  vim.notify(string.format("Opened random note: %s", vim.fn.fnamemodify(random_file, ":t")), vim.log.levels.INFO)
end

function M.setup()
  vim.api.nvim_create_user_command("RandomNote", M.open_random_note, {})

  vim.keymap.set("n", "<leader>R", "<cmd>RandomNote<CR>", {
    noremap = true,
    silent = true,
    desc = "Open random note from vault",
  })
end

return M
