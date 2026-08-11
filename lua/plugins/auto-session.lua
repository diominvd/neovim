return {
	"rmagatti/auto-session",
	lazy = false,
	config = function()
		require("auto-session").setup({
			log_level = "error",
			auto_restore_enabled = true,
			auto_session_suppress_dirs = { "/", "~", "/Downloads" },
			auto_session_enable_last_session = false,
			pre_save_cmds = { "Neotree close" },
			session_lens = {
				-- Don't register the Telescope extension at startup, so the
				-- lazy-loaded Telescope stays cold until first use.
				load_on_setup = false,
				-- `theme_conf` was replaced by `picker_opts` in auto-session.
				-- `previewer = false` did nothing: the session-lens picker
				-- always renders its own buffer preview.
				picker_opts = {
					border = true,
				},
			},
		})
	end,
}
