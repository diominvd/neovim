return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewFileHistory" },
	config = function()
		require("diffview").setup({})
	end,
	keys = {
		{ "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Diff view (working tree)" },
		{ "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "Diff view (file history)" },
	},
}