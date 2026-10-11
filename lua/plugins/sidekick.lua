return {
	"folke/sidekick.nvim",
	enabled = true,
	cmd = { "Sidekick" },
	ft = { "lua", "python", "javascript", "typescript", "typescriptreact", "javascriptreact" },
	-- stylua: ignore
	keys = {
		-- Universal focus / toggle, works in normal, insert, terminal and visual mode.
		{ "<c-.>", function() require("sidekick.cli").focus() end, mode = { "n", "i", "t", "x" }, desc = "Sidekick Focus" },
		{ "<leader>aa", function() require("sidekick.cli").toggle() end, desc = "Sidekick Toggle CLI" },
		{ "<leader>as", function() require("sidekick.cli").select() end, desc = "Select CLI Tool" },
		{ "<leader>at", function() require("sidekick.cli").send({ msg = "{this}" }) end, mode = { "n", "x" }, desc = "Send This" },
		{ "<leader>av", function() require("sidekick.cli").send({ msg = "{selection}" }) end, mode = "x", desc = "Send Selection" },
		{ "<leader>af", function() require("sidekick.cli").send({ msg = "{file}" }) end, desc = "Send File" },
		{ "<leader>ap", function() require("sidekick.cli").prompt() end, mode = { "n", "x" }, desc = "Select Prompt" },
		-- The AI agent used outside of the editor: launched directly in a terminal.
		{ "<leader>ao", function() require("sidekick.cli").toggle({ name = "opencode", focus = true }) end, desc = "Sidekick OpenCode" },
	},
	opts = {
		cli = {
			-- The AI agent available from the terminal.
			-- Requires the `opencode` binary in PATH; detected automatically.
			opencode = {
				enabled = true,
				cmd = { "opencode" },
			},
		},
		-- Next Edit Suggestions come from the Copilot LSP server, which is not
		-- configured here. Kept off so sidekick never tries to run it.
		nes = {
			enabled = false,
		},
		terminal = {
			enabled = true,
			win = {
				border = "single",
				width = 0.8,
				height = 0.6,
			},
		},
	},
}