-- setting key maps
vim.g.mapleader = " " -- set leader key
vim.keymap.set("n", "<leader>vs", ":vsp<CR>") -- creates vertical split
vim.keymap.set("n", "<leader>hs", ":sp<CR>") -- creates horizontal split
vim.keymap.set("n", "<leader>q", ":q<CR>") -- write & quit
vim.keymap.set("n", "<leader>wq", ":wq<CR>") -- write & quit
vim.keymap.set("n", "<leader>l", ":Lazy<CR>") -- Lazy window
vim.keymap.set("n", "<leader>s", ":w<CR>") -- write / save
vim.keymap.set("n", "<leader>nhls", ":nohlsearch<CR>") -- clear highlighted search
-- vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggles file explorer nvimTree
