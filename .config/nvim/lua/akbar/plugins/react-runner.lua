return {
	dir = vim.fn.stdpath("config") .. "/lua/akbar/plugins",
	name = "react-runner",
	config = function()
		local function run_react_dev_server()
			local function is_react_project()
				return vim.fn.filereadable("package.json") == 1
			end

			local function get_package_manager()
				if vim.fn.filereadable("yarn.lock") == 1 then
					return "yarn"
				else
					return "npm"
				end
			end

			if not is_react_project() then
				vim.notify("Not a React project", vim.log.levels.WARN)
				return
			end

			local package_manager = get_package_manager()
			local cmd = package_manager .. " run dev"
			print("Running React development server: " .. cmd)

			vim.cmd("botright split | resize 15 | terminal " .. cmd)

			local current_buffer = vim.api.nvim_get_current_buf()
			vim.bo[current_buffer].bufhidden = "hide"
		end

		local function stop_react_dev_server()
			if not vim.g.react_dev_server_job_id then
				vim.notify("No React development server is currently running", vim.log.levels.WARN)
				return
			end

			vim.fn.jobstop(vim.g.react_dev_server_job_id)

			vim.g.react_dev_server_job_id = nil

			vim.notify("React development server stopped", vim.log.levels.INFO)
		end

		vim.keymap.set("n", "<leader>rlr", run_react_dev_server, {
			desc = "Run React local development server",
		})

		vim.keymap.set("n", "<leader>rlx", stop_react_dev_server, { desc = "Stop local React development server" })
	end,
}
