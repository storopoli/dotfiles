return {
	"nvim-telescope/telescope-media-files.nvim",
	dependencies = "nvim-telescope/telescope.nvim",
	config = function()
		require("telescope").load_extension("media_files")
	end,
}
