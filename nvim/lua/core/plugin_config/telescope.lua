
-- lua/core/plugin_config/telescope.lua

local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end

local builtin = require("telescope.builtin")

telescope.setup({
  defaults = {
    file_ignore_patterns = {
      "node_modules/",
      ".git/",
    },
    sorting_strategy = "ascending",
    layout_config = {
      prompt_position = "top",
    },
  },

  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
})

-- Load extensions safely
pcall(telescope.load_extension, "fzf")

-- Keymaps (defined once, after setup)
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<C-p>", builtin.find_files, vim.tbl_extend("force", opts, {
  desc = "Find files (Telescope)",
}))

map("n", "<Space><Space>", builtin.oldfiles, vim.tbl_extend("force", opts, {
  desc = "Recent files",
}))

map("n", "<Space>fg", builtin.live_grep, vim.tbl_extend("force", opts, {
  desc = "Live grep",
}))

map("n", "<Space>fh", builtin.help_tags, vim.tbl_extend("force", opts, {
  desc = "Help tags",
}))

map("n", "<Space>ff", builtin.builtin, vim.tbl_extend("force", opts, {
  desc = "Telescope pickers",
}))

map("n", "<Space>fb", builtin.current_buffer_fuzzy_find, vim.tbl_extend("force", opts, {
  desc = "Fuzzy search current buffer",
}))

