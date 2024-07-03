local map = vim.keymap -- for conciseness

-- setting key maps
vim.g.mapleader = " " -- set leader key
map.set("n", "<leader>vs", ":vsp<CR>") -- creates vertical split
map.set("n", "<leader>hs", ":sp<CR>") -- creates horizontal split
map.set("n", "<leader>q", ":q<CR>") -- write & quit
map.set("n", "<leader>wq", ":wq<CR>") -- write & quit
map.set("n", "<leader>l", ":Lazy<CR>") -- Lazy window
map.set("n", "<leader>s", ":w<CR>") -- write / save
map.set("n", "<leader>nhls", ":nohlsearch<CR>") -- clear highlighted search
map.set("n", "vv", "ggvG") -- clear highlighted search
map.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" }) -- escape from insert mode

-- increment/decrement numbers
map.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
map.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement
