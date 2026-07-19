return {
	{
		'hrsh7th/cmp-nvim-lsp',
		event = { 'BufReadPre', 'BufNewFile' },
		keys = {
			{ '<space>e', function() vim.diagnostic.open_float() end },
			{ '[d',       vim.diagnostic.goto_prev },
			{ ']d',       vim.diagnostic.goto_next },
			{ '<space>q', vim.diagnostic.setloclist },
		},
		dependencies = {
			'hrsh7th/nvim-cmp',
		},
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			local telescope_custom = require('plugins.telescope')

			vim.api.nvim_create_autocmd('LspAttach', {
				callback = function(ev)
					local opts = { buffer = ev.buf }

					vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
					vim.keymap.set('n', 'gd', telescope_custom.lsp_definitions_pretty, opts)
					vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
					vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
					vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
					vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set('n', '<space>wl', function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
					vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
					vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
					vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, opts)
					vim.keymap.set('n', '<space>f', function()
						vim.lsp.buf.format { async = true }
					end, opts)
				end,
			})

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

			vim.lsp.config('marksman', {
				cmd = { 'marksman', 'server' },
				filetypes = { 'markdown' },
				root_markers = { '.marksman.toml', '.git' },
				single_file_support = true,
				capabilities = capabilities,
			})

			vim.lsp.config('kotlin_lsp', {
				cmd = { 'kotlin-lsp', '--stdio' },
				filetypes = { 'kotlin' },
				root_markers = { 'build.gradle', 'build.gradle.kts', 'pom.xml', '.git' },
				single_file_support = true,
				capabilities = capabilities,
			})

			vim.lsp.config('lcvgc', {
				cmd = { 'lcvgc-lsp' },
				filetypes = { 'cvg' },
				root_markers = { '.git' },
				capabilities = capabilities,
			})

			vim.lsp.enable({ 'ruby_lsp', 'ts_ls', 'lua_ls', 'bashls', 'pyright', 'marksman', 'kotlin_lsp' })
		end,
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
