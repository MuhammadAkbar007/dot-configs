return {
	"tpope/vim-fugitive",

	config = function()
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ga", "<cmd>Gwrite<cr>", { desc = "Git add ." })
		keymap.set("n", "<leader>gc", "<cmd>G commit<cr>", { desc = "Git comit" })
		keymap.set("n", "<leader>gb", "<cmd>GBrowse<cr>", { desc = "open this git item in default browser" })
		keymap.set("n", "<leader>gs", "<cmd>Git<cr>", { desc = "open this git item in default browser" })
	end,
}
