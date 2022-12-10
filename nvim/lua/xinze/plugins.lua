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
        -- use {
	    --     'RRethy/nvim-base16', -- themes
	    --     config = function()
        --         -- vim.cmd('colorscheme base16-onedark')
        --         vim.cmd('colorscheme base16-google-dark')
	    --     end,
	    -- }
        use {
            'navarasu/onedark.nvim',
            config = function ()
               vim.cmd('colorscheme onedark') 
            end
        }
        require('onedark').load()

        use {
            'kyazdani42/nvim-tree.lua', -- file explorer
            requires = {
                'kyazdani42/nvim-web-devicons', -- optional, for file icons
            },
            tag = 'nightly', -- optional, updated every week. (see issue #1193)
            config = function ()
                require("xinze.ui.nvim-tree")
            end
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

        -- Dashboard is a nice start screen for nvim
        use {
            'nvim-telescope/telescope-fzf-native.nvim',
            run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
        }

        -- use { "nvim-telescope/telescope-file-browser.nvim" }

        use {
            'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
            requires = { {'nvim-lua/plenary.nvim'} },
            config = function()
                require('xinze.other.telescope')
            end
        }

        use {
            'glepnir/dashboard-nvim',
            config = function()
                require('xinze.ui.dashboard')
            end
        }

        use {
            "iamcco/markdown-preview.nvim",
            run = "cd app && npm install",
            setup = function()
                vim.g.mkdp_filetypes = { "markdown" }
            end,
            ft = { "markdown" },
        }

        use 'voldikss/vim-floaterm'

        -- Hightlights
        use{
            'nvim-treesitter/nvim-treesitter',
            event = 'CursorHold',
            run = function()
                require('nvim-treesitter.install').update({ with_sync = true })
            end,
            config = function()
                require('xinze.syntax.treesitter')
            end,
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

        -- NOTE: nvim-autopairs needs to be loaded after nvim-cmp, so that <CR> would work properly
        use({
            'windwp/nvim-autopairs',
            event = 'InsertCharPre',
            after = 'nvim-cmp',
            config = function()
                require('xinze.syntax.pairs')
            end,
        })

	    -- Format & Syntax
	    use {
            "lukas-reineke/indent-blankline.nvim",
            requires = { "nvim-treesitter/nvim-treesitter" }
        }
        require("indent_blankline").setup {
            -- for example, context is off by default, use this to turn it on
            show_current_context = true,
            show_current_context_start = true,
        }

        use {
            'numToStr/Comment.nvim', -- block commenting
            config = function()
                require("xinze.syntax.comment")
            end,
            requires = { "nvim-treesitter/nvim-treesitter" }
        }

        use {
            'kkoomen/vim-doge', -- DO(cstring) GE(neration)
            run = ':call doge#install()'
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
