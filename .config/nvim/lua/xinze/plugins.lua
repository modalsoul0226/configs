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

        -- LSP
        use {
    	    "williamboman/mason.nvim",
    	    config = function()
                require("mason").setup({
                    ui = {
                        icons = {
                            package_installed = "✓",
                            package_pending = "➜",
                            package_uninstalled = "✗"
                        }
                    }
                })
    	    end
    	}

        use {
    	    "williamboman/mason-lspconfig.nvim",
    	    config = function()
    		    require'mason-lspconfig'.setup{}
    	    end
    	}

        use {
            'neovim/nvim-lspconfig',
            config = function()
                require('xinze.lsp.servers')
            end,
            requires = {
                {
                    -- WARN: Unfortunately we won't be able to lazy load this
                    'hrsh7th/cmp-nvim-lsp',
                },
            },
        }

        -- Auto-completion
        use {
            {
                'hrsh7th/nvim-cmp',
                config = function()
                    require('xinze.lsp.cmp')
                end,
                requires = {
                    {
                        'L3MON4D3/LuaSnip',
                        event = 'InsertEnter',
                        config = function()
                            require('xinze.lsp.luasnip')
                        end,
                        requires = {
                            {
                                'rafamadriz/friendly-snippets',
                                event = 'CursorHold',
                            },
                        },
                    },
                },
            },
            { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
        }

	    -- Format & Syntax
	    use "lukas-reineke/indent-blankline.nvim"
        require("indent_blankline").setup {
            -- for example, context is off by default, use this to turn it on
            show_current_context = true,
            show_current_context_start = true,
        }

    end,
    config = {
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'single' })
            end,
        },
    },
})
