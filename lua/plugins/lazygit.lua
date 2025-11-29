return {
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
    config = function()
      -- Configuración para que use el fondo transparente si lo tienes activado
      vim.g.lazygit_floating_window_winblend = 0 -- Transparencia (0 = solido, pero deja ver el fondo de la terminal)
      vim.g.lazygit_floating_window_scaling_factor = 0.9 -- Tamaño de la ventana (90%)
      vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } -- Bordes redondeados
      vim.g.lazygit_use_neovim_remote = 1 -- Para mejor integración
    end,
  },
}