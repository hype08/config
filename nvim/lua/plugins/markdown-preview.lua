return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
  config = function()
    local keymap = vim.keymap
    keymap.set("n", "<Leader>M", ":MarkdownPreviewToggle<CR>", { noremap = true, silent = true })
  end,
}
