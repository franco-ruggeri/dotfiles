local M = {}

M.options = require("core.options")
M.keymaps = require("core.keymaps")
M.autocommands = require("core.autocommands")
M.plugins = require("core.plugins")

M.setup = function()
	M.options.setup()
	M.keymaps.setup()
	M.autocommands.setup()
	M.plugins.setup()
end

return M
