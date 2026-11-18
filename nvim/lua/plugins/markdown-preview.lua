return {
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		-- mkdp#util#install() は非同期 job のため lazy.nvim のビルドが先に完了扱いとなり
		-- サーバーバイナリのダウンロードが打ち切られる。install.sh を同期実行して確実に取得する。
		build = "cd app && ./install.sh",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
			vim.g.mkdp_refresh_slow = 1

			-- プレビューの表示幅などを調整したカスタム CSS。
			-- mkdp はこの変数で /_static/markdown.css を丸ごと差し替えるため、
			-- 上流の markdown.css のコピーに追記した物を指定している。
			vim.g.mkdp_markdown_css = vim.fn.stdpath("config") .. "/css/markdown-preview.css"

			-- カスタムブラウザ関数を定義
			vim.cmd([[
function! OpenMarkdownPreview(url)
    if has('wsl')
        silent! execute '!/usr/bin/wslview ' . shellescape(a:url) . ' &'
    elseif has('mac')
        silent! execute '!open -a "/Applications/Google Chrome.app" ' . shellescape(a:url)
    endif
endfunction
]])
			vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
		end,
		ft = { "markdown" },
	},
}
