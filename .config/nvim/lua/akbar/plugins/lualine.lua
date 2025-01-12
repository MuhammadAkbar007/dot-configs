return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		vim.api.nvim_set_hl(0, "LualineCInactive", { fg = "#B88339", bg = "#303030" })
		vim.api.nvim_set_hl(0, "LualineCActive", { fg = "#000000", bg = "#B88339" })

		lualine.setup({
			options = {
				icons_enabled = true,
				theme = "powerline_dark", -- "catppuccin" or "auto"
				globalstatus = true,
				section_separators = { left = "", right = "" },
				component_separators = "", -- "|"
			},
			sections = {
				lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
				lualine_b = { { "branch" }, { "diff" }, { "diagnostics", sources = { "nvim_lsp" } } },
				lualine_c = {
					{ "%=" },
					{
						"buffers",
						section_separators = { left = "", right = "" },
						component_separators = { left = "|", right = "|" },
						hide_filename_extension = false,
						show_modified_status = true,
						mode = 0,
						max_length = vim.o.columns,
						filetype_names = {
							TelescopePrompt = "🔭",
							dashboard = "📊 Dashboard",
							packer = "📦 Packer",
							fzf = "🔍 FZF",
							alpha = "🐺 Alpha",
							NvimTree = "🌳",
						},
						buffers_color = {
							active = "LualineCActive", -- Color for active buffer.
							inactive = "LualineCInactive", -- Color for inactive buffer.
						},
						symbols = {
							modified = " ●", -- Text to show when the buffer is modified
							alternate_file = " ⊙ ", -- Text to show to identify the alternate file
							directory = "", -- Text to show when the buffer is a directory
						},
					},
				},
				lualine_x = {},
				lualine_y = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ffd700" },
					},
					{ "progress" },
				},
				lualine_z = {
					{ "location", separator = { right = "" }, left_padding = 2 },
				},
			},
		})
	end,
}
