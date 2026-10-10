{
	"nickjvandyke/opencode.nvim",
	enabled = true,
	cmd = { "Opencode", "OpencodeNew", "OpencodeOpen", "OpencodeClose", "OpencodeFocus", "OpencodeToggle", "OpencodeAsk", "OpencodeSend" },
	keys = {
		{ "<leader>oa", "<cmd>OpencodeAsk<cr>", desc = "Opencode Ask" },
		{ "<leader>os", "<cmd>OpencodeSend<cr>", mode = "v", desc = "Opencode Send Selection" },
		{ "<leader>ot", "<cmd>OpencodeToggle<cr>", desc = "Opencode Toggle" },
		{ "<leader>on", "<cmd>OpencodeNew<cr>", desc = "Opencode New Session" },
	},
	config = function()
		require("opencode").setup({
			-- opencode server
			server = {
				-- Path to opencode binary (auto-detected if in PATH)
				-- bin = "opencode",
			},
			-- Buffer context sent with prompts
			context = {
				-- Include current buffer content
				current_buffer = true,
				-- Include visible buffers
				visible_buffers = true,
				-- Include diagnostics
				diagnostics = true,
				-- Include selection
				selection = true,
			},
			-- UI
			ui = {
				-- Window type: "float" | "split" | "vsplit"
				window = "float",
				-- Border style
				border = "single",
				-- Relative position
				relative = "editor",
				-- Size
				width = 0.8,
				height = 0.6,
			},
		})
	end,
}