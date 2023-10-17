-- VIM Options
vim.opt.number = true
vim.opt.smartcase = true
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 10

vim.g.mapleader = ","

-- Language Server Protocol Configs
vim.cmd.packadd("nvim-lspconfig")
require"lspconfig".hls.setup{}

-- Fuzzy finder
vim.cmd.packadd("plenary.nvim")
vim.cmd.packadd("telescope.nvim")
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, {})
vim.keymap.set("n", "<leader>fp", builtin.lsp_workspace_symbols, {})

-- Scratch Terminal
vim.cmd.packadd("FTerm.nvim")
vim.keymap.set("n", "<leader>t", function()
  require("FTerm").toggle()
end)
