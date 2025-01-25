return {
  "sphamba/smear-cursor.nvim",

  opts = {
    cursor_color = "#d3cdc3",

    normal_bg = "#282828",

    smear_between_buffers = true,

    smear_between_neighbor_lines = false,

    legacy_computing_symbols_support = true,

    stiffness = 0.8, -- 0.6      [0, 1]
    trailing_stiffness = 0.5, -- 0.3      [0, 1]
    distance_stop_animating = 0.5, -- 0.1      > 0
    hide_target_hack = false, -- true     boolean
  },
}
