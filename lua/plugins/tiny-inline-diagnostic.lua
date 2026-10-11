return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "LspAttach",
	priority = 1000,
	config = function()
		require("tiny-inline-diagnostic").setup({
			preset = "modern",
			options = {
				right_align = true,
				format = function(diagnostic)
					return diagnostic.message:gsub("%s+$", "")
				end,
			},
		})
		-- disable built-in virtual_text to avoid duplicates
		vim.diagnostic.config({ virtual_text = false })
	end,
}