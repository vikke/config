return {
	{
		'stevearc/aerial.nvim',
		keys = {
			{ "<C-a>", "<cmd>AerialToggle!<CR>", desc = "Toggle Aerial" },
		},
		opts = function()
			return {
				-- アウトライン側でカーソル移動時に本体へ自動ジャンプ
				autojump = true,
				-- シンボルを名前順（A→Z）に並べ替える
				post_add_all_symbols = function(_, items)
					local function sort_children(list)
						table.sort(list, function(a, b)
							return a.name:lower() < b.name:lower()
						end)
						for _, child in ipairs(list) do
							if child.children and #child.children > 0 then
								sort_children(child.children)
							end
						end
					end
					sort_children(items)
					return items
				end,
				filter_kind = { "Class", "Struct", "Interface", "Enum", "Constructor", "Method", "Function", "Field", "Property", "Constant" },
				-- Nerd Font利用を強制（自動判定で外れるケースを防ぐ）
				-- nerd_font = true,
				-- Aerialでlspkindのアイコンを使う（lspkindが無い場合はデフォルト）
				-- icons = ok and lspkind.symbol_map or {},
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
				}
			}
		end,
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	}
}
