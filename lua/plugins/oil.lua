return {
  {
    "stevearc/oil.nvim",
    opts = {},
    -- Opcional: Establecerlo como explorador por defecto
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open Parent Directory" },
    },
  },
}