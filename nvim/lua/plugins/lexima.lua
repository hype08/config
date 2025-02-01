return {
  "cohama/lexima.vim",
  event = "InsertEnter",
  config = function()
    -- General lexima configuration
    vim.g.lexima_enable_basic_rules = 1
    vim.g.lexima_enable_newline_rules = 1
    vim.g.lexima_enable_endwise_rules = 1

    -- Additional Ruby-specific rules for better end completion
    local lexima_rules = {
      -- Ruby block completion with 'do'
      { char = "<CR>", at = "do\\%#", input = "<CR>", input_after = "<CR>end" },
      -- Ruby block completion with '{'
      { char = "<CR>", at = "{\\%#}", input = "<CR>", input_after = "<CR>}" },
      -- Ensure proper indentation for Ruby blocks
      { char = "<CR>", at = "\\%(\\s*\\)\\%#\\%(\\s*\\)end", input = "<CR>", input_after = "<CR>end", 
        delete = "\\n\\s*end" },
    }

    -- Add each rule
    for _, rule in ipairs(lexima_rules) do
      vim.fn["lexima#add_rule"](rule)
    end
  end,
}
