local ftGroup = vim.api.nvim_create_augroup("filetype_group", { clear = false })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*/sites-enabled/*.conf",
	command = "set filetype=nginx",
	group = ftGroup,
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.brief" },
	command = "set filetype=brief",
	group = ftGroup,
})
