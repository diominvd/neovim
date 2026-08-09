return {
	"folke/snacks.nvim",
	main = "snacks",
	opts = {
		-- Only the visual helpers and the terminal are enabled; the rest of snacks stays off.
		indent = { enabled = true },
		scroll = { enabled = true },
		terminal = {
			enabled = true,
			win = {
				position = "float",
				border = "single",
				row = -1,
				width = 0.9,
				height = 0.35,
			},
		},
	},
}
