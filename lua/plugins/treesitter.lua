return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		require("nvim-treesitter").setup({})

		local langs = require("config.languages")

		-- Install missing parsers (from the per-language list) on startup.
		vim.schedule(function()
			local want = langs.parsers()
			local installed = require("nvim-treesitter.config").get_installed("parsers")
			local missing = {}
			for _, lang in ipairs(want) do
				if not vim.tbl_contains(installed, lang) then
					missing[#missing + 1] = lang
				end
			end
			if #missing > 0 then
				require("nvim-treesitter.install").install(missing, { summary = true })
			end
		end)

		require("nvim-treesitter-textobjects").setup({
			select = { lookahead = true },
			move = { set_jumps = true },
		})

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

		local function map_move(lhs, fn, desc)
			vim.keymap.set({ "n", "x", "o" }, lhs, fn, { desc = desc })
		end
		map_move("]f", function()
			move.goto_next_start("@function.outer", "textobjects")
		end, "Next function")
		map_move("[f", function()
			move.goto_previous_start("@function.outer", "textobjects")
		end, "Prev function")
		map_move("]k", function()
			move.goto_next_start("@class.outer", "textobjects")
		end, "Next class")
		map_move("[k", function()
			move.goto_previous_start("@class.outer", "textobjects")
		end, "Prev class")
	end,
}
