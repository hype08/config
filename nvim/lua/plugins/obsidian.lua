local nui_ok, Input = pcall(require, "nui.input")
if not nui_ok then
  error("nui.nvim is required for thought capture feature")
end

local function create_thought_window()
  local obsidian = require("obsidian")
  local client = obsidian.get_client()
  local picker = client:picker()

  if not picker then
    vim.notify("No picker configured for Obsidian", vim.log.levels.ERROR)
    return
  end

  picker:find_templates({
    prompt_title = "Select Template",
    callback = function(template_name)
      local title_input = Input({
        position = "50%",
        size = {
          width = 60,
        },
        border = {
          style = "rounded",
          text = {
            top = " Note Title ",
            top_align = "center",
          },
        },
        win_options = {
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
        },
      }, {
        prompt = "> ",
        default_value = "",
        on_close = function() end,
        on_submit = function(title)
          local content_input = Input({
            position = "50%",
            size = {
              width = 60,
              height = 10,
            },
            border = {
              style = "rounded",
              text = {
                top = " Note Content ",
                top_align = "center",
              },
            },
            win_options = {
              winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
            },
          }, {
            prompt = "",
            default_value = "",
            on_close = function() end,
            on_submit = function(content)
              local note = client:create_note({
                title = title,
                no_write = true,
              })

              client:write_note(note, {
                template = template_name,
                update_content = function(lines)
                  local final_lines = lines
                  for _, line in ipairs(vim.split(content, "\n")) do
                    table.insert(final_lines, line)
                  end
                  return final_lines
                end,
              })

              client:open_note(note)

              vim.notify(
                string.format("Note created with template '%s': %s", template_name, title),
                vim.log.levels.INFO
              )
            end,
          })

          content_input:mount()

          content_input:map("n", "<Esc>", function()
            content_input:unmount()
          end, { noremap = true })

          content_input:map("n", "<CR>", function()
            local lines = {}
            for i = 1, vim.fn.line("$") do
              table.insert(lines, vim.fn.getline(i))
            end
            content_input:submit(table.concat(lines, "\n"))
          end, { noremap = true })
        end,
      })

      title_input:mount()

      title_input:map("n", "<Esc>", function()
        title_input:unmount()
      end, { noremap = true })
    end,
  })
end

return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>oo", "<cmd>ObsidianOpen<cr>", desc = "Open in Obsidian" },
    { "<leader>oq", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick switch note" },
    { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Search notes" },
    { "<leader>ol", "<cmd>ObsidianLink<cr>", desc = "Create link" },
    {
      "<leader>on",
      function()
        if vim.fn.mode() == "v" or vim.fn.mode() == "V" then
          local title = vim.fn.input("Title (optional): ")
          if title == "" then
            vim.cmd([[normal! "vy]])
            vim.cmd("ObsidianLinkNew")
          else
            vim.cmd([[normal! "vy]])
            vim.cmd("ObsidianLinkNew " .. title)
          end
        else
          vim.cmd("normal! viw")
          vim.cmd("ObsidianLinkNew")
        end
      end,
      mode = { "n", "v" },
      desc = "Create and link note",
    },
    { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Show backlinks" },
    { "<leader>of", "<cmd>ObsidianFollowLink<cr>", desc = "Follow link" },
    { "<leader>oa", "<cmd>ObsidianLinks<cr>", desc = "Show all links" },
    { "<leader>oe", "<cmd>ObsidianExtractNote<cr>", desc = "Extract to new note" },
    { "<leader>ot", "<cmd>ObsidianNewFromTemplate<cr>", desc = "New from template" },
    { "<leader>oi", "<cmd>ObsidianPasteImg<cr>", desc = "Paste image" },
    { "<leader>oc", "<cmd>ObsidianTOC<cr>", desc = "Table of contents" },
    { "<leader>og", "<cmd>ObsidianTags<cr>", desc = "Search tags" },
    { "<leader>or", "<cmd>ObsidianRename<cr>", desc = "Rename note" },
    { "<leader>ow", "<cmd>ObsidianWorkspace<cr>", desc = "Switch workspace" },
    { "<leader>ox", "<cmd>ObsidianToggleCheckbox<cr>", desc = "Toggle checkbox" },
    { "<leader>oh", create_thought_window, desc = "Quick capture note" },
  },
  opts = {
    workspaces = {
      {
        name = "vault",
        path = "/Users/henry/Documents/vault/slipbox/",
      },
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },
    note_id_func = function(title)
      if title then
        return title
      end
      return vim.fn.input("Title: ")
    end,
  },
  config = function(_, opts)
    local obsidian = require("obsidian")
    obsidian.setup(opts)
    vim.api.nvim_create_user_command("ObsidianCapture", create_thought_window, {})
  end,
}
