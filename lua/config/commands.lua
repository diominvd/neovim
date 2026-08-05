local version = require("config.version")

vim.api.nvim_create_user_command("ConfigVersion", function()
	vim.notify("Config version " .. version, vim.log.levels.INFO, { title = "nvim" })
end, { desc = "Show current config version" })
