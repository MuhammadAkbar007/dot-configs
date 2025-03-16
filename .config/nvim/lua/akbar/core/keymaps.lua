local map = vim.keymap -- for conciseness

vim.g.mapleader = " " -- set leader key
map.set("n", "<Tab>", ":bn<CR>", { desc = "creates horizontal split" })
map.set("n", "<S-Tab>", ":bp<CR>", { desc = "creates horizontal split" })

map.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
map.set("n", "vv", "gg0vG$", { desc = "select whole file" })
map.set("n", "<leader>s", ":w<CR>", { desc = "write / save" })
map.set("n", "<leader>q", ":q<CR>", { desc = "just quit" })
map.set("n", "<leader>wq", ":wq<CR>", { desc = "write & quit" })
map.set("n", "<leader>lw", ":Lazy<CR>", { desc = "Lazy window" })
map.set("n", "<leader>mw", ":Mason<CR>", { desc = "Mason window" })
map.set("n", "<leader>nh", ":nohlsearch<CR>", { desc = "clear highlighted search" })

-- increment/decrement numbers
map.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
map.set("n", "<leader>_", "<C-x>", { desc = "Decrement number" })

-- for rest.nvim open horizontally
vim.api.nvim_create_autocmd("FileType", {
	pattern = "httpResult", -- This is the filetype for rest.nvim result
	callback = function()
		vim.cmd("belowright split") -- Moves the split to the bottom (horizontal split)
	end,
})
