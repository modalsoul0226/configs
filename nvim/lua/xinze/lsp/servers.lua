local lsp = require('lspconfig')
local mappings = require('xinze.lsp.mappings')

---Common `on_attach` function for LSP servers
---@param client table
---@param buf integer
local function on_attach(client, buf)
    -- utils.disable_formatting(client)
    mappings.set(buf)
end

-- Servers with default configurations
local ds = {
    'pyright',
    'sumneko_lua',
    'volar', -- vue.js
    'intelephense', -- php
    'html',
    'tsserver',
    'jsonls',
    'tailwindcss',
    'bashls',
    'marksman', -- markdown
}

for _, server in ipairs(ds) do
    lsp[server].setup{
        on_attach = on_attach,
    }
end

-- require'lspconfig'.pyright.setup{}
-- require'lspconfig'.sumneko_lua.setup{}
-- require'lspconfig'.vuels.setup{}
