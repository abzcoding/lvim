local M = {}

M.config = function()
  local function sep_os_replacer(str)
    local result = str
    local path_sep = package.config:sub(1, 1)
    result = result:gsub("/", path_sep)
    return result
  end

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

  dap.configurations.go = {
    {
      type = "go",
      name = "Debug",
      request = "launch",
      showLog = false,
      program = "${file}",
      dlvToolPath = vim.fn.exepath "dlv", -- Adjust to where delve is installed
    },
  }

  dap.configurations.dart = {
    {
      type = "dart",
      request = "launch",
      name = "Launch flutter",
      dartSdkPath = sep_os_replacer(os.getenv "HOME" .. "/flutter/bin/cache/dart-sdk/"),
      flutterSdkPath = sep_os_replacer(os.getenv "HOME" .. "/flutter"),
      program = sep_os_replacer "${workspaceFolder}/lib/main.dart",
      cwd = "${workspaceFolder}",
    },
  }

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
  }

  dap.configurations.typescriptreact = {
    {
      type = "chrome",
      request = "chrome attach",
      name = "chrome",
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
  }

  dap.configurations.javascript = {
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
      type = "node2",
      name = "node launch",
      request = "launch",
      program = "${workspaceFolder}/${file}",
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      protocol = "inspector",
    },
    {
      type = "chrome",
      request = "attach",
      name = "chrome",
      program = "${file}",
      port = 9222,
      webRoot = "${workspaceFolder}",
      sourceMapPathOverrides = {
        -- Sourcemap override for nextjs
        ["webpack://_N_E/./*"] = "${webRoot}/*",
        ["webpack:///./*"] = "${webRoot}/*",
      },
    },
  }

  dap.configurations.javascriptreact = {
    {
      type = "chrome",
      name = "chrome attach",
      request = "attach",
      program = "${file}",
      -- cwd = vim.fn.getcwd(),
      -- sourceMaps = true,
      -- protocol = "inspector",
      port = 9222,
      sourceMapPathOverrides = {
        -- Sourcemap override for nextjs
        ["webpack://_N_E/./*"] = "${webRoot}/*",
        ["webpack:///./*"] = "${webRoot}/*",
      },
    },
  }

  dap.adapters.lldb = {
    type = "executable",
    command = "/usr/local/opt/llvm/bin/lldb-vscode",
    name = "lldb",
  }

  dap.configurations.cpp = {
    {
      name = "Launch",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = true,
      args = {},
      runInTerminal = false,
    },
  }

  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = {
    {
      name = "Launch",
      type = "lldb",
      request = "launch",
      program = function()
        return sep_os_replacer(vim.fn.getcwd() .. "/target/debug/" .. "${workspaceFolderBasename}")
      end,
      env = function()
        local variables = {}
        for k, v in pairs(vim.fn.environ()) do
          table.insert(variables, string.format("%s=%s", k, v))
        end
        return variables
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = {},
      runInTerminal = false,
      externalConsole = true,
    },
  }
end

return M
