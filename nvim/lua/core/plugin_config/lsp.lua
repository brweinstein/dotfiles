-- lsp.lua
-- =============================
-- LSP, Completion, and Snippet Setup
-- =============================

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load required modules
local lspconfig = require("lspconfig")
local cmp = require("cmp")
local luasnip = require("luasnip")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

-- =============================
-- Mason Setup
-- =============================
mason.setup()
mason_lspconfig.setup({
  ensure_installed = { "rust_analyzer", "pyright", "texlab" }, -- Racket is handled manually
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
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
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
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- =============================
-- Common on_attach function
-- =============================
local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
	-- Show diagnostics (error/warning) in a floating window
	vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { noremap = true, silent = true })

	-- Go to next diagnostic
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { noremap = true, silent = true })

	-- Go to previous diagnostic
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { noremap = true, silent = true })

	-- List all diagnostics in the location list
	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { noremap = true, silent = true })
	  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
end

-- =============================
-- Setup standard LSP servers
-- =============================
local servers = { "rust_analyzer", "pyright", "texlab" }
for _, server_name in ipairs(servers) do
  lspconfig[server_name].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
end

-- =============================
-- Manually setup Racket LSP
-- =============================
lspconfig.racket_langserver.setup({
  cmd = { "racket", "-l", "racket-langserver" },  -- Correct hyphen path
  filetypes = { "racket" },
  root_dir = lspconfig.util.root_pattern("info.rkt", ".git"),
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Optional: auto-hover on CursorHold
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*",
  callback = function()
    vim.lsp.buf.hover()
  end,
})
