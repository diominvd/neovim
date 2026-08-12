local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Plugins & Configuration
require("lazy").setup({
	spec = {
		{ import = "plugins" },
		-- theme.lua is the theme's plugin spec; palette.lua in the same
		-- directory is a plain module and must not be treated as one.
		{ import = "appearance.theme" },
	},
	ui = {
		border = "single",
	},
})
