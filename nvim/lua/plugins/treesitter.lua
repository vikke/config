return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function () 
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = { "lua", "vimdoc", "ruby", "python", "php", "markdown", "bash", "javascript", "typescript", "html", "css", "mermaid", "sql", "slim", "yaml", "json" },
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },  
			})
		end
	},
}
