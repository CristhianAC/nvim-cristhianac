local uv = vim.loop

-- Leer archivo
local function read_file(path)
  local fd = uv.fs_open(path, "r", 438)
  if not fd then return nil end
  local stat = uv.fs_fstat(fd)
  local data = uv.fs_read(fd, stat.size)
  uv.fs_close(fd)
  return data
end

-- Escribir archivo
local function write_file(path, content)
  local fd = assert(uv.fs_open(path, "w", 420))
  uv.fs_write(fd, content)
  uv.fs_close(fd)
end

-- Crear carpetas si no existen
local function mkdir_p(path)
  uv.fs_mkdir(path, 493)
end

-- Detectar si es React o Astro
local function detect_project_type(root)
  local package_json = root .. "/package.json"
  local content = read_file(package_json)
  if not content then return nil end

  if content:match('"astro"') then return "astro" end
  if content:match('"react"') or content:match('"react%-dom"') or content:match('"next"') then
    return "react"
  end

  return nil
end

-- Listar carpetas dentro de src/ para autocompletar rutas
local function list_src_dirs()
  local src_path = vim.fn.getcwd() .. "/src"
  local dirs = {}
  local handle = uv.fs_scandir(src_path)
  if handle then
    while true do
      local name, type = uv.fs_scandir_next(handle)
      if not name then break end
      if type == "directory" then
        table.insert(dirs, name)
      end
    end
  end
  return dirs
end

-- COMANDO PRINCIPAL
vim.api.nvim_create_user_command("Rc", function(opts)
  local args = vim.split(opts.args, " ")

  local action = args[1]
  local name   = args[2]
  local custom_path = args[3]   -- ruta opcional

  if action ~= "c" or not name then
    print("Uso: :Rc c <Nombre> [ruta]")
    return
  end

  local root = vim.fn.getcwd()
  local type = detect_project_type(root)

  if not type then
    print("🚫 Este proyecto no es React ni Astro")
    return
  end

  -- Ruta por defecto si no dan nada
  local base_path = custom_path and (root .. "/" .. custom_path) or (root .. "/src/components")

  -- Crear carpetas necesarias
  mkdir_p(root .. "/src")
  mkdir_p(base_path)

  -- Carpeta final del componente
  local component_dir = base_path .. "/" .. name
  mkdir_p(component_dir)

  local style_file = component_dir .. "/" .. name .. ".module.css"
  local index_file = component_dir .. "/index.ts"

  --------------------------------------------------------------------------
  -- REACT
  --------------------------------------------------------------------------
  if type == "react" then
    local component_file = component_dir .. "/" .. name .. ".tsx"

    local react_template = string.format([[
import styles from './%s.module.css';

interface %sProps {}

export function %s(props: %sProps) {
  return (
    <div className={styles.container}>
      %s component
    </div>
  );
}
]], name, name, name, name, name)

    write_file(component_file, react_template)
    write_file(style_file, ".container {\n  display: flex;\n}\n")
    write_file(index_file, string.format([[export * from './%s';]], name))

    vim.cmd("edit " .. component_file)
    print("✨ Componente React creado en: " .. component_dir)
    return
  end

  --------------------------------------------------------------------------
  -- ASTRO
  --------------------------------------------------------------------------
  if type == "astro" then
    local astro_file = component_dir .. "/" .. name .. ".astro"

    local astro_template = string.format([[
---
  export interface Props {}
---

<div class="%s">
  %s component
</div>

<style>
  @import './%s.module.css';
</style>
]], name:lower(), name, name)

    write_file(astro_file, astro_template)
    write_file(style_file, ".container {\n  display: flex;\n}\n")
    write_file(index_file, string.format([[export * from './%s.astro';]], name))

    vim.cmd("edit " .. astro_file)
    print("🌟 Componente Astro creado en: " .. component_dir)
    return
  end
end, {
  nargs = "*",
  complete = function(_, line)
    local words = vim.split(line, "%s+")
    if #words == 1 then
      -- Sugerir subcomandos
      return {"c"}
    elseif #words == 2 then
      -- Si ya pusiste "c", sugerir rutas dentro de src/
      return list_src_dirs()
    else
      return {}
    end
  end,
})
