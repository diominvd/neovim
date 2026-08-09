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

		local view = require("which-key.view")

		-- Which-key stretches its popup across the whole editor, which overlaps
		-- the neo-tree on the left. Right before showing it, anchor it to the
		-- left edge of the current editor window and cap the width so it fits
		-- the editor area (col/width are re-read on every show).
		--
		-- Neo-tree keeps focus when a directory is opened, so anchor to the
		-- first non-neo-tree window instead of the focused one.
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
			local conf = require("which-key.config")
			local col = vim.fn.win_screenpos(winid)[2] - 1
			conf.win.col = col
			conf.win.width = vim.o.columns - col
		end

		local show = view.show
		view.show = function()
			anchor()
			return show()
		end
	end,
}
