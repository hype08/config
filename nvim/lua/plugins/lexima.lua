return {
  "cohama/lexima.vim",
  event = "InsertEnter",
  init = function()
    -- Disable basic rules (brackets, quotes, etc.)
    vim.g.lexima_enable_basic_rules = 0
    -- Enable newline rules for proper indentation
    vim.g.lexima_enable_newline_rules = 1
    -- Enable endwise rules
    vim.g.lexima_enable_endwise_rules = 1
  end,
  config = function()
    -- Ruby-specific endwise rules
    local ruby_rules = {
      -- Ruby def completion
      {
        char = "<CR>",
        at = "^\\s*def\\s\\+.*\\%#$",
        input = "<CR>",
        input_after = "<CR>end",
        filetype = "ruby",
      },
      -- Ruby class completion
      {
        char = "<CR>",
        at = "^\\s*class\\s\\+.*\\%#$",
        input = "<CR>",
        input_after = "<CR>end",
        filetype = "ruby",
      },
      -- Ruby module completion
      {
        char = "<CR>",
        at = "^\\s*module\\s\\+.*\\%#$",
        input = "<CR>",
        input_after = "<CR>end",
        filetype = "ruby",
      },
      -- Ruby do completion
      {
        char = "<CR>",
        at = "do\\s*\\%#$",
        input = "<CR>",
        input_after = "<CR>end",
        filetype = "ruby",
      },
      -- Ruby if/unless completion
      {
        char = "<CR>",
        at = "^\\s*\\%(if\\|unless\\)\\s\\+.*\\%#$",
        input = "<CR>",
        input_after = "<CR>end",
        filetype = "ruby",
      },
      -- Ruby begin completion
      {
        char = "<CR>",
        at = "^\\s*begin\\s*\\%#$",
        input = "<CR>",
        input_after = "<CR>end",
        filetype = "ruby",
      },
    }

    -- Add each rule
    for _, rule in ipairs(ruby_rules) do
      vim.fn["lexima#add_rule"](rule)
    end
  end,
}
