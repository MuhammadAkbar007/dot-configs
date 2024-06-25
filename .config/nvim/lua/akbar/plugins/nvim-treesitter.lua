return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"windwp/nvim-ts-autotag",
	},
	config = function()
		local treesitter = require("nvim-treesitter.configs")
		treesitter.setup({
			-- A list of parser names, or "all" (the five listed parsers should always be installed)
			ensure_installed = {
				"json",
				"bash",
				"gitignore",
				"javascript",
				"python",
				"java",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"html",
				"json",
			},

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},

			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = true,

			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
			-- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx

			-- context_commentstring = {
			-- 	enable = true,
			-- 	enable_autocmd = false,
			-- },

			auto_install = true,
			indent = { enable = true },
			autotag = {
				enable = true,
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = true,
			},
		})
	end,
}
