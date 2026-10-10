return {
	"folke/lazydev.nvim",
	ft = "lua",
	cmd = "LazyDev",
	opts = {
		library = {
			-- Load luvit types when `vim.uv` shows up.
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			-- Pre-load types from plugins this config relies on, so
			-- completions work even before their modules are required.
			"lazy.nvim",
			"snacks.nvim",
			"nvim-lspconfig",
			"blink.cmp",
		},
	},
}