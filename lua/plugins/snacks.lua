return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          -- Tu logo ASCII va aquí arriba (no lo borres)
          header = [[
         ##################                                 
      ###########################                           
     #################   ############                       
    #################     ##############                    
    ###### ################################                 
     #####   ###############################                
        ##     ####   ######################                
          ##    ###        ################  #####          
# ##              ##          ############  #######         
####   ########                 ################### #       
 ########                   ###########################     
       ##   #            ###############################    
       ###  ###      ####################################   
       ######################           ##################  
           ############         ########################### 
                            ################################
          ]],
          -- AQUI DEFINIMOS LOS BOTONES DEL MENU
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = "🧱", key = "m", desc = "Mason", action = ":Mason" }, -- <--- Nuevo botón para Mason
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
  },
}