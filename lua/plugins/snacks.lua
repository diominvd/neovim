return {
	"folke/snacks.nvim",
	main = "snacks",
	opts = {
		-- Only the visual helpers, word-references and the terminal are enabled;
		-- the rest of snacks stays off.
		indent = { enabled = true },
		scroll = { enabled = true },
		-- Highlight all references of the word under the cursor (IDE-like)
		-- and navigate them with ]] / [[ / <a-n> / <a-p>.
		words = {
			enabled = true,
			notify_end = false,
		},
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
		dashboard = {
			enabled = true,
			preset = {
			-- Doesn't work for oasis mini.pick
			-- lock = true,
			-- The section between header and windows
				header = {
				{ "  Find file", icon = " ", key = "f", desc = "Find file" },
				{ "  Recently files", icon = " ", key = "r", desc = "Recent files" },
				{ "  Config", icon = " ", key = "c", desc = "Configuration" },
				{ "󰒲  Lazy", icon = "󰒲 ", key = "l", desc = "Lazy" },
				{ "  Quit", icon = " ", key = "q", desc = "Quit" },
			},
			-- The main body of the dashboard
			buttons = {
				{ "  Find file", icon = " ", key = "f", action = ":Telescope find_files" },
				{ "  Recent files", icon = " ", key = "r", action = ":Telescope oldfiles" },
				{ "  Config", icon = " ", key = "c", action = ":Lazy" },
				{ "  Quit", icon = " ", key = "q", action = "qa" },
			},
			},
		},
		statuscolumn = {
			enabled = true,
		},
		gitbrowse = {
			enabled = true,
		},
		zen = {
			enabled = true,
		},
		bufdelete = {
			enabled = true,
		},
		rename = {
			enabled = true,
		},
		bigfile = {
			enabled = true,
			-- large file preview
			opts = {
				wrap = true,
				signcolumn = false,
				cursorline = false,
			},
		},
	},
}
