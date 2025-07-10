local M = {}

M.setup = function()
	vim.keymap.set("n", "-", "<Cmd>Explore<CR>", { desc = "Open netrw" })
end

return M
