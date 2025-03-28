-- Share clipboard with OS
-- Schedule it after `UiEnter` because it can increase startup-time
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Show relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Highlight cursor line
vim.opt.cursorline = true

-- Indent wrapped lines (long lines that don't fit the screen)
vim.opt.breakindent = true

-- Save undo history (kept if you close and re-open a file)
vim.opt.undofile = true

-- Case-insensitive search unless the pattern contains capital letters
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Show effect of substitution interactively
vim.opt.inccommand = "split"

-- Keep minimum number of lines above and below the cursor line
vim.opt.scrolloff = 10

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Set indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.et = true

-- Set default split behavior to right/below
vim.opt.splitright = true
vim.opt.splitbelow = true
