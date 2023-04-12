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


require("dap-go").setup({
	dap_configurations = {
		{
			-- Must be "go" or it will be ignored by the plugin
			type = "go",
			name = "Attach remote",
			mode = "remote",
			request = "attach",
		},
		{
			type = "go",
			request = "launch",
			name = "Run PP Debug",
			program = vim.fn.getcwd() .. "/cmd/service/main.go",
		},
		{
			type = "go",
			name = "Debug test Integration",
			request = "launch",
			mode = "test",
			program = "${file}",
			args = { "-test.tags", "integration" },
		},
	},
	delve = {
		initialize_timeout_sec = 20,
		port = "${port}",
	},
})

require("dapui").setup()
