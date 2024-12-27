local M = {}

-- Configuration with defaults
M.config = {
  vault_path = vim.fn.expand('~/Documents/vault'),
  review_data_file = vim.fn.expand('~/Documents/vault/.review-data.json'),
  default_tags = {'review', 'important'},
  review_interval_days = 7
}

-- Utility functions
local function get_all_markdown_files()
  local command = string.format('fd -e md . "%s"', M.config.vault_path)
  local handle = io.popen(command)
  local result = handle:read('*a')
  handle:close()
  
  local files = {}
  for file in result:gmatch('[^\n]+') do
    table.insert(files, file)
  end
  return files
end

local function get_file_metadata(file_path)
  local stat = vim.loop.fs_stat(file_path)
  if not stat then return nil end
  
  local file = io.open(file_path, 'r')
  if not file then return nil end
  
  local content = file:read('*a')
  file:close()
  
  -- Extract tags from content
  local tags = {}
  for tag in content:gmatch('#([%w-_]+)') do
    table.insert(tags, tag)
  end
  
  return {
    path = file_path,
    modified = stat.mtime.sec,
    tags = tags
  }
end

-- Core functionality
function M.open_random_note()
  local files = get_all_markdown_files()
  if #files > 0 then
    math.randomseed(os.time())
    local random_file = files[math.random(#files)]
    vim.cmd('edit ' .. vim.fn.fnameescape(random_file))
  else
    vim.notify('No markdown files found in vault', vim.log.levels.WARN)
  end
end

function M.open_recent_notes(days)
  days = days or M.config.review_interval_days
  local files = get_all_markdown_files()
  local recent_files = {}
  local current_time = os.time()
  
  for _, file in ipairs(files) do
    local metadata = get_file_metadata(file)
    if metadata and (current_time - metadata.modified) <= (days * 24 * 60 * 60) then
      table.insert(recent_files, file)
    end
  end
  
  if vim.fn.exists(':FzfLua') == 2 then
    require('fzf-lua').files({
      prompt = string.format('Notes modified in last %d days> ', days),
      cwd = M.config.vault_path,
      file_ignore_patterns = {"^[^.].*"},
      fd_opts = string.format("--type f --color=never --hidden --follow -E .git --modified-within %dd", days)
    })
  else
    require('telescope.builtin').find_files({
      prompt_title = string.format('Notes modified in last %d days', days),
      search_dirs = recent_files,
      hidden = true
    })
  end
end

function M.open_tagged_notes(tag)
  local files = get_all_markdown_files()
  local tagged_files = {}
  
  for _, file in ipairs(files) do
    local metadata = get_file_metadata(file)
    if metadata then
      for _, file_tag in ipairs(metadata.tags) do
        if file_tag:lower() == tag:lower() then
          table.insert(tagged_files, file)
          break
        end
      end
    end
  end
  
  if vim.fn.exists(':FzfLua') == 2 then
    require('fzf-lua').files({
      prompt = string.format('Notes tagged with #%s> ', tag),
      cwd = M.config.vault_path,
      file_ignore_patterns = {"^[^.].*"},
      fd_opts = "--type f --color=never --hidden --follow -E .git"
    })
  else
    require('telescope.builtin').find_files({
      prompt_title = string.format('Notes tagged with #%s', tag),
      search_dirs = tagged_files,
      hidden = true
    })
  end
end

-- Setup function
function M.setup(opts)
  M.config = vim.tbl_deep_extend('force', M.config, opts or {})
  
  -- Create user commands
  vim.api.nvim_create_user_command('ObsidianRandomNote', M.open_random_note, {})
  vim.api.nvim_create_user_command('ObsidianRecentNotes', 
    function(opts) M.open_recent_notes(tonumber(opts.args)) end,
    { nargs = '?' })
  vim.api.nvim_create_user_command('ObsidianTaggedNotes',
    function(opts) M.open_tagged_notes(opts.args) end,
    { nargs = 1 })
    
  -- Set up keymaps
  local opts = { noremap = true, silent = true }
  vim.keymap.set('n', '<leader>or', '<cmd>ObsidianRandomNote<CR>', opts)
  vim.keymap.set('n', '<leader>ot', ':ObsidianTaggedNotes ', { noremap = true })
  vim.keymap.set('n', '<leader>on', '<cmd>ObsidianRecentNotes<CR>', opts)
end

return M