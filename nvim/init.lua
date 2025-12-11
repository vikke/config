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
vim.opt.statusline = [[%F%m%h%w %<[ENC=%{&fenc!=''?&fenc:&enc}] [FMT=%{&ff}] [TYPE=%y] %=[CODE=0x%02B] [POS=%l/%L(%02v)]]
vim.opt.autoread = true

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

-- プラグイン管理
require("lazy").setup({
	-- プラグインの設定をlua/pluginsディレクトリから読み込む
	{ import = "plugins" },
}, {
	-- Lazyの設定オプション
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})

-- Global mappings.
-- (LSP 関連のキー設定は lua/plugins/lsp.lua に集約)

local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	sources = {
		{ name = 'sonicpi' },
		{ name = 'nvim_lsp' },
		-- { name = "buffer" },
		-- { name = "path" },
	},
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm { select = true },
	}),
	experimental = {
		ghost_text = true,
	},
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
	'confirm_done',
	cmp_autopairs.on_confirm_done()
)

local opt = vim.opt
opt.ai = true
opt.number = true
opt.ts = 4
opt.backup = false
opt.writebackup = false
opt.incsearch = true
opt.ignorecase = false
opt.visualbell = true
opt.shiftwidth = 4
opt.compatible = false
opt.hidden = true
opt.backspace = 'indent,eol,start'
opt.diffopt = 'filler,iwhite'
opt.foldenable = true
opt.foldmethod = 'indent'
opt.foldlevel = 3
opt.foldlevelstart = 99
opt.history = 2000
opt.updatetime = 500
opt.list = true
opt.hlsearch = false
opt.background = 'dark'
vim.cmd("colorscheme iceberg")
opt.laststatus = 3
opt.encoding = 'utf-8'
vim.scriptencoding = 'utf-8'
opt.fileencoding = 'utf-8'
opt.fileencodings = 'ucs-bom,utf-8,euc-jp,cp932'
opt.fileformats = 'unix,dos,mac'
opt.ambiwidth = 'double'

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
		{ 'n', '<leader>s', require('sonicpi.remote').stop,               default_mapping_opts },
		{ 'i', '<M-s>',     require('sonicpi.remote').stop,               default_mapping_opts },
		{ 'n', '<leader>r', require('sonicpi.remote').run_current_buffer, default_mapping_opts },
		{ 'i', '<M-r>',     require('sonicpi.remote').run_current_buffer, default_mapping_opts },
	},
	single_file = true,
})
