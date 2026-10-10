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
	},
}
