-- treesitter.lua
require'nvim-treesitter'.setup {
  -- Parsers to install
  ensure_installed = {
    "c",
    "rust",
	"js",
	"ts",
    "lua",
    "python",
    "vim",
    "html",
    "racket",
    "markdown",         -- Needed for markdown parsing
    "markdown_inline",  -- Needed for fenced code highlighting
	"latex"
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    enable = true,
    -- Required for markdown treesitter highlighting
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true,
  },
}
