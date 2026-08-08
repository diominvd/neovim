return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "UIEnter",
	config = function()
		local p = require("appearance.palette")
		require("bufferline").setup({
			options = {
				mode = "buffers",
				show_buffer_icons = true,
				show_buffer_close_icons = false,
				show_close_icon = false,
				indicator = { style = "icon", icon = "" },
				separator_style = { "|", "|" },
				offsets = {
					{
						filetype = "neo-tree",
						text = "File explorer",
						text_align = "left",
						separator = true,
					},
				},
			},
			highlights = {
				-- Inactive Elements:
				background = { bg = p.bg0 },
				buffer_visible = { bg = p.bg0 },
				separator = { bg = p.bg0 },
				separator_visible = { bg = p.bg0 },
				indicator_visible = { bg = p.bg0 },
				modified = { bg = p.bg0 },
				-- Active Elements:
				buffer_selected = { bg = p.bg3 },
				separator_selected = { bg = p.bg3 },
				indicator_selected = { bg = p.bg3 },
				modified_selected = { bg = p.bg3 },
			},
		})
	end,
}
