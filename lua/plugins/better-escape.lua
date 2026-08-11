return {
	"max397574/better-escape.nvim",
	event = "InsertEnter",
	opts = {
		-- First key is returned immediately (no typing latency); only the
		-- second key has to arrive within this window.
		timeout = 150,
		-- Insert-only: visual j/k are already restricted by hardtime, so don't
		-- map them here and clobber its keymaps.
		default_mappings = false,
		mappings = {
			i = {
				j = { k = "<Esc>" },
				k = { j = "<Esc>" },
			},
		},
	},
}
