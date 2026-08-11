return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")
		wk.setup({
			plugins = {
				spelling = { enabled = false },
			},
			win = {
				border = "single",
				-- No section-name title on the frame (it makes the popup jump
				-- when opening a group).
				title = false,
				-- Less empty space between the content and the frame.
				padding = { 0, 2 },
			},
			-- Hide the `<esc> close` / `<bs> back` hints and the trail footer.
			show_help = false,
			show_keys = false,
			icons = {
				-- No per-row mapping icons.
				mappings = false,
			},
		})

		wk.add({
			{ "<leader>c", group = "Code" },
			{ "<leader>f", group = "Find" },
			{ "<leader>g", group = "Git" },
			{ "<leader>h", group = "Help" },
			{ "<leader>i", group = "Inlay" },
			{ "<leader>m", group = "Markdown" },
			{ "<leader>q", group = "Quit / Session" },
			{ "<leader>r", group = "Refactor" },
			{ "<leader>s", group = "Split" },
			{ "<leader>t", group = "Terminal" },
			{ "<leader>u", group = "Undo / Format" },
			{ "<leader>x", group = "Diagnostics" },
		})

		-- Which-key opens the popup at the left edge of the whole editor by
		-- default, which overlaps the neo-tree column. Anchor it to the left
		-- edge of the current editor window (falling back to the first
		-- non-neo-tree window) and cap its width to that window.
		local view = require("which-key.view")
		local config = require("which-key.config")

		local function anchor()
			local winid = vim.api.nvim_get_current_win()
			if vim.bo[vim.api.nvim_win_get_buf(winid)].filetype == "neo-tree" then
				for _, w in ipairs(vim.api.nvim_list_wins()) do
					if vim.bo[vim.api.nvim_win_get_buf(w)].filetype ~= "neo-tree" then
						winid = w
						break
					end
				end
			end
			local scr = vim.fn.win_screenpos(winid)
			config.options.win.col = scr[2] - 1
			config.options.win.width = vim.api.nvim_win_get_width(winid)
		end

		local show = view.show
		view.show = function()
			anchor()
			return show()
		end
	end,
}
