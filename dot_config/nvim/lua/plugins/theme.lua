return {
	"folke/tokyonight.nvim",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all
	config = function()
		vim.o.termguicolors = true
		vim.o.background = "dark"
		require("tokyonight").setup({
			style = "night", 
		})
		vim.cmd([[colorscheme tokyonight]])
	end,
}