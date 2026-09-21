return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "UIEnter",
	config = function()
		local p = require("appearance.palette")

		-- Dimmed label for the tabline offset that sits above neo-tree.
		vim.api.nvim_set_hl(0, "BufferOffset", { fg = p.dim, italic = true })

		require("bufferline").setup({
			options = {
				mode = "buffers",

				-- Clean: no close buttons and no separators — tabs are flush
				-- "pills" and only the active one is filled.
				show_buffer_icons = true,
				show_buffer_close_icons = false,
				show_close_icon = false,
				separator_style = { "", "" },
				indicator = { style = "icon", icon = "▎" },

				-- Functional: LSP diagnostics rendered right inside each tab.
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(_, _, diagnostics_dict)
					local s = ""
					for _, d in ipairs({ { "error", "E" }, { "warning", "W" }, { "info", "I" }, { "hint", "H" } }) do
						local n = diagnostics_dict[d[1]] or 0
						if n > 0 then
							s = s .. d[2] .. n .. " "
						end
					end
					return s ~= "" and vim.trim(s) or ""
				end,

				-- Right-click closes the buffer under the cursor.
				right_mouse_command = "bdelete! %d",

				-- Hide the bar when only a single buffer is open.
				always_show_bufferline = false,

				-- Cap long paths nicely.
				max_name_length = 24,
				truncate_names = true,

				offsets = {
					{
						filetype = "neo-tree",
						text = "  File explorer",
						text_align = "left",
						separator = false,
						highlight = "BufferOffset",
					},
				},
			},
			highlights = {
				-- The empty rail underneath the tabs.
				background = { bg = p.bg0 },
				fill = { bg = p.bg0 },

				-- Inactive tabs: muted, quiet. The indicator slot of visible
				-- tabs falls back to `buffer_visible`, so it stays flush.
				buffer_visible = { bg = p.bg0, fg = p.dim },
				modified_visible = { bg = p.bg0, fg = p.yellow },
				duplicate_visible = { bg = p.bg0, fg = p.dim, italic = true },

				-- Active tab: filled pill, bold name, green accent bar.
				buffer_selected = { bg = p.bg3, fg = p.fg, bold = true },
				indicator_selected = { fg = p.green },
				modified_selected = { bg = p.bg3, fg = p.yellow },
				duplicate_selected = { bg = p.bg3, fg = p.dim, italic = true },

				-- LSP diagnostics labels ("E2", "W1", …) tinted by severity.
				error_visible = { bg = p.bg0, fg = p.red },
				error_selected = { bg = p.bg3, fg = p.red },
				warning_visible = { bg = p.bg0, fg = p.yellow },
				warning_selected = { bg = p.bg3, fg = p.yellow },
				info_visible = { bg = p.bg0, fg = p.aqua },
				info_selected = { bg = p.bg3, fg = p.aqua },
				hint_visible = { bg = p.bg0, fg = p.green },
				hint_selected = { bg = p.bg3, fg = p.green },

				-- The offset separator is glued to the rail.
				offset_separator = { bg = p.bg0 },

				-- Tabpage elements (bufferline draws these in buffers mode too).
				tab = { bg = p.bg0 },
				tab_selected = { bg = p.bg3 },
			},
		})
	end,
}