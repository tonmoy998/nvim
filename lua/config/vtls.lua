require("lspconfig").vtsls.setup({
  settings = {
    vtsls = {
      experimental = {
        -- 1. Filters results on the server, sending less data to Neovim
        completion = {
          enableServerSideFuzzyMatch = true,
          entriesLimit = 30, -- Limits the list size (standard is often too high)
        },
      },
      -- 2. Automatically use the project's TS version for better consistency
      autoUseWorkspaceTsdk = true,
    },
    typescript = {
      tsserver = {
        -- 3. Increase memory for large monorepos (default is often 4096)
        maxTsServerMemory = 8192,
      },
      -- 4. Disable heavy features if you don't use them
      preferences = {
        -- Disable searching every package.json (can be slow in large repos)
        includePackageJsonAutoImports = "off",
      },
    },
  },
})
