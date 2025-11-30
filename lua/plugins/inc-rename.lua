return {
  "smjonas/inc-rename.nvim",
  config = function()
    require("inc_rename").setup()
  end,
  keys = {
    {
      "<leader>rn",
      function()
        return ":Rename " .. vim.fn.expand("<cword>")
      end,
      desc = "Live Rename",
      expr = true,
    },
  },
}