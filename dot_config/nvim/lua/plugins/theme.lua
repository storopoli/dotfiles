return {
	"ellisonleao/gruvbox.nvim", -- Set colorscheme to Gruvbox Theme
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all
	config = function()
		vim.o.termguicolors = true
		vim.o.background = "dark"
		vim.cmd([[colorscheme gruvbox]])
	end,
}