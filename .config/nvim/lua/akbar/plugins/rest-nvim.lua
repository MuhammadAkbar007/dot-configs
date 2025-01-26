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
						local path = vim.fn.getcwd() .. "/rest_nvim_result#Response"
						local file = io.open(path, "w")
						if file then
							file:write(response.body)
							file:close()
						end
					end,
				},
			},
		}
	end,

	vim.keymap.set("n", "<leader>rr", ":Rest run<CR>", { noremap = true, silent = true }),
}
