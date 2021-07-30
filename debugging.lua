lvim.builtin.dap.on_config_done = function()
  local dap = require "dap"
  -- C, CPP
  -- install lldb-vscode
  dap.adapters.lldb = {
    type = "executable",
    command = "lldb-vscode",
    name = "lldb",
  }
  dap.configurations.cpp = {
    {
      name = "Launch",
      type = "lldb",
      request = "launch",
      program = "${workspaceFolder}/build/binary_name",
      cwd = "${workspaceFolder}/build",
      stopOnEntry = false,
      args = {},
      runInTerminal = false,
    },
  }
  dap.configurations.c = dap.configurations.cpp

  -- Rust
  -- install lldb-vscode
  dap.adapters.rust = {
    type = "executable",
    attach = {
      pidProperty = "pid",
      pidSelect = "ask",
    },
    command = "lldb-vscode", -- my binary was called 'lldb-vscode-11'
    env = {
      LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES",
    },
    name = "lldb",
  }
  dap.configurations.rust = {
    {
      type = "rust",
      name = "Debug",
      request = "launch",
      program = "${workspaceFolder}/target/debug/binary_name",
    },
  }

  -- Golang
  -- go get github.com/go-delve/delve/cmd/dlv
  dap.adapters.go = function(callback, _)
    local handle
    -- local pid_or_err
    local port = 38697
    handle, _ = vim.loop.spawn("dlv", {
      args = { "dap", "-l", "127.0.0.1:" .. port },
      detached = true,
    }, function(code)
      handle:close()
      print("Delve exited with exit code: " .. code)
    end)
    vim.defer_fn(function()
      dap.repl.open()
      callback { type = "server", host = "127.0.0.1", port = port }
    end, 100)
    dap.repl.open()
    callback { type = "server", host = "127.0.0.1", port = port }
  end
  dap.configurations.go = {
    {
      type = "go",
      name = "Debug",
      request = "launch",
      program = "${file}",
    },
  }

  -- Python
  -- pip install debugpy
  dap.adapters.python = {
    type = "executable",
    command = "python",
    args = { "-m", "debugpy.adapter" },
  }
  dap.configurations.python = {
    {
      type = "python",
      request = "launch",
      name = "Launch file",
      program = "${file}", -- This configuration will launch the current file if used.
      pythonPath = function()
        local cwd = vim.fn.getenv "VIRTUAL_ENV"
        if vim.fn.executable(cwd .. "/bin/python") == 1 then
          return cwd .. "/bin/python"
        elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
          return cwd .. "/.venv/bin/python"
        else
          return "/usr/bin/python"
        end
      end,
    },
  }
end
