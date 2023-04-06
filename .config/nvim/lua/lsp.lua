-- LSP config
-- local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
--lsp_installer.on_server_ready(function(server)
--    local opts = {}
--    print(server)
--    server:setup(opts)
--end)

require("neodev").setup()

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
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

nvim_lsp.gopls.setup{
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

nvim_lsp.tsserver.setup{
  on_attach = lsp_attach,
  flags = {
      debounce_text_changes = 150,
  },
  capabilities = capabilities,
}

nvim_lsp.lua_ls.setup({
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace"
      }
    }
  },
  on_attach = lsp_attach,
  flags = {
      debounce_text_changes = 150,
  },
  capabilities = capabilities,
})
