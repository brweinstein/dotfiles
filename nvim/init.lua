if not vim.tbl_islist and vim.islist then
  vim.tbl_islist = vim.islist
end

require("core.keymaps")
require("core.plugins")
require("core.plugin_config")

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      vim.cmd("Alpha")
    end
  end,
})

vim.loader.enable()

vim.cmd("set autoindent")
vim.cmd("set number")
vim.opt.relativenumber = true
vim.o.shiftwidth = 4
vim.g.loaded_perl_provider = 0
vim.cmd("set noexpandtab")
vim.o.tabstop = 4
vim.opt.wrap = true          -- Enable line wrapping
vim.opt.linebreak = true     -- Wrap at word boundaries
vim.opt.breakat = " "        -- Allow wrap at spaces
vim.opt.showbreak = "\\ "    -- Show "\" at the start of wrapped lines
vim.cmd("colorscheme gruvbox")
