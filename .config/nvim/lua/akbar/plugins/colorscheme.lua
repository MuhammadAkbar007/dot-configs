return {

	"catppuccin/nvim", -- colorscheme catppuccin
	priority = 1000,
	name = "catppuccin",
	config = function()
		require("catppuccin").setup({
			transparent_background = true, -- disables setting the background color.
			term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
			styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
				comments = { "italic" }, -- Change the style of comments
				conditionals = { "italic" },
			},
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = false,
				treesitter = true,
				notify = false,
				mini = false, -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
			},
			custom_highlights = function(colors)
				return {
					LineNr = { fg = colors.lavender },
				}
			end,
		})

		vim.cmd.colorscheme("catppuccin-mocha")
	end,

	-- "Mofiqul/dracula.nvim", -- colorscheme Dracula
	-- priority = 1000, -- make sure to load this before all the other start plugins
	-- config = function()
	-- 	require("dracula").setup({
	-- 		colors = { -- customize dracula color palette
	-- 			bg = "#282A36",
	-- 			fg = "#F8F8F2",
	-- 			selection = "#44475A",
	-- 			comment = "#6272A4",
	-- 			red = "#FF5555",
	-- 			orange = "#FFB86C",
	-- 			yellow = "#F1FA8C",
	-- 			green = "#50fa7b",
	-- 			purple = "#BD93F9",
	-- 			cyan = "#8BE9FD",
	-- 			pink = "#FF79C6",
	-- 			bright_red = "#FF6E6E",
	-- 			bright_green = "#69FF94",
	-- 			bright_yellow = "#FFFFA5",
	-- 			bright_blue = "#D6ACFF",
	-- 			bright_magenta = "#827305",
	-- 			bright_cyan = "#A4FFFF",
	-- 			bright_white = "#FFFFFF",
	-- 			menu = "#21222C",
	-- 			visual = "#3E4452",
	-- 			gutter_fg = "#4B5263",
	-- 			nontext = "#3B4048",
	-- 			white = "#ABB2BF",
	-- 			black = "#191A21",
	-- 		},
	--
	-- 		show_end_of_buffer = true, -- show the '~' characters after the end of buffers default false
	--
	-- 		transparent_bg = false, -- use transparent background default false
	--
	-- 		lualine_bg_color = "#44475a", -- set custom lualine background color default nil
	--
	-- 		italic_comment = true, -- set italic comment default false
	--
	-- 		overrides = { -- You can use overrides as table like this
	-- 			NonText = { fg = "white" }, -- set NonText fg to white
	-- 			NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
	-- 			Nothing = {}, -- clear highlight of Nothing
	-- 		},
	-- 	})
	--
	-- 	vim.cmd([[colorscheme dracula-soft]])
	-- end,
}
