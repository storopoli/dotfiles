return {
	"nvim-telescope/telescope.nvim", -- Telescope
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{ "<leader>?", "<CMD>Telescope oldfiles<CR>", desc = "[?] Find recently opened files" },
		{ "<leader><space>", "<CMD>Telescope buffers<CR>", desc = "[ ] Find existing buffers" },
		{
			"<leader>/",
			"<CMD>Telescope current_buffer_fuzzy_find<CR>",
			desc = "[/] Fuzzily search in current buffer]",
		},

		{ "<leader>sf", "<CMD>Telescope find_files<CR>", desc = "[S]earch [F]iles" },
		{ "<leader>sh", "<CMD>Telescope help_tags<CR>", desc = "[S]earch [H]elp" },
		{ "<leader>sw", "<CMD>Telescope grep_string<CR>", desc = "[S]earch current [W]ord" },
		{ "<leader>sg", "<CMD>Telescope live_grep<CR>", desc = "[S]earch by [G]rep" },
		{ "<leader>sd", "<CMD>Telescope diagnostics<CR>", desc = "[S]earch [D]iagnostics" },
	},
	config = function()
		-- See `:help telescope` and `:help telescope.setup()`
		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<C-u>"] = false,
						["<C-d>"] = false,
						["<C-j>"] = "move_selection_next",
						["<C-k>"] = "move_selection_previous",
					},
				},
				winblend = 20,
			},
			extensions = {
				media_files = {
					-- filetypes whitelist
					-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
					filetypes = { "png", "webp", "jpg", "jpeg", "mp4", "pdf", "webm" },
					find_cmd = "rg", -- find command (defaults to `fd`)
				},
			},
		})
	end,
}
