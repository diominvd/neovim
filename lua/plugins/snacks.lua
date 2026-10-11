return {
	"folke/snacks.nvim",
	main = "snacks",
	priority = 1000,
	-- NOTE: keep this plugin loaded at startup (no `keys` / `cmd` / `event` /
	-- `ft`). Its modules are lazy by design — `indent`, `scroll` and `words`
	-- attach themselves on `BufReadPost` / `UIEnter` / `LspAttach` *inside*
	-- `Snacks.setup()`. Any lazy.nvim trigger here would defer `setup()` to a
	-- keypress and silently disable every module. Related keymaps live in
	-- `lua/config/keymaps.lua`.
	opts = {
		-- Indentation guides: one vertical bar per level. All guides stay gray,
		-- while the scope the cursor is in is drawn brighter — see
		-- `Whitespace` / `SnacksIndent*` in theme.lua.
		indent = {
			enabled = true,
			indent = {
				char = "│",
				-- Guide every level at once; set to `true` to guide only the
				-- scope the cursor is in.
				only_scope = false,
			},
			scope = {
				enabled = true,
				char = "│",
				underline = false,
			},
			chunk = { enabled = false },
		},
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