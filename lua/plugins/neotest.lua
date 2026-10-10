{
	"nvim-neotest/neotest",
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
		{ "<leader>tr", "<cmd>lua require('neotest').run.run()<cr>", desc = "Run nearest test" },
		{ "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "Run file tests" },
		{ "<leader>td", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", desc = "Debug nearest test" },
		{ "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<cr>", desc = "Test summary" },
		{ "<leader>to", "<cmd>lua require('neotest').output.open({ enter = true })<cr>", desc = "Test output" },
	},
}