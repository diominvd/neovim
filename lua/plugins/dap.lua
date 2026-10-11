return {
	"mfussenegger/nvim-dap",
	enabled = true,
	desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",
	cmd = {
		"DapContinue",
		"DapToggleBreakpoint",
		"DapStepOver",
		"DapStepInto",
		"DapStepOut",
		"DapTerminate",
		"DapRestart",
		"DapPause",
		"DapToggleRepl",
	},
	-- stylua: ignore
	keys = {
		{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
		{ "<leader>dc", function() require("dap").continue() end, desc = "Run / Continue" },
		{ "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
		{ "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
		{ "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
		{ "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
		{ "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
		{ "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
	},
	config = function()
		local dap = require("dap")

		-- DAP configuration for Python (debugpy, installed via Mason)
		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Debug file",
				program = "${file}",
				pythonPath = function()
					return vim.fn.system({ "which", "python3" }):gsub("%s+$", "")
				end,
			},
		}

		-- DAP configuration for JavaScript / TypeScript (node2)
		dap.configurations.javascript = {
			{
				type = "node2",
				request = "launch",
				name = "Debug file",
				program = "${file}",
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
				protocol = "inspector",
				skipFiles = { "<node_internals>/**" },
			},
		}
		dap.configurations.typescript = dap.configurations.javascript
		dap.configurations.typescriptreact = dap.configurations.javascript
	end,
	dependencies = {
		-- Debugger UI (console, scopes, watch variables, stacks, breakpoints)
		{
			"rcarriga/nvim-dap-ui",
			enabled = true,
			-- stylua: ignore
			keys = {
				{ "<leader>du", function() require("dapui").toggle() end, desc = "Debug Sidebar" },
				{ "<leader>de", function() require("dapui").eval() end, mode = { "n", "v" }, desc = "Eval" },
			},
			opts = {
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.25 },
							{ id = "breakpoints", size = 0.25 },
							{ id = "stacks", size = 0.25 },
							{ id = "watches", size = 0.25 },
						},
						size = 40,
						position = "left",
					},
					{
						elements = {
							"repl",
							"console",
						},
						size = 10,
						position = "bottom",
					},
				},
			},
			config = function(_, opts)
				local dap = require("dap")
				local dapui = require("dapui")

				dapui.setup(opts)

				-- Open the sidebar when a session starts, close it when it ends.
				-- Guarded so closing the sidebar manually is not overridden.
				dap.listeners.after.event_initialized["dapui_config"] = dapui.open
				dap.listeners.before.event_terminated["dapui_config"] = dapui.close
				dap.listeners.before.event_exited["dapui_config"] = dapui.close
			end,
		},
		-- Show variable values inline as virtual text while debugging.
		{
			"theHamsta/nvim-dap-virtual-text",
			enabled = true,
			opts = {},
		},
		-- Install/ensure language debug adapters through Mason.
		{
			"jay-babu/mason-nvim-dap.nvim",
			enabled = true,
			dependencies = { "williamboman/mason.nvim" },
			opts = {
				ensure_installed = {
					"python", -- debugpy
					"node2", -- js-debug for JS/TS
				},
				automatic_installation = true,
			},
		},
	},
}