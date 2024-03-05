return {
	"shellRaining/hlchunk.nvim",
	event = { "UIEnter" },
	config = function()
		require("hlchunk").setup({
			line_num = {
				enable = true,
				use_treesitter = true,
				style = "#806d9c",
			},
		})
	end,
}
