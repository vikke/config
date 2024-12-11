vim.g.python3_host_prog = "~/.pyenv/shims/python"
vim.g.lsp_log_verbose = 0
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

vim.keymap.set('n', 'fk', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'fi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'fr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'fd', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'fn', '<cmd>lua vim.lsp.buf.rename()<CR>')

local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = {
    { name = "nvim_lsp" },
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
