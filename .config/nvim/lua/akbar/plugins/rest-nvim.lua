return {
	-- :TSInstall http
	"rest-nvim/rest.nvim",
	vim.keymap.set("n", "<leader>rr", ":Rest run<CR>", { noremap = true, silent = true }),
}
