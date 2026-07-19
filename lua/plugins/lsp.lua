return {
	"neovim/nvim-lspconfig",
	config = function()
		vim.diagnostic.config({
			virtual_text = true,
			severity_sort = true,
			underline = true,
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		local ok, blink = pcall(require, "blink.cmp")
		if ok then
			capabilities = blink.get_lsp_capabilities(capabilities)
		end
		vim.lsp.config("*", { capabilities = capabilities })

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					workspace = {
						library = vim.api.nvim_get_runtime_file("lua", true),
						checkThirdParty = false,
						maxPreload = 10000,
						preloadFileSize = 5000,
					},
					telemetry = { enable = false },
				},
			},
		})

		vim.lsp.config("pyright", {
			settings = {
				python = {
					analysis = {
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						diagnosticMode = "openFilesOnly",
						exclude = {
							"**/__pycache__",
							"**/node_modules",
							"**/.git",
							"**/venv",
							"**/.venv",
							"**/site-packages",
						},
					},
				},
			},
		})

		vim.lsp.config("ruff", {
			on_attach = function(client)
				client.server_capabilities.hoverProvider = false
			end,
		})

		vim.lsp.enable({ "lua_ls", "jsonls", "pyright", "ruff" })
	end,
}
