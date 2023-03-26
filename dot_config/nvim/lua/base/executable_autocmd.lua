--  Highlight on Yank
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- Restore Cursors
-- See `:help restore-cursor`
local restore_group = vim.api.nvim_create_augroup("RestoreGroup", { clear = true })
vim.api.nvim_create_autocmd("BufRead", {
	command = [[call setpos(".", getpos("'\""))]],
	group = restore_group,
	pattern = "*",
})

vim.cmd([[set iskeyword+=-]])

vim.cmd("set whichwrap+=<,>,[,],h,l")
-- about fold
-- vim.cmd("set foldmethod=expr")
-- vim.cmd("set foldexpr=nvim_treesitter#foldexpr()")
-- vim.cmd([[autocmd BufReadPost,FileReadPost * normal zR]])

-- set bg transparent
-- vim.cmd([[autocmd ColorScheme * highlight Normal guibg=NONE ctermbg=NONE]])
