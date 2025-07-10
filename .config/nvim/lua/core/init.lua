local M = {}

M.options = require("core.options")
M.plugins = require("core.plugins")

M.setup = function()
	M.options.setup()
	M.plugins.setup()
end

return M
