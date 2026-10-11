local opt = vim.opt
local g = vim.g

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
