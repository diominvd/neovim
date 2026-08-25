return {
	"folke/noice.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	opts = {
		presets = {
			bottom_search = true,
			command_palette = true,
			long_message_to_split = true,
			lsp_doc_border = true,
		},
		notify = {
			view = "mini",
		},
		views = {
			mini = {
				border = { style = "single" },
				timeout = 3000,
			},
			cmdline_popup = {
				border = { style = "single" },
			},
			popupmenu = {
				border = { style = "single" },
			},
		},
		routes = {
			{
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
			},
		},
	},
}
