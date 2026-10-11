return {
	"nvim-neotest/neotest",
	cmd = { "Neotest" },
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-neotest/neotest-python",
		"marilari88/neotest-vitest",
		"nvim-neotest/neotest-plenary",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-python")({
					dap = { justMyCode = false },
				}),
				require("neotest-vitest")({
					filter_dir = function(name, rel_path, root)
						return not string.match(rel_path, "node_modules")
					end,
				}),
			},
			status = { virtual_text = true },
			output = { open_on_run = true },
			quickfix = {
				open = function()
					if vim.fn.exists(":Trouble") == 2 then
						require("trouble").open({ mode = "quickfix", focus = false })
					else
						vim.cmd("copen")
					end
				end,
			},
		})
	end,
	keys = {
		{ "<leader>tr", "<cmd>Neotest run nearest<cr>", desc = "Run nearest test" },
		{ "<leader>tf", "<cmd>Neotest run file<cr>", desc = "Run file tests" },
		{ "<leader>td", "<cmd>Neotest run dap<cr>", desc = "Debug nearest test" },
		{ "<leader>ts", "<cmd>Neotest summary<cr>", desc = "Test summary" },
		{ "<leader>to", "<cmd>Neotest output<cr>", desc = "Test output" },
	},
}