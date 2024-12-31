return {
	-- https://github.com/rest-nvim/rest.nvim
	-- :TSInstall http
	"rest-nvim/rest.nvim",
	event = "VeryLazy",
	vim.keymap.set("n", "<leader>rr", ":Rest run<CR>", { noremap = true, silent = true }),
}
