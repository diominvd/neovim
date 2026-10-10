return {
	"aznhe21/actions-preview.nvim",
	keys = {
		{
			"<leader>ca",
			function()
				require("actions-preview").code_actions()
			end,
			mode = { "n", "v" },
			desc = "Code action (preview)",
		},
	},
	config = function()
		require("actions-preview").setup({
			diff = {
				ctxlen = 3,
			},
			-- Prefer telescope, fall back to snacks if it is not loaded.
			backend = { "telescope", "snacks" },
			-- Match the other Telescope pickers (ascending list is a dropdown
			-- theme default; only the size is overridden here).
			telescope = require("telescope.themes").get_dropdown({
				layout_config = { width = 0.7, height = 0.8 },
			}),
		})
	end,
}