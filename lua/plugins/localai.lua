-- return
return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      strategies = {
        chat = { adapter = "ollama" },
        inline = { adapter = "ollama" },
      },
      adapters = {
        http = {
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              -- Pass the custom endpoint url block inside env
              env = {
                url = "http://192.168.0.101:11434", -- Replace with your actual server URL & port
              },
              schema = {
                model = {
                  default = "qwen-short",
                },
              },
            })
          end,
        },
      },
    },
  },
  {
    "David-Kunz/gen.nvim",
    opts = {
      model = "qwen-short", -- Default fallback
      host = "192.168.0.101", -- Default fallback
      port = "11434",
      quit_map = "q",
      display_mode = "float",
    },
    config = function(_, opts)
      local gen = require("gen")
      gen.setup(opts)

      -- Command format: :GenConnect <hostname> <modelname>
      vim.api.nvim_create_user_command("GenConnect", function(opts)
        -- Split the space-separated arguments
        local args = vim.split(opts.args, "%s+", { trimempty = true })

        local host = args[1]
        local model = args[2]

        if host and model then
          gen.host = host
          gen.model = model
          vim.notify(string.format("Gen.nvim connected to %s using %s", host, model), vim.log.levels.INFO)
        else
          vim.notify("Usage: :GenConnect <hostname> <modelname>", vim.log.levels.ERROR)
        end
      end, {
        nargs = "+",
        desc = "Connect gen.nvim to a specific host and model",
      })
    end,
  },
}
