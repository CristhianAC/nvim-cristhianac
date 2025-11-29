return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "stylua", -- Formateador para Lua
        "shfmt",  -- Formateador para Shell
        -- Añade aquí otros LSPs o herramientas que necesites
        "jdtls",
        -- "prettier",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      
      -- Lógica para instalar automáticamente las herramientas listadas
      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed or {}) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
}