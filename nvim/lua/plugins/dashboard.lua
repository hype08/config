return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  config = function()
    require("dashboard").setup({
      theme = "hyper",
      config = {
        header = {
          " ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⠇⠀⠀⠀⠀⠀⠀⠀⠀",
          " ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡾⠋⠀⠀⠀⠀⠀⠀⠀⣠⡆⠀",
          " ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠰⠁⠀⢀⠀⠀⣿⣧⡔⠀⠀⠀⠀⠀⠀⣰⠟⠁⠀",
          " ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣧⡀⠀⡀⢹⣄⣠⣿⣿⡧⣾⠀⣀⠀⡀⠀⠀⠀⠀⠀",
          " ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡇⢀⣿⣿⣿⣿⣿⡏⡀⠋⣰⡇⠞⡀⠀⠀⠀⣠⠖",
          " ⠀⠀⠀⠀⠀⢦⡀⠀⠀⠐⣸⣴⣸⣿⣿⣿⣿⣿⢴⣧⣴⣿⠃⣰⡟⠀⡜⠀⠁⠀",
          " ⢠⡀⠀⢄⢠⠈⢿⡄⣆⡇⢿⣿⣿⣿⡿⡇⢏⣴⢸⡿⠁⡇⣰⠋⡀⠀⡇⠀⠀⠀",
          " ⠀⠻⡄⠸⣾⠧⡘⡇⠸⣿⣼⣧⡈⣮⣾⣷⣿⠣⣫⣷⣶⡇⡇⣦⡇⠐⠁⠀⠀⠀",
          " ⡀⠀⠀⡀⢈⡼⠾⠾⠇⡿⣎⣿⣿⡿⡿⣿⣿⣴⡿⠟⠋⢷⢣⢟⠀⠀⠀⠀⠀⠀",
          " ⠘⠀⢀⢹⡆⠦⢰⢋⢝⠁⠟⣵⢻⣇⢧⣿⣿⠟⡁⠀⠀⣾⢸⢸⠁⠀⠀⠀⠀⠀",
          " ⠀⠀⠀⢋⣷⡉⢘⠤⠥⡶⠁⡶⢿⣿⣷⡦⢀⠈⠁⠀⣠⣧⡇⡎⠀⠀⠀⠀⠀⠀",
          " ⠀⠀⠀⠘⢿⢘⡲⠬⠭⠶⢠⠐⣡⢹⣷⡿⡕⢝⣒⣫⠶⣻⠃⣄⠀⠀⠀⠀⠀⠀",
          " ⠀⠀⠀⠑⢠⡁⠪⠉⠉⣴⢢⡗⠴⢟⣿⢳⠙⠶⣤⣤⠞⣡⡳⡜⡆⠀⠀⠀⠀⠀",
          " ⠀⠀⠀⠀⠀⠁⠀⠀⠘⡇⠾⠥⠃⢛⣋⣩⢞⣓⡺⡿⠘⢗⣕⡚⠁⠀⠀⠀⠀⠀",
          " ⠀⠀⠀⠀⠀⠀⣀⣤⣾⠇⡁⢁⠁⠈⠉⡁⢈⠛⠿⣿⣄⡀⠉⠀⠀⠀⠀⠀⠀⠀",
          " ⠀⠀⠀⠀⠀⠈⠉⠁⢲⣆⣛⡵⢛⣛⣛⢯⣛⣀⣶⠊⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀",
          " ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⠱⠢⣿⡿⣿⡗⠎⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
          "                               ",
          "  hugr yfir eða undir hrjóða   ",
          "                               ",
        },
        shortcut = {
          { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
          {
            icon = " ",
            icon_hl = "@variable",
            desc = "Files",
            group = "Label",
            action = "Telescope oldfiles cwd_only=true",
            key = "f",
          },
          {
            desc = "Restore",
            key = "SPC wr",
            action = "<cmd>SessionRestore<CR>",
          },
        },
        packages = { enable = false }, -- show how many plugins neovim loaded
      },
    })
  end,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
