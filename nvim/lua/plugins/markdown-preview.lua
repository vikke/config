return {
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
			vim.g.mkdp_refresh_slow = 1

			-- カスタムブラウザ関数を定義
			vim.cmd([[
function! OpenMarkdownPreview(url)
    if has('wsl')
        silent! execute '!/usr/bin/wslview ' . shellescape(a:url) . ' &'
    elseif has('mac')
        silent! execute '!open -a "/Applications/Comet.app" ' . shellescape(a:url)
    endif
endfunction
]])
			vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
		end,
		ft = { "markdown" },
	},
}
