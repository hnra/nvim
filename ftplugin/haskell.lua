vim.cmd.packadd("FTerm.nvim")

vim.keymap.set("n", "<leader>bb", function()
  local buf = vim.api.nvim_buf_get_name(0)
  require("FTerm").scratch({ cmd = "cabal run", buf })
end)

