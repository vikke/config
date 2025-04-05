return {
	{
		-- [[
		-- https://neovim.io/doc/user/lsp.html#lsp-api
		-- https://coralpink.github.io/commentary/neovim/lsp/nvim-lspconfig.html
		-- https://alpacat.com/posts/nvim-lspconfig-key-mappings#%E3%81%8A%E3%81%99%E3%81%99%E3%82%81%E3%
		-- ]]
		'neovim/nvim-lspconfig',
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.ruby_lsp.setup {

			}
			lspconfig.ts_ls.setup {

			}
			lspconfig.lua_ls.setup {

			}
			lspconfig.bashls.setup {

			}
		end
	},
	{
		'hrsh7th/cmp-nvim-lsp',
		config = function()
			require('cmp_nvim_lsp').default_capabilities()
		end,
		dependencies = {
			'hrsh7th/nvim-cmp',
		}
	},
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		event = "VeryLazy", -- 起動後に読み込む（任意）
		config = function()
			require("lsp_lines").setup()
			-- 通常の virtual_text をオフ、virtual_lines をオンにする
			vim.diagnostic.config({
				virtual_text = false,
				virtual_lines = true,
			})
		end,
	},
}
