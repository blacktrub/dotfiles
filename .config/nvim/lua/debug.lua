require("dapui").setup()
require('dap-python').setup()

local dap = require('dap')
dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Django',
    program = vim.fn.getcwd() .. '/manage.py',
    args = {'runserver', '8000', '--noreload'},
    justMyCode = false,
  },
  {
    type = 'python',
    request = 'launch',
    name = 'Django tests',
    program = vim.fn.getcwd() .. '/manage.py',
    args = {'test', 'apps.channels.tests', '--keepdb'},
    justMyCode = false,
  }
}
