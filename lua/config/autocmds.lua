-- Open a pristine, unnamed buffer next to neo-tree when starting on a
-- directory (or with no arguments), leaving focus in the file explorer.
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local argc = vim.fn.argc()
		local opening_dir = argc == 0
		if not opening_dir then
			local stats = vim.uv.fs_stat(vim.fn.argv(0))
			opening_dir = stats ~= nil and stats.type == "directory"
		end
		if not opening_dir then
			return
		end

		vim.schedule(function()
			-- Starting on a directory leaves a buffer named after it behind;
			-- swap it for a clean, unnamed one.
			local dirbuf = argc > 0 and vim.api.nvim_get_current_buf() or nil
			if dirbuf then
				vim.cmd("enew")
			end
			vim.cmd("Neotree focus")
			if dirbuf and vim.api.nvim_buf_is_valid(dirbuf) then
				vim.api.nvim_buf_delete(dirbuf, { force = true })
			end
		end)
	end,
})

-- Collapse the neo-tree to its root when the last named buffer is deleted
-- (only empty [No Name] buffers remain). The delayed check outlasts
-- neo-tree's 100ms follow debounce, which would otherwise re-render over
-- the collapsed tree.
vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
	callback = function()
		vim.defer_fn(function()
			for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
				local listed = vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted
				if listed and vim.bo[bufnr].buftype == "" and vim.fn.bufname(bufnr) ~= "" then
					return
				end
			end
			require("utils.neotree").collapse_to_root()
		end, 200)
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
		local ok = pcall(vim.treesitter.get_parser, args.buf)
		if not ok then
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

-- Strip trailing whitespace on save (skip special and prose buffers:
-- trailing spaces are meaningful in prose).
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		if vim.bo.binary or vim.bo.buftype ~= "" or vim.list_contains(wrap_filetypes, vim.bo.filetype) then
			return
		end
		local view = vim.fn.winsaveview()
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.winrestview(view)
	end,
})
