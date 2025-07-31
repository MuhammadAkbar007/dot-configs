return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count
		local devicons = require("nvim-web-devicons")

		-- Add custom icon for .properties files
		devicons.setup({
			override_by_filename = {
				["application.properties"] = {
					icon = "", -- or use "", "󰟜", "⚙", "🔧"
					color = "#6DB33F",
					name = "Properties",
				},
			},
			override_by_extension = {
				["properties"] = {
					icon = "", -- or use "", "󰟜", "⚙", "🔧"
					color = "#6DB33F",
					name = "Properties",
				},
			},
		})

		local left_separator = ""
		local right_separator = ""

		vim.api.nvim_set_hl(0, "LualineBufferActive", { fg = "#000000", bg = "#B88339" })
		vim.api.nvim_set_hl(0, "LualineBufferInactive", { fg = "#B88339", bg = "#303030" })

		local function my_current_buffer()
			local current_buf = vim.api.nvim_get_current_buf()

			-- Get current buffer info
			local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(current_buf), ":t")
			local filetype = vim.bo[current_buf].filetype

			-- Hide buffer for unnamed buffers or specific filetypes
			local excluded_filetypes = {
				"NvimTree",
				"TelescopePrompt",
				"TelescopeResults",
				"help",
				-- "terminal",
				-- "toggleterm",
				"lazy",
				"mason",
				"lspinfo",
				"null-ls-info",
				"rest_nvim_result#Response",
				"qf", -- quickfix
				"", -- empty filetype
			}

			if filename == "" or vim.tbl_contains(excluded_filetypes, filetype) then
				return "" -- Return empty string for excluded buffers
			end

			-- Get icon and color with fallback for properties files
			local icon, icon_color = devicons.get_icon_color(filename)

			if not icon or not icon_color then
				if filetype and filetype ~= "" then
					icon, icon_color = devicons.get_icon_color_by_filetype(filetype)
				end
			end

			if filetype == "runner-terminal" then
				icon = "󰑮 " --  or 󰑮
				icon_color = "#00ff00"
			end

			-- Custom fallback for properties files
			if not icon and (filename:match("%.properties$") or filename == "application.properties") then
				icon = ""
				icon_color = "#6DB33F"
			end

			if not icon then
				icon = "󰈙"
			end
			if not icon_color then
				icon_color = "#B88339"
			end

			-- Set highlight groups for current buffer
			local hl_group = "LualineBufCurrent"
			local hl_group_bold = hl_group .. "Bold"

			vim.api.nvim_set_hl(0, hl_group, { fg = "#000000", bg = icon_color })
			vim.api.nvim_set_hl(0, hl_group_bold, {
				fg = "#000000",
				bg = icon_color,
				bold = true,
			})

			-- Check if buffer is modified
			local modified = vim.bo[current_buf].modified and " ●" or ""

			-- Add filename truncation
			local max_filename_length = 37 -- Adjust this value as needed
			local truncated_filename = filename

			if string.len(filename) > max_filename_length then
				local start_chars = math.floor((max_filename_length - 3) / 2)
				local end_chars = max_filename_length - 3 - start_chars
				truncated_filename = string.sub(filename, 1, start_chars) .. "..." .. string.sub(filename, -end_chars)
			end

			-- Return formatted string
			return string.format(
				"%%#%s# %s %%*%%#%s# %s%s %%*",
				hl_group,
				icon,
				hl_group_bold,
				truncated_filename,
				modified
			)
		end

		lualine.setup({
			options = {
				icons_enabled = true,
				theme = "powerline_dark", -- "catppuccin" or "auto"
				globalstatus = true,
				section_separators = { left = "", right = "" },
				component_separators = "", -- "|"
			},
			sections = {
				lualine_a = { { "mode", icon = " |", separator = { left = left_separator }, right_padding = 2 } },
				lualine_b = {
					{
						"lsp_status",
						icon = "",
						-- icon = "󰒍 ",
						-- icon = " ",
						color = { bg = "#df8e1d", fg = "#000000", gui = "bold" },
					},
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						-- sources = { "nvim_lsp" },
						separator = { right = "" },
						sections = { "error", "warn", "hint", "info" },
						symbols = { error = " ", warn = " ", hint = "󰠠 ", info = " " },
						colored = true,
						update_in_insert = false,
						always_visible = false,
					},
				},
				lualine_c = {
					"%=",
					{ my_current_buffer },
				},
				lualine_x = {
					{
						"branch",
						icon = "",
						color = { bg = "#7287fd", fg = "black", gui = "bold" },
					},
					{
						"diff",
						separator = { right = "" },
						sections = { "added", "modified", "removed" },
						symbols = { added = " ", modified = "󰌇 ", removed = "󱛘 " },
						colored = true,
						update_in_insert = false,
						always_visible = false,
					},
				},
				lualine_y = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ffd700" },
					},
				},
				lualine_z = {
					{
						function()
							local session_name = require("auto-session.lib").current_session_name(true)
							if session_name and session_name ~= "" and session_name ~= nil then
								local max_length = 17
								if #session_name > max_length then
									session_name = "..." .. string.sub(session_name, -(max_length - 3))
								end
								return " " .. session_name
							else
								return "  session"
							end
						end,
						separator = { right = right_separator },
						left_padding = 2,
						color = { bg = "#40a02b", fg = "#000000", gui = "bold" },
					},
				},
			},
		})
	end,
}
