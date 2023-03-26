local options = {
	hlsearch = false, -- set highlight on search
	number = true, -- make line numbers default
	-- vim.o.lazyredraw = true, -- lazy redraw for crazy macros
	hidden = true, -- a lot of plugins depends on hidden true
	cmdheight = 0, -- set command line height to zero/two lines
	laststatus = 3, -- statusbar
	winbar = "%=%m %f", -- winbar on top of windows
	mouse = "a", -- enable mouse mode
	-- Scrolling
	scrolloff = 8, -- vertical scroll
	sidescrolloff = 8, -- horizontal scroll
	timeoutlen = 500, -- time in milliseconds to wait for a mapped sequence to complete
	wrap = false, -- no wrap
	breakindent = true, -- enable break indent
	undofile = true,  -- save undo history
	-- Case insensitive searching UNLESS /C or capital in search
	ignorecase = true,
	smartcase = true,
	updatetime = 250, -- faster completion (4000ms default)
	signcolumn = "yes",
	completeopt = "menuone,noselect", -- better completion experience
	-- Window splitting
	splitbelow = true,
	splitright = true,
	pastetoggle = "<F2>", -- paste mode is F2
	swapfile = false, -- no swap file
	cursorline = true, -- highlight the line where the cursor is located
	-- relative line numbers
	numberwidth = 4,
	relativenumber = true,
	wrap = false,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end
