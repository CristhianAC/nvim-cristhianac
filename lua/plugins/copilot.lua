return {
  -- Configuración explícita de Copilot para habilitar el Tab
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<Tab>", -- Aceptar sugerencia con Tab
          },
        },
      })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken",
    opts = {
      window = {
        layout = "float",
        width = 0.6,
        height = 0.6,
        border = "rounded",
      },
    },
    -- Aquí definimos el menú
    keys = {
      -- Definimos el grupo "a" para AI
      { "<leader>a", "", desc = "+ai (Copilot)", mode = { "n", "v" } },
      
      -- Opciones generales
      { "<leader>aa", function() require("CopilotChat").toggle() end, desc = "Toggle Chat", mode = { "n", "v" } },
      { "<leader>ax", function() require("CopilotChat").reset() end, desc = "Limpiar Chat", mode = { "n", "v" } },
      { "<leader>aq", function()
          local input = vim.fn.input("Pregunta rápida: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
          end
        end,
        desc = "Pregunta Rápida", mode = { "n", "v" }
      },

      -- Comandos específicos (funcionan mejor seleccionando código primero)
      { "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "Explicar Código", mode = "v" },
      { "<leader>af", "<cmd>CopilotChatFix<cr>", desc = "Arreglar Bug", mode = "v" },
      { "<leader>ao", "<cmd>CopilotChatOptimize<cr>", desc = "Optimizar", mode = "v" },
      { "<leader>ad", "<cmd>CopilotChatDocs<cr>", desc = "Documentar", mode = "v" },
      { "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "Generar Tests", mode = "v" },
      { "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "Revisar Código", mode = "v" },
    },
  },
}