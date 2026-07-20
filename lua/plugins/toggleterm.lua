return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    size = 80,
    open_mapping = nil, -- we'll define our own mappings
    direction = "vertical",
    persist_size = true,
    persist_mode = true,
    start_in_insert = true,
    close_on_exit = false,
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)

    local Terminal = require("toggleterm.terminal").Terminal

    -- Default vertical terminal
    local term = Terminal:new({
      direction = "vertical",
      hidden = true,
    })

    vim.keymap.set("n", "<leader>bt", function()
      term:toggle()
    end, { desc = "Toggle Vertical Terminal" })
  end,
}
