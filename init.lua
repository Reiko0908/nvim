local o = vim.o
local opt = vim.opt

vim.g.mapleader = ' '
vim.g.maplocalleader = " "

o.showtabline = 1

opt.backspace = '2'
opt.showcmd = true
opt.laststatus = 2
opt.autowrite = true
opt.wrap = false
-- opt.cursorline = true
opt.cursorline = false
opt.autoread = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.shiftround = true
opt.expandtab = true
opt.clipboard = "unnamedplus"
opt.number = true
opt.relativenumber = false
opt.termguicolors = true
opt.scrolloff = 5
opt.foldlevelstart = 99
opt.timeoutlen = 600

require("reiko.lazy")
require("reiko.core")


