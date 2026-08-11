return {
	"m4xshen/hardtime.nvim",
	lazy = false,
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	opts = {
		-- Блокировать стрелки не только в normal/insert, но и в visual/terminal.
		disabled_keys = {
			["<Up>"] = { "", "i", "x", "t" },
			["<Down>"] = { "", "i", "x", "t" },
			["<Left>"] = { "", "i", "x", "t" },
			["<Right>"] = { "", "i", "x", "t" },
		},
	},
}
