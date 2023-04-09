local mason_nvim_dap = require("mason-nvim-dap")
local servers = { "python", "delve" }

mason_nvim_dap.setup({
	ensure_installed = servers,
	automatic_installation = true,
	automatic_setup = true,
	handlers = {
		function(config)
			mason_nvim_dap.default_setup(config)
		end,
	},
})

local dap = require("dap")
dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Django",
		program = vim.fn.getcwd() .. "/manage.py",
		args = { "runserver", "8000", "--noreload" },
		justMyCode = false,
	},
	{
		type = "python",
		request = "launch",
		name = "Django tests",
		program = vim.fn.getcwd() .. "/manage.py",
		args = { "test", "apps.channels.tests", "--keepdb" },
		justMyCode = false,
	},
}

require("dapui").setup()
