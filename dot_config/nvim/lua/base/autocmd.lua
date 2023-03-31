--  highlight on yank
-- see `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- restore Cursors
-- see `:help restore-cursor`
local restore_group = vim.api.nvim_create_augroup("RestoreGroup", { clear = true })
vim.api.nvim_create_autocmd("BufRead", {
	command = [[call setpos(".", getpos("'\""))]],
	group = restore_group,
	pattern = "*",
})

vim.cmd([[set iskeyword+=-]])
vim.cmd("set whichwrap+=<,>,[,],h,l")
