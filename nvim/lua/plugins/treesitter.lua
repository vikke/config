return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		lazy = false,
		config = function()
			require("nvim-treesitter").setup()
			require("nvim-treesitter").install({
				"lua", "vimdoc", "ruby", "python", "php", "markdown", "markdown_inline",
				"bash", "javascript", "typescript", "html", "css", "mermaid", "sql",
				"slim", "yaml", "json",
			})

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local ft = args.match
					local lang = vim.treesitter.language.get_lang(ft)
					if lang and pcall(vim.treesitter.start, args.buf, lang) then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
}
