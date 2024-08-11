return {
  "ledger/vim-ledger",
  config = function()
    vim.g.ledger_maxwidth = 80
    vim.g.ledger_fillstring = "    -"
    vim.g.ledger_detailed_first = 1
    vim.g.ledger_fuzzy_account_completion = 1
    vim.g.ledger_fold_blanks = 0
  end,
}
