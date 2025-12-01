local uv = vim.loop

-- Listar carpetas dentro de .venv
local function list_venvs()
  local path = vim.fn.getcwd() .. "/.venv"
  local dirs = {}
  local handle = uv.fs_scandir(path)
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

-- Comando principal con completado
vim.api.nvim_create_user_command("Py", function(opts)
  local args = opts.fargs
  local action = args[1]

  if not action then
    print("Uso: :Py <comando> [args]")
    print("Comandos disponibles: venv, activate, requirements, install, run")
    return
  end

  local cwd = vim.fn.getcwd()
  local venv_dir = cwd .. "/.venv"

  if action == "venv" then
    local name = args[2] or "default"
    vim.fn.mkdir(venv_dir, "p")
    local path = venv_dir .. "/" .. name
    if uv.fs_stat(path) then
      print("El entorno virtual ya existe: " .. path)
      return
    end
    os.execute("python3 -m venv " .. path)
    print("✅ Venv creado: " .. path)
    return
  end

  if action == "activate" then
    local name = args[2] or "default"
    local path = venv_dir .. "/" .. name
    if not uv.fs_stat(path) then
      print("❌ No existe venv: " .. path)
      return
    end
    print("Para activar, ejecuta: source " .. path .. "/bin/activate")
    return
  end

  -- resto de comandos: requirements, install, run (igual que antes)
end, {
  nargs = "*",
  complete = function(ArgLead, CmdLine, CursorPos)
    local completions = {"venv", "activate", "requirements", "install", "run"}
    local words = vim.split(CmdLine, "%s+")
    -- Si ya escribiste :Py <algo>, sugerir entornos virtuales para ciertos comandos
    if #words == 2 then
      local cmd = words[2]
      if cmd == "activate" or cmd == "requirements" or cmd == "install" or cmd == "run" then
        return list_venvs()
      end
    end
    -- Si no, devolver los comandos principales
    return completions
  end,
})
