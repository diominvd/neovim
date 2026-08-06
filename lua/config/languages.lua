-- Central per-language configuration.
--
-- One entry per language. LSP servers, formatters and treesitter parsers are
-- enabled from here and auto-installed on startup (mason + nvim-treesitter).
-- Adding a new language is enough — restart nvim and everything installs.
--
--   enabled    toggle the whole language on/off (false = disabled)
--   lsp        LSP servers to enable (diagnostics come from these too)
--   formatter  conform.nvim formatters — a list (applies to all `ft`)
--              or a table keyed by filetype for per-filetype formatters
--   parsers    nvim-treesitter parsers
--   ft         filetypes the formatter applies to

local languages = {
	["TypeScript / React"] = {
		enabled = true,
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
		lsp = { "ts_ls" },
		formatter = { "prettierd", "prettier" },
		parsers = { "javascript", "typescript", "tsx" },
	},
	["CSS"] = {
		enabled = true,
		ft = { "css" },
		lsp = { "cssls" },
		formatter = { "prettierd", "prettier" },
		parsers = { "css" },
	},
	["HTML"] = {
		enabled = true,
		ft = { "html" },
		lsp = { "html" },
		formatter = { "prettierd", "prettier" },
		parsers = { "html" },
	},
	["JSON"] = {
		enabled = true,
		ft = { "json", "jsonc" },
		lsp = { "jsonls" },
		formatter = {
			json = { "fixjson" },
			jsonc = { "prettier" },
		},
		parsers = { "json" },
	},
	["Lua"] = {
		enabled = true,
		ft = { "lua" },
		lsp = { "lua_ls" },
		formatter = { "stylua" },
		parsers = { "lua" },
	},
	["Python"] = {
		enabled = true,
		ft = { "python" },
		lsp = { "pyright", "ruff" },
		formatter = { "ruff_fix", "ruff_format" },
		parsers = { "python" },
	},
	["Shell"] = {
		enabled = true,
		lsp = {},
		formatter = {},
		parsers = { "bash" },
	},
	["C"] = {
		enabled = true,
		lsp = {},
		formatter = {},
		parsers = { "c" },
	},
}

-- Parsers needed regardless of the language list above: editing the config
-- itself (vim/vimdoc), markdown (render-markdown) and helper parsers.
local common_parsers = { "vim", "vimdoc", "markdown", "markdown_inline", "comment", "diff" }

-- Below: derived lists consumed by mason / lspconfig / conform / treesitter.
-- No need to touch anything here.

local M = {}

-- conform formatter names that are not mason package names
local formatter_packages = {
	ruff_fix = "ruff",
	ruff_format = "ruff",
}

local function each_lang(fn)
	for _, lang in pairs(languages) do
		if lang.enabled ~= false then
			fn(lang)
		end
	end
end

local function flatten_formatters(lang)
	local names = {}
	if type(lang.formatter) == "table" and vim.tbl_islist(lang.formatter) then
		vim.list_extend(names, lang.formatter)
	elseif type(lang.formatter) == "table" then
		for _, f in pairs(lang.formatter) do
			vim.list_extend(names, f)
		end
	end
	return names
end

local function unique(list)
	local seen, result = {}, {}
	for _, item in ipairs(list) do
		if not seen[item] then
			seen[item] = true
			result[#result + 1] = item
		end
	end
	return result
end

function M.lsp_servers()
	local servers = {}
	each_lang(function(lang)
		vim.list_extend(servers, lang.lsp or {})
	end)
	return servers
end

function M.formatters_by_ft()
	local by_ft = {}
	each_lang(function(lang)
		if type(lang.formatter) == "table" and vim.tbl_islist(lang.formatter) then
			for _, ft in ipairs(lang.ft or {}) do
				by_ft[ft] = lang.formatter
			end
		elseif type(lang.formatter) == "table" then
			for ft, formatters in pairs(lang.formatter) do
				by_ft[ft] = formatters
			end
		end
	end)
	return by_ft
end

function M.parsers()
	local parsers = {}
	vim.list_extend(parsers, common_parsers)
	each_lang(function(lang)
		vim.list_extend(parsers, lang.parsers or {})
	end)
	return unique(parsers)
end

function M.tools()
	local tools = {}
	each_lang(function(lang)
		vim.list_extend(tools, lang.lsp or {})
		for _, f in ipairs(flatten_formatters(lang)) do
			tools[#tools + 1] = formatter_packages[f] or f
		end
	end)
	return unique(tools)
end

return M
