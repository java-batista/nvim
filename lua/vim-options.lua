--vim.cmd("set expandtab")
--vim.cmd("set tabstop=2")
--vim.cmd("set softtabstop=2")
--vim.cmd("set shiftwidth=2")

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.g.mapleader = " "
vim.g.background = "light"

vim.opt.swapfile = false

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.wo.number = true

vim.cmd.colorscheme 'simple'

-- Remove the tildes (~) from the empty lines. Disable the end-of-buffer markers
vim.opt.fillchars:append({ eob = " " })
-- Prevent Neovim LSP from opening a scratch preview buffer
--vim.cmd("set completeopt-=preview")
