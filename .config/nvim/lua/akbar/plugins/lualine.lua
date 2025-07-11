return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count
		local devicons = require("nvim-web-devicons")

		local left_separator = ""
		local right_separator = ""

		vim.api.nvim_set_hl(0, "LualineBufferActive", { fg = "#000000", bg = "#B88339" })
		vim.api.nvim_set_hl(0, "LualineBufferInactive", { fg = "#B88339", bg = "#303030" })

		local function my_buffers()
			local result = {}
			local buffers = vim.api.nvim_list_bufs()
			local visible_buffers = {}
			local current_buf = vim.api.nvim_get_current_buf()
			local current_idx = nil

			for _, bufnr in ipairs(buffers) do
				if vim.bo[bufnr].buflisted then
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t")
					if filename == "" then
						filename = "[No Name]"
					end
					local icon, icon_color = devicons.get_icon_color(filename)
					if not icon or not icon_color then
						local filetype = vim.bo[bufnr].filetype
						if filetype and filetype ~= "" then
							icon, icon_color = devicons.get_icon_color_by_filetype(filetype)
						end
					end
					if not icon then
						icon = ""
					end
					if not icon_color then
						icon_color = "#B88339"
					end
					local is_current = current_buf == bufnr
					if is_current then
						current_idx = #visible_buffers + 1
					end
					local hl_group = "LualineBuf" .. bufnr .. (is_current and "Active" or "Inactive")
					local hl_group_bold = hl_group .. "Bold"

					if is_current then
						vim.api.nvim_set_hl(0, hl_group, { fg = "#000000", bg = icon_color })
					else
						vim.api.nvim_set_hl(0, hl_group, { fg = icon_color, bg = "#303030" })
					end

					if is_current then
						vim.api.nvim_set_hl(0, hl_group_bold, {
							fg = "#000000",
							bg = icon_color,
							bold = true,
						})
					else
						vim.api.nvim_set_hl(0, hl_group_bold, {
							fg = icon_color,
							bg = "#303030",
							bold = true,
						})
					end

					local modified = vim.bo[bufnr].modified and " ●" or ""

					table.insert(visible_buffers, {
						bufnr = bufnr,
						filename = filename,
						icon = icon,
						modified = modified,
						hl_group = hl_group,
						hl_group_bold = hl_group_bold,
						is_current = is_current,
					})
				end
			end

			-- Calculate actual available space for buffers
			local function calculate_other_components_width()
				local width = 0

				-- Mode section (lualine_a) - approximate based on longest mode name
				width = width + 12 -- " NORMAL " + separators + padding

				-- LSP status (lualine_b) - rough estimate
				width = width + 8 -- icon + "LSP" + padding

				-- Diagnostics (lualine_b) - estimate based on typical diagnostic display
				local diagnostics = vim.diagnostic.get()
				if #diagnostics > 0 then
					width = width + 20 -- icons + numbers + padding
				end

				-- Git branch (lualine_x)
				local branch = vim.fn.system("git branch --show-current 2>/dev/null"):gsub("\n", "")
				if branch and branch ~= "" then
					width = width + string.len(branch) + 8 -- icon + branch name + padding
				end

				-- Git diff (lualine_x) - estimate
				width = width + 15 -- diff icons and numbers

				-- Lazy updates (lualine_y) - only if there are updates
				if lazy_status.has_updates() then
					width = width + 10
				end

				-- Session name (lualine_z)
				local session_name = require("auto-session.lib").current_session_name(true)
				if session_name and session_name ~= "" and session_name ~= nil then
					width = width + string.len(session_name) + 8
				else
					width = width + 12 -- " session" + padding
				end

				-- Add some buffer for separators and spacing
				width = width + 10

				return width
			end

			local win_width = vim.o.columns
			local other_components_width = calculate_other_components_width()
			local max_buffers_width = math.max(20, win_width - other_components_width) -- Ensure minimum space

			local function estimate_buffer_width(buf)
				-- Icon (2) + space (1) + filename + modified (0 or 2) + spacing (3)
				return 2 + 1 + string.len(buf.filename) + (buf.modified ~= "" and 2 or 0) + 3
			end

			-- If no current buffer found, return empty or fallback
			if not current_idx then
				return ""
			end

			local current_buf_width = estimate_buffer_width(visible_buffers[current_idx])

			-- If even the current buffer is too wide for available space, truncate filename
			if current_buf_width > max_buffers_width then
				local current = visible_buffers[current_idx]
				local available_for_filename = max_buffers_width - 8 -- space for icon, modified, padding
				local truncated_filename = current.filename

				if string.len(truncated_filename) > available_for_filename then
					truncated_filename = string.sub(truncated_filename, 1, available_for_filename - 3) .. "..."
				end

				table.insert(
					result,
					string.format(
						"%%#%s# %s %%*%%#%s# %s%s %%*",
						current.hl_group,
						current.icon,
						current.hl_group_bold,
						truncated_filename,
						current.modified
					)
				)
				return table.concat(result, " ")
			end

			local selected_buffers = {}
			-- Always start with current buffer
			table.insert(selected_buffers, visible_buffers[current_idx])
			local total_width = current_buf_width

			-- Add buffers around the current one
			local right_idx = current_idx + 1
			local left_idx = current_idx - 1
			local prefer_right = true

			while total_width < max_buffers_width do
				local added = false

				-- Try to add from preferred side first
				if prefer_right and right_idx <= #visible_buffers then
					local right_buf = visible_buffers[right_idx]
					local right_width = estimate_buffer_width(right_buf)
					-- Reserve space for right indicator if needed
					local indicator_space = (right_idx == #visible_buffers) and 0 or 6
					if total_width + right_width + indicator_space <= max_buffers_width then
						table.insert(selected_buffers, right_buf)
						total_width = total_width + right_width
						right_idx = right_idx + 1
						added = true
					end
				elseif not prefer_right and left_idx >= 1 then
					local left_buf = visible_buffers[left_idx]
					local left_width = estimate_buffer_width(left_buf)
					-- Reserve space for left indicator if needed
					local indicator_space = (left_idx == 1) and 0 or 6
					if total_width + left_width + indicator_space <= max_buffers_width then
						table.insert(selected_buffers, 1, left_buf)
						total_width = total_width + left_width
						left_idx = left_idx - 1
						added = true
					end
				end

				-- If preferred side didn't work, try the other side
				if not added then
					if prefer_right and left_idx >= 1 then
						local left_buf = visible_buffers[left_idx]
						local left_width = estimate_buffer_width(left_buf)
						local indicator_space = (left_idx == 1) and 0 or 6
						if total_width + left_width + indicator_space <= max_buffers_width then
							table.insert(selected_buffers, 1, left_buf)
							total_width = total_width + left_width
							left_idx = left_idx - 1
							added = true
						end
					elseif not prefer_right and right_idx <= #visible_buffers then
						local right_buf = visible_buffers[right_idx]
						local right_width = estimate_buffer_width(right_buf)
						local indicator_space = (right_idx == #visible_buffers) and 0 or 6
						if total_width + right_width + indicator_space <= max_buffers_width then
							table.insert(selected_buffers, right_buf)
							total_width = total_width + right_width
							right_idx = right_idx + 1
							added = true
						end
					end
				end

				if not added then
					break
				end

				-- Alternate preference for next iteration
				prefer_right = not prefer_right
			end

			-- Add indicators for hidden buffers
			if left_idx >= 1 then
				table.insert(selected_buffers, 1, { special = "left" })
			end
			if right_idx <= #visible_buffers then
				table.insert(selected_buffers, { special = "right" })
			end

			for _, buf in ipairs(selected_buffers) do
				if buf.special == "left" then
					table.insert(result, "%#LualineBufferInactive# 󰩔 %*")
				elseif buf.special == "right" then
					table.insert(result, "%#LualineBufferInactive# 󰋇 %*")
				else
					table.insert(
						result,
						string.format(
							"%%#%s# %s %%*%%#%s# %s%s %%*",
							buf.hl_group,
							buf.icon,
							buf.hl_group_bold,
							buf.filename,
							buf.modified
						)
					)
				end
			end

			return table.concat(result, " ")
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
					{ my_buffers },
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
