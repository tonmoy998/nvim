local M = {}
local fzf = require("fzf-lua")

M.show_images = function()
  local extensions = { "png", "jpg", "jpeg", "gif", "webp", "bmp" }
  local find_args = {}
  for _, ext in ipairs(extensions) do
    table.insert(find_args, string.format("-name '*.%s' -o -name '*.%s'", ext, ext:upper()))
  end
  local find_expr = table.concat(find_args, " -o ")

  -- Using 'printf' ensures the ANSI codes (\033[35m and \033[0m)
  -- are processed properly as colors instead of literal text.
  local cmd = string.format(
    "find . -type f \\( %s \\) -print0 | "
      .. "xargs -0 -I {} sh -c '"
      .. '  dims=$(identify -format "%%wx%%h" "$1" 2>/dev/null);'
      .. '  printf "\\033[35m%%s │ %%s\\033[0m\\n" "$1" "${dims:-Unknown}"'
      .. "' _ {}",
    find_expr
  )

  fzf.fzf_exec(cmd, {
    prompt = "Images (Path │ Dim)> ",
    previewer = false,
    fzf_opts = {
      ["--delimiter"] = "│",
      ["--preview-window"] = "hidden",
      ["--layout"] = "reverse",
      ["--ansi"] = "", -- Instructs fzf to parse the colors
    },
    winopts = {
      width = 0.90,
      height = 0.60,
    },
    actions = {
      ["default"] = function(selected)
        if not selected or #selected == 0 then
          return
        end

        local choice = selected[1]
        -- Strip any residual ANSI codes out before passing to Neovim
        local clean_choice = choice:gsub("\27%[[%d;]*m", "")

        -- Extract the file path
        local filepath = clean_choice:match("^(.-)%s*│")

        if filepath then
          filepath = filepath:gsub("^./", ""):gsub("%s+$", "")
          vim.cmd("edit " .. vim.fn.fnameescape(filepath))
        end
      end,
    },
  })
end

return M
