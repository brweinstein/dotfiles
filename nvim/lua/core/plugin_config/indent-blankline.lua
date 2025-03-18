vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#2a2e36", nocombine = true })
vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = "#5c6370", nocombine = true })

-- Directly set options using vim.g for version 3
vim.g.indent_blankline_char = "│"
vim.g.indent_blankline_filetype_exclude = { "help", "alpha", "dashboard", "NvimTree", "Trouble" }
vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_first_indent_level = true
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_show_current_context_start = true
vim.g.indent_blankline_space_char_blankline = " "
