return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	opts = {
		options = {
			vim.cmd([[
			nnoremap <silent><leader>1 <Cmd>BufferLineGoToBuffer 1<CR>
			nnoremap <silent><leader>2 <Cmd>BufferLineGoToBuffer 2<CR>
			nnoremap <silent><leader>3 <Cmd>BufferLineGoToBuffer 3<CR>
			nnoremap <silent><leader>4 <Cmd>BufferLineGoToBuffer 4<CR>
			nnoremap <silent><leader>5 <Cmd>BufferLineGoToBuffer 5<CR>
			nnoremap <silent><leader>6 <Cmd>BufferLineGoToBuffer 6<CR>
			nnoremap <silent><leader>7 <Cmd>BufferLineGoToBuffer 7<CR>
			nnoremap <silent><leader>8 <Cmd>BufferLineGoToBuffer 8<CR>
			nnoremap <silent><leader>9 <Cmd>BufferLineGoToBuffer 9<CR>

			nnoremap <silent><leader><Left> :BufferLineCyclePrev<CR>
			nnoremap <silent><leader><Right> :BufferLineCycleNext<CR>
			nnoremap <silent><TAB> :BufferLineCycleNext<CR>
			nnoremap <silent><S-TAB> :BufferLineCyclePrev<CR>
		]]),
			numbers = "ordinal",
			hover = {
				enabled = true,
				delay = 200,
				reveal = { "close" },
			},

			offsets = {
				{
					filetype = "NvimTree",
					text_align = "left",
					separator = true,
					highlight = "Directory",
					text = "📁 Akbar Ahmad ibn Akrom",
					-- text = function()
					--	return vim.fn.getcwd()
					-- end,
				},
			},
		},
	},

	vim.keymap.set("n", "<leader>w", ":bd<CR>"),
}
