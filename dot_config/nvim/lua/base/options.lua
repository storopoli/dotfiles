local options = {
	hlsearch = false, -- set highlight on search
	-- relative line numbers
	number = true, -- make line numbers default
	relativenumber = true,
	-- vim.o.lazyredraw = true, -- lazy redraw for crazy macros
	hidden = true, -- a lot of plugins depends on hidden true
	cmdheight = 0, -- set command line height to zero/two lines
	mouse = "a", -- enable mouse mode
	-- Scrolling
	scrolloff = 8, -- vertical scroll
	sidescrolloff = 8, -- horizontal scroll
	timeoutlen = 500, -- time in milliseconds to wait for a mapped sequence to complete
	wrap = false, -- no wrap
	breakindent = true, -- enable break indent
	undofile = true, -- save undo history
	-- Case insensitive searching UNLESS /C or capital in search
	ignorecase = true,
	smartcase = true,
	updatetime = 250, -- faster completion (4000ms default)
	-- Window splitting
	splitbelow = true,
	splitright = true,
	-- column
	signcolumn = "yes",
	colorcolumn = "80",
	-- etc
	vim.opt.isfname:append("@-@"),
	pastetoggle = "<F7>", -- paste mode is F7
	swapfile = false, -- no swap file
	cursorline = true, -- highlight the line where the cursor is located
}
for k, v in pairs(options) do
	vim.opt[k] = v
end
