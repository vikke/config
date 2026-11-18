return {
  'vikke/lcvgc.nvim',
  event = { 'BufReadPre *.cvg', 'BufNewFile *.cvg' },
  opts = {
    port = 5555,

    log_path = '/tmp/lcvgc.log',
    debounce = 150,  -- Delay before showing completions (ms). Default: 150
  },
}
