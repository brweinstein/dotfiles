-- lua/core/plugin_config/vimtex.lua

-- Compiler
vim.g.vimtex_compiler_method = 'latexmk'

-- Viewer settings
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_view_general_viewer = 'zathura'
vim.g.vimtex_view_general_options = [[--synctex-forward @line:@col:@tex @pdf]]

-- Enable vimtex mappings
vim.g.vimtex_mappings_enabled = 0  -- we will define our own

-- Syntax and conceal
vim.g.vimtex_syntax_enabled = 1
vim.g.vimtex_syntax_conceal_disable = 1

-- Quickfix
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_quickfix_autoclose_after_keystrokes = 2

-- Keybindings for compiling and viewing
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

