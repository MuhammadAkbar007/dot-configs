return {
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"mfussenegger/nvim-jdtls",
		"nvim-neotest/nvim-nio",
		"folke/lazydev.nvim",
		"theHamsta/nvim-dap-virtual-text",
	},

	opts = {
		expand_lines = true,
		floating = {
			border = "single",
			mappings = {
				close = { "q", "<Esc>" },
			},
		},
		force_buffers = true,
	},

	config = function(_, opts)
		local dap = require("dap")
		local dapui = require("dapui")

		require("lazydev").setup({
			library = { "nvim-dap-ui" },
		})

		require("nvim-dap-virtual-text").setup()

		dapui.setup(opts)

		-- Customize breakpoint signs
		vim.api.nvim_set_hl(0, "DapStoppedHl", { fg = "#98BB6C", bg = "#2A2A2A", bold = true })
		vim.api.nvim_set_hl(0, "DapStoppedLineHl", { bg = "#204028", bold = true })
		vim.fn.sign_define(
			"DapStopped",
			{ text = " ", texthl = "DapStoppedHl", linehl = "DapStoppedLineHl", numhl = "" }
		)
		vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
		vim.fn.sign_define(
			"DapBreakpointCondition",
			{ text = " ", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" }
		)
		vim.fn.sign_define(
			"DapBreakpointRejected",
			{ text = " ", texthl = "DiagnosticSignError", linehl = "", numhl = "" }
		)
		vim.fn.sign_define("DapLogPoint", { text = " ", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		dap.configurations.java = {
			{
				type = "java",
				request = "attach",
				name = "Debug (Attach) - Remote",
				hostName = "127.0.0.1",
				port = 5005,
			},
			{
				type = "java",
				request = "launch",
				name = "Debug (Launch) - Current File",
				mainClass = "${file}",
				projectName = "${workspaceFolder}",
			},
			{
				name = "Debug Maven Application",
				type = "java",
				request = "launch",
				mainClass = function()
					return vim.fn.input(
						"Main class: ",
						"",
						'customlist,v:lua.require("jdtls").get_main_class_candidates'
					)
				end,
				projectName = "${workspaceFolder}",
				classPaths = function()
					local result = {}
					local output = vim.fn.system("mvn dependency:build-classpath -Dmdep.outputFile=/tmp/cp.txt")
					if vim.v.shell_error ~= 0 then
						print("Failed to get classpath: " .. output)
						return result
					end
					local file = io.open("/tmp/cp.txt", "r")
					if file then
						local classpath = file:read("*all")
						file:close()
						for path in string.gmatch(classpath, "[^:]+") do
							table.insert(result, path)
						end
					end
					table.insert(result, vim.fn.getcwd() .. "/target/classes")
					return result
				end,
				vmArgs = "-Xmx2g",
			},
		}

		vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "Toggle breakpoint of nvim-dap" })
		vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Start or continue nvim-dap" })
		vim.keymap.set("n", "<Leader>di", dap.step_into, { desc = "Step into" })
		vim.keymap.set("n", "<Leader>do", dap.step_over, { desc = "Step over" })
		vim.keymap.set("n", "<Leader>dO", dap.step_out, { desc = "Step out" })
		vim.keymap.set("n", "<Leader>dr", dap.repl.open, { desc = "Open REPL" })
		vim.keymap.set("n", "<Leader>dl", dap.run_last, { desc = "Run last debug configuration" })
		vim.keymap.set("n", "<Leader>dx", dap.terminate, { desc = "Terminate debug session" })
	end,
}
