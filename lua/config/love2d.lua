vim.api.nvim_create_user_command("Loveconf", function()
  -- Using vim.fs to handle paths cleanly
  local root = vim.fn.getcwd()
  local luarc = root .. "/.luarc.json"

  if vim.uv.fs_stat(luarc) then
    vim.notify(".luarc.json already exists", vim.log.levels.WARN)
    return
  end

  local home = os.getenv("HOME")

  -- Using a raw string to ensure the JSON structure is preserved perfectly
  local content = {
    ["$schema"] = "https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json",
    runtime = {
      version = "LuaJIT",
    },
    diagnostics = {
      globals = { "vim", "love" },
    },
    workspace = {
      library = {
        vim.env.VIMRUNTIME,
        string.format("%s/.local/share/LuaAddons/love/api", home),
      },
      checkThirdParty = false,
    },
    telemetry = {
      enable = false,
    },
  }

  local file = io.open(luarc, "w")
  if file then
    file:write(vim.json.encode(content))
    file:close()
    vim.notify(".luarc.json created ✅", vim.log.levels.INFO)

    -- Force restart LSP to pick up the new configuration file
    vim.cmd("LspRestart")
  else
    vim.notify("Failed to create .luarc.json", vim.log.levels.ERROR)
  end
end, {})
