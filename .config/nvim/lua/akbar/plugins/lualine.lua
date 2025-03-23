return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count
		local devicons = require("nvim-web-devicons")

		vim.api.nvim_set_hl(0, "LualineBufferActive", { fg = "#000000", bg = "#B88339" })
		vim.api.nvim_set_hl(0, "LualineBufferInactive", { fg = "#B88339", bg = "#303030" })

		local function my_buffers()
			local result = {}
			local buffers = vim.api.nvim_list_bufs()
			local visible_buffers = {}
			local current_buf = vim.api.nvim_get_current_buf()
			local current_idx = nil

			for _, bufnr in ipairs(buffers) do
				if vim.api.nvim_buf_get_option(bufnr, "buflisted") then
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
					if is_current then
						vim.api.nvim_set_hl(0, hl_group, { fg = "#000000", bg = icon_color })
					else
						vim.api.nvim_set_hl(0, hl_group, { fg = icon_color, bg = "#303030" })
					end
					local modified = vim.api.nvim_buf_get_option(bufnr, "modified") and " ●" or ""

					table.insert(visible_buffers, {
						bufnr = bufnr,
						filename = filename,
						icon = icon,
						modified = modified,
						hl_group = hl_group,
						is_current = is_current,
					})
				end
			end

			local win_width = vim.o.columns
			local max_buffers_width = math.floor(win_width * 0.8) -- Adjust this percentage based on your needs

			local function estimate_buffer_width(buf)
				-- Icon (1) + space (1) + filename + modified (0 or 2) + spacing (3)
				return 2 + 1 + string.len(buf.filename) + (buf.modified ~= "" and 2 or 0) + 3
			end

			-- Smart buffer selection logic
			local selected_buffers = {}
			if current_idx then
				table.insert(selected_buffers, visible_buffers[current_idx])

				local right_idx = current_idx + 1
				local left_idx = current_idx - 1
				local total_width = estimate_buffer_width(visible_buffers[current_idx])

				while total_width < max_buffers_width do
					local added = false

					-- Try to add a buffer to the right
					if right_idx <= #visible_buffers then
						local right_buf = visible_buffers[right_idx]
						local right_width = estimate_buffer_width(right_buf)
						if total_width + right_width <= max_buffers_width then
							table.insert(selected_buffers, right_buf)
							total_width = total_width + right_width
							right_idx = right_idx + 1
							added = true
						end
					end

					-- Try to add a buffer to the left
					if left_idx >= 1 then
						local left_buf = visible_buffers[left_idx]
						local left_width = estimate_buffer_width(left_buf)
						if total_width + left_width <= max_buffers_width then
							table.insert(selected_buffers, 1, left_buf)
							total_width = total_width + left_width
							left_idx = left_idx - 1
							added = true
						end
					end

					-- If we couldn't add any more buffers, break
					if not added then
						break
					end
				end

				-- Add indicators for hidden buffers
				if left_idx >= 1 then
					table.insert(selected_buffers, 1, { special = "left" })
				end
				if right_idx <= #visible_buffers then
					table.insert(selected_buffers, { special = "right" })
				end
			else
				-- Fallback if no current buffer found
				selected_buffers = visible_buffers
			end

			-- Generate the final buffer string
			for _, buf in ipairs(selected_buffers) do
				if buf.special == "left" then
					table.insert(result, "%#LualineBufferInactive# 󰩔 %*")
					-- table.insert(result, "%#LualineBufferInactive# 󰶢 %*")
				elseif buf.special == "right" then
					table.insert(result, "%#LualineBufferInactive# 󰋇 %*")
					-- table.insert(result, "%#LualineBufferInactive# 󰔰 %*")
				else
					table.insert(
						result,
						string.format("%%#%s# %s %s%s %%*", buf.hl_group, buf.icon, buf.filename, buf.modified)
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
				lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
				lualine_b = {
					{ "branch", separator = { right = "" } },
					{ "diff", separator = { right = "" } },
					{ "diagnostics", sources = { "nvim_lsp" }, separator = { right = "" } },
				},
				lualine_c = {
					"%=",
					{ my_buffers },
				},
				lualine_x = {},
				lualine_y = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ffd700" },
					},
					{
						function()
							return require("auto-session.lib").current_session_name(true)
						end,
						separator = { left = "" },
						left_padding = 2,
						color = { bg = "#40a02b", fg = "#000000", gui = "bold" },
					},
					{ "progress", separator = { left = "" } },
				},
				lualine_z = {
					{ "location", separator = { right = "" }, left_padding = 2 },
				},
			},
		})
	end,
}
