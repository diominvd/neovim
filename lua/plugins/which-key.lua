return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")
		wk.setup({
			plugins = {
				spelling = { enabled = false },
			},
			win = {
				border = "single",
			},
		})
		wk.add({
			{ "<leader>f", group = "Find" },
			{ "<leader>g", group = "Git" },
			{ "<leader>s", group = "Split" },
			{ "<leader>x", group = "Diagnostics" },
		})
	end,
}
