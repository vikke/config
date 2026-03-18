return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  config = function()
    require("claudecode").setup({
      terminal = {
        snacks_win_opts = {
          wo = {
            listchars = "extends:>,tab:  ",
            fillchars = "eob: ,lastline:>",
          },
        },
      },
})
end,
keys = {
	{ "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
	{ "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
	{ "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
  },
}
