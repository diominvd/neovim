return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
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
			run_on_start = true,
		})
	end,
}
