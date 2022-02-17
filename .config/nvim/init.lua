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

  -- themes
  Plug 'marko-cerovac/material.nvim'
  Plug 'bluz71/vim-nightfly-guicolors'

  -- todo highlight
  Plug 'nvim-lua/plenary.nvim'
  Plug 'folke/todo-comments.nvim'
 
vim.call('plug#end')

require('lualine').setup({options = {theme = 'nightfly'}})
require('nvim-web-devicons').get_icons()

vim.opt.termguicolors = true

-- vim.cmd 'colorscheme material'
vim.cmd [[colorscheme nightfly]]
vim.cmd 'set signcolumn=yes'


-- Spaces & Tabs {{{
vim.opt.tabstop = 4       -- number of visual spaces per TAB
vim.opt.softtabstop = 4   -- number of spaces in tab when editing
vim.opt.shiftwidth = 4    -- number of spaces to use for autoindent
vim.opt.expandtab = true  -- tabs are space
vim.opt.autoindent = true
vim.opt.copyindent = true -- copy indent from the previous line
vim.opt.wrap = false -- copy indent from the previous line
-- }}} Spaces & Tabs

-- Clipboard {{{
vim.opt.clipboard='unnamedplus'
-- }}} Clipboard

-- UI Config {{{
vim.opt.hidden = true
vim.opt.number = true                  -- show line number
vim.opt.showcmd = true                 -- show command in bottom bar
vim.opt.cursorline = true               -- highlight current line
vim.opt.colorcolumn = '100'               -- highlight current line
--vim.opt.cursorline               -- highlight current line
--vim.opt.wildmenu                 -- visual autocomplete for command menu
vim.opt.showmatch = true                -- highlight matching brace
vim.opt.laststatus = 2             -- window will always have a status line

-- vim.opt.nobackup = true
--vim.opt.noswapfile = true
-- }}} UI Config

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- buffer hotkeys
map('n', '{', ':BufferPrevious<CR>', opts)
map('n', '}', ':BufferNext<CR>', opts)
map('n', '<C-c>', ':BufferClose<CR>', opts)
map('n', '<C-a>', ':BufferCloseAllButCurrent<CR>', opts)

map('n', '<C-n>', ':NvimTreeToggle<CR>', opts)
map('n', '<C-b>', ':NvimTreeFocus<CR>', opts)
map('n', '<leader>r', ':NvimTreeRefresh<CR>', opts)
map('n', '<leader>n', ':NvimTreeFindFile<CR>', opts)

map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opts)
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', opts)
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', opts)
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', opts)

-- formatter
map('n', '<C-f>', ':Neoformat<cr>', opts)
-- terminal
-- does not work
-- TODO: how to disable terminal visual mode
-- map('t', '<Esc>', ':startinsert', opts)
-- tnoremap <C-h> <C-\><C-N><C-w>h
-- tnoremap <C-j> <C-\><C-N><C-w>j
-- tnoremap <C-k> <C-\><C-N><C-w>k
-- tnoremap <C-l> <C-\><C-N><C-w>l
--map('t', '<C-h>', '<C-\\><C-N><C-w>h', opts)
--map('t', '<C-j>', '<C-\\><C-N><C-w>j', opts)
--map('t', '<C-k>', '<C-\\><C-N><C-w>k', opts)
--map('t', '<C-l>', '<C-\\><C-N><C-w>l', opts)
map('t', '<esc>', '<C-\\><C-n>', opts)


require'alpha'.setup(require'alpha.themes.startify'.opts)
require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  auto_close          = true,
  open_on_tab         = true,
  hijack_cursor       = false,
  update_cwd          = false,
  update_to_buf_dir   = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {}
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = 'left',
    auto_resize = false,
    mappings = {
      custom_only = false,
      list = {}
    }
  }
}

require("toggleterm").setup{
  open_mapping = [[<c-p>]],
  shade_filetypes = {},
  shade_terminals = true,
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = true,
  direction = 'float',
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
  float_opts = {
      border = 'single',
  }
}

require('telescope').setup{
    defaults = {
        file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    }
}
require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

-- LSP config
-- local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
--lsp_installer.on_server_ready(function(server)
--    local opts = {}
--    print(server)
--    server:setup(opts)
--end)

local nvim_lsp = require('lspconfig')
local lsp_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

nvim_lsp.gopls.setup{
  -- cmd = {"/Users/blacktrub/go/bin/gopls"},
  cmd = {"/home/bt/go/bin/gopls"},
  on_attach = lsp_attach,
  flags = {
      debounce_text_changes = 150,
  },
  capabilities = capabilities,
}

nvim_lsp.pyright.setup{
  on_attach = lsp_attach,
  flags = {
      debounce_text_changes = 150,
  },
  capabilities = capabilities,
}

nvim_lsp.yamlls.setup{
  on_attach = lsp_attach,
  flags = {
      debounce_text_changes = 150,
  },
  capabilities = capabilities,
}

nvim_lsp.html.setup{
  on_attach = lsp_attach,
  flags = {
      debounce_text_changes = 150,
  },
  capabilities = capabilities,
}

nvim_lsp.dockerls.setup{
  on_attach = lsp_attach,
  flags = {
      debounce_text_changes = 150,
  },
  capabilities = capabilities,
}

nvim_lsp.clangd.setup{
  on_attach = lsp_attach,
  flags = {
      debounce_text_changes = 150,
  },
  capabilities = capabilities,
}

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- nvim_lsp.sumneko_lua.setup{
--   cmd = { "lua-language-server" },
--   on_attach = lsp_attach,
--   flags = {
--       debounce_text_changes = 150,
--   },
--   capabilities = capabilities,
--   settings = {
--     Lua = {
--       runtime = {
--         -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--         version = 'LuaJIT',
--         -- Setup your lua path
--         path = runtime_path,
--       },
--       diagnostics = {
--         -- Get the language server to recognize the `vim` global
--         globals = {'vim'},
--       },
--       workspace = {
--         -- Make the server aware of Neovim runtime files
--         library = vim.api.nvim_get_runtime_file("", true),
--       },
--       -- Do not send telemetry data containing a randomized but unique identifier
--       telemetry = {
--         enable = false,
--       },
--     },
--   },
-- }

vim.o.completeopt = 'menuone,noselect'
--vim.opt.omnifunc = 'v:lua.vim.lsp.omnifunc'
--
local luasnip = require 'luasnip'
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}


vim.g.bufferline = {
  -- Enable/disable animations
  animation = false,
  auto_hide = true,
  closable = false,
  icons = true,
  maximum_padding = 0,
}

vim.diagnostic.config({virtual_text = false})
require('nvim_comment').setup()


require("todo-comments").setup {}

