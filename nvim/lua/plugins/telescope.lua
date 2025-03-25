return {
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
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
			local function find_files_from_current_dir()
				telescope_builtin.find_files({cwd = vim.fn.expand("%:p:h")})
			end

			local opts = { noremap = true, silent = true }
			vim.keymap.set('n', 'FF', find_files_from_current_dir, opts)
			vim.keymap.set('n', 'ff', telescope_builtin.find_files, opts)
			vim.keymap.set('n', 'FG', telescope_builtin.live_grep, opts)
			vim.keymap.set('n', 'fg', telescope_builtin.live_grep, opts)
			vim.keymap.set('n', 'fb', telescope_builtin.buffers, opts)
			vim.keymap.set('n', 'fh', telescope_builtin.help_tags, opts)
			vim.keymap.set('n', 'fc', find_files_from_current_dir, opts)
		end,
	},
	{
		"nvim-telescope/telescope-frecency.nvim",
		config = function()
			require("telescope").load_extension "frecency"
			vim.keymap.set('n', 'fm', "<Cmd>Telescope frecency workspace=CWD<CR>", {noremap = true, silent = true})
		end,
		dependencies = { "kkharji/sqlite.lua" }
	},
}
