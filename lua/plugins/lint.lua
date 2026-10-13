return {
	"mfussenegger/nvim-lint",
	ft = { "python", "javascript", "typescript", "typescriptreact", "javascriptreact" },
	config = function()
		local lint = require("lint")

		-- Linters per filetype; one that is not installed is skipped instead of
		-- erroring on every save (eslint_d / eslint come from the project).
		local wanted = {
			python = { "ruff" },
			javascript = { "eslint_d", "eslint" },
			typescript = { "eslint_d", "eslint" },
			typescriptreact = { "eslint_d", "eslint" },
			javascriptreact = { "eslint_d", "eslint" },
		}

		local function available(ft)
			for _, name in ipairs(wanted[ft] or {}) do
				local linter = lint.linters[name]
				local cmd = type(linter) == "table" and linter.cmd or name
				if type(cmd) == "function" then
					cmd = cmd()
				end
				if vim.fn.executable(cmd) == 1 then
					return { name }
				end
			end
			return {}
		end

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
			callback = function(args)
				local names = available(vim.bo[args.buf].filetype)
				if #names > 0 then
					lint.try_lint(names)
				end
			end,
		})
	end,
}
