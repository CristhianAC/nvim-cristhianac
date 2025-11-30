return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- no estrictamente necesario, pero recomendado
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Opcional: soporte para previsualizar imágenes
  },
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer NeoTree (Root Dir)" },
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
        filtered_items = {
          visible = true, -- Muestra archivos ocultos por defecto
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
      window = {
        width = 30,
        mappings = {
          ["<space>"] = "none", -- Desactivar espacio para evitar conflictos
        },
      },
    })
  end,
}
