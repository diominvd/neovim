return {
	"folke/trouble.nvim",
	cmd = { "Trouble" },
	keys = {
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
		{ "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
		{ "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols / outline (Trouble)" },
		{ "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
	},
	config = function()
		require("trouble").setup({
			border = "single",
		})
	end,
}
