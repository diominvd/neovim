return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	cmd = { "Neotree" },
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			enable_git_status = true,
			enable_diagnostics = true,
			filesystem = {
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
				filtered_items = {
					visible = true,
				},
			},
			window = {
				position = "left",
				width = 30,
				mapping_options = {
					noremap = true,
					nowait = true,
				},
				mappings = {
					["<space>"] = "none",
					["l"] = "open",
					["h"] = "close_node",
					["v"] = "open_vsplit",
					["s"] = "open_split",
				},
			},
			default_component_configs = {
				icon = {
					highlight = "NeoTreeFileIcon",
				},
			},
		})
	end,
}
