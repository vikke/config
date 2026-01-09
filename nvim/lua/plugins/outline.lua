return {
	"hedyhli/outline.nvim",
	lazy = true,
	cmd = { "Outline", "OutlineOpen" },
	keys = {
		{ "<C-a>", "<cmd>Outline<CR>", desc = "Toggle Outline" },
	},
	opts = {
		symbol_folding = {
			-- false にすると起動時に全て展開された状態になる
			autofold_depth = false,
			auto_unfold = {
				hovered = true,
				only = true,
			},
		},
		symbols = {
			filter = {
				"Class",
				"Struct",
				"Interface",
				"Enum",
				"Constructor",
				"Method",
				"Function",
				"Field",
				"Property",
				"Constant",
			},
			icons = {
				Class       = { icon = "[Cl]" },
				Constructor = { icon = "[Co]" },
				Interface   = { icon = "[In]" },
				Struct      = { icon = "[St]" },
				Enum        = { icon = "[En]" },
				Method      = { icon = "[Mt]" },
				Function    = { icon = "[Fu]" },
				Field       = { icon = "[v]" },
				Variable    = { icon = "[Va]" },
				Property    = { icon = "[v]" },
				Constant    = { icon = "[co]" },
			},
		},
	},
}
