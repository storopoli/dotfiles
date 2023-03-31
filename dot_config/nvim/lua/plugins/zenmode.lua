return {
	"folke/zen-mode.nvim",
	config = true,
	event = "VeryLazy",
	keys = {
		{ "<leader>zz",
			function()
				require("zen-mode").toggle()

				vim.wo.wrap = false
				vim.wo.number = true
				vim.wo.rnu = true
			end,
		},
		{ "<leader>zZ",
			function()
				require("zen-mode").toggle()

				vim.wo.wrap = false
				vim.wo.number = false
				vim.wo.rnu = false
			end,
		},
	}
}
