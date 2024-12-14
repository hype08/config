return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "Navigate left pane" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", desc = "Navigate down pane" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", desc = "Navigate up pane" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", desc = "Navigate right pane" },
    { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", desc = "Navigate to previous pane" },
  },
}