return {
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = true },
				panel = { enabled = false },
			})
		end,
	},
}
