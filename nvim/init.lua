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
require("lazy").setup("plugins")

vim.cmd('set hidden')
vim.cmd('set clipboard+=unnamedplus')

-- Define split borders with visible colors
vim.o.fillchars = "vert:│,horiz:─,horizup:┴,horizdown:┬,vertleft:┤,vertright:├,verthoriz:┼"
vim.o.splitbelow = true
vim.o.splitright = true

-- Make the split border color visible
vim.cmd [[
  highlight WinSeparator guibg=None guifg=#bd93f9
]]

-- Show file name in each split window bar
vim.o.winbar = '%#WinBar#%=' .. '%f' .. '%='
vim.cmd [[
  highlight WinBar guibg=#282a36 guifg=#f8f8f2
]]

