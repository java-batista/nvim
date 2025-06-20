local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
--require("lazy").setup("plugins")
require("lazy").setup(
  {
	-- require 'plugins.catppuccin',
	-- require 'plugins.tokyonight',
	require 'plugins.treesitter',	
	require 'plugins.telescope',
	require 'plugins.neo-tree',
	require 'plugins.lsp-config'
  }
)
