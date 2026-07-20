local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
  -- Remove "tsserver" or "ts_ls" from this list if it's there!
  ensure_installed = { "lua_ls", "html", "cssls" },
})
