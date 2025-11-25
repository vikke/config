-- In your lazy.nvim configuration file (e.g., init.lua or plugins/dap.lua)
return {
	"mfussenegger/nvim-dap",
	dependencies = {
		-- Language-specific debug adapter client (example for Python)
		"mfussenegger/nvim-dap-python",
		-- UI enhancements (optional)
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio", -- Required dependency for nvim-dap-ui
		"nvim-telescope/telescope-dap.nvim",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- Basic DAP configuration
		dap.set_log_level("TRACE") -- Optional: for debugging DAP itself

		-- Docker Container Debug Adapters Configuration
		-- Python debugpy adapter (for Docker container)
		-- 方法1: 直接サーバーに接続
		dap.adapters.python_docker = {
			type = "server",
			host = "127.0.0.1", -- Docker container mapped port
			port = 5678, -- debugpy default port
			options = {
				source_filetype = "python",
			}
		}

		-- 方法2: debugpy-adapterを使用（別の方法）
		dap.adapters.debugpy = {
			type = "executable",
			command = "python",
			args = { "-m", "debugpy.adapter" },
			options = {
				source_filetype = "python",
			}
		}

		-- Node.js adapter (for Docker container)
		dap.adapters.node2_docker = {
			type = "server",
			host = "localhost",
			port = 9229, -- Node.js default debug port
		}

		-- Configuration for debugging Python in Docker
		dap.configurations.python = dap.configurations.python or {}

		-- 設定1: 直接サーバーに接続
		table.insert(dap.configurations.python, {
			type = "python_docker",
			request = "attach",
			name = "Docker: Attach to Python (Direct)",
			connect = {
				host = "127.0.0.1",
				port = 5678,
			},
			pathMappings = {
				{
					localRoot = "${workspaceFolder}",
					remoteRoot = "/app",
				},
			},
			justMyCode = false,
		})

		-- 設定2: debugpy adapterを使用
		table.insert(dap.configurations.python, {
			type = "debugpy",
			request = "attach",
			name = "Docker: Attach via debugpy adapter",
			connect = {
				host = "127.0.0.1",
				port = 5678,
			},
			pathMappings = {
				{
					localRoot = "${workspaceFolder}",
					remoteRoot = "/app",
				},
			},
			justMyCode = false,
		})

		-- Configuration for debugging Node.js in Docker
		dap.configurations.javascript = dap.configurations.javascript or {}
		table.insert(dap.configurations.javascript, {
			type = "node2_docker",
			request = "attach",
			name = "Docker: Attach to Node",
			address = "localhost",
			port = 9229,
			localRoot = "${workspaceFolder}",
			remoteRoot = "/app", -- Adjust to your container's working directory
			protocol = "inspector",
			skipFiles = { "<node_internals>/**" },
		})

		-- TypeScript uses the same configuration as JavaScript
		dap.configurations.typescript = dap.configurations.javascript

		-- UI configuration (if using nvim-dap-ui)
		dapui.setup({
			icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
			layouts = {
				{
					elements = {
						{ id = "scopes",      size = 0.25 },
						{ id = "breakpoints", size = 0.25 },
						{ id = "stacks",      size = 0.25 },
						{ id = "watches",     size = 0.25 },
					},
					size = 40,
					position = "right",
				},
				{
					elements = {
						{ id = "repl",    size = 0.5 },
						{ id = "console", size = 0.5 },
					},
					size = 0.25,
					position = "bottom",
				},
			},
		})

		-- Keymaps (example)
		vim.keymap.set("n", "<leader>dt", dapui.toggle, { desc = "Toggle DAP UI" })
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
		vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "Step Over" })
		vim.keymap.set("n", "<leader>ds", dap.step_into, { desc = "Step Into" })
		vim.keymap.set("n", "<leader>df", dap.step_out, { desc = "Step Out" })

		-- DAP UI内でのキーマップ（Scratchバッファ用）
		local function setup_dap_ui_keymaps()
			vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
				pattern = "*",
				callback = function()
					local buftype = vim.bo.buftype
					local filetype = vim.bo.filetype
					-- DAP UIのバッファ（通常はnofileやscratchタイプ）でのみ設定
					if buftype == "nofile" and (filetype == "dap-repl" or filetype == "dapui_scopes" or filetype == "dapui_breakpoints" or filetype == "dapui_stacks" or filetype == "dapui_watches" or filetype == "dapui_console") then
						vim.keymap.set("n", "b", dap.toggle_breakpoint, { buffer = true, desc = "Toggle Breakpoint" })
						vim.keymap.set("n", "c", dap.continue, { buffer = true, desc = "Continue" })
						vim.keymap.set("n", "n", dap.step_over, { buffer = true, desc = "Step Over" })
						vim.keymap.set("n", "s", dap.step_into, { buffer = true, desc = "Step Into" })
						vim.keymap.set("n", "f", dap.step_out, { buffer = true, desc = "Step Out" })
					end
				end,
			})
		end
		setup_dap_ui_keymaps()
	end,
}
