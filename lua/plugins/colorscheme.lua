return {
  -- Configurar Kanagawa con transparencia
  { 
    "DonJulve/NeoCyberVim",
    opts = {
      transparent = true, -- <--- Aquí es donde debe ir
    },
  },

  -- Configurar LazyVim para usar el esquema de color
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "NeoCyberVim",
    },
  }
}