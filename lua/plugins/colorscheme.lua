return {
  -- Configurar Kanagawa con transparencia
  { 
    "rebelot/kanagawa.nvim",
    opts = {
      transparent = true, -- <--- Aquí es donde debe ir
    },
  },

  -- Configurar LazyVim para usar el esquema de color
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa",
    },
  }
}