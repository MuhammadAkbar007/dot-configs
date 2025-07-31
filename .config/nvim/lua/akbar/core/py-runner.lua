local function run_python_file()
	local bufnr = vim.api.nvim_get_current_buf()
	local filename = vim.api.nvim_buf_get_name(bufnr)

	-- Check if current file is a Python file
	if not filename:match("%.py$") then
		vim.notify("Current file is not a Python file", vim.log.levels.WARN)
		return
	end

	-- Get just the filename without path
	local file = vim.fn.expand("%:t")
	local cmd = "python3 " .. file

	-- Open terminal in bottom split and run the command
	vim.cmd("botright split | resize 15 | terminal " .. cmd)
	vim.cmd("normal G")

	local term_buf = vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_set_name(term_buf, "r_" .. file .. "_r")
	vim.bo[term_buf].bufhidden = "hide"
	vim.bo[term_buf].filetype = "runner-terminal" -- ★ key line

	vim.notify("Run: " .. cmd, vim.log.levels.INFO)
end

-- Add this keymap alongside your existing ones
vim.keymap.set("n", "<leader>pr", run_python_file, { desc = "Run Python file" })
