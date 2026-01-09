return {
	{
		'stevearc/aerial.nvim',
		enabled = false,  -- 一時的に無効化
		keys = {
			{ "<C-a>", "<cmd>AerialToggle!<CR>", desc = "Toggle Aerial" },
			{ "<C-l>", function() require("aerial").focus() end, desc = "Focus Aerial" },
		},
		opts = {
			autojump = true,
			filter_kind = { "Class", "Struct", "Interface", "Enum", "Constructor", "Method", "Function", "Field", "Property", "Constant" },
			icons = {
				Class = "[Cl]",
				Constructor = "[Co]",
				Interface = "[In]",
				Struct = "[St]",
				Enum = "[En]",
				Method = "[Mt]",
				Function = "[Fu]",
				Field = "[v]",
				Variable = "[Va]",
				Property = "[v]",
				Constant = "[co]",
			},
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	}
}
