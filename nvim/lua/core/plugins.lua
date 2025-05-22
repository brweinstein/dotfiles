local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
use 'wbthomason/packer.nvim'
use {
  'iamcco/markdown-preview.nvim',
  run = 'cd app && npm install',
  ft = { 'markdown' }
}
use 'neovim/nvim-lspconfig'
use 'williamboman/mason.nvim'
use 'williamboman/mason-lspconfig.nvim'
use { "hrsh7th/nvim-cmp" }
use { "hrsh7th/cmp-nvim-lsp" }
use { "hrsh7th/cmp-buffer" }
use { "hrsh7th/cmp-path" }
use { "hrsh7th/cmp-cmdline" }
use { "L3MON4D3/LuaSnip" }
use { "saadparwaiz1/cmp_luasnip" }
use 'nvim-tree/nvim-tree.lua'
use 'navarasu/onedark.nvim'  -- Load the Onedark theme
use 'nvim-tree/nvim-web-devicons'
use 'm4xshen/autoclose.nvim'
use 'shaunsingh/nord.nvim'
use 'ellisonleao/gruvbox.nvim'
use {'nvim-treesitter/nvim-treesitter', run = 'TSUpdate'}
use {
	'nvim-telescope/telescope.nvim', tag = '0.1.8',
	requires = { {'nvim-lua/plenary.nvim'} }
}
  -- My plugins here
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
