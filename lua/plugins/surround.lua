return {
	"echasnovski/mini.surround",
	version = "*",
	config = function()
		require("mini.surround").setup({
			-- The `gs*` prefix is used because the default `s*` conflicts with flash.nvim jump.
			mappings = {
				add = "gsa",
				delete = "gsd",
				find = "gsf",
				find_left = "gsF",
				highlight = "gsh",
				replace = "gsr",
				update_n_lines = "gsn",
			},
			search_method = "cover_or_next",
		})
	end,
}
