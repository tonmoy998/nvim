local lspconfig = require("lspconfig")

-- 1. Get the base Neovim runtime files (returns a list)
local library_paths = vim.api.nvim_get_runtime_file("", true)

-- 2. Append your custom Love2D and system paths to that list
vim.list_extend(library_paths, {
  vim.fn.expand("~/.local/share/LuaAddons/love/api"), -- LOVE2D EmmyLua
  "/usr/local/share/lua/5.1/lib", -- System Lua lib
})

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim", "love" },
      },
      workspace = {
        -- 3. Pass the newly merged flat list here
        library = library_paths,
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
