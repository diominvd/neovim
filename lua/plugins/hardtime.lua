return {
	"m4xshen/hardtime.nvim",
	lazy = false,
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	opts = {
		-- Restrict arrow keys not only in normal/insert but also in visual/terminal.
		disabled_keys = {
			["<Up>"] = { "", "i", "x", "t" },
			["<Down>"] = { "", "i", "x", "t" },
			["<Left>"] = { "", "i", "x", "t" },
			["<Right>"] = { "", "i", "x", "t" },
		},
	},
}
