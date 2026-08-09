-- Opening neo-tree when opening a directory
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local stats = vim.uv.fs_stat(vim.fn.argv(0) or "")
		if vim.fn.argc() == 0 or (stats and stats.type == "directory") then
			vim.cmd("Neotree show")
		end
	end,
})

-- Display diagnostics and LSP hover in a single window.
-- Auto-opens only when the cursor is on an error/warning line; <K> forces it anywhere.
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		require("utils.hover").combined_hover({ focusable = false, only_on_diagnostic = true })
	end,
})

-- Briefly highlight the yanked region.
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
	end,
})

-- Treesitter-based folding for buffers that have a parser.
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		if not vim.treesitter.language.add(vim.bo[args.buf].filetype) then
			return
		end
		vim.opt_local.foldmethod = "expr"
		vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.opt_local.foldlevel = 99
		vim.opt_local.foldlevelstart = 99
	end,
})

-- Enable wrapping only for prose filetypes
-- (wrap/linebreak/breakindent are window-local: set them on the buffer's windows)
local wrap_filetypes = { "markdown", "text", "tex", "rst" }
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		if vim.list_contains(wrap_filetypes, ft) then
			for _, win in ipairs(vim.fn.win_findbuf(args.buf)) do
				vim.wo[win].wrap = true
				vim.wo[win].linebreak = true
				vim.wo[win].breakindent = true
			end
		end
	end,
})

-- Strip trailing whitespace on save (skip prose: trailing spaces are meaningful)
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		local ft = vim.bo.filetype
		if vim.bo.binary or vim.list_contains(wrap_filetypes, ft) then
			return
		end
		local view = vim.fn.winsaveview()
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.winrestview(view)
	end,
})
