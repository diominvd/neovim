return {
	"folke/todo-comments.nvim",
	event = { "BufReadPost", "BufNewFile" },
	keys = {
		-- TodoTelescope is defined by todo-comments and wraps the lazy-loaded
		-- Telescope extension, keeping Telescope cold until first use.
		{ "<leader>ft", "<cmd>TodoTelescope<CR>", desc = "Find TODOs / FIXMEs" },
	},
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("todo-comments").setup({
			signs = false,
			highlight = {
				keyword = "fg",
				after = "",
			},
		})
	end,
}
