local M = {}

M.keymaps = require("core.keymaps")
M.plugins = require("core.plugins")

M.setup = function()
	M.keymaps.setup()
	M.plugins.setup()
end

return M
