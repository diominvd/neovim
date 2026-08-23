-- Shared helpers for the neo-tree file explorer.
local M = {}

-- Collapse the filesystem tree back to its root: close every expanded folder.
-- No-op when neo-tree is not open. Used by <leader>E and by the last-buffer
-- autocmd in config/autocmds.lua.
function M.collapse_to_root()
	local ok, renderer = pcall(require, "neo-tree.ui.renderer")
	if not ok then
		return
	end
	local state = require("neo-tree.sources.manager").get_state("filesystem")
	if state and state.tree and renderer.window_exists(state) then
		state.explicitly_opened_nodes = {}
		renderer.collapse_all_nodes(state.tree)
		renderer.redraw(state)
	end
end

return M
