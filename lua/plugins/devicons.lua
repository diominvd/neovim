return {
	"nvim-tree/nvim-web-devicons",
	config = function()
		local devicons = require("nvim-web-devicons")
		devicons.set_icon({
			go = { icon = vim.fn.nr2char(0xf07d3), color = "#00ADD8", cterm_color = "38", name = "Go" },
		})
	end,
}