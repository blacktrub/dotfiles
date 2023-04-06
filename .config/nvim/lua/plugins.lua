local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')
  --Plug 'vim-airline/vim-airline'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'kyazdani42/nvim-web-devicons' -- for file icons
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'goolord/alpha-nvim'
  Plug 'romgrk/barbar.nvim'
  Plug 'akinsho/toggleterm.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-ui-select.nvim'
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/nvim-lsp-installer'

  Plug 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  Plug 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  Plug 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  Plug 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  Plug 'L3MON4D3/LuaSnip' -- Snippets plugin
  Plug 'averms/black-nvim'
  Plug 'chr4/nginx.vim'
  Plug 'sbdchd/neoformat' -- Format code
  Plug "terrortylor/nvim-comment"

  -- fuzzy finder for lsp, it seems pretty but I don't know how to use it properly
  Plug 'ojroques/nvim-lspfuzzy'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'

  -- themes
  Plug 'marko-cerovac/material.nvim'
  Plug 'bluz71/vim-nightfly-guicolors'
  Plug 'projekt0n/github-nvim-theme'
  Plug 'bluz71/vim-moonfly-colors'

  -- todo highlight
  Plug 'nvim-lua/plenary.nvim'
  Plug 'folke/todo-comments.nvim'


  -- session
  -- Plug 'Shatur/neovim-session-manager'

  Plug 'blacktrub/neovim-typer'
  Plug 'kevinhwang91/nvim-bqf'

  Plug 'fatih/vim-go'

  -- Debugger
  Plug 'mfussenegger/nvim-dap'
  Plug 'rcarriga/nvim-dap-ui'
  Plug 'mfussenegger/nvim-dap-python'

  Plug 'chrisbra/csv.vim'

  Plug 'vlime/vlime'
  Plug 'bhurlow/vim-parinfer'

  Plug 'folke/trouble.nvim'

  Plug 'folke/neodev.nvim'

vim.call('plug#end')
