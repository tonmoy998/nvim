return {
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = {
      -- cfg options
    },
  },
  {
    "voldikss/vim-floaterm",
  },
  {
    "norcalli/nvim-colorizer.lua",
    enabled = false,
  },
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup({})
    end,
  },
  {
    "karb94/neoscroll.nvim",
    opts = {},
  },
  {
    "https://github.com/lambdalisue/vim-suda",
  },

  { "KabbAmine/vCoolor.vim" },
}
