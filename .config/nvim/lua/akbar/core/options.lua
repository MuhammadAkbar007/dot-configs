-- Global options of Neovim
local opt = vim.opt -- for simplicity

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = "a" -- enable mouse support
opt.clipboard = "unnamedplus" -- enable system clipboard
opt.swapfile = false -- don't use swapfile
opt.completeopt = "menuone,noinsert,noselect" -- autocomplete options

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true -- set numbers
opt.relativenumber = true -- numbers relatively to current line
opt.showmatch = true -- highlight matching parenthesis
opt.ignorecase = true -- ignore case letters when search
opt.smartcase = true -- ignore lowercase for the whole pattern
opt.termguicolors = true -- enable 24-bit RGB colors

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.tabstop = 4 -- 1 tab == 4 spaces
opt.smartindent = true -- autoindent new lines
opt.shiftwidth = 4 -- Shift 4 spaces when tab
opt.wrap = false -- no wrap line

-----------------------------------------------------------
-- Cursor
-----------------------------------------------------------
opt.cursorline = true
