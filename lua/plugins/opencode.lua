return {
	"nickjvandyke/opencode.nvim",
	enabled = true,
	-- opencode.nvim registers no Neovim commands: it is a pure Lua API, so it
	-- is lazy-loaded by the first keypress below (and never by a `cmd`/event).
	-- stylua: ignore
	keys = {
		{ "<leader>oa", function() require("opencode").ask("@this: ") end, mode = { "n", "x" }, desc = "Ask OpenCode (about @this)" },
		{ "<leader>oo", function() require("opencode").select() end, mode = { "n", "x" }, desc = "Select OpenCode Action" },
		{ "<leader>os", function() return require("opencode").operator("@this") end, mode = { "n", "x" }, expr = true, desc = "Send Range to OpenCode" },
		{ "<leader>ol", function() return require("opencode").operator("@this") .. "_" end, mode = "n", expr = true, desc = "Send Line to OpenCode" },
		{ "<leader>ob", function() require("opencode").ask("@buffer: ") end, mode = "n", desc = "Ask OpenCode (about @buffer)" },
		{ "<leader>od", function() require("opencode").select({ prompt = "OpenCode: ", prompts = { fix = "Fix @diagnostics", explain = "Explain @diagnostics" } }) end, mode = "n", desc = "Ask OpenCode About Diagnostics" },
		{ "<leader>ot", function() require("snacks.terminal").toggle("opencode", { border = "single", win = { position = "float", width = 0.9, height = 0.6 } }) end, mode = { "n", "t" }, desc = "Toggle OpenCode Terminal" },
	},
	config = function()
		vim.g.opencode_opts = {
			server = {
				-- Boot the OpenCode server in a floating snacks terminal instead
				-- of the default vertical split.
				start = function()
					require("snacks.terminal").open(
						"opencode",
						{ border = "single", win = { position = "float", width = 0.9, height = 0.6 } }
					)
				end,
			},
			-- Contexts injected into prompts: `@this`, `@buffer`, `@diagnostics`,
			-- `@buffers`, `@marks`, `@quickfix`, `@visible`.
			events = {
				enabled = true,
				-- Reload buffers that OpenCode edits (requires `opt.autoread`).
				reload = { enabled = true },
			},
		}

		-- Show the terminal as soon as OpenCode starts executing a prompt.
		vim.api.nvim_create_autocmd("User", {
			pattern = "OpencodeEvent:session.execution.started",
			callback = function()
				local win = require("snacks.terminal").get("opencode", { create = false })
				if win then
					win:show()
				end
			end,
		})
	end,
	-- snacks provides the input (ask) and picker (select) UI.
	dependencies = { "folke/snacks.nvim" },
}