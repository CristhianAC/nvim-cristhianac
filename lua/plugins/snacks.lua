return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          -- Tu logo ASCII
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
          -- BOTONES DEL MENU (Añadidos LazyGit, Harpoon, Trouble, Todo)
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            -- TUS PLUGINS PERSONALIZADOS
            { icon = "🧱", key = "m", desc = "Mason", action = ":Mason" },
            { icon = " ", key = "G", desc = "LazyGit", action = ":LazyGit" },
            { icon = " ", key = "h", desc = "Harpoon", action = ":lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())" },
            { icon = " ", key = "x", desc = "Trouble", action = ":Trouble diagnostics toggle" },
            { icon = " ", key = "t", desc = "Todo", action = ":TodoTrouble" },
            { icon = " ", key = "v", desc = "Vim Be Good", action = ":VimBeGood" },
            { icon = "📓", key = "o", desc = "Obsidian", action = ":cd ~/Documents/NotasTrabajos | lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
  },
}