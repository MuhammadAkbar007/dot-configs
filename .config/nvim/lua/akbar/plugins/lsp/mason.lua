return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			ensure_installed = {
				"jdtls",
				"html",
				"cssls",
				"lua_ls",
				"emmet_ls",
				"pyright",
				"bashls",
				"jsonls",
				"lemminx",
				"yamlls",
				-- "ts_ls",
				"vtsls", -- for ts, js, jsx, tsx
				"tailwindcss",
				"eslint",
			},
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true, -- not the same as ensure_installed
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettierd", -- prettier formatter
				"stylua", -- lua formatter
				--"pylint",
				"eslint_d",
			},
		})
	end,
}
