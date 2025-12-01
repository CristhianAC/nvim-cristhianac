local Job = require("plenary.job")
local uv = vim.loop

-- Listar carpetas dentro de src/app para autocompletar rutas
local function list_app_dirs()
  local path = vim.fn.getcwd() .. "/src/app"
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

vim.api.nvim_create_user_command("Ng", function(opts)
  local args = vim.split(opts.args, " ")

  if #args == 0 then
    print("Uso: :Ng <comando> (ej: :Ng g c Test)")
    return
  end

  local buf = vim.api.nvim_create_buf(false, true)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    border = "rounded",
    title = "Angular CLI",
    title_pos = "center",
  })

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Ejecutando: ng " .. table.concat(args, " "), "" })

  Job:new({
    command = "ng",
    args = args,
    cwd = vim.fn.getcwd(),
    on_stdout = function(_, data)
      if data then
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(buf, -1, -1, false, { data })
        end)
      end
    end,
    on_stderr = function(_, data)
      if data then
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(buf, -1, -1, false, { "ERROR: " .. data })
        end)
      end
    end,
    on_exit = function(_, code)
      vim.schedule(function()
        vim.api.nvim_buf_set_lines(buf, -1, -1, false, {
          "",
          "Proceso terminado. Código: " .. code,
        })
      end)
    end,
  }):start()
end, {
  nargs = "*",
  complete = function(_, line)
    local words = vim.split(line, "%s+")
    local main_cmds = {
      "serve", "build", "test", "lint", "generate", "g", "add", "update", "deploy", "new"
    }

    -- Nivel 1: sugerir comandos principales
    if #words == 1 then
      return main_cmds
    end

    -- Nivel 2: si el primer comando es generate/g
    local first = words[1]
    if first == "g" or first == "generate" then
      local sub = {"c", "component", "m", "module", "s", "service", "p", "pipe", "d", "directive"}
      if #words == 2 then
        return sub
      end
      -- Nivel 3: sugerir rutas dentro de src/app
      if #words == 3 then
        return list_app_dirs()
      end
    end

    return {}
  end,
})
