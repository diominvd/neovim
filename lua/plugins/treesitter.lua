return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		local ts = require("nvim-treesitter")
		local langs = require("config.languages")

		-- Install missing parsers (from the per-language list) on startup.
		vim.schedule(function()
			local installed = ts.get_installed("parsers")
			local missing = vim.tbl_filter(function(lang)
				return not vim.tbl_contains(installed, lang)
			end, langs.parsers())
			if #missing > 0 then
				ts.install(missing, { summary = true })
			end
		end)

		local select = require("nvim-treesitter-textobjects.select")
		local move = require("nvim-treesitter-textobjects.move")

		for lhs, query in pairs({
			["af"] = "@function.outer",
			["if"] = "@function.inner",
			["ac"] = "@class.outer",
			["ic"] = "@class.inner",
			["aa"] = "@parameter.outer",
			["ia"] = "@parameter.inner",
			["al"] = "@loop.outer",
			["il"] = "@loop.inner",
			["ai"] = "@conditional.outer",
			["ii"] = "@conditional.inner",
		}) do
			vim.keymap.set({ "x", "o" }, lhs, function()
				select.select_textobject(query, "textobjects")
			end, { desc = "Select " .. query })
		end

		for _, m in ipairs({
			{ "]f", move.goto_next_start, "@function.outer", "Next function" },
			{ "[f", move.goto_previous_start, "@function.outer", "Prev function" },
			{ "]k", move.goto_next_start, "@class.outer", "Next class" },
			{ "[k", move.goto_previous_start, "@class.outer", "Prev class" },
		}) do
			vim.keymap.set({ "n", "x", "o" }, m[1], function()
				m[2](m[3], "textobjects")
			end, { desc = m[4] })
		end
	end,
}
