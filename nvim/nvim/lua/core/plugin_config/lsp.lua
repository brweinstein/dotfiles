-- ~/.config/nvim/lua/core/plugin_config/lsp.lua
-- =============================
-- LSP, Completion, and Snippet Setup (Neovim 0.11+ API)
-- =============================

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- =============================
-- Required modules
-- =============================
local cmp = require("cmp")
local luasnip = require("luasnip")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- =============================
-- LuaSnip Setup
-- =============================
luasnip.config.set_config({
  enable_autosnippets = true,
})
require("luasnip.loaders.from_vscode").lazy_load()  -- Load friendly-snippets

-- =============================
-- Mason Setup
-- =============================
mason.setup()
mason_lspconfig.setup({
  ensure_installed = { "rust_analyzer", "pyright", "texlab" },
})

-- =============================
-- nvim-cmp Setup
-- =============================
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
  })
})

-- =============================
-- LSP Capabilities
-- =============================
local capabilities = cmp_nvim_lsp.default_capabilities()

-- =============================
-- Helper: find project root safely
-- =============================
local function find_root(patterns)
  local file = vim.fs.find(patterns, { upward = true })[1]
  return file and vim.fs.dirname(file) or vim.loop.cwd()
end

-- =============================
-- Common on_attach function
-- =============================
local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- Diagnostics
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<leader>d", vim.diagnostic.setqflist, opts)

  -- LSP actions
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, opts)
  vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
end

-- =============================
-- Setup LSP server
-- =============================
local function setup_server(name, config)
  config = config or {}
  config.capabilities = config.capabilities or capabilities
  config.on_attach = config.on_attach or on_attach

  vim.lsp.config[name] = vim.tbl_deep_extend(
    "force",
    vim.lsp.config[name] or {},
    config
  )

  vim.lsp.enable(name)
end

-- =============================
-- Setup standard LSP servers
-- =============================
setup_server("pyright", {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_dir = find_root({ "pyproject.toml", "setup.py", "requirements.txt", ".git" }),
})

setup_server("rust_analyzer", {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_dir = find_root({ "Cargo.toml", "rust-project.json", ".git" }),
})

setup_server("texlab", {
  cmd = { "texlab" },
  filetypes = { "tex", "bib" },
  root_dir = find_root({ ".git" }),
})

-- =============================
-- Diagnostics UI configuration
-- =============================
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded" },
})

-- =============================
-- CursorHold diagnostics float
-- =============================
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter" },
      border = "rounded",
      source = "always",
    }
    vim.diagnostic.open_float(nil, opts)
  end,
})
