return {
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function()
      -- No animar si el scroll es muy grande (para evitar mareos)
      local animate = require("mini.animate")
      return {
        resize = {
          timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
        },
        scroll = {
          timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
          subscroll = animate.gen_subscroll.equal({
            predicate = function(total_scroll)
              if mouse_scrolled then
                mouse_scrolled = false
                return false
              end
              return total_scroll > 1
            end,
          }),
        },
        cursor = {
          -- Animación suave del cursor
          timing = animate.gen_timing.linear({ duration = 80, unit = "total" }),
        },
      }
    end,
  },
}