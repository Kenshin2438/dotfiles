return {
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    cmd = "ToggleTerm",
    opts = {
      open_mapping = [[<c-\>]],
      direction = "float",
      shade_terminals = false,
      shell = "pwsh -NoLogo",
      float_opts = {
        border = "curved",
        width = math.floor(vim.fn.winwidth(0) * 0.8),
        height = math.floor(vim.fn.winheight(0) * 0.8),
      },
      insert_mappings = true,
      start_in_insert = true,
      close_on_exit = true,
    },
  },
}
