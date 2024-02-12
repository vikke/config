vim.g.python3_host_prog = "~/.pyenv/shims/python"
vim.g.lsp_log_verbose = 0
vim.g.lsp_log_file = vim.fn.expand('~/vim-lsp.log')

vim.api.nvim_del_keymap('n', 'Y')
vim.keymap.set('n', '<C-I>', '<C-O>', { noremap = true })
vim.keymap.set('n', '<C-O>', '<C-I>', { noremap = true })
vim.keymap.set('n', 'j', 'gj', { noremap = true })
vim.keymap.set('n', 'k', 'gk', { noremap = true })

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
		'neovim/nvim-lspconfig',
		dependencies = {
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-nvim-lsp'},
		},
	},
	{
		'nvim-telescope/telescope.nvim',
		dependencies =  { 'nvim-lua/plenary.nvim' }
	},
	{
	  "nvim-telescope/telescope-frecency.nvim",
	  config = function()
	    require("telescope").load_extension "frecency"
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
})

require('mason').setup()
require('mason-lspconfig').setup_handlers({ function(server)
	local opt = {
		capabilities = require('cmp_nvim_lsp').default_capabilities(
			vim.lsp.protocol.make_client_capabilities()
		)	
	}
	require('lspconfig')[server].setup(opt)
end})

--[[
nnoremap <silent> fd :LspDefinition<CR>
nnoremap <silent> fi :LspImplementation<CR>
nnoremap <silent> fr :LspReferences<CR>
nnoremap <silent> fh :LspHover<CR>
nnoremap <silent> fk :LspPeekDefinition<CR>
--]]
vim.keymap.set('n', 'fk', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'fi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'fr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'fd', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'fn', '<cmd>lua vim.lsp.buf.rename()<CR>')

local builtin = require('telescope.builtin')
vim.keymap.set('n', 'ff', builtin.find_files, {})
vim.keymap.set('n', 'FG', builtin.live_grep, {})
vim.keymap.set('n', 'fg', builtin.grep_string, {})
vim.keymap.set('n', 'fs', builtin.buffers, {})
vim.keymap.set('n', 'fh', builtin.help_tags, {})
vim.keymap.set('n', 'fm', "<Cmd>Telescope frecency workspace=CWD<CR>")

local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = {
    { name = "nvim_lsp" },
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

--[[
local nvim_lsp = require('lspconfig')
local handlers = {
	["textDocument/publishDiagnostics"] = vim.lsp.with(
		vim.lsp.diagnostic.on_publish_diagnostics, {
			virtual_text = true
		}
	)
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
nvim_lsp.solargraph.setup {
	cmd = {
		"solargraph",
		"stdio"
	},
	filetypes = {
		"ruby"
	},
	flags = {
		debounce_text_changes = 150
	},
	-- on_attach = on_attach,
	root_dir = nvim_lsp.util.root_pattern("Gemfile", ".git", "."),
	capabilities = capabilities,
	handlers = handlers,
	settings = {
		solargraph = {
			autoformat = true,
			completion = true,
			diagnostic = true,
			folding = true,
			references = true,
			rename = true,
			symbols = true
		}
	}
}
--]]

-- If you want insert `(` after select function or method item
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
opt.foldmethod = 'marker'
opt.foldlevel = 3
opt.foldlevelstart = 99
opt.history= 2000
opt.updatetime= 500
opt.list = true
opt.hlsearch = false
opt.background = 'dark'
vim.cmd("colorscheme iceberg")
-- opt.listchars = 'trail:\ ,tab:\ \ ,'

function GetB()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local line = vim.api.nvim_get_current_line()
    local char = line:sub(col, col)
    -- 注意: Neovim APIではエンコーディングの変換が直接サポートされていません。
    -- 必要に応じてLuaでエンコーディング変換を実装するか、外部ライブラリを利用してください。
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
--
