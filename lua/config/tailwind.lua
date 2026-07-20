require("lspconfig").tailwindcss.setup({
  -- Optional: Custom settings for specific filetypes or regex
  filetypes = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "svelte", "rust" },
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          -- Example for custom Phoenix/Heex regex if needed
          'class[:]\\s*"([^"]*)"',
        },
      },
    },
  },
})
