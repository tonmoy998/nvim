local lspconfig = require("lspconfig")

-- TypeScript 7.0 Native LSP configuration
lspconfig.tsserver.setup({
  -- Call the tsc binary directly with the native LSP flag
  cmd = { "tsc", "--lsp", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
  -- Optional: Highly recommended for TS 7.0's multithreaded capabilities
  init_options = {
    hostInfo = "neovim",
  },
})
