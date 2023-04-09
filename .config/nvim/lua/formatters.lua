local null_ls = require("null-ls")

local need_to_install = { "goimports", "prettier", "stylua", "black" }

require("mason-null-ls").setup({
	ensure_installed = need_to_install,
})

local sources = {
	null_ls.builtins.formatting.black,
	null_ls.builtins.formatting.gofmt,
	null_ls.builtins.formatting.goimports,
	null_ls.builtins.formatting.prettier,
	null_ls.builtins.formatting.stylua,
}

null_ls.setup({
	sources = sources,
})
