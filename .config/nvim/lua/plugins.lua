local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- TODO: do I need it?
-- vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
	"nvim-lualine/lualine.nvim",
	"kyazdani42/nvim-web-devicons",
	"kyazdani42/nvim-tree.lua",
	"goolord/alpha-nvim",
	"akinsho/toggleterm.nvim",
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
	"nvim-telescope/telescope-ui-select.nvim",
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	"neovim/nvim-lspconfig",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"saadparwaiz1/cmp_luasnip",
	"L3MON4D3/LuaSnip",
	"terrortylor/nvim-comment",
	"ojroques/nvim-lspfuzzy",
	"junegunn/fzf",
	"junegunn/fzf.vim",
	"marko-cerovac/material.nvim",
	"bluz71/vim-nightfly-guicolors",
	"bluz71/vim-moonfly-colors",
	"folke/todo-comments.nvim",
	"blacktrub/neovim-typer",
	"kevinhwang91/nvim-bqf",
	"bhurlow/vim-parinfer",
	"folke/trouble.nvim",
	"folke/neodev.nvim",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"jose-elias-alvarez/null-ls.nvim",
	"jay-babu/mason-null-ls.nvim",
	"jay-babu/mason-nvim-dap.nvim",
	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",
	"mfussenegger/nvim-dap-python",
	"leoluz/nvim-dap-go",
	"ThePrimeagen/harpoon",
	"APZelos/blamer.nvim",
	"chentoast/marks.nvim",
	"sindrets/diffview.nvim",
})
