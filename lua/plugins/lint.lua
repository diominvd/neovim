{
	"mfussenegger/nvim-lint",
	event = { "BufWritePost", "BufReadPost", "InsertLeave" },
	config = function()
		require("lint").try_lint()
		require("lint").linters_by_ft = {
			python = { "ruff" },
			javascript = { "eslint" },
			typescript = { "eslint" },
			typescriptreact = { "eslint" },
			javascriptreact = { "eslint" },
			css = { "eslint" },
			html = { "eslint" },
			json = { "fixjson" },
		}
	end,
}