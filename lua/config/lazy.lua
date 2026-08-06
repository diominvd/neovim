local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
		-- Only theme.lua is a plugin spec; palette.lua in the same dir is a
		-- plain module and must not be scanned as a spec (see Spec:normalize).
		{ import = "appearance.theme" },
	},
	ui = {
		border = "single",
	},
})
