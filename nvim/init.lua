-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Load custom modules
require("custom.random-notes").setup()
require("custom.obsidian-utils").setup()
