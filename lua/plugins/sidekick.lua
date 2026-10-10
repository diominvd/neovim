{
	"folke/sidekick.nvim",
	enabled = true,
	cmd = { "Sidekick", "SidekickOpen", "SidekickClose", "SidekickToggle" },
	keys = {
		{ "<leader>sk", "<cmd>Sidekick<cr>", desc = "Sidekick" },
		{ "<leader>sc", "<cmd>SidekickCli<cr>", desc = "Sidekick CLI" },
		{ "<leader>sn", "<cmd>SidekickNew<cr>", desc = "Sidekick New" },
	},
	opts = {
		-- CLI integrations
		cli = {
			-- opencode (your AI agent)
			opencode = {
				enabled = true,
				-- Path to opencode binary
				-- cmd = "opencode",
			},
			-- Claude Code
			claude = {
				enabled = false,
			},
			-- Codex
			codex = {
				enabled = false,
			},
			-- Gemini
			gemini = {
				enabled = false,
			},
		},
		-- Next Edit Suggestions (NES) from Copilot LSP
		nes = {
			enabled = false, -- enable if you have Copilot
		},
		-- Terminal
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