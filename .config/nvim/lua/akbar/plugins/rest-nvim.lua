return {
	-- https://github.com/rest-nvim/rest.nvim
	-- :TSInstall http
	"rest-nvim/rest.nvim",
	event = "VeryLazy",
	config = function()
		vim.g.rest_nvim = {
			response = {
				hooks = {
					-- This hook saves the response to a specified file
					after_request = function(response)
						local file = io.open(vim.fn.getcwd() .. "/rest_nvim_result#Response", "w")
						if file then
							file:write(response.body)
							file:close()
							vim.notify("Response has been written", vim.log.levels.INFO)
						end
					end,
				},
			},
		}

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "httpResult", -- This is the filetype for rest.nvim result
			callback = function()
				vim.cmd("belowright split") -- Moves the split to the bottom (horizontal split)
			end,
		})

		vim.keymap.set("n", "<leader>rr", ":Rest run<CR>", { noremap = true, silent = true })
	end,
}
