return {
  "folke/noice.nvim",
  opts = {
    -- Disable features that conflict with snacks.nvim
    notify = {
      enabled = false,  -- Let snacks.nvim handle notifications
    },
    lsp = {
      hover = {
        enabled = false,  -- Disable noice hover
      },
      signature = {
        enabled = false,  -- Disable noice signature help
      },
      -- Disable markdown conversion since it conflicts
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
        ["vim.lsp.util.stylize_markdown"] = false,
      },
    },
    -- Keep
    cmdline = {
      enabled = true,
      view = "cmdline",
    },
    messages = {
      enabled = true,
    },
    popupmenu = {
      enabled = true,
    },
  },
}
