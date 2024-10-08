require("config.lazy")

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

-- Colorscheme
vim.cmd.colorscheme "catppuccin"

-- Treesitter
require("nvim-treesitter.configs").setup {
  ensure_installed = { "haskell", "lua" },
  highlight = {
    enable = true,
  }
}

-- Language Server Protocol Configs
vim.o.updatetime = 1000
local on_attach = function(_, bufnr)
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
      }
      vim.diagnostic.open_float(nil, opts)
    end
  })
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
end
require("lspconfig").hls.setup { on_attach = on_attach }
require("typescript-tools").setup { on_attach = on_attach }

-- Remember last file position
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = "*",
  -- group = vim.g.user.event,
  callback = function(args)
    local valid_line = vim.fn.line([['"]]) >= 1 and vim.fn.line([['"]]) < vim.fn.line('$')
    local not_commit = vim.b[args.buf].filetype ~= 'commit'

    if valid_line and not_commit then
      vim.cmd([[normal! g`"]])
    end
  end,
})

-- Fuzzy finder
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, {})
vim.keymap.set("n", "<leader>fp", builtin.lsp_workspace_symbols, {})
vim.keymap.set("n", "<leader>gf", builtin.git_files, {})
vim.keymap.set("n", "<leader>qf", builtin.quickfix, {})

-- Scratch Terminal
vim.keymap.set("n", "<leader>t", function()
  require("FTerm").toggle()
end)
vim.api.nvim_set_keymap('t', '<ESC>', '<C-\\><C-n>',  { noremap = true })
