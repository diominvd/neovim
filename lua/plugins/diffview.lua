{
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewFileHistory" },
	config = function()
		require("diffview").setup({})
	end,
	keys = {
		{ "<leader>do", "<cmd>DiffviewOpen<cr>", desc = "Open diff view" },
		{ "<leader>dh", "<cmd>DiffviewFileHistory<cr>", desc = "File history" },
	},
}