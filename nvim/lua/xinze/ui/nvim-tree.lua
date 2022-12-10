require("nvim-tree").setup({
    filters = {
        dotfiles = false,
        custom = { '^.git$' }
    },
    git = {
        ignore = false,
    },
})
