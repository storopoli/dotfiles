return {
	"jpalardy/vim-slime",
	keys = {
		-- needs custom keybindings
		-- check: https://libreddit.spike.codes/r/neovim/comments/uc6q8h/ability_to_map_ctrl_tab_and_more/
		-- { "<C-V><S-CR>", "<cmd>SlimeRegionSend<CR>",    mode = "x" },
		-- { "<C-V><S-CR>", "<cmd>SlimeParagraphSend<CR>", mode = "n" },
		{ "<c-c><c-c>", "<cmd>SlimeRegionSend<CR>",    mode = "x" },
		{ "<c-c><c-c>", "<cmd>SlimeParagraphSend<CR>", mode = "n" },
	},
	config = function()
		-- vim.g.slime_target = "wezterm"
		vim.g.slime_target = "tmux"
		vim.g.slime_default_config = {
			socket_name = "default",
			target_pane = "{right-of}",
		}
		vim.g.slime_paste_file = vim.fn.tempname()
		vim.g.slime_no_mappings = 1
	end,
}
