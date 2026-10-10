return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	-- Keep the plugin lazy-loaded (keys only) but let :Mason and the tool
	-- installer commands work directly without loading it first.
	cmd = { "Mason", "MasonToolsInstall", "MasonToolsUpdate", "MasonToolsClean" },
	keys = {
		-- Install every LSP server / formatter listed in config/languages.lua.
		{ "<leader>Mi", "<cmd>MasonToolsInstall<CR>", desc = "Install all language tools" },
		{ "<leader>Mo", "<cmd>Mason<CR>", desc = "Open Mason registry" },
	},
	config = function()
		require("mason").setup({
			ui = {
				border = "single",
				icons = {
					package_installed = "",
					package_pending = "",
					package_uninstalled = "",
				},
			},
		})

		require("mason-lspconfig").setup({
			automatic_enable = false,
		})

		require("mason-tool-installer").setup({
			ensure_installed = require("config.languages").tools(),
			auto_update = false,
			run_on_start = false,
		})
	end,
}
