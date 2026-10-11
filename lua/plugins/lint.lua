return {
	"mfussenegger/nvim-lint",
	ft = { "python", "javascript", "typescript", "typescriptreact", "javascriptreact", "css", "html", "json", "jsonc" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			python = { "ruff" },
			javascript = { "eslint" },
			typescript = { "eslint" },
			typescriptreact = { "eslint" },
			javascriptreact = { "eslint" },
			css = { "eslint" },
			html = { "eslint" },
			json = { "fixjson" },
			jsonc = { "fixjson" },
		}

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}