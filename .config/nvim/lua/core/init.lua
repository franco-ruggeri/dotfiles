local M = {}

M.plugins = require("core.plugins")

M.setup = function()
	M.plugins.setup()
end

return M
