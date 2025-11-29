return {
  {
    "folke/trouble.nvim",
    opts = {}, -- usa configuración por defecto
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
    },
  },
}