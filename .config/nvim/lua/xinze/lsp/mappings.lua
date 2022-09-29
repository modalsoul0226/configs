local mappings = {}

-- Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
function mappings.set(bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local k = vim.keymap
    local b = vim.lsp.buf
    local bufopts = { noremap=true, silent=true, buffer=bufnr }

    k.set('n', 'gD', b.declaration, bufopts)
    k.set('n', 'gd', b.definition, bufopts)
    k.set('n', 'K', b.hover, bufopts)
    k.set('n', 'gi', b.implementation, bufopts)
    k.set('n', '<C-k>', b.signature_help, bufopts)
    k.set('n', '<space>wa', b.add_workspace_folder, bufopts)
    k.set('n', '<space>wr', b.remove_workspace_folder, bufopts)
    k.set('n', '<space>wl', function()
        print(vim.inspect(b.list_workspace_folders()))
    end, bufopts)
    k.set('n', '<space>D', b.type_definition, bufopts)
    k.set('n', '<space>rn', b.rename, bufopts)
    k.set('n', '<space>ca', b.code_action, bufopts)
    k.set('n', 'gr', b.references, bufopts)
    k.set('n', '<space>f', b.formatting, bufopts)
end

return mappings
