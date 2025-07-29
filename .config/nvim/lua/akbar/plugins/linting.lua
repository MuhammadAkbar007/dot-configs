return {
	"mfussenegger/nvim-lint",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
			python = { "ruff", "mypy" },
			c = { "cpplint" },
			cpp = { "cpplint" },
			bash = { "shellcheck" },
			zsh = { "shellcheck" },
			shell = { "shellcheck" },
		}

		lint.linters.cpplint.args = { "--filter=-whitespace/braces" }

		lint.linters.shellcheck.args = {
			"--shell=zsh", -- shellcheck does not fully support zsh but this helps a little
			"--exclude=SC1090,SC1091", -- examples of ignoring common warnings
		}

		lint.linters.ruff.args = {
			"--select=ALL",
			"--ignore=E501",
		}

		lint.linters.mypy.args = {
			cmd = "mypy",
			args = {
				"--ignore-missing-imports",
				"--no-color-output",
				"--show-column-numbers",
			},
			stdin = false,
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>li", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
