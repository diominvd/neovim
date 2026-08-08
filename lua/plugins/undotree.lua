return {
	"mbbill/undotree",
	cmd = { "UndotreeToggle" },
	keys = {
		-- `u` is also a prefix of `<leader>uF` (toggle format on save), so the
		-- direct mapping lives at `uu` and `u` stays a clean which-key group.
		{ "<leader>uu", "<cmd>UndotreeToggle<CR>", desc = "Undo tree" },
	},
}
