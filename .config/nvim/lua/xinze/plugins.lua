-- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand:
vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('PACKER', { clear = true }),
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerCompile',
})

return require('packer').startup({
    function(use)
        -- Packer can manage itself
        use 'wbthomason/packer.nvim'

        -- Appearances
        use {
	        'RRethy/nvim-base16', -- themes
	        config = function()
                vim.cmd('colorscheme base16-onedark')	
	        end,
	    }

        use {
            'kyazdani42/nvim-tree.lua', -- file explorer
            requires = {
                'kyazdani42/nvim-web-devicons', -- optional, for file icons
            },
            tag = 'nightly' -- optional, updated every week. (see issue #1193)
        }

        use {
            'nvim-lualine/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true }
        }
        require('lualine').setup {
            view = {
                width=10,
            }
        }

        -- Snippets and Auto-completions
        use "williamboman/mason.nvim"

        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })

        use {
            'neovim/nvim-lspconfig',
            config = function()
                require'lspconfig'.pyright.setup{}
            end
        }

        -- Auto-completion
        use 'hrsh7th/nvim-cmp'
        use 'hrsh7th/cmp-buffer'
        use 'hrsh7th/cmp-path'
        use 'hrsh7th/cmp-cmdline'
        -- use 'hrsh7th/cmp-nvim-lsp'


	    -- Format & Syntax
	    use "lukas-reineke/indent-blankline.nvim"

    end,
    config = {
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'single' })
            end,
        },
    },
})
