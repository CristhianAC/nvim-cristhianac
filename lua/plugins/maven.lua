return {
  {
    "eatgrass/maven.nvim",
    -- AÑADE "MavenCreate" AQUÍ PARA QUE NEOVIM LO RECONOZCA
    cmd = { "Maven", "MavenExec", "MavenCreate" }, 
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("maven").setup({
        executable = "./mvnw",
      })

      -- Función para obtener groupId y version del pom.xml actual
      local function get_maven_info()
        local file = io.open("pom.xml", "r")
        if not file then return nil, nil end
        local content = file:read("*all")
        file:close()
        
        -- Aplanar el contenido para facilitar la búsqueda con patrones simples
        content = content:gsub("[\r\n]", " ")

        -- Intentar encontrar groupId y version
        local group_id = content:match("<groupId>(.-)</groupId>")
        local version = content:match("<version>(.-)</version>")
        
        -- Si no encuentra version directa, intenta buscar en parent
        if not version then
           version = content:match("<parent>.-<version>(.-)</version>")
        end

        -- Limpiar espacios en blanco
        if group_id then group_id = group_id:match("^%s*(.-)%s*$") end
        if version then version = version:match("^%s*(.-)%s*$") end

        return group_id, version
      end

      -- Crea el comando :MavenCreate
      vim.api.nvim_create_user_command('MavenCreate', function()
        local options = { 'Crear Módulo (Maven Module)', 'Crear Paquete (Java Package)' }
        
        vim.ui.select(options, { prompt = '¿Qué deseas crear?' }, function(choice)
          if not choice then return end

          vim.ui.input({ prompt = 'Nombre (' .. choice .. '): ' }, function(input)
            if not input or input == "" then return end

            if choice == 'Crear Módulo (Maven Module)' then
              -- Opción A: Crear Módulo
              local group_id, version = get_maven_info()
              local extra_args = ""
              if group_id then extra_args = extra_args .. " -DgroupId=" .. group_id end
              if version then extra_args = extra_args .. " -Dversion=" .. version end
              
              local cmd = string.format("mvn archetype:generate -DartifactId=%s -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=true%s", input, extra_args)
              vim.cmd("TermExec cmd='" .. cmd .. "'")

            elseif choice == 'Crear Paquete (Java Package)' then
              -- Opción B: Crear Paquete
              local sep = package.config:sub(1,1)
              local path = "src" .. sep .. "main" .. sep .. "java" .. sep .. input:gsub("%.", sep)
              
              local success = vim.fn.mkdir(path, "p")
              if success == 1 then
                print("✅ Paquete creado: " .. path)
              else
                print("❌ Error al crear el paquete.")
              end
            end
          end)
        end)
      end, {})
    end,
  },
}