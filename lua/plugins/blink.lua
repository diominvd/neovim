return {
	"saghen/blink.cmp",
	dependencies = {
		"saghen/blink.lib",
		"rafamadriz/friendly-snippets",
	},
	build = function()
		require("blink.cmp").build():pwait()
	end,
	config = function()
		require("blink.cmp").setup({
			appearance = {
				nerd_font_variant = "mono",
			},
			completion = {
				accept = {
					-- Auto-insert paired brackets for function calls (VS Code-like).
					auto_brackets = {
						enabled = true,
					},
				},
				list = {
					selection = {
						preselect = false,
						auto_insert = true,
					},
				},
				menu = {
					border = "single",
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,BlinkCmpMenuSelection:BlinkCmpMenuSelection",
					draw = {
						columns = {
							{ "label", "label_description", gap = 1 },
							{ "kind_icon", "kind" },
						},
						-- Treesitter-highlight completion labels from LSP.
						treesitter = { "lsp" },
					},
				},
				-- Auto-show the documentation window while cycling candidates.
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
					window = {
						border = "single",
						winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
					},
				},
				ghost_text = {
					enabled = true,
				},
			},
			-- Signature help popup while typing `func(` (falls back to manual <C-k>).
			signature = {
				enabled = true,
				trigger = {
					enabled = true,
				},
				window = {
					border = "single",
					winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
				},
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				-- lazydev gives smart completions for nvim APIs in Lua files.
				per_filetype = {
					lua = { inherit_defaults = true, "lazydev" },
				},
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100, -- higher priority than lsp
					},
				},
			},
			-- Completion in the command line (`:Mason`, `:Trouble`, ...).
			cmdline = {
				enabled = true,
				keymap = {
					preset = "cmdline",
					-- Don't hijack left/right arrow movement in the cmdline.
					["<Right>"] = false,
					["<Left>"] = false,
				},
				completion = {
					list = {
						selection = { preselect = false },
					},
					menu = {
						auto_show = function(ctx)
							return vim.fn.getcmdtype() == ":"
						end,
					},
					ghost_text = { enabled = true },
				},
			},
			keymap = {
				preset = "none",
				-- Some terminals swallow <C-space>; Ctrl+/ is the common fallback.
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-/>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-n>"] = { "select_next", "fallback" },
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-e>"] = { "hide" },
				["<C-y>"] = { "select_and_accept" },
				["<CR>"] = { "accept", "fallback" },
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
			},
		})
	end,
}