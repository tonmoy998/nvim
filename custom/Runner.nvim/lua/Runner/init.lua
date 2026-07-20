local M = {}

-- Default options
M.opts = {
  ts = "", -- TypeScript compiler options
  python = "python3",
}

-- Helper to open the floating window
local function open_floating_window()
  local width = math.ceil(vim.o.columns * 0.8)
  local height = math.ceil(vim.o.lines * 0.8)
  local row = math.ceil((vim.o.lines - height) / 2)
  local col = math.ceil((vim.o.columns - width) / 2)
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = " Runner Output ",
    title_pos = "center",
  })
  vim.keymap.set("n", "q", ":close<CR>", { buffer = buf, silent = true })
  -- vim.keymap.set("n", "<ESC>", ":close<CR>", { buffer = buf, silent = true })
  return buf, win
end

function M.run_code()
  local ft = vim.bo.filetype
  local abs_path = vim.fn.expand("%:p")
  local abs_root = vim.fn.expand("%:p:r")
  local execution_cmd = ""

  if ft == "cpp" then
    print("🔨 Compiling C++...")
    local compile_out = vim.fn.system(string.format("g++ %s -o %s", abs_path, abs_root))
    if vim.v.shell_error ~= 0 then
      print("❌ Compilation Failed!")
      print(compile_out)
      return
    end
    execution_cmd = abs_root
  elseif ft == "typescript" then
    print("🔨 Compiling TypeScript...")
    -- Fixed: Use .. for concatenation (not +) and proper option access
    local ts_flags = M.opts.ts ~= "" and " " .. M.opts.ts or ""
    local compile_out = vim.fn.system("tsc " .. abs_path .. ts_flags)
    if vim.v.shell_error ~= 0 then
      print("❌ TypeScript Compilation Failed!")
      print(compile_out)
      return
    end
    execution_cmd = "node " .. abs_root .. ".js"
  elseif ft == "javascript" then
    execution_cmd = "node " .. abs_path
  elseif ft == "python" then
    execution_cmd = M.opts.python .. " " .. abs_path
  elseif ft == "lua" then
    execution_cmd = "lua " .. abs_path
  elseif ft == "markdown" then
    execution_cmd = "glow -p " .. abs_path
  elseif ft == "cs" then
    -- print(" Compiling ...")
    vim.notify(" 🔨 Compiling ...")
    execution_cmd = "dotnet run"
  end

  -- Open UI and Execute
  open_floating_window()
  vim.fn.termopen(execution_cmd)
  vim.cmd("startinsert")
end

function M.setup(user_opts)
  -- Merge user options with defaults
  M.opts = vim.tbl_deep_extend("force", M.opts, user_opts or {})

  local group = vim.api.nvim_create_augroup("Runner", { clear = true })
  local supported_fts = { "typescript", "javascript", "python", "cpp", "lua", "cs", "md", "markdown" }

  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = supported_fts,
    callback = function()
      vim.keymap.set("n", "<leader>r", M.run_code, {
        buffer = true,
        desc = "Build and Run Code",
      })
    end,
  })
end

return M
