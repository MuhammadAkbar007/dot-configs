local map = vim.keymap -- for conciseness

-- setting key maps
vim.g.mapleader = " " -- set leader key
map.set("n", "<leader>vs", ":vsp<CR>", { desc = "creates vertical split" })
map.set("n", "<leader>hs", ":sp<CR>", { desc = "creates horizontal split" })
map.set("n", "<leader>q", ":q<CR>", { desc = "just quit" })
map.set("n", "<leader>wq", ":wq<CR>", { desc = "write & quit" })
map.set("n", "<leader>l", ":Lazy<CR>", { desc = "Lazy window" })
map.set("n", "<leader>s", ":w<CR>", { desc = "write / save" })
map.set("n", "<leader>nh", ":nohlsearch<CR>", { desc = "clear highlighted search" })
map.set("n", "vv", "gg0vG$", { desc = "select whole file" })
map.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- increment/decrement numbers
map.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
map.set("n", "<leader>_", "<C-x>", { desc = "Decrement number" })
