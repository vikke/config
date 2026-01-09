return {
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
			vim.g.mkdp_refresh_slow = 1
			vim.g.mkdp_browser = '/Applications/Comet.app/Contents/MacOS/Comet'
		end,
		ft = { "markdown" },
	},
}
