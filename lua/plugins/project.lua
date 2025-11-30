return {
  "ahmedkhalf/project.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" }, -- Añadimos esta línea
  config = function()
    require("project_nvim").setup({
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
    })
    -- Envolvemos esto en pcall para evitar errores si telescope falla por otra razón
    local status, telescope = pcall(require, "telescope")
    if status then
      telescope.load_extension('projects')
    end
  end,
  keys = {
    { "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Projects" },
  },
}