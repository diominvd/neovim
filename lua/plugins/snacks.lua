return {
	"folke/snacks.nvim",
	main = "snacks",
	priority = 1000,
	-- stylua: ignore
	keys = {
		{ "<leader>gz", function() Snacks.zen() end, desc = "Zen Mode" },
		{ "<leader>gr", function() Snacks.gitbrowse.open() end, desc = "Open Git in Browser" },
		{ "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
	},
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
		-- Enrich the gutter column: folds, signs and diagnostics rendered by
		-- snacks so the built-in signcolumn stays clean.
		statuscolumn = { enabled = true },
		-- Git helpers that work outside of lazygit.
		gitbrowse = { enabled = true },
		zen = { enabled = true },
		bufdelete = { enabled = true },
		rename = { enabled = true },
		-- Gracefully degrade instead of stalling on huge files.
		bigfile = {
			enabled = true,
			notify = true,
			size = 1024 * 1024, -- 1MB before degrading
			line_length = 500, -- average line length that counts as "minified"
		},
	},
}