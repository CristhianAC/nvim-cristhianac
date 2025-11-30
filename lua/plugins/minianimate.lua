return {
  {
    "nvim-mini/mini.animate",
    event = "VeryLazy",
    opts = function()
      local animate = require("mini.animate")
      return {
        resize = {
          enable = false, -- Desactivar animación de redimensionado
        },
        scroll = {
          timing = animate.gen_timing.linear({ duration = 100, unit = "total" }), -- Scroll más rápido
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
