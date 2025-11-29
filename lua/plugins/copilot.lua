return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true, -- Habilita el "texto fantasma" (ghost text)
        auto_trigger = true, -- Sugerir automáticamente al escribir
        keymap = {
          accept = "<Tab>", -- Usa Tab para aceptar la sugerencia
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
      panel = { enabled = false }, -- Desactiva el panel lateral si no lo usas
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
}