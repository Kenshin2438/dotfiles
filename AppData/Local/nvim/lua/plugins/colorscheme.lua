return {
  -- {
  --   "akinsho/bufferline.nvim",
  --   opts = {
  --     options = {
  --       always_show_bufferline = true,
  --     },
  --   },
  -- },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      style = "moon", -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
      transparent = true, -- enable this to disable setting the background color
      styles = {
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "transparent", -- style for sidebars, see below
        floats = "transparent", -- style for floating windows
      },
      on_colors = function(colors)
        colors.bg_statusline = colors.none
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
