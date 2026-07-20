return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    dependencies = {
      -- Note: 'copilot-lsp' repository structure usually dictates this format
      "copilotlsp-nvim/copilot-lsp",
    },
    enabled = true,
    opts = {
      -- Your copilot.lua setup configurations go here
      -- Leave empty ({}) for default settings
    },
    -- Alternatively, if you want to explicitly run the setup function manually:
    -- config = function(_, opts)
    --   require("copilot").setup(opts)
    -- end,
  },
}
