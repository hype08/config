return {
  "jaimecgomezz/here.term",
  opts = {},
  config = function()
    require("here-term").setup({
      -- The command we run when exiting the terminal and no other buffers are listed. An empty
      -- buffer is shown by default.
      startup_command = "enew", -- Startify, Dashboard, etc. Make sure it has been loaded before `here.term`.

      -- Mappings
      -- Every mapping bellow can be customized by providing your prefered combo, or disabled
      -- entirely by setting them to `nil`.
      --
      -- The minimal mappings used to toggle and kill the terminal. Available in
      -- `normal` and `terminal` mode.
      mappings = {
        toggle = "<leader>;",
        kill = "<leader><leader>;",
      },
      -- Additional mappings that I consider useful since you won't have to escape (<C-\><C-n>)
      -- the terminal each time. Available in `terminal` mode.
      extra_mappings = {
        enable = true, -- Disable them entirely
        escape = "<leader>,", -- Escape terminal mode
        -- left = "", -- Move to the left window
        -- down = "", -- Move to the window down
        -- up = "", -- Move to the window up
        -- right = "", -- Move to right window
      },
    })
  end,
}
