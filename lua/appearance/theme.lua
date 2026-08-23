return {
	"sainnhe/gruvbox-material",
	priority = 1000,
	config = function()
		local p = require("appearance.palette")

		-- Colors configuration
		vim.g.gruvbox_material_better_performance = 1
		vim.g.gruvbox_material_background = "medium"
		vim.g.gruvbox_material_foreground = "material"
		vim.g.gruvbox_material_transparent_background = 1
		-- Font configuration
		vim.g.gruvbox_material_enable_bold = 1
		vim.g.gruvbox_material_enable_italic = 1
		vim.cmd.colorscheme("gruvbox-material")

		local function apply_highlights()
			local function hi(group, opts)
				vim.api.nvim_set_hl(0, group, opts)
			end

			hi("CursorLine", { bg = p.selection })
			hi("NormalFloat", { bg = "NONE" })
			hi("FloatBorder", { bg = "NONE", fg = p.border_fg })
			hi("UtilsHoverHeader", { fg = vim.api.nvim_get_hl(0, { name = "Comment" }).fg, bold = true })
			hi("Pmenu", { bg = "NONE" })
			hi("PmenuSel", { bg = p.selection })
			hi("PmenuBorder", { bg = "NONE", fg = p.border_fg })

			hi("BlinkCmpMenu", { bg = "NONE" })
			hi("BlinkCmpMenuBorder", { bg = "NONE", fg = p.border_fg })
			hi("BlinkCmpMenuSelection", { bg = p.selection })
			hi("BlinkCmpDoc", { bg = "NONE" })
			hi("BlinkCmpDocBorder", { bg = "NONE", fg = p.border_fg })
			hi("BlinkCmpDocSeparator", { bg = "NONE", fg = p.border_fg })
			hi("BlinkCmpGhostText", { bg = "NONE", fg = p.dim })
			hi("BlinkCmpLabelMatch", { bg = "NONE" })
			hi("BlinkCmpSignatureHelp", { bg = "NONE" })
			hi("BlinkCmpSignatureHelpBorder", { bg = "NONE", fg = p.border_fg })

			hi("MasonNormal", { bg = "NONE" })
			hi("MasonHeader", { bg = "NONE", fg = p.fg })
			hi("MasonFooter", { bg = "NONE", fg = p.border_fg })

			hi("LspInfoBorder", { bg = "NONE", fg = p.border_fg })

			local severity_colors = { Error = p.red, Warn = p.yellow, Info = p.aqua, Hint = p.green }
			for severity, color in pairs(severity_colors) do
				hi("DiagnosticFloating" .. severity, { bg = "NONE", fg = color })
				hi("DiagnosticVirtualText" .. severity, { bg = "NONE", fg = color })
				hi("DiagnosticSign" .. severity, { bg = "NONE", fg = color })
				hi("DiagnosticUnderline" .. severity, { undercurl = true, sp = color })
			end

			hi("NoiceCmdlinePopup", { bg = "NONE" })
			hi("NoiceCmdlinePopupBorder", { bg = "NONE", fg = p.border_fg })
			hi("NoiceCmdlinePopupBorderSearch", { bg = "NONE", fg = p.border_fg })
			hi("NoiceConfirm", { bg = "NONE" })
			hi("NoiceConfirmBorder", { bg = "NONE", fg = p.border_fg })
		end

		apply_highlights()
		vim.api.nvim_create_autocmd("ColorScheme", { callback = apply_highlights })
	end
}
