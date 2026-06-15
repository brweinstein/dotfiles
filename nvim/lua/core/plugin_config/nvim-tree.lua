-- ~/.config/nvim/lua/core/plugin_config/nvim-tree.lua

-- Require plugin (loaded on startup)
local nvim_tree = require("nvim-tree")

-- NvimTree setup
nvim_tree.setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
  git = {
    ignore = false,
  },
})

-- Keymap to toggle NvimTree
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Auto-close NvimTree when opening any file
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local tree_bufnr = vim.fn.bufnr("NvimTree_1")
    if tree_bufnr ~= -1 then
      vim.cmd("NvimTreeClose")
    end
  end,
})
