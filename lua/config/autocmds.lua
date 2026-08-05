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
