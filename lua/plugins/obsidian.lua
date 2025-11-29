return {
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the below event with "BufReadPre" if you want to load obsidian.nvim for all markdown files
  -- event = {
  --   "BufReadPre " .. vim.fn.expand "~" .. "/Documents/Obsidian Vault/**.md",
  -- },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "NotasTrabajos",
        path = "~/Documents/NotasTrabajos", -- CAMBIA ESTO por la ruta real de tu bóveda
      },
    },
    
    -- Configuración de notas diarias
    daily_notes = {
      folder = "dailies",
      date_format = "%Y-%m-%d",
      template = nil,
    },

    -- Completado de enlaces [[link]]
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },

    -- Mapeos de teclas específicos para Obsidian
    mappings = {
      -- "gf" para ir al archivo bajo el cursor (Go File) funciona nativamente,
      -- pero este plugin lo mejora para notas de Obsidian.
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Checkbox toggle con <leader>ch
      ["<leader>ch"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
    },

    -- Configuración de UI
    ui = {
      enable = true,  -- set to false to disable all additional syntax features
      update_debounce = 200,  -- update delay after a text change (in milliseconds)
      checkboxes = {
        [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
        ["x"] = { char = "", hl_group = "ObsidianDone" },
      },
    },
  },
}
