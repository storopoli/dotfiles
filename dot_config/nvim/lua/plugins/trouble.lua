return {
	"folke/trouble.nvim",
	keys = {
		{ "tr", "<cmd>TroubleToggle<cr>", desc = "trouble" },
	},
	config = function()
		require("trouble").setup {
			icons = false,
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		}
	end
}
