return {
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    cmd = "ToggleTerm",
    opts = {
      open_mapping = [[<c-\>]],
      shell = "fish",
      direction = "float",
      shade_terminals = false,
      float_opts = {
        border = "curved",
        width = math.floor(vim.fn.winwidth(0) * 0.85),
        height = math.floor(vim.fn.winheight(0) * 0.85),
      },
      insert_mappings = true,
      start_in_insert = true,
      close_on_exit = true,
    },
  },
}
