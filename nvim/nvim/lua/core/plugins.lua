-- ~/.config/nvim/lua/core/plugins.lua

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      'git', 'clone', '--depth', '1',
      'https://github.com/wbthomason/packer.nvim', install_path
    })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  -----------------------------------------------------------
  -- Packer can manage itself
  -----------------------------------------------------------
  use 'wbthomason/packer.nvim'

  -----------------------------------------------------------
  -- Markdown preview
  -----------------------------------------------------------
  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && npm install',
    ft = { 'markdown' },
  }

  -----------------------------------------------------------
  -- LSP, Mason, and completion
  -----------------------------------------------------------
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'

  use {
    "goolord/alpha-nvim",
    requires = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("core.plugin_config.alpha")
    end,
  }

  use {
    "hrsh7th/nvim-cmp",
    config = function()
      require("core.plugin_config.cmp")
    end
  }

  use { "hrsh7th/cmp-nvim-lsp" }
  use { "hrsh7th/cmp-buffer" }
  use { "hrsh7th/cmp-path" }
  use { "hrsh7th/cmp-cmdline" }
  use { "L3MON4D3/LuaSnip" }
  use { "saadparwaiz1/cmp_luasnip" }

  -----------------------------------------------------------
  -- File tree & UI
  -----------------------------------------------------------

  use {
    'nvim-tree/nvim-tree.lua',
    requires = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("core.plugin_config.nvim-tree")
    end,
  }
  use {
    'm4xshen/autoclose.nvim',
    event = "InsertEnter",
    config = function()
      require("autoclose").setup()
    end
  }

	use "olimorris/onedarkpro.nvim"

  -----------------------------------------------------------
  -- Telescope + FZF extension
  -----------------------------------------------------------
  
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
      },
    },
    config = function()
      require("core.plugin_config.telescope")
    end,
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require("core.plugin_config.treesitter")
    end,
  }

  -----------------------------------------------------------
  -- LaTeX
  -----------------------------------------------------------
  use {
    'lervag/vimtex',
    ft = { 'tex' },
    config = function()
      require("core.plugin_config.vimtex")
    end,
  }

  use {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = function()
      require("gitsigns").setup()
    end
  }

  use {
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup()
    end
  }

  -----------------------------------------------------------
  -- Bootstrap Packer on first install
  -----------------------------------------------------------
  if packer_bootstrap then
    require('packer').sync()
  end
end)
