return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				lua = { "stylua" },
				txt = { "prettier" },
				xml = { "lemminx" },
				java = { "google-java-format" },
				-- sql = { "sql_formatter" },
				--python = { "isort", "black" },
			},

			formatters = {
				prettier = {
					prepend_args = { "--tab-width", "4" },
				},
				["google-java-format"] = {
					prepend_args = { "--aosp" }, -- Uses 4 spaces instead of 2
				},
			},

			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}