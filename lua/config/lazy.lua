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
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_err_writeln("Failed to clone lazy.nvim:\n" .. vim.fn.system({ "git", "clone", lazyrepo, lazypath }))
		return
	end
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
