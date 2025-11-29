return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false,
  opts = {
    -- Proveedor por defecto
    provider = "copilot", 
    auto_suggestions_provider = "copilot",
    
    -- Configuración de proveedores (NUEVA ESTRUCTURA)
    providers = {
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-5-sonnet-20240620",
        timeout = 30000,
        -- Parámetros específicos de la petición
        extra_request_body = {
          max_tokens = 4096,
          temperature = 0,
        },
      },
      gemini = {
        model = "gemini-1.5-flash-latest",
        timeout = 30000,
        -- Parámetros específicos de la petición
        extra_request_body = {
          maxOutputTokens = 4096,
          temperature = 0,
        },
      },
    },

    behaviour = {
      auto_suggestions = false, -- Lo tenías en true en tu último cambio
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
    },
    mappings = {
      diff = {
        ours = "co",
        theirs = "ct",
        all_theirs = "ca",
        both = "cb",
        cursor = "cc",
        next = "]x",
        prev = "[x",
      },
      suggestion = {
        accept = "<M-l>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
      jump = {
        next = "]]",
        prev = "[[",
      },
      submit = {
        normal = "<CR>",
        insert = "<C-s>",
      },
      sidebar = {
        apply_all = "A",
        apply_cursor = "a",
        switch_windows = "<Tab>",
        reverse_switch_windows = "<S-Tab>",
      },
    },
    hints = { enabled = true },
    windows = {
      position = "right",
      wrap = true,
      width = 30,
      sidebar_header = {
        align = "center",
        rounded = true,
      },
    },
    highlights = {
      diff = {
        current = "DiffText",
        incoming = "DiffAdd",
      },
    },
    repo_map = {
      ignore_patterns = { "%.git", "%.worktree", "__pycache__", "node_modules" },
      negate_patterns = {},
      files_limit = 5000,
      file_content_limit = 2000000,
    },
  },
  build = "make",
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-tree/nvim-web-devicons",
    "zbirenbaum/copilot.lua",
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "Avante" },
      },
      ft = { "Avante" },
    },
  },
}