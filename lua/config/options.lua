local opt = vim.opt
local g = vim.g

-- Mason-installed tools (LSP servers, formatters, linters) must be on PATH
-- before anything starts them; mason itself is lazy-loaded and would only add
-- this on its first use.
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

-- General Settings
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
opt.clipboard = "unnamedplus"
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split"
opt.showmode = false
-- Don't pause for "Press ENTER" after startup messages (they are shown by noice).
opt.shortmess:append("I")

-- Interface Options
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.fillchars = { eob = " " }
opt.cursorline = true
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.winborder = "single"
opt.wrap = false

-- Visualize trailing whitespace and tabs (hidden by default).
-- Tab stops are drawn as vertical bars so nesting levels stay readable
-- instead of the `»` arrow; keep them gray via the `Whitespace` group.
opt.list = true
opt.listchars = { trail = "·", tab = "│ " }

-- Indentation Settings
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

-- Window & Display
opt.splitright = true
opt.splitbelow = true

-- File Handling
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.updatetime = 250
opt.timeoutlen = 300

-- Confirm exit with unsaved changes
opt.confirm = true

-- Keep screen position when splitting windows
opt.splitkeep = "screen"

-- Sessions (auto-session) also restore window-local options.
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Folds start open (treesitter folding is set per buffer in autocmds.lua).
opt.foldlevelstart = 99
