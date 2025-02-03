vim.g.python3_host_prog = "~/.pyenv/shims/python"
vim.g.lsp_log_verbose = 1
vim.g.lsp_log_file = vim.fn.expand('~/vim-lsp.log')
vim.g.mapleader = ','

vim.api.nvim_del_keymap('n', 'Y')
vim.keymap.set('n', '<C-I>', '<C-O>', { noremap = true })
vim.keymap.set('n', '<C-O>', '<C-I>', { noremap = true })
vim.keymap.set('n', 'j', 'gj', { noremap = true })
vim.keymap.set('n', 'k', 'gk', { noremap = true })

vim.keymap.set('n', '<C-N>', ':Neotree filesystem reveal left<CR>')

vim.opt.clipboard = "unnamedplus"
if vim.fn.has('wsl') == 1 then
  vim.g.clipboard = {
  name = "win32yank-wsl",
  copy = {
    ["+"] = "win32yank.exe -i --crlf",
    ["*"] = "win32yank.exe -i --crlf"
    },
  paste = {
    ["+"] = "win32yank.exe -o --crlf",
    ["*"] = "win32yank.exe -o --crlf"
    },
  cache_enable = 0,
  }
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		'vim-jp/vimdoc-ja',
	},
	{
		'nvim-telescope/telescope.nvim',
		dependencies =  { 'nvim-lua/plenary.nvim' },
		config = function()
			local telescope_actions = require('telescope.actions')
			local telescope_builtin = require('telescope.builtin')
			require('telescope').setup {
				defaults = {
					mappings = {
						i= {
							["<C-k>"] = telescope_actions.select_horizontal,
							["<C-o>"] = telescope_actions.select_vertical
						},
						n = {
							["<C-k>"] = telescope_actions.select_horizontal,
							["<C-o>"] = telescope_actions.select_vertical
						}
					}
				}
			}
			local map = vim.api.nvim_set_keymap
			local opts = { noremap = true, silent = true }
			local function find_files_from_current_dir()
				local current_file = vim.fn.expand('%:p')
				local current_dir = vim.fn.fnamemodify(current_file, ':h')
				telescope_builtin.find_files({cwd = current_dir})
			end
			vim.keymap.set('n', 'FF', find_files_from_current_dir, opts)
			map('n', 'ff', '<cmd>Telescope find_files<CR>', opts)
			map('n', 'FG', '<cmd>Telescope live_grep<CR>', opts)
			map('n', 'fg', '<cmd>Telescope grep_string<CR>', opts)
			map('n', 'fs', '<cmd>Telescope buffers<CR>', opts)
			map('n', 'fh', '<cmd>Telescope help_tags<CR>', opts)
		end
	},
	{
	  "nvim-telescope/telescope-frecency.nvim",
	  config = function()
	    require("telescope").load_extension "frecency"
		vim.keymap.set('n', 'fm', "<Cmd>Telescope frecency workspace=CWD<CR>", {noremap = true, silent = true})
	  end,
	},	
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		opts = {} -- this is equalent to setup({}) function
	},
	{	
		'cocopon/iceberg.vim'
	},
	{
		'tyru/current-func-info.vim'
	},
	{
		'magicmonty/sonicpi.nvim',
		config = function()
--			require('sonicpi').setup()
		end,
		dependencies = {
			'hrsh7th/nvim-cmp',
			'kyazdani42/nvim-web-devicons',
		},
		single_file = true
	},
	{
		'tpope/vim-fugitive',
	},
	--[[
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function () 
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = { "lua", "vimdoc", "ruby", "markdown", "bash", "javascript", "typescript", "html", "css", "mermaid", "sql" },
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },  
			})
		end
	},
	]]
	{
		-- solargraphで設定。ruby-lspだと、rbenvで複数version使ったときに具合が出るので。
		-- gem install solargraph
		-- gem install solargraph-rails
		--
		-- projedt_root/.solargraph.yml
		-- ---
        -- include:
        -- - "**/*.rb"
        -- exclude:
        -- - spec/**/*
        -- - test/**/*
        -- - vendor/**/*
        -- - ".bundle/**/*"
        -- require:
        -- - actioncable
        -- - actionmailer
        -- - actionpack
        -- - actionview
        -- - activejob
        -- - activemodel
        -- - activerecord
        -- - activestorage
        -- - activesupport
        -- 
        -- domains: []
        -- reporters:
        -- - rubocop
        -- - require_not_found
        -- formatter:
        --   rubocop:
        --     cops: safe
        --     except: []
        --     only: []
        --     extra_args: []
        -- require_paths: []
        -- plugins: []
        -- max_files: 5000
		"neoclide/coc.nvim",
		branch = 'release',
		build = 'npm ci',
		config = function()
			-- Some servers have issues with backup files, see #649
			vim.opt.backup = false
			vim.opt.writebackup = false

			-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
			-- delays and poor user experience
			vim.opt.updatetime = 300

			-- Always show the signcolumn, otherwise it would shift the text each time
			-- diagnostics appeared/became resolved
			vim.opt.signcolumn = "yes"

			local keyset = vim.keymap.set
			-- Autocomplete
			function _G.check_back_space()
				local col = vim.fn.col('.') - 1
				return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
			end

			-- Use Tab for trigger completion with characters ahead and navigate
			-- NOTE: There's always a completion item selected by default, you may want to enable
			-- no select by setting `"suggest.noselect": true` in your configuration file
			-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
			-- other plugins before putting this into your config
			local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
			keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
			keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

			-- Make <CR> to accept selected completion item or notify coc.nvim to format
			-- <C-g>u breaks current undo, please make your own choice
			keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

			-- Use <c-j> to trigger snippets
			keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
			-- Use <c-space> to trigger completion
			keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

			-- Use `[g` and `]g` to navigate diagnostics
			-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
			keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
			keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

			-- GoTo code navigation
			keyset("n", "gk", "<Plug>(coc-definition)", {silent = true})
			keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
			keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
			keyset("n", "gr", "<Plug>(coc-references)", {silent = true})


			-- Use K to show documentation in preview window
			function _G.show_docs()
				local cw = vim.fn.expand('<cword>')
				if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
					vim.api.nvim_command('h ' .. cw)
				elseif vim.api.nvim_eval('coc#rpc#ready()') then
					vim.fn.CocActionAsync('doHover')
				else
					vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
				end
			end
			keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})


			-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
			vim.api.nvim_create_augroup("CocGroup", {})
			vim.api.nvim_create_autocmd("CursorHold", {
				group = "CocGroup",
				command = "silent call CocActionAsync('highlight')",
				desc = "Highlight symbol under cursor on CursorHold"
			})


			-- Symbol renaming
			keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})


			-- Formatting selected code
			keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
			keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})


			-- Setup formatexpr specified filetype(s)
			vim.api.nvim_create_autocmd("FileType", {
				group = "CocGroup",
				pattern = "typescript,json",
				command = "setl formatexpr=CocAction('formatSelected')",
				desc = "Setup formatexpr specified filetype(s)."
			})

			-- Update signature help on jump placeholder
			vim.api.nvim_create_autocmd("User", {
				group = "CocGroup",
				pattern = "CocJumpPlaceholder",
				command = "call CocActionAsync('showSignatureHelp')",
				desc = "Update signature help on jump placeholder"
			})

			-- Apply codeAction to the selected region
			-- Example: `<leader>aap` for current paragraph
			local opts = {silent = true, nowait = true}
			keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
			keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

			-- Remap keys for apply code actions at the cursor position.
			keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
			-- Remap keys for apply source code actions for current file.
			keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
			-- Apply the most preferred quickfix action on the current line.
			keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

			-- Remap keys for apply refactor code actions.
			keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
			keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
			keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

			-- Run the Code Lens actions on the current line
			keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)


			-- Map function and class text objects
			-- NOTE: Requires 'textDocument.documentSymbol' support from the language server
			keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
			keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
			keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
			keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
			keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
			keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
			keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
			keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)


			-- Remap <C-f> and <C-b> to scroll float windows/popups
			---@diagnostic disable-next-line: redefined-local
			local opts = {silent = true, nowait = true, expr = true}
			keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
			keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
			keyset("i", "<C-f>",
			'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
			keyset("i", "<C-b>",
			'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
			keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
			keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)


			-- Use CTRL-S for selections ranges
			-- Requires 'textDocument/selectionRange' support of language server
			keyset("n", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
			keyset("x", "<C-s>", "<Plug>(coc-range-select)", {silent = true})


			-- Add `:Format` command to format current buffer
			vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

			-- " Add `:Fold` command to fold current buffer
			vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})

			-- Add `:OR` command for organize imports of the current buffer
			vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

			-- Add (Neo)Vim's native statusline support
			-- NOTE: Please see `:h coc-status` for integrations with external plugins that
			-- provide custom statusline: lightline.vim, vim-airline
			vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

			-- Mappings for CoCList
			-- code actions and coc stuff
			---@diagnostic disable-next-line: redefined-local
			local opts = {silent = true, nowait = true}
			-- Show all diagnostics
			keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
			-- Manage extensions
			keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
			-- Show commands
			keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
			-- Find symbol of current document
			keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
			-- Search workspace symbols
			keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
			-- Do default action for next item
			keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)
			-- Do default action for previous item
			keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
			-- Resume latest coc list
			keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)
		end
	},
})

local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	sources = {
		{ name = 'sonicpi'},
		-- { name = "buffer" },
		-- { name = "path" },
	},
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		['<C-l>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm { select = true },
	}),
	experimental = {
		ghost_text = true,
	},
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
'confirm_done',
cmp_autopairs.on_confirm_done()
)

local opt = vim.opt
opt.ai = true
opt.number = true
opt.ts=4
opt.backup = false
opt.writebackup = false
opt.incsearch = true
opt.ignorecase = false
opt.visualbell = true
opt.shiftwidth = 4
opt.compatible = false
opt.hidden = true
opt.backspace='indent,eol,start'
opt.diffopt='filler,iwhite'
opt.foldenable = true
opt.foldmethod = 'indent'
opt.foldlevel = 3
opt.foldlevelstart = 99
opt.history= 2000
opt.updatetime= 500
opt.list = true
opt.hlsearch = false
opt.background = 'dark'
vim.cmd("colorscheme iceberg")

function GetB()
	local col = vim.api.nvim_win_get_cursor(0)[2]
	local line = vim.api.nvim_get_current_line()
	local char = line:sub(col, col)
	return String2Hex(char)
end
function Nr2Hex(nr)
	return string.format("%X", nr)
end
function String2Hex(str)
	local out = ''
	for i = 1, #str do
		local char = str:sub(i, i)
		out = out .. Nr2Hex(string.byte(char))
	end
	return out
end

--[[
vim.o.statusline = "%<[%n]%m%r%h%w%[" ..
"%{luaeval('vim.bo.fileencoding ~= \"\" and vim.bo.fileencoding or vim.o.enc')}:" ..
"%{luaeval('vim.bo.fileformat')}]" ..
"%y %F%=" .. "[%{luaeval('GetB()')}]" ..
" %{cfi#format('[%s()]', 'no function')} %l,%c%V%8P"
--]]

require('sonicpi').setup({
	-- server_dir = '/var/lib/flatpak/app/net.sonic_pi.SonicPi/current/active/files/app/server',
	server_dir = '/mnt/c/Program Files/Sonic Pi/app/server',
	mappings = {
		{ 'n', '<leader>s', require('sonicpi.remote').stop, default_mapping_opts },
		{ 'i', '<M-s>', require('sonicpi.remote').stop, default_mapping_opts },
		{ 'n', '<leader>r', require('sonicpi.remote').run_current_buffer, default_mapping_opts },
		{ 'i', '<M-r>', require('sonicpi.remote').run_current_buffer, default_mapping_opts },
	},
	single_file = true,
})
