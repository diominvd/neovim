{
	"MagicDuck/grug-far.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		{ "<leader>fr", "<cmd>GrugFar<cr>", desc = "Search and replace" },
	},
	-- stylua: ignore
	cond = function()
		return vim.fn.executable("rg") == 1
	end,
}