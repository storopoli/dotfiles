return {
	"nvim-lualine/lualine.nvim",
	event = "BufWinEnter",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", lazy = true },
		"ellisonleao/gruvbox.nvim",
	},
	config = function()
			require("lualine").setup({
				options = {
					icons_enabled = false,
					theme = "gruvbox",
					component_separators = "|",
					section_separators = "",
				},
			})
	end,
}
