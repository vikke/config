return {
	{
		'neovim/nvim-lspconfig',
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			vim.lsp.config('ruby_lsp', {
				cmd = { 'ruby-lsp' },
				filetypes = { 'ruby', 'eruby' },
				root_markers = { 'Gemfile', '.git' },
				capabilities = capabilities,
			})

			vim.lsp.config('ts_ls', {
				cmd = { 'typescript-language-server', '--stdio' },
				filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
				root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
				capabilities = capabilities,
			})

			vim.lsp.config('lua_ls', {
				cmd = { 'lua-language-server' },
				filetypes = { 'lua' },
				root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
				settings = {
					Lua = {
						diagnostics = {
							globals = { 'vim' }
						}
					}
				},
				capabilities = capabilities,
			})

			vim.lsp.config('bashls', {
				cmd = { 'bash-language-server', 'start' },
				filetypes = { 'sh', 'bash' },
				root_markers = { '.git' },
				capabilities = capabilities,
			})

			vim.lsp.config('pyright', {
				cmd = { 'pyright-langserver', '--stdio' },
				filetypes = { 'python' },
				root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', 'pyrightconfig.json', '.git' },
				capabilities = capabilities,
			})

			vim.lsp.enable({ 'ruby_lsp', 'ts_ls', 'lua_ls', 'bashls', 'pyright' })
		end
	},
	{
		'hrsh7th/cmp-nvim-lsp',
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
