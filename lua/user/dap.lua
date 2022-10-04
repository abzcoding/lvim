local M = {}

M.config = function()
  local function sep_os_replacer(str)
    local result = str
    local path_sep = package.config:sub(1, 1)
    result = result:gsub("/", path_sep)
    return result
  end
  local join_path = require("lvim.utils").join_paths

  local status_ok, dap = pcall(require, "dap")
  if not status_ok then
    return
  end

  dap.configurations.lua = {
    {
      type = "nlua",
      request = "attach",
      name = "Neovim attach",
      host = function()
        local value = vim.fn.input "Host [127.0.0.1]: "
        if value ~= "" then
          return value
        end
        return "127.0.0.1"
      end,
      port = function()
        local val = tonumber(vim.fn.input "Port: ")
        assert(val, "Please provide a port number")
        return val
      end,
    },
  }

  -- NOTE: if you want to use `dap` instead of `RustDebuggables` you can use the following configuration
  if vim.fn.executable "lldb-vscode" == 1 then
    dap.adapters.lldbrust = {
      type = "executable",
      attach = { pidProperty = "pid", pidSelect = "ask" },
      command = "lldb-vscode",
      env = { LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES" },
    }
    dap.adapters.rust = dap.adapters.lldbrust
    dap.configurations.rust = {
      {
        type = "rust",
        request = "launch",
        name = "lldbrust",
        program = function()
          local metadata_json = vim.fn.system "cargo metadata --format-version 1 --no-deps"
          local metadata = vim.fn.json_decode(metadata_json)
          local target_name = metadata.packages[1].targets[1].name
          local target_dir = metadata.target_directory
          return target_dir .. "/debug/" .. target_name
        end,
        args = function()
          local inputstr = vim.fn.input("Params: ", "")
          local params = {}
          local sep = "%s"
          for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
            table.insert(params, str)
          end
          return params
        end,
      },
    }
  end

  dap.adapters.go = function(callback, _)
    local stdout = vim.loop.new_pipe(false)
    local handle
    local pid_or_err
    local port = 38697
    local opts = {
      stdio = { nil, stdout },
      args = { "dap", "-l", "127.0.0.1:" .. port },
      detached = true,
    }
    handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
      stdout:close()
      handle:close()
      if code ~= 0 then
        print("dlv exited with code", code)
      end
    end)
    assert(handle, "Error running dlv: " .. tostring(pid_or_err))
    stdout:read_start(function(err, chunk)
      assert(not err, err)
      if chunk then
        vim.schedule(function()
          require("dap.repl").append(chunk)
        end)
      end
    end)
    -- Wait for delve to start
    vim.defer_fn(function()
      callback { type = "server", host = "127.0.0.1", port = port }
    end, 100)
  end
  -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
  dap.configurations.go = {
    {
      type = "go",
      name = "Debug",
      request = "launch",
      program = "${file}",
    },
    {
      type = "go",
      name = "Debug test", -- configuration for debugging test files
      request = "launch",
      mode = "test",
      program = "${file}",
    },
    -- works with go.mod packages and sub packages
    {
      type = "go",
      name = "Debug test (go.mod)",
      request = "launch",
      mode = "test",
      program = "./${relativeFileDirname}",
    },
  }

  dap.configurations.dart = {
    {
      type = "dart",
      request = "launch",
      name = "Launch flutter",
      dartSdkPath = sep_os_replacer(join_path(vim.fn.expand "~/", "/flutter/bin/cache/dart-sdk/")),
      flutterSdkPath = sep_os_replacer(join_path(vim.fn.expand "~/", "/flutter")),
      program = sep_os_replacer "${workspaceFolder}/lib/main.dart",
      cwd = "${workspaceFolder}",
    },
  }

  dap.adapters.firefox = {
    type = "executable",
    command = "node",
    args = {
      join_path(
        vim.fn.expand "~/",
        "/.vscode/extensions/firefox-devtools.vscode-firefox-debug-2.9.6/dist/adapter.bundle.js"
      ),
    },
  }

  local firefoxExecutable = "/usr/bin/firefox"
  if vim.fn.has "mac" == 1 then
    firefoxExecutable = "/Applications/Firefox.app/Contents/MacOS/firefox"
  end

  dap.configurations.typescript = {
    {
      type = "node2",
      name = "node attach",
      request = "attach",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
    },
    {
      type = "chrome",
      name = "chrome",
      request = "attach",
      program = "${file}",
      -- cwd = "${workspaceFolder}",
      -- protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}",
      -- sourceMaps = true,
      sourceMapPathOverrides = {
        -- Sourcemap override for nextjs
        ["webpack://_N_E/./*"] = "${webRoot}/*",
        ["webpack:///./*"] = "${webRoot}/*",
      },
    },
    {
      name = "Debug with Firefox",
      type = "firefox",
      request = "launch",
      reAttach = true,
      sourceMaps = true,
      url = "http://localhost:6969",
      webRoot = "${workspaceFolder}",
      firefoxExecutable = firefoxExecutable,
    },
  }

  dap.configurations.typescriptreact = dap.configurations.typescript
  dap.configurations.javascript = dap.configurations.typescript
  dap.configurations.javascriptreact = dap.configurations.typescript

  --Java debugger adapter settings
  dap.configurations.java = {
    {
      name = "Debug (Attach) - Remote",
      type = "java",
      request = "attach",
      hostName = "127.0.0.1",
      port = 5005,
    },
    {
      name = "Debug Non-Project class",
      type = "java",
      request = "launch",
      program = "${file}",
    },
  }

  local path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/packages/codelldb/extension/")
    or vim.fn.expand "~/" .. ".vscode/extensions/vadimcn.vscode-lldb-1.8.1/"
  local lldb_cmd = path .. "adapter/codelldb"

  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      -- CHANGE THIS to your path!
      command = lldb_cmd,
      args = { "--port", "${port}" },

      -- On windows you may have to uncomment this:
      -- detached = false,
    },
  }

  dap.configurations.cpp = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = true,
    },
  }
  dap.configurations.c = dap.configurations.cpp

  if lvim.builtin.metals.active then
    dap.configurations.scala = {
      {
        type = "scala",
        request = "launch",
        name = "Run or Test Target",
        metals = {
          runType = "runOrTestFile",
        },
      },
      {
        type = "scala",
        request = "launch",
        name = "Test Target",
        metals = {
          runType = "testTarget",
        },
      },
    }
  end
  dap.configurations.python = dap.configurations.python or {}
  table.insert(dap.configurations.python, {
    type = "python",
    request = "launch",
    name = "launch with options",
    program = "${file}",
    python = function() end,
    pythonPath = function()
      local path
      for _, server in pairs(vim.lsp.buf_get_clients()) do
        if server.name == "pyright" or server.name == "pylance" then
          path = vim.tbl_get(server, "config", "settings", "python", "pythonPath")
          break
        end
      end
      path = vim.fn.input("Python path: ", path or "", "file")
      return path ~= "" and vim.fn.expand(path) or nil
    end,
    args = function()
      local args = {}
      local i = 1
      while true do
        local arg = vim.fn.input("Argument [" .. i .. "]: ")
        if arg == "" then
          break
        end
        args[i] = arg
        i = i + 1
      end
      return args
    end,
    justMyCode = function()
      local yn = vim.fn.input "justMyCode? [y/n]: "
      if yn == "y" then
        return true
      end
      return false
    end,
    stopOnEntry = function()
      local yn = vim.fn.input "stopOnEntry? [y/n]: "
      if yn == "y" then
        return true
      end
      return false
    end,
    console = "integratedTerminal",
  })
end

return M
