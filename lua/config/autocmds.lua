-- Opening neo-tree when opening a directory
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local stats = vim.uv.fs_stat(vim.fn.argv(0) or "")
		if vim.fn.argc() == 0 or (stats and stats.type == "directory") then
			vim.cmd("Neotree show")
		end
	end,
})

-- Display diagnostics and LSP hover in a single window
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		require("utils.hover").combined_hover({ focusable = false })
	end,
})

-- Enable wrapping only for prose filetypes
local wrap_filetypes = { "markdown", "text", "tex", "rst" }
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		if vim.tbl_contains(wrap_filetypes, ft) then
			vim.bo[args.buf].wrap = true
			vim.bo[args.buf].linebreak = true
			vim.bo[args.buf].breakindent = true
		end
	end,
})

-- Strip trailing whitespace on save (skip prose: trailing spaces are meaningful)
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		local ft = vim.bo.filetype
		if vim.bo.binary or vim.tbl_contains(wrap_filetypes, ft) then
			return
		end
		local view = vim.fn.winsaveview()
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.winrestview(view)
	end,
})
