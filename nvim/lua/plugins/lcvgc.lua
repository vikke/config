-- lcvgc.nvim 開発モード判定
-- 環境変数 LSP_DEV_MODE=TRUE, LSP_DEV_PATH=<path> で開発用ローカルパスを使用
local function dev_config()
	local is_dev = vim.env.LSP_DEV_MODE == 'TRUE'
	return {
		dev = is_dev,
		dir = is_dev and vim.env.LSP_DEV_PATH or nil,
	}
end

local dev = dev_config()

return {
	{
		'vikke/lcvgc.nvim',
		dev = dev.dev,
		dir = dev.dir,
		event = { 'BufReadPre *.cvg', 'BufNewFile *.cvg' },
		opts = {
			port = 5555,
			log_path = '/tmp/lcvgc.log',
			debounce = 150,
		},
	},
}
