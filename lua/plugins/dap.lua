{
	"mfussenegger/nvim-dap",
	enabled = true,
	desc = "Debugging support. Requires language specific adapters to be configured.",
	cmd = { "DapContinue", "DapToggleBreakpoint", "DapStepOver", "DapStepInto", "DapStepOut" },
	keys = {
		{ "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle breakpoint" },
		{ "<leader>dc", "<cmd>DapContinue<cr>", desc = "Continue/start debug" },
		{ "<leader>dso", "<cmd>DapStepOver<cr>", desc = "Step over" },
		{ "<leader>dsi", "<cmd>DapStepInto<cr>", desc = "Step into" },
		{ "<leader>dso", "<cmd>DapStepOut<cr>", desc = "Step out" },
	},
	condition = function()
		return vim.fn.executable("nvim-dap") == 1
	end,
	dependencies = {
		-- UI for debugger
		{
			"rcarriga/nvim-dap-ui",
			enabled = true,
			keys = {
				{ "<leader>dui", "<cmd>DapUIToggle<cr>", desc = "Debug UI" },
				{ "<leader>deb", "<cmd>DapUIBreakpoints<cr>", desc = "Breakpoints" },
				{ "<leader>dev", "<cmd>DapUIEval<cr>", desc = "Eval" },
			},
			opts = {
				layouts = {
					{
						elements = {
							"scopes",
							"breakpoints",
							"stacks",
							"watches",
						},
						position = "left",
						size = 40,
					},
					{
						elements = {
							"repl",
							"console",
						},
						position = "bottom",
						size = 10,
					},
				},
			},
		},
		-- Virtual text for dap
		{
			"theHamsta/nvim-dap-virtual-text",
			enabled = true,
			opts = {},
		},
		-- Mason ensures adapters are installed
		{
			"jay-babu/mason-nvim-dap.nvim",
			enabled = true,
			dependencies = { "williamboman/mason.nvim" },
			opts = {
				ensure_installed = {
					"python", -- debugpy
					"node2", -- JS/TS debugging
				},
				automatic_installation = true,
			},
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- DAP config for Python (debugpy)
		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Debug",
				program = "${file}",
				pythonPath = function()
					return vim.fn.system({ "which", "python3" }):gsub("%s+$", "")
				end,
			},
		}

		-- DAP config for JavaScript/TypeScript (node2)
		dap.configurations.javascript = {
			{
				type = "node2",
				request = "launch",
				name = "Debug",
				program = "${file}",
				-- automatically resolves `js` and `mjs` filetypes
				-- to use `node` instead of `node2`
				runtimeExecutable = "node",
			},
		}
		dap.configurations.typescript = dap.configurations.javascript

		-- DAP UI setup
		dapui.setup({
			layouts = {
				{
					elements = {
						"scopes",
						"breakpoints",
						"stacks",
						"watches",
					},
					position = "left",
					size = 40,
				},
				{
					elements = {
						"repl",
						"console",
					},
					position = "bottom",
					size = 10,
				},
			},
		})

		-- Auto open/close UI
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end
	end,
}