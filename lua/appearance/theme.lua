return {
	"sainnhe/gruvbox-material",
	priority = 1000,
	config = function()
		local p = require("config.palette")

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

			hi("DiagnosticFloatingError", { bg = "NONE", fg = p.red })
			hi("DiagnosticFloatingWarn", { bg = "NONE", fg = p.yellow })
			hi("DiagnosticFloatingInfo", { bg = "NONE", fg = p.aqua })
			hi("DiagnosticFloatingHint", { bg = "NONE", fg = p.green })

			hi("DiagnosticVirtualTextError", { bg = "NONE", fg = p.red })
			hi("DiagnosticVirtualTextWarn", { bg = "NONE", fg = p.yellow })
			hi("DiagnosticVirtualTextInfo", { bg = "NONE", fg = p.aqua })
			hi("DiagnosticVirtualTextHint", { bg = "NONE", fg = p.green })

			hi("DiagnosticSignError", { bg = "NONE", fg = p.red })
			hi("DiagnosticSignWarn", { bg = "NONE", fg = p.yellow })
			hi("DiagnosticSignInfo", { bg = "NONE", fg = p.aqua })
			hi("DiagnosticSignHint", { bg = "NONE", fg = p.green })

			hi("DiagnosticUnderlineError", { undercurl = true, sp = p.red })
			hi("DiagnosticUnderlineWarn", { undercurl = true, sp = p.yellow })
			hi("DiagnosticUnderlineInfo", { undercurl = true, sp = p.aqua })
			hi("DiagnosticUnderlineHint", { undercurl = true, sp = p.green })

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
