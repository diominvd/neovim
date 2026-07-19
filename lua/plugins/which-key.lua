return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	enabled = false,
	config = function()
		require("which-key").setup({
			plugins = {
				spelling = { enabled = false },
			},
			win = {
				border = "single",
			},
		})
	end,
}
