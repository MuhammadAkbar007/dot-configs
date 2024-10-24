return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		-- configure lualine with modified theme
		lualine.setup({
			options = {
				icons_enabled = true,
				-- theme = "catppuccin",
				-- theme = "auto",
				theme = "powerline_dark",
				globalstatus = true,
				-- section_separators = { left = "", right = "" },
				-- component_separators = "|",
			},
			sections = {
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ffd700" },
					},
					{
						function()
							local dir_icon = "" -- Directory icon
							local cwd = vim.fn.expand("%:~:.") -- Current working directory
							return " " .. dir_icon .. " " .. cwd -- Display icon with directory name
						end,
						color = { fg = "#dfff00" }, -- Set text and background color
						separator = "",
					},
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
			},
		})
	end,
}
