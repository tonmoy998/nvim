local img_dim_plugin = require("fzf-image-dimensions")

vim.keymap.set("n", "<leader>id", img_dim_plugin.show_images, {
  desc = "FZF Image Dimensions",
})
