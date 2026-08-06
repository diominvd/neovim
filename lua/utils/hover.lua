local M = {}

local HEADER_NS = vim.api.nvim_create_namespace("utils.hover.headers")

-- Remember the last non-focusable preview so a repeated CursorHold on the
-- same line does not re-fire an LSP request while the window is still open.
local last = { buf = nil, line = nil, win = nil }

local function preview(lines, header_lines, focusable)
	if #lines == 0 then
		return
	end
	local winid, bufnr = vim.lsp.util.open_floating_preview(lines, "markdown", {
		border = "single",
		focusable = focusable,
		focus_id = "textDocument/hover",
		close_events = { "CursorMoved", "CursorMovedI", "BufLeave", "InsertEnter" },
	})
	for _, lnum in ipairs(header_lines) do
		vim.api.nvim_buf_set_extmark(bufnr, HEADER_NS, lnum, 0, {
			end_col = #lines[lnum + 1],
			hl_group = "UtilsHoverHeader",
		})
	end
	if not focusable then
		last = { buf = vim.api.nvim_get_current_buf(), line = vim.api.nvim_win_get_cursor(0)[1] - 1, win = winid }
	end
end

local function assemble(diag_lines, hover_lines)
	local lines = {}
	local header_lines = {}
	if #diag_lines > 0 then
		table.insert(lines, "Diagnostics:")
		table.insert(header_lines, #lines - 1)
		vim.list_extend(lines, diag_lines)
	end
	if #hover_lines > 0 then
		if #lines > 0 then
			table.insert(lines, "")
		end
		table.insert(lines, "LSP:")
		table.insert(header_lines, #lines - 1)
		vim.list_extend(lines, hover_lines)
	end
	return lines, header_lines
end

function M.combined_hover(opts)
	local focusable = (opts and opts.focusable ~= nil) and opts.focusable or true

	local buf = vim.api.nvim_get_current_buf()
	local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1

	if not focusable then
		if last.buf == buf and last.line == lnum and last.win and vim.api.nvim_win_is_valid(last.win) then
			return
		end
	end

	local diag_lines = {}
	for _, diag in ipairs(vim.diagnostic.get(buf, { lnum = lnum })) do
		local severity = vim.lsp.protocol.DiagnosticSeverity[diag.severity] or "Error"
		local source = diag.source and (" " .. diag.source) or ""
		table.insert(diag_lines, ("[%s%s] %s"):format(severity, source, diag.message))
	end

	local hover_client = nil
	for _, client in ipairs(vim.lsp.get_clients({ bufnr = buf })) do
		if client:supports_method("textDocument/hover") then
			hover_client = client
			break
		end
	end

	if not hover_client then
		local lines, header_lines = assemble(diag_lines, {})
		return preview(lines, header_lines, focusable)
	end

	local params = vim.lsp.util.make_position_params(0, hover_client.offset_encoding)
	local opened = false
	vim.lsp.buf_request(buf, "textDocument/hover", params, function(err, result, ctx)
		if opened or err or result == nil then
			return
		end
		if ctx.bufnr ~= vim.api.nvim_get_current_buf() then
			return
		end
		if vim.api.nvim_win_get_cursor(0)[1] - 1 ~= params.position.line then
			return
		end
		opened = true

		local hover_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
		hover_lines = vim.split(table.concat(hover_lines, "\n"), "\n", { trimempty = true })

		if #diag_lines == 0 and #hover_lines == 0 then
			return
		end

		local lines, header_lines = assemble(diag_lines, hover_lines)
		preview(lines, header_lines, focusable)
	end)
end

return M
