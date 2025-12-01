return {
  {
    "nvim-mini/mini.animate",
    event = "VeryLazy",
    opts = function()
      local animate = require("mini.animate")
      return {
        resize = { enable = false },
        scroll = {
          timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
          subscroll = animate.gen_subscroll.equal({ predicate = function() return true end }),
        },
        cursor = { timing = animate.gen_timing.linear({ duration = 80, unit = "total" }) },
      }
    end,
  },
}
