-- Obsidian utility functions for extracting content into notes
local M = {}

-- Function to get the currently selected text using visual mode markers
local function get_visual_selection()
  -- Retrieve the start and end positions of the visual selection
  local _, start_line, start_col, _ = unpack(vim.fn.getpos("'<"))
  local _, end_line, end_col, _ = unpack(vim.fn.getpos("'>"))
  local lines = vim.fn.getline(start_line, end_line)
  
  if #lines == 0 then
    return ''
  end
  
  -- For single-line selections, we extract just the selected portion
  if #lines == 1 then
    return string.sub(lines[1], start_col, end_col)
  end
  
  -- For multi-line selections, we handle the first and last lines specially
  -- since they might be partially selected
  lines[1] = string.sub(lines[1], start_col)
  lines[#lines] = string.sub(lines[#lines], 1, end_col)
  
  return table.concat(lines, '\n')
end

-- Function to sanitize filename while preserving spaces and readability
local function sanitize_filename(name)
  -- Remove characters that are unsafe for filesystems while keeping spaces
  name = name:gsub("[/\\%?%*:|\"<>]", "")
  -- Normalize spaces to ensure clean formatting
  name = name:gsub("%s+", " ")
  -- Remove any leading or trailing whitespace
  name = name:gsub("^%s*(.-)%s*$", "%1")
  return name
end

-- Function to extract selected text into a new note
function M.extract_to_note()
  -- Get the selected text from the current buffer
  local selected_text = get_visual_selection()
  
  if selected_text == '' then
    vim.notify("No text selected", vim.log.levels.ERROR)
    return
  end
  
  -- Prompt for the note title
  local title = vim.fn.input("Enter note title: ")
  if title == '' then
    vim.notify("Note title is required", vim.log.levels.ERROR)
    return
  end
  
  -- Create a clean, readable filename that preserves spaces
  local filename = sanitize_filename(title)
  local vault_path = "/Users/henry/Documents/vault"
  local file_path = string.format("%s/%s.md", vault_path, filename)
  
  -- Check for existing files to prevent accidental overwrites
  local f = io.open(file_path, "r")
  if f then
    f:close()
    local overwrite = vim.fn.input("File already exists. Overwrite? (y/n): ")
    if overwrite:lower() ~= 'y' then
      vim.notify("Operation cancelled", vim.log.levels.INFO)
      return
    end
  end
  
  -- Create the new note with the selected content
  local file = io.open(file_path, "w")
  if not file then
    vim.notify("Failed to create note", vim.log.levels.ERROR)
    return
  end
  
  -- Write the content exactly as it was selected
  file:write(selected_text)
  file:close()
  
  -- Give the user control over whether to keep or remove the original text
  local remove = vim.fn.input("Remove text from current buffer? (y/n): ")
  if remove:lower() == 'y' then
    vim.cmd('normal! gvd')
  end
  
  vim.notify(string.format("Created note: %s", filename), vim.log.levels.INFO)
end

-- Set up module functions
function M.setup()
  -- Register the ObsidianExtract command
  vim.api.nvim_create_user_command('ObsidianExtract', function()
    M.extract_to_note()
  end, {
    range = true,
    desc = "Extract selected text into a new note, preserving spaces in filename"
  })
end

return M