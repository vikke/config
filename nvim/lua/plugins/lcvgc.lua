return {
	{
		'vikke/lcvgc.nvim',
		event = { 'BufReadPre *.cvg', 'BufNewFile *.cvg' },
		opts = {
			port = 9876,
			log_path = '/tmp/lcvgc.log',
		},
	},
}
