return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader><space>",
        function()
          Snacks.picker.files()
        end,
        desc = "Find Files",
      },
      {
        "<leader>fw",
        function()
          Snacks.picker.grep()
        end,
        desc = "Grep Project",
      },
      {
        "<leader>fC",
        function()
          Snacks.picker.colorschemes()
        end,
        desc = "Colorschemes with Preview",
      },
      {
        "<leader>fg",
        function()
          Snacks.picker.git_files()
        end,
        desc = "Find Git Files",
      },
      {
        "<leader>fr",
        function()
          Snacks.picker.recent()
        end,
        desc = "Recent Files",
      },
      {
        "<leader>fp",
        function()
          Snacks.picker.projects()
        end,
        desc = "Projects",
      },
      {
        "<leader>lg",
        function()
          Snacks.lazygit()
        end,
        desc = "Lazygit",
      },
    },
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      debug = { enabled = false },
      explorer = { enabled = false },
      indent = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      image = {
        enabled = true, -- Enable the image module
        doc = {
          -- This enables inline image rendering for supported filetypes
          enabled = true,
          inline = true, -- Render inside the buffer (works best on Kitty)
          float = false, -- Disable floating window if using inline
          max_width = 80,
          max_height = 40,
        },
      },
    },
  },
}
