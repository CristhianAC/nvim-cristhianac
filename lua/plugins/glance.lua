return {
  "dnlhc/glance.nvim",
  cmd = "Glance",
  keys = {
    { "gd", "<CMD>Glance definitions<CR>", desc = "Glance Definitions" },
    { "gr", "<CMD>Glance references<CR>", desc = "Glance References" },
    { "gy", "<CMD>Glance type_definitions<CR>", desc = "Glance Type Definitions" },
    { "gm", "<CMD>Glance implementations<CR>", desc = "Glance Implementations" },
  },
  config = function()
    require('glance').setup({})
  end,
}