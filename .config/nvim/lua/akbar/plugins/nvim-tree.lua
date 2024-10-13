return {
	-- file explorer tree
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		local nvimtree = require("nvim-tree")

		-- disable netrw at the very start of your init.lua
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- set termguicolors to enable highlight groups
		vim.opt.termguicolors = true

		-- configure nvim-tree
		nvimtree.setup({
			sync_root_with_cwd = true,
			respect_buf_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = true,
			},
			sort_by = "case_sensitive",
			view = {
				-- width = 30,
				adaptive_size = true,
				relativenumber = true,
			},
			-- change folder arrow icons
			renderer = {
				indent_markers = {
					enable = true,
				},
				group_empty = false, -- compact middle empty folders
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "", -- arrow when folder is closed
							arrow_open = "", -- arrow when folder is open
						},
					},
				},
			},
			actions = {
				use_system_clipboard = true,
				open_file = {
					window_picker = {
						enable = false,
					},
					quit_on_open = true,
				},
			},
			filters = {
				dotfiles = false,
				custom = { ".DS_Store" },
			},
			git = {
				ignore = false,
			},
		})

		-- Function to set highlight groups
		local function set_highlight(group, fg, bg)
			local command = string.format("highlight %s guifg=%s guibg=%s", group, fg or "NONE", bg or "NONE")
			vim.cmd(command)
		end

		-- Customize nvim-tree highlight groups
		set_highlight("NvimTreeFolderName", "#FFD700")
		set_highlight("NvimTreeFolderIcon", "#FFD700")
		set_highlight("NvimTreeOpenedFolderName", "#FFD700")
		set_highlight("NvimTreeEmptyFolderName", "#808080")
		set_highlight("NvimTreeIndentMarker", "#A9A9A9")
		-- set_highlight("NvimTreeFolderArrowOpen", "#FFD700")
		-- set_highlight("NvimTreeFolderArrowClosed", "#FFD700")

		vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggles file explorer nvimTree
	end,
}
